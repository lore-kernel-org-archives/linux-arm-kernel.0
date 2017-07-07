From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Jul 2017 15:39:02 -0700
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <CAF6AEGvH3Vivi8d=MyXsv3x9J9AenAdLN9pr9RtucQ+AwZTO=A@mail.gmail.com>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <20170629124908.GV4902@n2100.armlinux.org.uk>
 <20170629145808.GQ29665@vireshk-i7>
 <20170629154353.GX4902@n2100.armlinux.org.uk>
 <20170629210002.GB22780@codeaurora.org>
 <CAF6AEGvH3Vivi8d=MyXsv3x9J9AenAdLN9pr9RtucQ+AwZTO=A@mail.gmail.com>
Message-ID: <20170707223902.GI22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05, Rob Clark wrote:
> On Thu, Jun 29, 2017 at 5:00 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 06/29, Russell King - ARM Linux wrote:
> >>
> >> As far as the memory being used goes, they probably locate the frame
> >> buffer well away from the kernel or any area that the kernel is likely
> >> to use during decompression.
> >>
> >> It's probably also marked as a reserved memory region in DT to avoid
> >> the kernel touching it during boot, or _maybe_ they just locate it
> >> somewhere in memory that they've tested that the kernel doesn't touch
> >> until after their kernel has initialised the LCD controller (thereby
> >> avoiding the memory being permanently consumed.)
> >>
> >
> > Yes. The display controller is typically pointed to a memory
> > carveout that we treat as reserved in the kernel. I'm fairly
> > certain that we avoid the "permanently consumed" problem by
> > making it a carveout for the display controller, so that when the
> > display controller probes it can take ownership of the memory
> > from the bootloader.
> >
> 
> For aarch64/arm64 booting with EFI, the bootloader passes info about
> memory layout to the kernel (including the fact that the framebuffer
> is carved out) so kernel doesn't clobber the scanout buffer.  The
> non-EFI case, the bootloader should (not that lk does) patch up the
> fdt reserved memory node w/ correct address/size.  I think
> lk+downstream just relies on luck.
> 

Downstream+lk seems to be doing a carveout with reserved-memory
in DT[1]. The bootloader isn't updating the DT to indicate this,
instead we rely on an agreement between bootloader and kernel's
DT file to have the carveout. Once the display driver configures
things enough to allocate another display buffer it actually
frees the memory back to the system[2]. Most of the code for this
splash screen stuff is in that mdss_mdp_splash_logo.c file.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8996.dtsi?h=rel/msm-4.4#n231
[2] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/video/fbdev/msm/mdss_mdp_splash_logo.c?h=rel/msm-4.4#n252

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
