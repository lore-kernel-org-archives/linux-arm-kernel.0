From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 May 2018 13:53:18 +0530
Subject: [PATCH] ARM: dts: da850-lcdk: increase the size of the u-boot
 nand partition
In-Reply-To: <20180504080835.28632-1-brgl@bgdev.pl>
References: <20180504080835.28632-1-brgl@bgdev.pl>
Message-ID: <a998535f-8963-9e95-0652-b6ac16a13afa@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Friday 04 May 2018 01:38 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Current mainline u-boot builds images that are bigger than the 0x80000
> bytes u-boot partition allocated from the NAND memory. Using the free
> space partition results in an unbootable system. Increase the partition
> size to 0xa0000 bytes.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 7de302f890d7..fc8667445892 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -336,11 +336,11 @@
>  				partition at 20000 {
>  					/* The LCDK defaults to booting from this partition */
>  					label = "u-boot";
> -					reg = <0x020000 0x080000>;
> +					reg = <0x020000 0x0a0000>;
>  				};
>  				partition at a0000 {
>  					label = "free space";
> -					reg = <0x0a0000 0>;
> +					reg = <0x0c0000 0>;

Unfortunately, we cannot do this because it introduces incompatibility
(data loss) for users who may have some data stored in "free space".

I should have insisted on a lot of padding for the u-boot partition or
asked not to add partitions to DT at all. For now the only solution is
to use command line partitions. They take precedence over DT partitions.

Thanks,
Sekhar
