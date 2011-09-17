From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 15:56:14 +0100
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <CAGsJ_4ysZ7C7PZ7eCLyrLuUGux2U8mVknobaJ4tRdk1g97z-dA@mail.gmail.com>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<20110915013937.GE1488@S2100-06.ap.freescale.net>
	<20110915083248.GG6267@n2100.arm.linux.org.uk>
	<CAGsJ_4xpc-8zzGkZ9LThqP7in27n6uX4LRGAf+AtoWTM4p=82w@mail.gmail.com>
	<20110917104518.GD16381@n2100.arm.linux.org.uk>
	<CAGsJ_4ysZ7C7PZ7eCLyrLuUGux2U8mVknobaJ4tRdk1g97z-dA@mail.gmail.com>
Message-ID: <20110917145614.GG16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 10:41:58PM +0800, Barry Song wrote:
> for aux ctrl, it is really simple. but how about the following:
> 
>  393 static void __init pl310_of_setup(const struct device_node *np,
>  394                                   __u32 *aux_val, __u32 *aux_mask)
>  395 {
>  396         u32 data[3] = { 0, 0, 0 };
>  397         u32 tag[3] = { 0, 0, 0 };
>  398         u32 filter[2] = { 0, 0 };
>  399
>  400         of_property_read_u32_array(np, "arm,tag-latency", tag,
> ARRAY_SIZE(tag));
>  401         if (tag[0] && tag[1] && tag[2])
>  402                 writel_relaxed(
>  403                         ((tag[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
>  404                         ((tag[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
>  405                         ((tag[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
>  406                         l2x0_base + L2X0_TAG_LATENCY_CTRL);
>  407
>  408         of_property_read_u32_array(np, "arm,data-latency",
>  409                                    data, ARRAY_SIZE(data));
>  410         if (data[0] && data[1] && data[2])
>  411                 writel_relaxed(
>  412                         ((data[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
>  413                         ((data[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
>  414                         ((data[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
>  415                         l2x0_base + L2X0_DATA_LATENCY_CTRL);
>  416
>  417         of_property_read_u32_array(np, "arm,filter-ranges",
>  418                                    filter, ARRAY_SIZE(filter));
>  419         if (filter[0] && filter[1]) {
>  420                 writel_relaxed(ALIGN(filter[0] + filter[1], SZ_1M),
>  421                                l2x0_base + L2X0_ADDR_FILTER_END);
>  422                 writel_relaxed((filter[0] & ~(SZ_1M - 1)) |
> L2X0_ADDR_FILTER_EN,
>  423                                l2x0_base + L2X0_ADDR_FILTER_START);
>  424         }
>  425 }
> 
> not all l2 have all these registers. for example, it seems only prima2
> has L2X0_ADDR_FILTER_START/END by now. and only some platforms set
> latency too.

Save them as normal.  If there aren't the values in DT, read them in the
above functions and save the value.  Then...

> > and we can do a similar thing when initializing the PL310 and resuming
> > the PL310 - add a new outer_cache callback called 'resume' to be pointed
> > at the relevant resume function which knows which registers to restore.

Do that.

> in my last reply, i also suggested this:
> struct outer_cache_fns {
>        void (*inv_range)(unsigned long, unsigned long);
>        void (*clean_range)(unsigned long, unsigned long);
>        void (*flush_range)(unsigned long, unsigned long);
>        void (*flush_all)(void);
>        void (*inv_all)(void);
>        void (*disable)(void);
> #ifdef CONFIG_OUTER_CACHE_SYNC
>        void (*sync)(void);
> #endif
>        void (*set_debug)(unsigned long);
>  +       void (*save)(void);
>  +      void (*restore)(void);
> };
> 
> but it looks we only need resume since we can save all in init phase:

Correct.

> > That's not possible in SoCs operating in non-secure mode from generic
> > code, as some of these registers will not be accessible. ?They can only
> > be programmed from platform specific code due to the complexities of
> > dealing with the abhorrent secure monitor stuff.
> >
> > I'm now starting to think that we don't actually want any resume code
> > at the L2 level - most SoCs will be operating in non-secure mode (I
> > believe it's only ARM's development platforms which operate in secure
> > mode) and so most of the generic code which will need to write to the
> > L2 control registers on resume will fail.
> 
> that is probably real. at least our team never get any requirement to
> use secure mode.

So probably the best we can do in generic code is present platform code
with a data structure describing the intended register values which were
used at init time, and we leave it to platform code to do the necessary
reprogramming that's required in the way that's required for the
abhorrent secure monitor on their platform.
