From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 22 Sep 2016 22:55:22 +0200
Subject: [PATCH] ARM: dts: exynos: Add reboot reason support for Trats2
In-Reply-To: <87shsrlq1f.fsf@monsta.com>
References: <20160922174606.GA4988@kozik-lap>
 <87shsrlq1f.fsf@monsta.com>
Message-ID: <20160922205522.GA15917@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 08:59:03PM +0200, Wolfgang Wiedmeyer wrote:
> 
> Krzysztof Kozlowski writes:
> 
> > On Thu, Sep 22, 2016 at 06:48:35PM +0200, Wolfgang Wiedmeyer wrote:
> >> This allows to reboot the device into recovery mode and into the download
> >> mode of the bootloader.
> >
> > Which bootloader? Probably UBoot... or Samsung stock one? Could you put
> > that information here?
> 
> I'm only working with the stock one. I was under the impression that the
> stock bootloader cannot be replaced on a i9300 because there's a
> signature check. Is UBoot loaded after the stock one on Trats2 or how
> does this work? I didn't find information on that.

+CC Marek,

Trats2 is working with U-Boot. Just U-Boot. However I never converted S3
into Trats2 on my own. I always used targets prepared to be "Trats2"
type. 

Of course kernel is independent to bootloader but in that case you want
to use a specific interface between kernel and specific bootloader
type/version. In that case - this should be U-Boot, I think.

> 
> >> 
> >> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> >> ---
> >>  arch/arm/boot/dts/exynos4412-trats2.dts | 14 ++++++++++++++
> >>  arch/arm/boot/dts/exynos4x12.dtsi       |  2 +-
> >>  2 files changed, 15 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> >> index 129e973..a38d1e3 100644
> >> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> >> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> >> @@ -1294,3 +1294,17 @@
> >>  	vtmu-supply = <&ldo10_reg>;
> >>  	status = "okay";
> >>  };
> >> +
> >> +&pmu {
> >> +	compatible = "syscon", "simple-mfd";
> >> +
> >> +	reboot-mode {
> >> +		compatible = "syscon-reboot-mode";
> >> +		offset = <0x80c>;
> >> +
> >> +		mode-normal	= <0x12345670>;
> >> +		mode-bootloader	= <0x12345671>;
> >> +		mode-download	= <0x12345671>;
> >> +		mode-recovery	= <0x12345674>;
> >
> > Hmmm, how did you get these values? Are they already supported?
> 
> I only have the vendor source drop as documentation. The magic mode
> values [1] and the offset [2] can be found there.

It would be useful to mention that in commit msg (just the source)...
however as I wrote above, these values should be for U-Boot, not the
stock one.

Best regards,
Krzysztof

> 
> > It would be nice to document them:
> > 1. In Documentation/arm/Samsung/Bootloader-interface.txt
> > 2. In header. I hate such magic numbers... you could add new header next
> >    to existing rockchip one:
> >    include/dt-bindings/soc/samsung,boot-mode.h
> >    (and update maintainers entry :) )
> 
> Thanks for the review! I will do the documentation and update the commit
> message.
> 
> Best regards,
> Wolfgang
> 
> [1] https://code.fossencdi.org/kernel_samsung_smdk4412.git/tree/arch/arm/mach-exynos/sec-reboot.c#n65
> 
> [2] https://code.fossencdi.org/kernel_samsung_smdk4412.git/tree/arch/arm/mach-exynos/include/mach/regs-pmu.h#n79
> 
> 
> -- 
> Website: https://fossencdi.org
> Jabber: wolfgang at wiedmeyer.de
> OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
> Key download: https://wiedmeyer.de/keys/ww.asc
