From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 28 Jun 2017 19:45:00 +0200
Subject: [PATCH v1 1/3] interconnect: Add generic interconnect controller
 API
In-Reply-To: <20170627174903.27978-2-georgi.djakov@linaro.org>
References: <20170627174903.27978-1-georgi.djakov@linaro.org>
 <20170627174903.27978-2-georgi.djakov@linaro.org>
Message-ID: <CAKfTPtCLf-JAKM5MD-pe-az3xUF_4nYtYvnsZpztmtaqk0C4PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Georgi,

On 27 June 2017 at 19:49, Georgi Djakov <georgi.djakov@linaro.org> wrote:

[snip]

> +
> +static int interconnect_aggregate(struct interconnect_node *node,
> +                                 struct interconnect_creq *creq)
> +{
> +       int ret = 0;
> +
> +       mutex_lock(&node->icp->lock);
> +
> +       if (node->icp->ops->aggregate) {
> +               ret = node->icp->ops->aggregate(node, creq);
> +               if (ret) {
> +                       pr_info("%s: error (%d)\n", __func__, ret);
> +                       goto out;
> +               }
> +       } else {
> +               /* do not aggregate by default */
> +               struct icp *icp = node->icp;
> +
> +               icp->creq.avg_bw = creq->avg_bw;
> +               icp->creq.peak_bw = creq->peak_bw;

Does it means that by default the last caller defines the bandwidth
for everybody ?
IMHO, having a default aggregation policy that sums the avg_bw of all
request of the node
and that gets the max of peak_bw of all request of a node is better

> +       }
> +
> +out:
> +       mutex_unlock(&node->icp->lock);
> +       return ret;
> +}
> +
> +/**
> + * interconnect_set() - set constraints on a path between two endpoints
> + * @path: reference to the path returned by interconnect_get()
> + * @creq: request from the consumer, containing its requirements
> + *
> + * This function is used by an interconnect consumer to express its own needs
> + * in term of bandwidth and QoS for a previously requested path between two
> + * endpoints. The requests are aggregated and each node is updated accordingly.
> + *
> + * Returns 0 on success, or an approproate error code otherwise.
> + */
> +int interconnect_set(struct interconnect_path *path,
> +                    struct interconnect_creq *creq)
> +{
> +       struct interconnect_node *next, *prev = NULL;
> +       size_t i;
> +       int ret = 0;
> +
> +       for (i = 0; i < path->num_nodes; i++, prev = next) {
> +               next = path->reqs[i].node;
> +
> +               if (!next || !prev)

This needs a comment with an explanation about why you don't do
anything in this case

> +                       continue;
> +
> +               if (next->icp != prev->icp)

This needs a comment with an explanation about why you don't do
anything in this case

> +                       continue;
> +
> +               /* aggregate requests from consumers */

you should update the path->reqs[i].avg_bw and path->reqs[i].peak_bw
with creq values
before aggregating the requests from the different consumer of a node ?

              path->reqs[i].avg_bw = creq->avg_bw
              path->reqs[i].peak_bw = creq->peak_bw

> +               ret = interconnect_aggregate(next, creq);
> +               if (ret)
> +                       goto out;
> +
> +               if (next->icp->ops->set) {
> +                       mutex_lock(&next->icp->lock);
> +                       /* commit the aggregated constraints */
> +                       ret = next->icp->ops->set(prev, next, &next->icp->creq);
> +                       mutex_unlock(&next->icp->lock);
> +                       if (ret)
> +                               goto out;
> +               }
> +       }
> +
> +out:
> +       return ret;
> +}
> +
> +/**
> + * interconnect_get() - return a handle for path between two endpoints
> + * @sdev: source device identifier
> + * @sid: source device port id
> + * @ddev: destination device identifier
> + * @did: destination device port id
> + *
> + * This function will search for a path between two endpoints and return an
> + * interconnect_path handle on success. Use interconnect_put() to release
> + * constraints when the they are not needed anymore.
> + *
> + * Return: interconnect_path pointer on success, or ERR_PTR() on error
> + */
> +struct interconnect_path *interconnect_get(const char *sdev, const int sid,
> +                                          const char *ddev, const int did)
> +{
> +       struct interconnect_node *src, *dst;
> +       struct interconnect_path *path;
> +       int ret;
> +
> +       src = node_find(sdev, sid);
> +       if (IS_ERR(src))
> +               return ERR_CAST(src);
> +
> +       dst = node_find(ddev, did);
> +       if (IS_ERR(dst))
> +               return ERR_CAST(dst);
> +
> +       /* TODO: cache the path */
> +       path = path_find(src, dst);
> +       if (IS_ERR(path)) {
> +               pr_err("error finding path between %p and %p (%ld)\n",
> +                      src, dst, PTR_ERR(path));
> +               return path;
> +       }
> +
> +       ret = path_init(path);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return path;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_get);
> +
> +/**
> + * interconnect_put() - release the reference to the interconnect_path
> + *
> + * @path: interconnect path
> + *
> + * Use this function to release the path and free the memory when setting
> + * constraints on the path is no longer needed.
> + */
> +void interconnect_put(struct interconnect_path *path)
> +{
> +       struct interconnect_creq creq = { 0, 0 };
> +       struct interconnect_node *node;
> +       size_t i;
> +       int ret;
> +
> +       if (IS_ERR(path))
> +               return;
> +
> +       for (i = 0; i < path->num_nodes; i++) {
> +               node = path->reqs[i].node;
> +
> +               /*
> +                * Remove the constraints from the path,
> +                * update the nodes and free the memory
> +                */
> +               ret = interconnect_set(path, &creq);
> +               if (ret)
> +                       pr_err("%s error %d\n", __func__, ret);
> +
> +               node->icp->users--;
> +       }
> +
> +       kfree(path);
> +}
> +EXPORT_SYMBOL_GPL(interconnect_put);
> +
> +/**
> + * interconnect_add_provider() - add a new interconnect provider
> + * @icp: the interconnect provider that will be added into topology
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int interconnect_add_provider(struct icp *icp)
> +{
> +       WARN(!icp->ops->set, "%s: .set is not implemented\n", __func__);
> +
> +       mutex_lock(&interconnect_provider_list_mutex);
> +       mutex_init(&icp->lock);
> +       list_add(&icp->icp_list, &interconnect_provider_list);
> +       mutex_unlock(&interconnect_provider_list_mutex);
> +
> +       dev_info(icp->dev, "interconnect provider is added to topology\n");
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_add_provider);
> +
> +/**
> + * interconnect_del_provider() - delete previously added interconnect provider
> + * @icp: the interconnect provider that will be removed from topology
> + *
> + * Return: 0 on success, or an error code otherwise
> + */
> +int interconnect_del_provider(struct icp *icp)
> +{
> +       mutex_lock(&icp->lock);
> +       if (icp->users) {
> +               mutex_unlock(&icp->lock);
> +               return -EBUSY;
> +       }
> +       mutex_unlock(&icp->lock);
> +
> +       mutex_lock(&interconnect_provider_list_mutex);
> +       list_del(&icp->icp_list);
> +       mutex_unlock(&interconnect_provider_list_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(interconnect_del_provider);
> +
> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org");
> +MODULE_DESCRIPTION("Interconnect Driver Core");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/interconnect-consumer.h b/include/linux/interconnect-consumer.h
> new file mode 100644
> index 000000000000..c8055f936ff3
> --- /dev/null
> +++ b/include/linux/interconnect-consumer.h
> @@ -0,0 +1,72 @@
> +/*
> + * Copyright (c) 2017, Linaro Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _LINUX_INTERCONNECT_CONSUMER_H
> +#define _LINUX_INTERCONNECT_CONSUMER_H
> +
> +struct interconnect_node;
> +struct interconnect_path;
> +
> +#if IS_ENABLED(CONFIG_INTERCONNECT)
> +
> +struct interconnect_path *interconnect_get(const char *sdev, const int sid,
> +                                          const char *ddev, const int did);
> +
> +void interconnect_put(struct interconnect_path *path);
> +
> +/**
> + * struct creq - interconnect consumer request
> + * @avg_bw: the average requested bandwidth (over longer period of time) in kbps
> + * @peak_bw: the peak (maximum) bandwidth in kpbs
> + */
> +struct interconnect_creq {
> +       u32 avg_bw;
> +       u32 peak_bw;
> +};
> +
> +/**
> + * interconnect_set() - set constraints on a path between two endpoints
> + * @path: reference to the path returned by interconnect_get()
> + * @creq: request from the consumer, containing its requirements
> + *
> + * This function is used by an interconnect consumer to express its own needs
> + * in term of bandwidth and QoS for a previously requested path between two
> + * endpoints. The requests are aggregated and each node is updated accordingly.
> + *
> + * Returns 0 on success, or an approproate error code otherwise.
> + */
> +int interconnect_set(struct interconnect_path *path,
> +                    struct interconnect_creq *creq);
> +
> +#else
> +
> +inline struct interconnect_path *interconnect_get(const char *sdev,
> +                                                        const int sid,
> +                                                        const char *ddev,
> +                                                        const int did)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
> +
> +inline void interconnect_put(struct interconnect_path *path)
> +{
> +}
> +
> +inline int interconnect_set(struct interconnect_path *path, u32 bandwidth)
> +{
> +       return -ENOTSUPP
> +}
> +
> +#endif /* CONFIG_INTERCONNECT */
> +
> +#endif /* _LINUX_INTERCONNECT_CONSUMER_H */
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> new file mode 100644
> index 000000000000..84b9c7130553
> --- /dev/null
> +++ b/include/linux/interconnect-provider.h
> @@ -0,0 +1,120 @@
> +/*
> + * Copyright (c) 2017, Linaro Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _LINUX_INTERCONNECT_PROVIDER_H
> +#define _LINUX_INTERCONNECT_PROVIDER_H
> +
> +#include <linux/interconnect-consumer.h>
> +
> +/**
> + * struct icp_ops - platform specific callback operations for interconnect
> + * providers that will be called from drivers
> + *
> + * @aggregate: aggregate constraints with the current configuration
> + * @set: set constraints on interconnect
> + */
> +struct icp_ops {
> +       int (*aggregate)(struct interconnect_node *node,
> +                        struct interconnect_creq *creq);
> +       int (*set)(struct interconnect_node *src, struct interconnect_node *dst,
> +                  struct interconnect_creq *creq);
> +};
> +
> +/**
> + * struct icp - interconnect provider (controller) entity that might
> + * provide multiple interconnect controls
> + *
> + * @icp_list: list of the registered interconnect providers
> + * @nodes: internal list of the interconnect provider nodes
> + * @ops: pointer to device specific struct icp_ops
> + * @dev: the device this interconnect provider belongs to
> + * @lock: a lock to protect creq and users
> + * @creq: the actual state of constraints for this interconnect provider
> + * @users: count of active users
> + * @data: pointer to private data
> + */
> +struct icp {
> +       struct list_head        icp_list;
> +       struct list_head        nodes;
> +       const struct icp_ops    *ops;
> +       struct device           *dev;
> +       struct mutex            lock;
> +       struct interconnect_creq creq;
> +       int                     users;
> +       void                    *data;
> +};
> +
> +/**
> + * struct interconnect_node - entity that is part of the interconnect topology
> + *
> + * @links: links to other interconnect nodes
> + * @num_links: number of links to other interconnect nodes
> + * @icp: points to the interconnect provider of this node
> + * @icn_list: list of interconnect nodes
> + * @search_list: list used when walking the nodes graph
> + * @reverse: pointer to previous node when walking the nodes graph
> + * @is_traversed: flag that is used when walking the nodes graph
> + * @req_list: a list of QoS constraint requests
> + * @dev_id: device id
> + * @con_id: connection id
> + */
> +struct interconnect_node {
> +       struct interconnect_node **links;
> +       size_t                  num_links;
> +
> +       struct icp              *icp;
> +       struct list_head        icn_list;
> +       struct list_head        search_list;
> +       struct interconnect_node *reverse;
> +       bool                    is_traversed;
> +       struct hlist_head       req_list;
> +
> +       const char              *dev_id;
> +       int                     con_id;
> +};
> +
> +/**
> + * struct interconnect_req - constraints that are attached to each node
> + *
> + * @req_node: the linked list node
> + * @node: the interconnect node to which this constraint applies
> + * @avg_bw: an integer describing the average bandwidth in kbps
> + * @peak_bw: an integer describing the peak bandwidth in kbps
> + */
> +struct interconnect_req {
> +       struct hlist_node req_node;
> +       struct interconnect_node *node;
> +       u32 avg_bw;
> +       u32 peak_bw;
> +};
> +
> +#if IS_ENABLED(CONFIG_INTERCONNECT)
> +
> +int interconnect_add_provider(struct icp *icp);
> +int interconnect_del_provider(struct icp *icp);
> +
> +#else
> +
> +static inline int interconnect_add_provider(struct icp *icp)
> +{
> +       return -ENOTSUPP;
> +}
> +
> +static inline int interconnect_del_provider(struct icp *icp)
> +{
> +       return -ENOTSUPP;
> +}
> +
> +#endif /* CONFIG_INTERCONNECT */
> +
> +#endif /* _LINUX_INTERCONNECT_PROVIDER_H */
