From: gmbnomis@gmail.com (Simon Baatz)
Date: Tue, 19 Jun 2012 09:18:54 +0200
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex Net
In-Reply-To: <CAMW5UfaUBROU4o+1jz9O0AxTAgN6e0bjOX=T7YwQvomCTec3aQ@mail.gmail.com>
References: <CAMW5UfaUBROU4o+1jz9O0AxTAgN6e0bjOX=T7YwQvomCTec3aQ@mail.gmail.com>
Message-ID: <20120619071854.GA28421@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Mon, Jun 18, 2012 at 08:35:27PM -0400, Josh Coombs wrote:
> This is an attempt to get the Seagate GoFlex Net booting using
> Kirkwood DTS support based on Arch Linux ARM's non-DTS GFN patches.
> Currently 3.5rc3 will load and begin initializing, but stops without
> error before mounting a rootfs and starting init.  This patch is based
> on 3.5rc3 with the printk fix already applied.  The only oddity I can
> pick out from dmesg is the console attaching to ttyS0 twice.

It looks like you don't enable NAND (the GoFlex Net has NAND, isn't
it?). The problem is that the associated clock (runit) seems also to
be used for other purposes and the machine locks up when it is
disabled if neither NAND nor SPI are used. 

Thus, you either need to find Andrew's patch (can't lookup the URL
currently, the title is "Fix crash when neither NAND nor SPI") to
always enable the clock or you should add a nand part to your dts
file.


...
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/physmap.h>
...
> +
> +struct mtd_partition goflexnet_partitions[] = {
> +	{
> +		.name	= "u-boot",
> +		.size	= SZ_1M,
> +		.offset = 0,
> +	},
> +	{
> +		.name	= "uImage",
> +		.size	= SZ_4M,
> +		.offset = MTDPART_OFS_NXTBLK,
> +	},
> +	{
> +		.name	= "pogoplug",
> +		.size	= SZ_32M,
> +		.offset = MTDPART_OFS_NXTBLK,
> +	},
> +	{
> +		.name	= "root",
> +		.size	= MTDPART_SIZ_FULL,
> +		.offset = MTDPART_OFS_NXTBLK,
> +	},
> +};
> +

You can remove this. I think it is not used and it should be defined
in the dts anyway.


- Simon
