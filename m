From: panand@redhat.com (Pratyush Anand)
Date: Tue, 7 Jun 2016 20:47:22 +0530
Subject: Support for unaligned watchpoints in arm/arm64
In-Reply-To: <20160607065520.GD13643@dhcppc6>
References: <CAJt8pk8FBbTVMMM45SaEs86MZOp0o6xChAsMT1sO+_Xy-GENyw@mail.gmail.com>
 <20160531123827.GF24936@arm.com> <20160607065520.GD13643@dhcppc6>
Message-ID: <20160607151722.GH13643@dhcppc6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016:12:25:20 PM, Pratyush Anand wrote:
> On 31/05/2016:01:38:27 PM, Will Deacon wrote:
> > On Thu, May 26, 2016 at 05:04:46PM +0100, Pavel Labath wrote:
> > > Hello all,
> > 
> > Hi Pavel,
> > 
> > > I've been wondering if there are any plans about adding support for
> > > unaligned watchpoints to the kernel. It seems quite a shame that
> > > applications are not able not use them, even though the hardware
> > > should support that feature.
> > 
> > I'm actually coming round to the idea of ditching the perf hw_breakpoint
> > mechanism entirely and simply writing a ptrace back-end that can expose
> > the hardware features directly to userspace. The two issues with this
> > are:
> > 
> >   (1) It's a fair amount of work
> 
> So, by the time this new interface would come, probably we can consider a fixup
> like following to resolve this issue at hand. Probably, things should work by
> just allowing hw_breakpoint.c to pass checks for unaligned offset when it is a
> WATCHPOINT, no?

Sorry, this is not going to work.
There could be some BAS values where few consecutive LSBs are 0s.

~Pratyush
> 
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 26a6bf77d272..c803347c1413 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -384,7 +384,12 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
>                 *gen_len = HW_BREAKPOINT_LEN_8;
> @@ -384,7 +384,12 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
>                 *gen_len = HW_BREAKPOINT_LEN_8;
>                 break;
>         default:
> -               return -EINVAL;
> +               if (ctrl.type == ARM_BREAKPOINT_EXECUTE
> +                               || ctrl.len & (ctrl.len + 1)
> +                               || ctrl.len < ARM_BREAKPOINT_LEN_1
> +                               || ctrl.len > ARM_BREAKPOINT_LEN_8)
> +                       return -EINVAL;
> +               *gen_len = ffs(ctrl.len + 1) - 1;
>         }
> 
>         return 0;
> @@ -430,7 +435,11 @@ static int arch_build_bp_info(struct perf_event *bp)
>                 info->ctrl.len = ARM_BREAKPOINT_LEN_8;
>                 break;
>         default:
> -               return -EINVAL;
> +               if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE
> +                               || bp->attr.bp_len < HW_BREAKPOINT_LEN_1
> +                               || bp->attr.bp_len > HW_BREAKPOINT_LEN_8)
> +                       return -EINVAL;
> +               info->ctrl.len = (1 << bp->attr.bp_len) - 1;
>         }
> 
>         /*
> 
> @Pavel, does above patch helps to resolve the issue.
> 
> ~Pratyush
> 
> >   (2) We might already have users of the perf interface (including compat)
> > 
> > I'm really not happy with the way hw_breakpoint worked out :(
> > 
> > Will
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
