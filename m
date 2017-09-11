From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Sep 2017 15:32:18 +0530
Subject: [RFC 2/2] DTS: davinci: da850evm: Enable LCD and Backlight
In-Reply-To: <1504933135-29747-2-git-send-email-aford173@gmail.com>
References: <1504933135-29747-1-git-send-email-aford173@gmail.com>
 <1504933135-29747-2-git-send-email-aford173@gmail.com>
Message-ID: <6cf5489c-0e87-0c9e-23e4-5b5ad40744a2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 September 2017 10:28 AM, Adam Ford wrote:
> When using the board files the LCD works, but not with the DT.
> This adds enables the original da850-evm to work with the same
> LCD in device tree mode.
> 
> RFC:  Currently, I cannot get the backlight to do anything other
> than 100%. I don't get the userspace files to write the brightness.
> Any suggestions on what I am dowing wrong?

Not sure what went wrong for you here, but applying your patches and
building the new kernel & modules did create the
/sys/class/backlight/backlight/brightness needed.

That said, the brightness changes did not seem take effect. I did not
debug it further.

Do you have the pwm_bl and backlight modules loaded?

> RFC:  The board-file version enables the LCD, but the only way
> I can enable the LCD is the disable the VPIF display.  Should
> I use a new name for the this DTS file to maintain compatibility,
> or is there a better way to enable the LCD without losing VPIF

For pinmux clashes of this sort, we need to keep one of the nodes
disabled (status = "disabled"). In future, a device-tree overlay may be
used to enable the node. For now, user has to hand-edit the device-tree
file to disable LCD node and enable VPIF display.

In case of VPIF, it looks like the pins should be part of the display
port node (port at 1) so only the display port can be kept disabled. I have
not tried to see if thats possible.

> Signed-off-by: Adam Ford <aford173@gmail.com>

Can you follow subject line prefix format of existing patches on this
file. See:

$ git log --oneline arch/arm/boot/dts/da850-evm.dts

> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 67e72bc..10df630 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -10,6 +10,7 @@
>  /dts-v1/;
>  #include "da850.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
>  
>  / {
>  	compatible = "ti,da850-evm", "ti,da850";
> @@ -30,6 +31,7 @@
>  					0x04 0x00011000 0x000ff000
>  				>;
>  			};
> +

Please drop this stray change for next time.

Thanks,
Sekhar
