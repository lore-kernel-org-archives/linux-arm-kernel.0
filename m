From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 08 Oct 2012 10:21:09 +1300
Subject: [PATCH v2] arm: vt8500: Fix build warning in uncompress.h [for
 3.7]
In-Reply-To: <1349643405-27943-1-git-send-email-linux@prisktech.co.nz>
References: <1349643405-27943-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1349644869.19187.8.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-08 at 09:56 +1300, Tony Prisk wrote:
> This removes a build-time warning in uncompress.h due to incorrectly
> cast values being passed to readb/writeb.
> 
> Removed arm/io.h and readb/writeb. Read/write directly to the serial
> port with a volatile pointer.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  arch/arm/mach-vt8500/include/mach/uncompress.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
> index bb9e2d2..8c49d28 100644
> --- a/arch/arm/mach-vt8500/include/mach/uncompress.h
> +++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
> @@ -15,15 +15,15 @@
>   *
>   */
>  
> -#define UART0_PHYS 0xd8200000
> -#include <asm/io.h>
> +#define UART0_PHYS	0xf8200000
> +#define UART0_ADDR(x)	*(volatile unsigned char *)(UART0_PHYS + x)
>  
>  static void putc(const char c)
>  {
> -	while (readb(UART0_PHYS + 0x1c) & 0x2)
> +	while (UART0_ADDR(0x1c) & 0x2)
>  		/* Tx busy, wait and poll */;
>  
> -	writeb(c, UART0_PHYS);
> +	UART0_ADDR(0) = c;
>  }
>  
>  static void flush(void)

Blah - had a senior moment. Don't know why I changed the address because
I believe this is called before paging is set up so it should be the
actual physical address of the UART.

Regards
Tony P
