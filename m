From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Oct 2015 12:33:34 +0000
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <CACRpkdbpD+Kr01hDc7QnL4x_4=A_rnAO+G0CaMce8+5ns+bx2Q@mail.gmail.com>
References: <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
 <CACRpkdb1XRSq3EERbiMwCnuV7Dtit2xGYRDBtQ9+odyXq6kM7A@mail.gmail.com>
 <20151020112026.GF10728@bivouac.eciton.net>
 <CAD0U-hKZM-A2N_Lpnzwkt0WmAi+kRR=UOEE4Vr2M-iTo9ikkOg@mail.gmail.com>
 <CACRpkdZ2Ydyzf9rHOgjZ_KhhxqFi_cK1-Jh47Fh+SP4YGjg_EA@mail.gmail.com>
 <562F6799.1060301@arm.com>
 <CACRpkdbpD+Kr01hDc7QnL4x_4=A_rnAO+G0CaMce8+5ns+bx2Q@mail.gmail.com>
Message-ID: <20151027123334.GC3091@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 01:22:39PM +0100, Linus Walleij wrote:
> On Tue, Oct 27, 2015 at 1:01 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On 27/10/15 11:55, Linus Walleij wrote:
> >> On Wed, Oct 21, 2015 at 12:07 PM, Ryan Harkin <ryan.harkin@linaro.org>
> >> wrote:
> >>
> >>> FYI, in the latest Juno motherboard firmware [1], I have a file called
> >>> "blank.img" in the NOR flash at address 0x0BFC0000 that represents the
> >>> UEFI
> >>> (and now u-boot) config area at the end of the NOR flash.
> >>>
> >>> I mostly put this there so that you can "touch blank.img" to erase the
> >>> config, but also to show that the region is reserved to anyone who might
> >>> think about putting something there.
> >>
> >>
> >> Then it is safe to enable NOR flash and AFS in the kernel.
> >
> > *No*, not on Juno. If we need to enable them for other platforms, then
> > we should either disable NOR flash in DT(or even remove it completely
> > whichever is appropriate).
> >
> > Since idle is enable in defconfig and if DT has idle states, then it
> > can't boot for the reason I previously mentioned.
> 
> Yeah right I remember that now. Let's say it is safe to enable
> for the tamper-security reason. There may be other reasons
> not to...
> 
> If this is about different idle functionalities blocking flash
> access, what we should do is to in Kconfig make it impossible
> to compile in both deep idle states and flash support at the
> same time, as that is how the system really behaves.
> 
> I.e do you mean something like this, or am I getting it wrong?
> 
> index 21340e0be73e..07d91776bcfe 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -4,6 +4,7 @@
>  config ARM_CPUIDLE
>          bool "Generic ARM/ARM64 CPU idle Driver"
>          select DT_IDLE_STATES
> +       depends on !(ARCH_VEXPRESS && MTD)
>          help
>            Select this to enable generic cpuidle driver for ARM.
>            It provides a generic idle driver whose idle states are configured
> 
> Hiding hardware from the devicetree seems over the top to me,
> it is better to keep the device trees describing the actual hardware
> and the operating system to figure out how things need to be
> set up to interoperate, at config-time or run-time.

... except that the current bindings do not imply any of said
negotiation, and imply that the hardware is available for use. We'd need
new bindings to describe that.

For situations like these we typically have the node, but ensure that it
has status = "disabled". That way the DT is safe by default, and FW can
grant the OS the ability to use the hardware by replacing/removing the
status property.

It sounds like even for U-Boot, PSCI* and Non-secure OS access to the NOR
are mutually exclusive. Given the inability to describe that constraint,
the only agent that can possibly filter the DT appropriately is the FW.

* Sudeep, I assume the constraints on CPU_SUSPEND would also apply to
  CPU_ON, is that correct?

Thanks,
Mark.
