From: l.majewski@majess.pl (Lukasz Majewski)
Date: Tue, 4 Oct 2016 09:48:05 +0200
Subject: [PATCH v2 0/6] Support PWM polarity control
In-Reply-To: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
Message-ID: <20161004094805.466ebc6d@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bhuvanchandra,

Thank you for your effort to send those patches to ML.

> Changes since v2:
> 
> - Picked the stalled patchset[1] from Lothar Wassmann which adds the
> basic support for polarity control on imx-pwm driver and adds
> backward compatibility support for devices which does not have
> polarity control feature.
> 
> Changes since Lothars v6:
> 
> - Squash Lukasz patch[2].
> 
> [1] http://thread.gmane.org/gmane.linux.pwm/1621
> [2] https://www.spinics.net/lists/arm-kernel/msg530818.html
> 
> Bhuvanchandra DV (3):
>   arm: dts: imx7: Update #pwm-cells for PWM polarity control
>   arm: dts: imx7-colibri: Use pwm polarity control
>   arm: dts: imx7-colibri: Use enable-gpios for BL_ON
> 
> Lothar Wassmann (3):
>   pwm: print error messages with pr_err() instead of pr_debug()
>   pwm: core: make the PWM_POLARITY flag in DTB optional
>   pwm: imx: support output polarity inversion

For some reason this patchset works differently than the one developed
by Lothar.

The difference is with the brightness level control.

My brightness definition in DTS:

           pwms = <&pwm2 0 5000000 PWM_POLARITY_INVERTED>;

 		brightness-levels = <  0   1   2   3   4   5   6   7   8   9

					 ..  ............
				    250 251 252 253 254 255>;
		default-brightness-level = <50>;
		enable-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;

When I go to the backlight sysfs entry:

cd /sys/devices/soc0/backlight/backlight/backlight

It seems like the brightness level control is inverted - i.e. 
'echo 20 > brightness" makes picture on the screen very bright, and 
'echo 200 > brightness' makes the picture diminish.

With my "internal" patches the situation is opposite (and I've checked it with
my HW connections).

Could you check on your setup if similar situation takes place? I mean
if the brightness control works as expected?

Thanks in advance,
?ukasz Majewski

> 
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
>  arch/arm/boot/dts/imx7-colibri.dtsi               | 12 +++++-
>  arch/arm/boot/dts/imx7s.dtsi                      |  8 ++--
>  drivers/pwm/core.c                                | 31 ++++++++------
>  drivers/pwm/pwm-imx.c                             | 51
> +++++++++++++++++++++-- 5 files changed, 83 insertions(+), 25
> deletions(-)
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/797a9606/attachment-0001.sig>
