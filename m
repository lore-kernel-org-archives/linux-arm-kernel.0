From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 5 Oct 2015 09:55:28 +0800
Subject: [linux-sunxi] [PATCH 1/3] ARM: dts: sun4i: Allow to use the PH6
 pin for GPIO on pcDuino1/2
In-Reply-To: <1443985128-23137-2-git-send-email-siarhei.siamashka@gmail.com>
References: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
 <1443985128-23137-2-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <CAGb2v65n6ymon+sEASa726sam0KLOvMPbxTxCqvV4j0ust2PCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 5, 2015 at 2:58 AM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> The pcDuino1 board does not use any power switches at all for its
> two USB host ports and the VBUS pins are always connected to 5V.
>
> The pcDuino2 board uses the RT9701GB power switch for its single
> USB host port, but the USB_EN pin (PD2) is pulled up with a 10K
> resistor. So that the USB power is still enabled by default even
> if nobody bothers to configure the PD2 pin or runs the pcDuino1
> firmware.

Seems like it would be better if you had a regulator controlled
by PD2. At least can shut down VBUS power when it wants to?

ChenYu

> The current dts file unnecessarily meddles with the PH3 and PH6
> pins. But the PH6 pin is available on the J11 expansion header
> and may have a better use for other purposes. This patch fixes
> the problem and now the PH6 pin can be used with the GPIO sysfs
> interface. Tested on a pcDuino2 board and confirmed the voltage
> on the PH6 pin with a multimeter:
>
>     echo 230 > /sys/class/gpio/export
>     echo "out" > /sys/class/gpio/gpio230/direction
>     echo 0 > /sys/class/gpio/gpio230/value
>     echo 1 > /sys/class/gpio/gpio230/value
>
> USB still works as expected too.
>
> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts | 10 ----------
>  1 file changed, 10 deletions(-)
