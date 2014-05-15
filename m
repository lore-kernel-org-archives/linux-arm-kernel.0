From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 15 May 2014 11:57:38 +0300
Subject: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
In-Reply-To: <20140513213205.GB18001@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-5-git-send-email-tony@atomide.com>
 <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com>
 <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com>
 <20140509153723.GD17814@atomide.com> <20140513213205.GB18001@atomide.com>
Message-ID: <53748182.1080705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/14 00:32, Tony Lindgren wrote:

> +&lcd0 {
> +	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
> +	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
> +	/*
> +	 * The LCD is sideways, so we want the VGA mode instead of
> +	 * QVGA mode. Probably also want to have omapfb.rotate=3
> +	 * in the kernel cmdline until there's a binding for that.
> +	 */
> +	mode-gpios = <&gpio5 26 GPIO_ACTIVE_LOW		/* gpio154, lcd MO */
> +		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
> +		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */

I don't think that is correct. The panel bindings should define what the
first mode-gpio means. Looking at the panel spec, I think the definition
should be "enable QVGA mode". And in the board's dts above, the
GPIO_ACTIVE_x should tell which is one is correct polarity for QVGA
mode. Which is GPIO_ACTIVE_HIGH here.

If we want to tell the panel driver to use QVGA mode, we should do that
explicitly with a flag, not by hacking the GPIO polarities. It's the
panel driver's job to set the GPIO.

So in the previous mail I suggested the 'vga-mode' flag, but I think we
need actually two flags for each GPIO: one that's used to tell the
driver which mode we want, which is used if the panel driver has control
for the GPIO, and the other that tells which is the hardwired setting.

Then again, the two cases are exclusive, so maybe a single flag per mode
pin is ok. So, for the MO pin, we could have 'qvga-mode' flag in the
.dts, which means:

"If there is MO gpio, set MO high. If there's no MO gpio, presume MO pin
is pulled up"

Of course, one could argue that, in case MO is controlled with GPIO, the
'qvga-mode' flag is about SW level configuration, not hardware...

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/5136eb07/attachment.sig>
