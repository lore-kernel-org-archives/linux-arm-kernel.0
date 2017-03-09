From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Mar 2017 07:26:23 +0000
Subject: FW: undefined instruction: msr s3_0_c12_c11_5, x27
In-Reply-To: <CA+0sSFHdmt=yj=V3aWxyZasP5VicbHRV_RD+6=9RD3hpqmJRwQ@mail.gmail.com>
 (Jerry zzy's message of "Thu, 9 Mar 2017 13:17:25 +0800")
References: <AF7C0ADF1FEABA4DABABB97411952A2EDD08542B@CN-MBX05.HTC.COM.TW>
 <20170308114424.GD20400@arm.com>
 <87shmnyk1y.fsf@on-the-bus.cambridge.arm.com>
 <AF7C0ADF1FEABA4DABABB97411952A2EDD085A44@CN-MBX05.HTC.COM.TW>
 <CA+0sSFHdmt=yj=V3aWxyZasP5VicbHRV_RD+6=9RD3hpqmJRwQ@mail.gmail.com>
Message-ID: <87bmtaykps.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09 2017 at  5:17:25 am GMT, Jerry zzy <zzyjsjcom@gmail.com> wrote:
> Thanks Marc and Will,
>
> I will check these points which you provided, but still have some questions,
>
> For SRE configuration, I have searched from Google, but not luck. do
> you have any information for SRE.

See https://static.docs.arm.com/ihi0069/c/IHI0069C_gic_architecture_specification.pdf
which describe the GICv3 architecture and the role of the various system
registers (section 8.2.22 for ICC_SRE_EL1).

> Do you mean: if ICC_SGI1R_EL1 corrupted, arm will trigger undefined
> instruction. Am I right?

My hunch is that the SRE bit gets cleared, resulting in the
ICC_SGI1R_EL1 register to become undefined.

> Do you mean, SRE configuration state should be correct saved accross
> idle?

None of the GIC configuration should be affected by entering/exiting
idle. The kernel really doesn't expect any of this to be changed behind
its back.

> So maybe there have abnormal interrupt corrupt the register ?

Well, something must somehow disable system register access at the CPU
interface level. It would be worth checking the ICC_SRE_EL1 state before
and after idle to find out.

Thanks,

        M.

> Thanks
>             Jerry.
> ---
> Welcome our free-time team, for free eduction, will be updated.
>
> On Thu, Mar 9, 2017 at 12:50 PM, <zhiyuan_zhu@htc.com> wrote:
>
>     -----Original Message-----
>     From: Marc Zyngier [mailto:marc.zyngier at arm.com]
>     Sent: Wednesday, March 08, 2017 9:28 PM
>     To: Will Deacon
>     Cc: Zhiyuan Zhu(???); catalin.marinas at arm.com; linux-arm-kernel at lists.infradead.org; Zhangru Lin(???);
>     Dennis Zhang(??); Rachel Zhang(??); Reynold Gao(???)
>     Subject: Re: undefined instruction: msr s3_0_c12_c11_5, x27
>    
>     On Wed, Mar 08 2017 at 11:44:25 am GMT, Will Deacon <will.deacon@arm.com> wrote:
>     > [adding Marc, since this is happening as a result of a GICv3 system
>     > register  access]
>     >
>     > Given that you've just come out from idle in your backtrace, I suspect
>     > that your firmware isn't restoring the GIC state properly (e.g. SRE :/).
>     > The pstate looks fine.
>     >
>     > I've kept the original mail below, for Marc to read.
>    
>     Thanks Will.
>    
>     Indeed, it looks like something has (at least) corrupted the ICC_SRE_EL1.SRE state, making the kernel unable
>     to use the GIC system registers.
>    
>     At the first IPI we're trying to send, we'll try to access ICC_SGI1R_EL1 which is now disabled and UNDEFs,
>     resulting in this splat. Clearly, this is not expected, as we only set it when the CPU boots, and we expect
>     the SRE configuration to be preserved (one way or another) across idle.
>    
>     I suspect this is out of tree code (I can't find this msm_mpm_exit_sleep symbol), so I can't be of much help
>     here...
>    
>     Thanks,
>    
>             M.
>     --
>     Jazz is not dead, it just smell funny.
>

-- 
Jazz is not dead, it just smell funny.
