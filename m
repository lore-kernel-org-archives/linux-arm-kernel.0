From: ccross@android.com (Colin Cross)
Date: Fri, 4 Feb 2011 17:32:26 -0600
Subject: [PATCH v2 04/28] ARM: mm: cache-l2x0: Add support for re-enabling
	l2x0
In-Reply-To: <-8932138696981683633@unknownmsgid>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-5-git-send-email-ccross@android.com>
	<1295968464.10109.264.camel@e102109-lin.cambridge.arm.com>
	<20110125154133.GB17280@n2100.arm.linux.org.uk>
	<1295979242.10109.308.camel@e102109-lin.cambridge.arm.com>
	<2f97ec8a084e590220e1548fc927b60e@mail.gmail.com>
	<-8932138696981683633@unknownmsgid>
Message-ID: <AANLkTi=cTXmQFm_s5OL2pGyyaFv5UR_f9MV=S5Ajx0tu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 12:39 PM, Will Deacon <will.deacon@arm.com> wrote:
> Santosh,
>
>> > > Maybe we need a notifier list which can be told when cpuidle
>> > events
>> > > happen, so that parts of the system such as VFP and L2 cache
>> > support
>> > > can do the right thing without having platforms add lots of stuff
>> > like
>> > >
>> > > ? ? ? ? gic_secondary_init();
>> > > ? ? ? ? gic_restore_interrupt_types();
>> > > ? ? ? ? vfp_enable();
>> > > ? ? ? ? l2x0_enable();
>> > > ? ? ? ? twd_enable();
>> > > ? ? ? ? ... etc ...
>> > >
>> > > in their SoC specific code.
>> >
>> > But do we need a strict order between such operations? The notifier
>> > call
>> > chain isn't too flexible.
>> >
>> I guess it does depends on how the archs have integrated a9. Example
>> on OMAP there are different power modes possible.
>> ? ? ? 1. CPU context ,TWD lost
>> ? ? ? 2. CPU context ,TWD + L1 is lost
>> ? ? ? 3. CPU context + L1 is lost + GIC lost
>> ? ? ? 4. CPU context + L1 is lost + GIC lost + L2 lost
>> So there is need to have flexibility of calling these function
>> based on power modes. I don't know how notifiers can give
>> this flexibility
>
> Well if you set the priority fields in the notifier blocks correctly
> then you can just return NOTIFY_STOP when you've saved/restored as much
> as you want. This assumes of course that you can identify which power
> mode you're entering/leaving and that each one is `deeper' than the previous.

I doubt its possible to create an order that will work for all
architectures, and returning NOTIFY_STOP would require the decision on
when to finish to be made by the notifier block instead of the
platform code.

Tegra has three possible idle modes:

1.  WFI - nothing reset
2.  CPU, TWD, L1, GIC lost, L2 needs to be disabled but not reset
3.  CPU, TWD, L1, GIC, and L2 lost

CPU and L1 are already handled by the platform-specific suspend code.
TWD is handled by the clockevents broadcast notifiers.  That leaves L2
and GIC.

The L2 can be idled in two ways: just disable it, but keep the
contents, which prevents having to refill the cache, or a full reset.
Disabling can already be handled by outer_cache_disable().

The GIC needs to be idled differently depending on which cpus are
idle.  On Tegra, if both cpus are idle, the secondary cpu needs to
disable its GIC and go to WFI, while the first cpu saves the GIC
distributor state and powers off both cpus.

While it seems possible to handle all of these cases with a notifier
chain, the amount of platform-specific knowledge and ordering seems
too much to make it worthwhile.

If the ordering requirements are close enough between platforms, or
non-existent (I don't think there are any requirements on Tegra), a
notifier chain with a mask of the hardware that is being reset could
work.  On Tegra, in case 2 above, CPU1 would call:

idle_notify(IDLE_ENTER | GIC_DISABLE)

and CPU0 would call:

idle_notify(IDLE_ENTER | GIC_DISABLE | GIC_SAVE | L2_DISABLE)
