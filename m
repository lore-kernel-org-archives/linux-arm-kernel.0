From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Jul 2015 10:23:23 +0100
Subject: [PATCH v7 09/11] KVM: arm64: guest debug, HW assisted debug
 support
In-Reply-To: <87pp4asm6u.fsf@linaro.org>
References: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
 <1435775343-20034-10-git-send-email-alex.bennee@linaro.org>
 <20150702084847.GB3418@arm.com> <87pp4asm6u.fsf@linaro.org>
Message-ID: <20150703092323.GA1588@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Thu, Jul 02, 2015 at 02:50:33PM +0100, Alex Benn?e wrote:
> Are you happy with this?:

[...]

> +/**
> + * kvm_arch_dev_ioctl_check_extension
> + *
> + * We currently assume that the number of HW registers is uniform
> + * across all CPUs (see cpuinfo_sanity_check).
> + */
>  int kvm_arch_dev_ioctl_check_extension(long ext)
>  {
>         int r;
> @@ -64,6 +71,12 @@ int kvm_arch_dev_ioctl_check_extension(long ext)
>         case KVM_CAP_ARM_EL1_32BIT:
>                 r = cpu_has_32bit_el1();
>                 break;
> +       case KVM_CAP_GUEST_DEBUG_HW_BPS:
> +               r = hw_breakpoint_slots(TYPE_INST);
> +               break;
> +       case KVM_CAP_GUEST_DEBUG_HW_WPS:
> +               r  = hw_breakpoint_slots(TYPE_DATA);
> +               break;

Whilst I much prefer this code, it actually adds an unwanted dependency
on PERF_EVENTS that I didn't think about to start with. Sorry to keep
messing you about -- I guess your original patch is the best thing after
all.

Will
