From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 4 Dec 2009 12:07:20 +0800
Subject: [PATCH] ARM: NUC900: Implements putc() which is needed when
	uncompressing linux
In-Reply-To: <8fb2581d0912022326y6d128b78xaca22aeeeed899a7@mail.gmail.com>
References: <8fb2581d0912022326y6d128b78xaca22aeeeed899a7@mail.gmail.com>
Message-ID: <e68bb3470912032007o7af83b5eqa920c241cc913f5d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, thanks for your patch.

Acked-by:  Wan ZongShun <mcuos.com@gmail.com>


2009/12/3 Li Jie <eltshanli@gmail.com>:
> Hi,
>
> This patch implements the putc(), 'Uncompressing linux...done' can be
> outputs when booting zImage.
>
> Signed-off-by: lijie <eltshanli@gmail.com>
> ---
> ?arch/arm/mach-w90x900/include/mach/uncompress.h | ? 10 ++++++++++
> ?1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-w90x900/include/mach/uncompress.h
> b/arch/arm/mach-w90x900/include/mach/uncompress.h
> index 050d9fe..56f1a74 100644
> --- a/arch/arm/mach-w90x900/include/mach/uncompress.h
> +++ b/arch/arm/mach-w90x900/include/mach/uncompress.h
> @@ -22,11 +22,21 @@
>
> ?#include <mach/regs-serial.h>
> ?#include <mach/map.h>
> +#include <linux/serial_reg.h>
>
> ?#define arch_decomp_wdog()
>
> +#define TX_DONE ? ? ? ?(UART_LSR_TEMT | UART_LSR_THRE)
> +static volatile u32 * uart_base = (u32 *)UART0_PA;
> +
> ?static void putc(int ch)
> ?{
> + ? ? ? /* Check THRE and TEMT bits before we transmit the character.
> + ? ? ? ?*/
> + ? ? ? while ((uart_base[UART_LSR] & TX_DONE) != TX_DONE)
> + ? ? ? ? ? ? ? barrier();
> +
> + ? ? ? *uart_base = ch;
> ?}
>
> ?static inline void flush(void)
> --
> 1.6.5.3
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
