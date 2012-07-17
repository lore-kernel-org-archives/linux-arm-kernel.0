From: nm@ti.com (Menon, Nishanth)
Date: Tue, 17 Jul 2012 02:59:04 -0500
Subject: [PATCHv6 4/7] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
In-Reply-To: <1339428387-4800-5-git-send-email-t-kristo@ti.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
 <1339428387-4800-5-git-send-email-t-kristo@ti.com>
Message-ID: <CAOMWX4fecw5A0BhDG-swVubKtxTEKdNpcODOh7=uFBFbSAnbgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Couple of minor comments:
On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
[...]
>  /**
> + * _omap4_update_context_lost - increment hwmod context loss counter if
> + * hwmod context was lost, and clear hardware context loss reg
> + * @oh: hwmod to check for context loss
> + *
> + * If the PRCM indicates that the hwmod @oh lost context, increment
> + * our in-memory context loss counter, and clear the RM_*_CONTEXT
> + * bits. No return value.
> + */
> +static void _omap4_update_context_lost(struct omap_hwmod *oh)
> +{
> +       u32 r;
> +
> +       if (oh->prcm.omap4.context_offs == USHRT_MAX)
> +               return;
would'nt it be better to return a dummy incremental counter instead of
returning no context loss (count = 0)?

> +
> +       r = omap4_prminst_read_inst_reg(oh->clkdm->pwrdm.ptr->prcm_partition,
> +                                       oh->clkdm->pwrdm.ptr->prcm_offs,
> +                                       oh->prcm.omap4.context_offs);
> +
> +       if (!r)
> +               return;
> +
> +       oh->prcm.omap4.context_lost_counter++;
need to be careful about counter overflow.


Regards,
Nishanth Menon
