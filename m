From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Jul 2015 09:51:40 +0100
Subject: [PATCH v7 09/11] KVM: arm64: guest debug, HW assisted debug
 support
In-Reply-To: <87h9plrzqq.fsf@linaro.org>
References: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
 <1435775343-20034-10-git-send-email-alex.bennee@linaro.org>
 <20150702084847.GB3418@arm.com> <87pp4asm6u.fsf@linaro.org>
 <20150703092323.GA1588@arm.com> <87h9plrzqq.fsf@linaro.org>
Message-ID: <20150706085140.GA30342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 03, 2015 at 05:07:41PM +0100, Alex Benn?e wrote:
> Will Deacon <will.deacon@arm.com> writes:
> > On Thu, Jul 02, 2015 at 02:50:33PM +0100, Alex Benn?e wrote:
> >> Are you happy with this?:
> >
> > [...]
> >
> >> +/**
> >> + * kvm_arch_dev_ioctl_check_extension
> >> + *
> >> + * We currently assume that the number of HW registers is uniform
> >> + * across all CPUs (see cpuinfo_sanity_check).
> >> + */
> >>  int kvm_arch_dev_ioctl_check_extension(long ext)
> >>  {
> >>         int r;
> >> @@ -64,6 +71,12 @@ int kvm_arch_dev_ioctl_check_extension(long ext)
> >>         case KVM_CAP_ARM_EL1_32BIT:
> >>                 r = cpu_has_32bit_el1();
> >>                 break;
> >> +       case KVM_CAP_GUEST_DEBUG_HW_BPS:
> >> +               r = hw_breakpoint_slots(TYPE_INST);
> >> +               break;
> >> +       case KVM_CAP_GUEST_DEBUG_HW_WPS:
> >> +               r  = hw_breakpoint_slots(TYPE_DATA);
> >> +               break;
> >
> > Whilst I much prefer this code, it actually adds an unwanted dependency
> > on PERF_EVENTS that I didn't think about to start with. Sorry to keep
> > messing you about -- I guess your original patch is the best thing after
> > all.
> 
> Everything looks to be in hw_breakpoint.[ch] which does depend on
> CONFIG_HAVE_HW_BREAKPOINT which depends on PERF_EVENTS to be built.
> However the previous code depended on this behaviour as well.

I think your original approach (of sticking stuff in the header file) works
regardless of the CONFIG option, no?

> It would seem weird to enable guest debug using HW debug registers to
> debug the guest yet not allowing the host kernel to use them? Of course
> this is the only code they would share as all the magic of guest
> debugging is already mostly there for dirty guest handling.
> 
> I'm not familiar with Kconfig but it looks like this is all part of
> arm64 defconfig. Are people really going to want to disable PERF_EVENTS
> but still debug their guests with HW support?

Then it's your call. I just find the host dependency on perf a bit weird
to get guest debug working (especially as the dependency is completely
"fake" because we don't use any perf infrastructure at all).

Will
