From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 1 Mar 2016 18:36:28 +0100
Subject: [PATCH v3 4/4] ARM: STM32: Enable Ethernet in stm32_defconfig
In-Reply-To: <1456483912-32090-5-git-send-email-alexandre.torgue@gmail.com>
References: <1456483912-32090-1-git-send-email-alexandre.torgue@gmail.com>
 <1456483912-32090-5-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <56D5D31C.7050908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex, Arnd,

On 02/26/2016 11:51 AM, Alexandre TORGUE wrote:
> Enable basic Ethernet support (IPV4) for stm32 defconfig.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index ec52505..8b8abe0 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -33,11 +33,20 @@ CONFIG_XIP_PHYS_ADDR=0x08008000
>   CONFIG_BINFMT_FLAT=y
>   CONFIG_BINFMT_SHARED_FLAT=y
>   # CONFIG_COREDUMP is not set
> +CONFIG_NET=y
> +CONFIG_INET=y
> +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +# CONFIG_IPV6 is not set
>   CONFIG_DEVTMPFS=y
>   CONFIG_DEVTMPFS_MOUNT=y
>   # CONFIG_FW_LOADER is not set
>   # CONFIG_BLK_DEV is not set
>   CONFIG_EEPROM_93CX6=y
> +CONFIG_NETDEVICES=y
> +CONFIG_STMMAC_ETH=y
> +# CONFIG_WLAN is not set
>   # CONFIG_INPUT is not set
>   # CONFIG_SERIO is not set
>   # CONFIG_VT is not set
>

The patch looks good, but I'm not sure I should apply it.
Indeed, not all the stm32 boards have Ethernet interface, and stm32 
internal flash size is rather limited (2MB).
Note that your glue layer can be compiled with COMPILE_TEST, so its 
build will be covered anyway.

Arnd, do you think we could use Kconfig fragments to enable features 
like USB, Ethernet, MTD, etc...?
Maybe we could have a subdirectory in arch/arm/configs where these stm32 
specifics fragments could leave?

For example, we could have:
arch/arm/configs/stm32/eth.config
arch/arm/configs/stm32/usb.config

For configuring the Discovery board we would use:
make stm32_defconfig stm32/usb.config

For the Eval board, we cwould use:
make stm32_defconfig eth.config

It would make easy to be able to boot every boards without multiplying 
the defconfigs.

Regards,
Maxime
