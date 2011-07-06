From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 13:55:26 +0200
Subject: [PATCH v3] ARM: l2x0: Add OF based initialization
In-Reply-To: <4E136125.1060502@gmail.com>
References: <1309810556-6224-1-git-send-email-robherring2@gmail.com>
	<20110705035511.GA13713@ponder.secretlab.ca>
	<4E136125.1060502@gmail.com>
Message-ID: <201107061355.27101.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Rob Herring wrote:
> How about something like this:
> 
> >       if (is_pl310) {
> >               if (tag[0] && tag[1] && tag[2])
> >                       writel_relaxed(
> >                               ((tag[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
> >                               ((tag[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
> >                               ((tag[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
> >                               l2x0_base + L2X0_TAG_LATENCY_CTRL);
> > 
> >               if (data[0] && data[1] && data[2])
> >                       writel_relaxed(
> >                               ((data[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
> >                               ((data[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
> >                               ((data[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
> >                               l2x0_base + L2X0_DATA_LATENCY_CTRL);
> > 
> >               return;
> >       }

Sorry if this is degrading into bike-shedding, but I think the cleanest
way to handle this kind of difference is to have separate functions
for pl3xx and l2xx. You can even remove the entire of_device_is_compatible()
check if you use the data field in the match table:

static const struct of_device_id l2x0_ids[] __initconst = {
       { .compatible = "arm,pl310-cache", .data = &l310_of_set_ram_timings },
       { .compatible = "arm,l220-cache",  .data = &l2x0_of_set_ram_timings },
       { .compatible = "arm,l210-cache",  .data = &l2x0_of_set_ram_timings },
       {}
};

int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
{
       struct device_node *np;
       void (*set_ram_timings)(const struct device_node *np,
                              __u32 *aux_val, __u32 *aux_mask);
       void __iomem *l2_base;

       np = of_find_matching_node(NULL, l2x0_ids);
       if (!np)
               return -ENODEV;
       l2_base = of_iomap(np, 0);
       if (!l2_base)
               return -ENOMEM;

       l2x0_of_set_address_filter(np);
       set_ram_timings = of_match_node(np, lx20_ids)->data;
       set_ram_timings(np, &aux_val, &aux_mask);
       l2x0_init(l2_base, aux_val, aux_mask);
       return 0;
}

Either that, or a simpler

	if (of_device_is_compatible(np, "arm,pl310-cache"))
		l310_of_set_ram_timings(np, &aux_val, &aux_mask);
	else
		l2x0_of_set_address_filter(np, &aux_val, &aux_mask);)


	Arnd
