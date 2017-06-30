From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 30 Jun 2017 15:52:13 +0300
Subject: [PATCH v1 1/3] interconnect: Add generic interconnect controller
 API
In-Reply-To: <CAKfTPtCLf-JAKM5MD-pe-az3xUF_4nYtYvnsZpztmtaqk0C4PQ@mail.gmail.com>
References: <20170627174903.27978-1-georgi.djakov@linaro.org>
 <20170627174903.27978-2-georgi.djakov@linaro.org>
 <CAKfTPtCLf-JAKM5MD-pe-az3xUF_4nYtYvnsZpztmtaqk0C4PQ@mail.gmail.com>
Message-ID: <93a7ab62-8b64-a757-1b5f-9a8bdd1751a4@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On 06/28/2017 08:45 PM, Vincent Guittot wrote:
> Hi Georgi,
> 
> On 27 June 2017 at 19:49, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> 
> [snip]
> 
>> +
>> +static int interconnect_aggregate(struct interconnect_node *node,
>> +                                 struct interconnect_creq *creq)
>> +{
>> +       int ret = 0;
>> +
>> +       mutex_lock(&node->icp->lock);
>> +
>> +       if (node->icp->ops->aggregate) {
>> +               ret = node->icp->ops->aggregate(node, creq);
>> +               if (ret) {
>> +                       pr_info("%s: error (%d)\n", __func__, ret);
>> +                       goto out;
>> +               }
>> +       } else {
>> +               /* do not aggregate by default */
>> +               struct icp *icp = node->icp;
>> +
>> +               icp->creq.avg_bw = creq->avg_bw;
>> +               icp->creq.peak_bw = creq->peak_bw;
> 
> Does it means that by default the last caller defines the bandwidth
> for everybody ?
> IMHO, having a default aggregation policy that sums the avg_bw of all
> request of the node
> and that gets the max of peak_bw of all request of a node is better
> 

Yes, i had this in one of the previous versions, but then i removed the
aggregation by default. Will put it back. Thanks!

>> +       }
>> +
>> +out:
>> +       mutex_unlock(&node->icp->lock);
>> +       return ret;
>> +}
>> +
>> +/**
>> + * interconnect_set() - set constraints on a path between two endpoints
>> + * @path: reference to the path returned by interconnect_get()
>> + * @creq: request from the consumer, containing its requirements
>> + *
>> + * This function is used by an interconnect consumer to express its own needs
>> + * in term of bandwidth and QoS for a previously requested path between two
>> + * endpoints. The requests are aggregated and each node is updated accordingly.
>> + *
>> + * Returns 0 on success, or an approproate error code otherwise.
>> + */
>> +int interconnect_set(struct interconnect_path *path,
>> +                    struct interconnect_creq *creq)
>> +{
>> +       struct interconnect_node *next, *prev = NULL;
>> +       size_t i;
>> +       int ret = 0;
>> +
>> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
>> +               next = path->reqs[i].node;
>> +
>> +               if (!next || !prev)
> 
> This needs a comment with an explanation about why you don't do
> anything in this case

Ok.

> 
>> +                       continue;
>> +
>> +               if (next->icp != prev->icp)
> 
> This needs a comment with an explanation about why you don't do
> anything in this case

Ok.

> 
>> +                       continue;
>> +
>> +               /* aggregate requests from consumers */
> 
> you should update the path->reqs[i].avg_bw and path->reqs[i].peak_bw
> with creq values
> before aggregating the requests from the different consumer of a node ?
> 
>               path->reqs[i].avg_bw = creq->avg_bw
>               path->reqs[i].peak_bw = creq->peak_bw

I am updating them currently in the vendor implementation of the
aggregate() function, but this was probably not the right place,
so i will move it here instead. Thanks for the comments!

BR,
Georgi
