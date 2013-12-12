From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 12 Dec 2013 11:36:42 +0000
Subject: [PATCH v4] ARM/KVM: save and restore generic timer registers
In-Reply-To: <52A982BB.4030901@linaro.org>
References: <1386672625-8060-1-git-send-email-andre.przywara@linaro.org>
 <20131212022822.GI2871@cbox>
 <CAFEAcA_F3T1+YsKKq3h8P139OX085N-PPPPZo5dvwgwcuGoXHg@mail.gmail.com>
 <52A982BB.4030901@linaro.org>
Message-ID: <CAFEAcA8bgy7Gi6aKKiS3d20Jh+_X2AComWTH-+Bwv_gV_zU5-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 December 2013 09:32, Andre Przywara <andre.przywara@linaro.org> wrote:
> On 12/12/2013 10:23 AM, Peter Maydell wrote:
>> What does it mean to say that a system register for AArch64
>> is "32 bits" given that MRS/MSR always operate on a 64 bit
>> register?

> But ARMv8 ARM still defines these registers as 32-bit:
> D8.5.14: CNTV_CTL_EL0
> Attributes
>            CNTV_CTL_EL0 is a 32-bit register.
> But indeed the MSR/MRS instruction references a Xt register, and the
> documentation does not seem to tell how this is handled, so I assume this is
> zero-extended.

I checked, and for AArch64 registers, "32 bits" is just
a shorthand for "64 bit register where the top 32 bits are
RAZ/WI" (and I suspect it's not totally impossible that some
future architecture revision might define new bits in the
top half).

So I would suggest that we should make the KVM user<->kernel
interface just consistently make all the sysregs 64 bit.

(There is actually precedent of a sort here in that the
kernel claims the PSTATE register is 64 bits wide despite
it really being a 32 bit SPSR format value under the hood.)

thanks
-- PMM
