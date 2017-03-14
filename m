From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Tue, 14 Mar 2017 17:39:13 +0200
Subject: [RFC v0 1/2] interconnect: Add generic interconnect controller API
In-Reply-To: <58B8CFDA.3080303@codeaurora.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
 <20170301182235.19154-2-georgi.djakov@linaro.org>
 <58B8CFDA.3080303@codeaurora.org>
Message-ID: <df0f892b-3318-8316-eafb-07e55ddc5406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 04:07 AM, Saravana Kannan wrote:
> On 03/01/2017 10:22 AM, Georgi Djakov wrote:
>> This patch introduce a new API to get the requirement and configure the
>> interconnect buses across the entire chipset to fit with the current
>> demand.
>>

[..]

>> +int interconnect_set(struct interconnect_path *path, u32 bandwidth)
>> +{
>> +    struct interconnect_node *node;
>> +
>> +    list_for_each_entry(node, &path->node_list, search_list) {
>> +        if (node->icp->ops->set)
>> +            node->icp->ops->set(node, bandwidth);
>
> This ops needs to take a "source" and "dest" input and you'll need to
> pass in the prev/next nodes of each "node" in this list. This is needed
> so that each interconnect know the local source/destination and can make
> the aggregation decisions correctly based on the internal implementation
> of the interconnect. For the first and last nodes in the list, the
> source and destination nodes can be NULL, respectively.

I agree. Updated.

>
>> +    }
>> +
>> +    return 0;
>> +}
>> +

[..]

>> +void interconnect_put(struct interconnect_path *path)
>> +{
>> +    struct interconnect_node *node;
>> +    struct icn_qos *req;
>> +    struct hlist_node *tmp;
>> +
>> +    if (IS_ERR(path))
>> +        return;
>> +
>> +    list_for_each_entry(node, &path->node_list, search_list) {
>> +        hlist_for_each_entry_safe(req, tmp, &node->qos_list, node) {
>> +            if (req->path == path) {
>> +                hlist_del(&req->node);
>> +                kfree(req);
>> +            }
>
> Should we go through and remove any bandwidth votes that were made on
> this path before we free it?
>

Yes, thanks! We should remove the constraints from the path, then
update the nodes and after that free the memory.

>> +        }
>> +    }
>> +
>> +    kfree(path);
>> +}
>> +EXPORT_SYMBOL_GPL(interconnect_put);
>> +
>> +int interconnect_add_provider(struct icp *icp)
>> +{
>> +    struct interconnect_node *node;
>> +
>> +    WARN(!icp->ops->xlate, "%s: .xlate is not implemented\n", __func__);
>> +    WARN(!icp->ops->set, "%s: .set is not implemented\n", __func__);
>> +
>> +    mutex_lock(&interconnect_provider_list_mutex);
>> +    list_add(&icp->icp_list, &interconnect_provider_list);
>> +    mutex_unlock(&interconnect_provider_list_mutex);
>> +
>> +    list_for_each_entry(node, &icp->nodes, icn_list) {
>> +        INIT_HLIST_HEAD(&node->qos_list);
>> +    }
>> +
>> +    dev_info(icp->dev, "added interconnect provider %s\n", icp->name);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(interconnect_add_provider);
>> +
>> +int interconnect_del_provider(struct icp *icp)
>> +{
>> +    mutex_lock(&interconnect_provider_list_mutex);
>> +    of_node_put(icp->of_node);
>> +    list_del(&icp->icp_list);
>
> If there's a path with an active vote, we should probably return a
> -EBUSY to prevent deleting a provider that's actively used?
>

Thanks, sounds good. Will do.

BR,
Georgi
