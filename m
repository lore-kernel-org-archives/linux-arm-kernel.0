From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jun 2014 22:15:10 -0700
Subject: [PATCH 1/1] ARM: dts: zynq: Add Parallella device tree
In-Reply-To: <1404075022-28745-2-git-send-email-afaerber@suse.de>
References: <1404075022-28745-1-git-send-email-afaerber@suse.de>
 <1404075022-28745-2-git-send-email-afaerber@suse.de>
Message-ID: <CAOesGMhKY1Lb+o8AbtFXS5c7SLg2uGt4-oosdro2FMj_+bB6Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 29, 2014 at 1:50 PM, Andreas F?rber <afaerber@suse.de> wrote:
> This allows to boot the Adapteva Parallella board to serial console.
>
> Cc: Andreas Olofsson <andreas@adapteva.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Nice and clean DTS, just a couple of comments below.

> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
> new file mode 100644
> index 0000000..98df66c
> --- /dev/null
> +++ b/arch/arm/boot/dts/zynq-parallella.dts
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (c) 2014 SUSE LINUX Products GmbH
> + *
> + * Derived from zynq-zed.dts:
> + *
> + *  Copyright (C) 2011 Xilinx
> + *  Copyright (C) 2012 National Instruments Corp.
> + *  Copyright (C) 2013 Xilinx
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +
> +/ {
> +       model = "Parallella Board";
> +       compatible = "xlnx,zynq-7000";

This should have a more specific compatible as the first one. Probably
something like:
   compatible = "adapteva,parallella", "xlnx,zynq-7000";

> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0 0x20000000>;

Does the bootloader update this entry, or is it truly static? If it's
updated then it's become recent habit to leave the memory size empty
in the static file.

> +       };
> +
> +       chosen {
> +               bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
> +       };
> +};

A bit more torn on this one, I'm OK with it staying in even if
firmware overrides for all practical purposes since it's good to keep
around for reference w.r.t. console. Note that we're starting to move
over to using /chosen/stdout-path, so you might want to add that now
instead of later.


-Olof
