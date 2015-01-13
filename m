From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 13 Jan 2015 17:23:21 +0100
Subject: [PATCH v3] Added support for pogoplug e02 (pink/gray)
In-Reply-To: <1421129591-18479-1-git-send-email-junghans@votca.org>
References: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
 <1421129591-18479-1-git-send-email-junghans@votca.org>
Message-ID: <20150113162321.GA13608@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 11:13:11PM -0700, Christoph Junghans wrote:
> From: Christoph Junghans <ottxor@gentoo.org>
> 
> The pogoplug differs from the SheevaPlug only by a
> few details, but especially in the led assignments.
> This patch was tested under Gentoo Linux and is
> based on dts files from Arch Linux ARM and OpenWrt.
> 
> Suggested-by: Felix Kaechele <heffer@fedoraproject.org>
> Suggested-by: Oleg Rakhmanov <moonman.ca@gmail.com>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---
> 
> V1: initial patch
> V2: added GPL-2 header
>     dropped earlyprintk from bootargs
>     added stdout-path
>     change leds name to scheme "devicename:colour:function"
> V3: rebase on v3.19-rc4
>     fixed stdout-path to be &uart0
>     fixed compiling issue by using pin-controller

Hi Christoph

Thanks for adding this list of changes.

> +
> +	ocp at f1000000 {
> +		pinctrl: pin-controller at 10000 {
> +			pmx_usb_power_enable: pmx-usb-power-enable {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_green: pmx-led-green {
> +				marvell,pins = "mpp48";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_orange: pmx-led-orange {
> +				marvell,pins = "mpp49";
> +				marvell,function = "gpio";
> +			};
> +		};

Sorry, should of made myself more clear, when i pointed at:

https://lkml.org/lkml/2014/12/28/34

Please use the label for pinctl, and don't nest it under ocp at f1000000.

> +		serial at 12000 {
> +			status = "ok";
> +		};
> +	};

Same here, just

&uart0 {
	status = "okay";
};

Doing it like this is somewhat new, so most of the other kirkwood
boards don't do this. But we would like all new boards to use this
layout.

	Thanks
		Andrew
