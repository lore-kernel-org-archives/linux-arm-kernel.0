From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Mar 2017 13:28:25 +0000
Subject: undefined instruction: msr s3_0_c12_c11_5, x27
In-Reply-To: <20170308114424.GD20400@arm.com> (Will Deacon's message of "Wed,
 8 Mar 2017 11:44:25 +0000")
References: <AF7C0ADF1FEABA4DABABB97411952A2EDD08542B@CN-MBX05.HTC.COM.TW>
 <20170308114424.GD20400@arm.com>
Message-ID: <87shmnyk1y.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08 2017 at 11:44:25 am GMT, Will Deacon <will.deacon@arm.com> wrote:
> [adding Marc, since this is happening as a result of a GICv3 system register
>  access]
>
> Given that you've just come out from idle in your backtrace, I suspect
> that your firmware isn't restoring the GIC state properly (e.g. SRE :/).
> The pstate looks fine.
>
> I've kept the original mail below, for Marc to read.

Thanks Will.

Indeed, it looks like something has (at least) corrupted the
ICC_SRE_EL1.SRE state, making the kernel unable to use the GIC system
registers.

At the first IPI we're trying to send, we'll try to access ICC_SGI1R_EL1
which is now disabled and UNDEFs, resulting in this splat. Clearly,
this is not expected, as we only set it when the CPU boots, and we
expect the SRE configuration to be preserved (one way or another) across
idle.

I suspect this is out of tree code (I can't find this msm_mpm_exit_sleep
symbol), so I can't be of much help here...

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
