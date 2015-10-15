From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Thu, 15 Oct 2015 08:29:42 +0200
Subject: [PATCH V2 6/6] gicv2m: acpi: Introducing GICv2m ACPI support
In-Reply-To: <561F449E.2050803@semihalf.com>
References: <1444865156-9870-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1444865156-9870-7-git-send-email-Suravee.Suthikulpanit@amd.com>
 <561F449E.2050803@semihalf.com>
Message-ID: <561F47D5.6070601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.10.2015 08:15, Tomasz Nowicki wrote:
> Hi Suravee,
>

[...]

> Moreover, seems we need to add irq_domain_free_fwnode to gicv2m_teardown():
>   static void gicv2m_teardown(void)
>   {
>       struct v2m_data *v2m, *tmp;
>
>       list_for_each_entry_safe(v2m, tmp, &v2m_nodes, entry) {
> +        struct fwnode_handle *handle = v2m->fwnode;
> +
>           list_del(&v2m->entry);
>           kfree(v2m->bm);
>           iounmap(v2m->base);
> -        of_node_put(to_of_node(v2m->fwnode));
> +        if (is_of_node(handle))
> +            of_node_put(to_of_node(handle));
> +        else if (is_irqchip_node(handle))
> +            irq_domain_free_fwnode(handle);
>           kfree(v2m);
>       }
>   }
>
Sorry, I missed you already did something similar in your patch.

Tomasz
