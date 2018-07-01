From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Sun, 1 Jul 2018 14:09:26 +0300
Subject: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
In-Reply-To: <CAKfTPtBApjf9rhJm3paeXdgbVG50ALeun=zMUddc-f+RnrvkqQ@mail.gmail.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
 <CAKfTPtBApjf9rhJm3paeXdgbVG50ALeun=zMUddc-f+RnrvkqQ@mail.gmail.com>
Message-ID: <730fac43-e99f-e4bd-bc40-eddeb8338e6e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On 27.06.18 ?. 9:19, Vincent Guittot wrote:
> Hi Georgi
> 
> On Wed, 20 Jun 2018 at 14:11, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> 
> [snip]
> 
>> +
>> +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
>> +{
>> +       struct icc_node *node = dst;
>> +       struct icc_path *path;
>> +       size_t i;
>> +
>> +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
> 
> Should be (num_nodes -1) * sizeof(*path->reqs) as there is already 1
> icc_req in icc_path struct

reqs[] is a flexible array member and it's size is not included in
sizeof(*path)

Thanks,
Georgi

>> +                      GFP_KERNEL);
>> +       if (!path)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       path->num_nodes = num_nodes;
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
>> +
>> +               path->reqs[i].node = node;
>> +               /* reference to previous node was saved during path traversal */
>> +               node = node->reverse;
>> +       }
>> +
>> +       return path;
>> +}
>> +
> 
> [snip]
> 
