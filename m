From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 27 Jun 2018 08:19:20 +0200
Subject: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
In-Reply-To: <20180620121141.15403-2-georgi.djakov@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
Message-ID: <CAKfTPtBApjf9rhJm3paeXdgbVG50ALeun=zMUddc-f+RnrvkqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Georgi

On Wed, 20 Jun 2018 at 14:11, Georgi Djakov <georgi.djakov@linaro.org> wrote:

[snip]

> +
> +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
> +{
> +       struct icc_node *node = dst;
> +       struct icc_path *path;
> +       size_t i;
> +
> +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),

Should be (num_nodes -1) * sizeof(*path->reqs) as there is already 1
icc_req in icc_path struct

> +                      GFP_KERNEL);
> +       if (!path)
> +               return ERR_PTR(-ENOMEM);
> +
> +       path->num_nodes = num_nodes;
> +
> +       for (i = 0; i < num_nodes; i++) {
> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
> +
> +               path->reqs[i].node = node;
> +               /* reference to previous node was saved during path traversal */
> +               node = node->reverse;
> +       }
> +
> +       return path;
> +}
> +

[snip]
