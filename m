From: oss@buserror.net (Scott Wood)
Date: Tue, 28 Jun 2016 21:05:49 -0500
Subject: [PATCH v2 1/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <5771267D.7030102@arm.com>
References: <1463114260-8724-1-git-send-email-oss@buserror.net>
 <20160513112441.200f4349@arm.com> <1466559926.22191.203.camel@buserror.net>
 <5771267D.7030102@arm.com>
Message-ID: <1467165949.32358.16.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-27 at 14:13 +0100, Marc Zyngier wrote:
> On 22/06/16 02:45, Scott Wood wrote:
> > 
> > On Fri, 2016-05-13 at 11:24 +0100, Marc Zyngier wrote:
> > > 
> > > On Thu, 12 May 2016 23:37:39 -0500
> > > Scott Wood <oss@buserror.net> wrote:
> > > 
> > > > +{
> > > > +	u64 cval_old, cval_new;
> > > > +	int timeout = 200;
> > > Can we have a comment on how this value has been chosen??
> > It's an arbitrary value well beyond the point at which we've seen it fail.
> So can we please have a comment *in the code* that explains how this
> value has been picked?

Sure, if you want. ?I just wasn't sure there was much value in a comment that
essentially says that there's no special meaning to this particular value.

> > > > int
> > > > access, unsigned long evt,
> > > > ?	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
> > > > ?}
> > > > ?
> > > > +#ifdef CONFIG_ARM64
> > > > +static __always_inline void rewrite_tval(const int access,
> > > > +		unsigned long evt, struct clock_event_device *clk)
> > > > +{
> > > > +	u64 cval_old, cval_new;
> > > > +	int timeout = 200;
> > > > +
> > > > +	do {
> > > > +		cval_old = __arch_counter_get_cntvct();
> > > > +		arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL,
> > > > evt,
> > > > clk);
> > > > +		cval_new = __arch_counter_get_cntvct();
> > > Don't you need to guarantee the order of accesses here?
> > I'm not 100% sure.??The erratum workaround sample code doesn't show any
> > barriers, and adding more barriers could make it harder for the loop to
> > successfully complete.??There's already a barrier after the write, so the
> > only
> > concern should be whether the timer read could be reordered after the
> > timer
> > write, which could cause the loop to exit even if the write was bad.??Do
> > you
> > know if A53 or A57 will reorder a counter read relative to a tval write?
> I can't see any absolute guarantee that they wouldn't be reordered (but
> I have no insight on the micro-architecture either). I'd rather err on
> the side of caution here.

OK, I'll see how well it works with the added barrier.

> > > > ?			clk->set_state_shutdown =
> > > > arch_timer_shutdown_virt;
> > > > ?			clk->set_state_oneshot_stopped =
> > > > arch_timer_shutdown_virt;
> > > > ?			clk->set_next_event =
> > > > arch_timer_set_next_event_virt;
> > > > +
> > > > +#ifdef CONFIG_ARM64
> > > > +			if
> > > > (static_branch_unlikely(&arch_timer_read_ool_enabled))
> > > > +				clk->set_next_event =
> > > > +					arch_timer_set_next_event_vir
> > > > t_er
> > > > rata;
> > > On the same line, please.
> > I was trying to avoid going beyond 80 columns.
> Please ignore what checkpatch says. Readability is more important (and
> I've given up using a vintage vt100...).

I'm not using a vintage vt100 either but I still have (approximately) 80-
column terminals, because I like having two terminals side-by-side with a
reasonable font size... and since different people have different terminal
setups, CodingStyle specifies a standard limit.

I think I can make it moot with the suggestion to have a helper function,
though.

> > > ?	} else {
> > > > ?		arch_timer_read_counter =
> > > > arch_counter_get_cntvct_mem;
> > > > ?
> > > > @@ -763,6 +870,9 @@ static void __init arch_timer_of_init(struct
> > > > device_node *np)
> > > > ?
> > > > ?	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
> > > > ?
> > > > +	if (of_property_read_bool(np, "fsl,erratum-a008585"))
> > > > +		static_branch_enable(&arch_timer_read_ool_enabled);
> > > > +
> > > > ?	/*
> > > > ?	?* If we cannot rely on firmware initializing the timer
> > > > registers
> > > > then
> > > > ?	?* we should use the physical timers instead.
> > > An outstanding question is how we're going to deal with this in KVM,
> > > because a guest absolutely needs to know about it (I can definitely see
> > > time jumping in guests running on a LS2080).
> > The property will need to be in the guest's device tree.??I'm not too
> > familiar
> > with how KVM handles device trees on arm...??From looking at the QEMU
> > source
> > it seems that the dtb is passed in by the user.??So either that dtb will
> > need
> > the erratum property in it, or QEMU (and KVM tool?) would need to patch it
> > ?into the guest dtb based on seeing the property in /proc/device-tree.
> There is no guarantee that the host device tree is always accessible to
> userspace. So we're probably looking at requiring a new KVM device API
> that would expose the timer properties, one of them being this erratum.
> That's certainly going to be fun to handle.

KVM on PPC relies on /proc/device-tree -- when would it not be available?
?Where is the dtb passed to QEMU expected to come from?

In any case, let's get the kernel sorted out first.

-Scott
