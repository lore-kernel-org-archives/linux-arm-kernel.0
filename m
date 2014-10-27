From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Oct 2014 13:50:36 +0000
Subject: [PATCH] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20141027135035.GA2629@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suravee,

[...]

>  dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
> +dtb-$(CONFIG_ARCH_SEATTLE) += amd-seattle.dtb

This should move earlier in the list (to keep things organised
alphabetically).

[...]

> +	v2m_serial0: uart at 1010000 {

Drop the "v2m_" prefix -- in other dts that refers to a Versatile
Express ?ATX motherboard (the V2M-P1), and this isn't a Versatile
Express.

Also, I believe the preferred node name is "serial" rather than "uart".

[...]

> +	chosen {
> +		linux,stdout-path = "console=ttyAMA0,115200 earlycon=pl011,0xe1010000";

The stdout-path property should just be a path to the UART node. It's
not a direct replacement for /chosen/bootargs.

This should be (assuming you fix up the label above):

	stdout-path = &serial0;

That will give us earlycon if "earlycon" (with no arguments) is provided
on the command line, and should set up that UART as the console. There's
no need for the "linux," prefix now either.

Unfortuantely, I believe that the UART rate will get changed when the
real PL011 driver registers, unless the rate is explicitly provided on
the command line. It might be worth looking into retaining the
configured rate somehow indepentent of bootargs (unless overriden).

Thanks,
Mark.
