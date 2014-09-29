From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 29 Sep 2014 09:50:08 +0200
Subject: [RFT PATCH v2] mtd: ixp4xx: Unrequire CONFIG_MTD_CFI_BE_BYTE_SWAP
In-Reply-To: <1800715024.324263.1411508605796.JavaMail.zimbra@xes-inc.com>
 (Aaron Sierra's message of "Tue, 23 Sep 2014 16:43:25 -0500 (CDT)")
References: <1800715024.324263.1411508605796.JavaMail.zimbra@xes-inc.com>
Message-ID: <m3fvfac1cf.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaron Sierra <asierra@xes-inc.com> writes:

> The .swap member of the map_info structure is provided for situations
> where a mapping must always be big or little endian regardless of the
> endianness of the system performing the access.

I like the idea but the patch doesn't work :-(

Without the patch:
IXP4XX-Flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000089 Chip ID 0x008922
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
Searching for RedBoot partition table in IXP4XX-Flash.0 at offset 0x1fe0000
5 RedBoot partitions found on MTD device IXP4XX-Flash.0

With the patch applied:
IXP4XX-Flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000089 Chip ID 0x008922
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
Using auto-unlock on power-up/resume
cfi_cmdset_0001: Erase suspend on write enabled
Searching for RedBoot partition table in IXP4XX-Flash.0 at offset 0x1fe0000
No RedBoot partition table detected in IXP4XX-Flash.0

> +++ b/drivers/mtd/maps/ixp4xx.c

> -#ifndef __ARMEB__
> -#ifndef CONFIG_MTD_CFI_BE_BYTE_SWAP
> -#  error CONFIG_MTD_CFI_BE_BYTE_SWAP required
> +
> +#ifdef __ARMEB__
> +#define fixup_32(io) (io)
> +#else
> +#define fixup_32(io) (void __iomem *)((unsigned long)(io) ^ 2)
>  #endif
>
>  static inline u16 flash_read16(void __iomem *addr)
>  {
> -	return be16_to_cpu(__raw_readw((void __iomem *)((unsigned long)addr ^ 0x2)));
> +	return be16_to_cpu(__raw_readw(fixup_32(addr)));
>  }
>
>  static inline void flash_write16(u16 d, void __iomem *addr)
>  {
> -	__raw_writew(cpu_to_be16(d), (void __iomem *)((unsigned long)addr ^ 0x2));
> +	__raw_writew(cpu_to_be16(d), fixup_32(addr));
>  }

The above change seems fine.

>  #define	BYTE0(h)	((h) & 0xFF)
>  #define	BYTE1(h)	(((h) >> 8) & 0xFF)
>
> -#else
...
> -#define	BYTE0(h)	(((h) >> 8) & 0xFF)
> -#define	BYTE1(h)	((h) & 0xFF)
> -#endif

This is used by ixp4xx_copy_from(). I don't exactly know what is MTD
layer going to do with map.swap = CFI_BIG_ENDIAN, but I think the
natural thing (= big endian on this CPU) is to copy data in big-endian
order, and then maybe (in LE mode) swap it.

In fact, it detects those RedBoot partitions when I use the original BE
BYTE0/BYTE1 macros (this second set, deleted by your patch).
Tested in BE mode only for now, can't give it more time at the moment
but will do soon.

CONFIG_MTD_CFI=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_CFI_I1=y
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
