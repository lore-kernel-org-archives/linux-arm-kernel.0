From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 06 Jun 2013 00:34:22 +0100
Subject: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
In-Reply-To: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20130605233422.3D6DE3E10E4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  5 Apr 2013 09:48:08 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
[...]
> irq_of_parse_and_map() calls to irq_create_of_mapping() which calls to
> the correct xlate function handler according to "#interrupt-cells"
> (irq_domain_xlate_onecell or irq_domain_xlate_twocell) and to
> irq_set_irq_type() to set the IRQ type.
> 
> But the type is never returned so it can't be saved on the IRQ struct
> resource flags member.
> 
> This means that drivers that need the IRQ type/level flags defined in
> the DT won't be able to get it.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
[...]
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 535cecf..98aec57 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -66,6 +66,10 @@ extern int of_irq_map_one(struct device_node *device, int index,
>  extern unsigned int irq_create_of_mapping(struct device_node *controller,
>  					  const u32 *intspec,
>  					  unsigned int intsize);
> +extern unsigned int irq_create_of_mapping_type(struct device_node *controller,
> +					       const u32 *intspec,
> +					       unsigned int intsize,
> +					       unsigned int *otype);

I count 11 users of irq_create_of_mapping(). That's a managable number
to update. Instead of creating a new function, please modify the
existing one and split it off into a separate patch.

Otherwise the patch looks fine to me.

g.
