From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 22 Mar 2016 17:42:00 +0100
Subject: [PATCH] ARM: dts: orion5x: add device tree for kurobox-pro
In-Reply-To: <1458656898-16183-1-git-send-email-rogershimizu@gmail.com>
References: <1458656898-16183-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160322164200.GH5250@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 11:28:18PM +0900, Roger Shimizu wrote:
> Add dts file to support Buffalo/Revogear Kurobox-Pro, which is marvell
> orion5x based 3.5" HDD NAS.
> 
> It's a quite old product and already discontinued. So there's no
> official website for it. But it was an early product which used marvell
> orion5x 88F5182 chipset, it's popular in the community.
> Some unofficial site:
>   - http://buffalo.nas-central.org/wiki/Category:KuroboxPro
>   - http://nice.kaze.com/KUROPRO_ProductSpecifications.pdf
> 
> This device tree is based on the board file:
>   arch/arm/mach-orion5x/kurobox_pro-setup.c

Hi Roger

This looks good, but lets try to figure out the NAND.

> However, the NAND device, which is supported by board file, is not
> supported by device tree yet. So I still want to keep the board file
> for the time being.

> +&devbus_cs0 {
> +	status = "disabled";
> +	devbus,keep-config;
> +
> +	/* According to board file: arch/arm/mach-orion5x/kurobox_pro-setup.c
> +	 * There's a NAND flash on Device Bus CS0, but it fails on probing,
> +	 * so it's disabled here.
> +	 */
> +
> +	flash at 0 {
> +		compatible = "cfi-flash";
> +		reg = <0 0x1000000>;
> +		bank-width = <1>;
> +	};
> +};

kurobox_pro-setup.c says:

/*
 * 256K NOR flash Device bus boot chip select
 */

#define KUROBOX_PRO_NOR_BOOT_BASE       0xf4000000
#define KUROBOX_PRO_NOR_BOOT_SIZE       SZ_256K

/*
 * 256M NAND flash on Device bus chip select 1
 */

#define KUROBOX_PRO_NAND_BASE           0xfc000000
#define KUROBOX_PRO_NAND_SIZE           SZ_2M

So there is a NOR on CS0, not NAND.

static struct platform_device kurobox_pro_nand_flash = {
        .name           = "orion_nand",
        .id             = -1,
        .dev            = {
                .platform_data  = &kurobox_pro_nand_data,
        },
        .resource       = &kurobox_pro_nand_resource,
        .num_resources  = 1,
};

The name "orion_nand" means this fits with the driver:

drivers/mtd/nand/orion_nand.c:

static struct platform_driver orion_nand_driver = {
        .remove         = orion_nand_remove,
        .driver         = {
                .name   = "orion_nand",
                .of_match_table = of_match_ptr(orion_nand_of_match_table),
        },
};

And this uses compatible string         { .compatible = "marvell,orion-nand", },

We need to add this to the dts file. The kirkwood.dtsi might be a good
example to copy.

	Andrew
