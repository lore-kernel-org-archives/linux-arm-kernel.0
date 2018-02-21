From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 20 Feb 2018 22:01:41 -0500 (EST)
Subject: [PATCH 1/7] ARM: disallow combining XIP and LTO
In-Reply-To: <20180220215954.4092811-2-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20180220215954.4092811-2-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802202158020.31644@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Feb 2018, Arnd Bergmann wrote:

> This fails during deflate_xip_data.sh
> 
>   /home/arnd/cross-gcc/bin/arm-linux-gnueabi-objcopy -O binary -R .comment -S  vmlinux arch/arm/boot/xipImage && /bin/bash -c '/git/arm-soc/arch/arm/boot/deflate_xip_data.sh vmlinux arch/arm/boot/xipImage || { rm -f arch/arm/boot/xipImage; false; }'
> make -f /git/arm-soc/scripts/Makefile.modpost
> + sym_val __data_loc
> + sed -n / __data_loc$/{s/ .*$//p;q}
> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> + local val=ac74c0f4
> + [ ac74c0f4 ]
> + echo 2893332724
> + __data_loc=2893332724
> + sym_val _edata_loc
> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> + sed -n / _edata_loc$/{s/ .*$//p;q}
> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> + local val=ac7b8744
> + [ ac7b8744 ]
> + echo 2893776708
> + _edata_loc=2893776708
> + sym_val _xiprom
> + sed -n / _xiprom$/{s/ .*$//p;q}
> + /home/arnd/cross-gcc/bin/arm-linux-gnueabi-gcc-nm vmlinux
> /home/arnd/cross-gcc/lib/gcc/arm-linux-gnueabi/8.0.1/../../../../arm-linux-gnueabi/bin/nm terminated with signal 13 [Broken pipe]
> 
> Obviously we want to make the combination work, no idea why it doesn't.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 823e397ee0f3..8ed0f664f86f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1976,6 +1976,7 @@ endchoice
>  config XIP_KERNEL
>  	bool "Kernel Execute-In-Place from ROM"
>  	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
> +	depends on !LTO

You should move this to config XIP_DEFLATED_DATA instead.


Nicolas
