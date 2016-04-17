From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 17 Apr 2016 14:29:33 +0200
Subject: [PATCH] ARM: dts: omap3-n900: Specify peripherals LDO regulators
 initial mode
In-Reply-To: <571329B0.9060503@gmail.com>
References: <1460788643-18590-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160417000536.GA1124@earth> <571329B0.9060503@gmail.com>
Message-ID: <20160417122933.GA8093@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Apr 17, 2016 at 09:14:08AM +0300, Ivaylo Dimitrov wrote:
> On 17.04.2016 03:05, Sebastian Reichel wrote:
> >On Sat, Apr 16, 2016 at 09:37:23AM +0300, Ivaylo Dimitrov wrote:
> >>Without that, regulators are left in the mode last set by the bootloader or
> >>by the kernel the device was rebooted from. This leads to various problems
> >>like non-working peripherals.
> >>
> >>Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> >>---
> >>  arch/arm/boot/dts/omap3-n900.dts | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >>diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> >>index b3c26a9..1bb36e2 100644
> >>--- a/arch/arm/boot/dts/omap3-n900.dts
> >>+++ b/arch/arm/boot/dts/omap3-n900.dts
> >>@@ -329,6 +329,7 @@
> >>  	regulator-name = "V28";
> >>  	regulator-min-microvolt = <2800000>;
> >>  	regulator-max-microvolt = <2800000>;
> >>+	regulator-initial-mode = <0x0e>;
> >>  	regulator-always-on; /* due to battery cover sensor */
> >>  };
> >
> >I think this should either get an additional
> >comment like /* MODE_NORMAL */ or implemented
> 
> According to the TRM, this is 'ACTIVE state', but that does not fit in the
> regulator framework terminology.

No problem with using STATE_ACTIVE or any other fitting description. IMHO
that "active" is misleading for regulators without "always-on/boot-on" tag,
but that was TI's decision.

> >using a define and a TWL4030_REGULATOR_MODE_NORMAL
> >constant to keep the *.dts easily readable.
> 
> We already have RES_STATE_ACTIVE defined in linux/i2c/twl.h, is there a way
> to include that in a dts?

Not in its current state. During kernel build the C preprocessor is
applied on the *.dts files. So the header may only contain
preprocessor macros (e.g. #define). For that solution something like
~/src/linux/include/dt-bindings/regulator/maxim,max77802.h should
be created for the twl regulator.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160417/5d018411/attachment.sig>
