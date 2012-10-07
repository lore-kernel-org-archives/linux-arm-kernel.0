From: olof@lixom.net (Olof Johansson)
Date: Sun, 7 Oct 2012 14:54:36 -0700
Subject: [PATCH v3] arm: vt8500: Fix build warning in uncompress.h [for
 3.7]
In-Reply-To: <1349645012-28381-1-git-send-email-linux@prisktech.co.nz>
References: <1349645012-28381-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CAOesGMhTL5pOSmVOLOUnYKGdjUeRDVCJfikAoK6K0j4vtpbSmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 7, 2012 at 2:23 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> This removes a build-time warning in uncompress.h due to incorrectly
> cast values being passed to readb/writeb.
>
> Removed arm/io.h and readb/writeb. Read/write directly to the serial
> port with a volatile pointer.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Ok, applied to fixes (I had actually applied v2, so replaced it).

Btw, if you want to annotate [for 3.7] in the future, put it on the
front of the patch subject, since it seems that git am doesn't strip
it off when it's not at the beginning. :-)


-Olof

> ---
>  arch/arm/mach-vt8500/include/mach/uncompress.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
> index bb9e2d2..e6e81fd 100644
> --- a/arch/arm/mach-vt8500/include/mach/uncompress.h
> +++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
> @@ -15,15 +15,15 @@
>   *
>   */
>
> -#define UART0_PHYS 0xd8200000
> -#include <asm/io.h>
> +#define UART0_PHYS     0xd8200000
> +#define UART0_ADDR(x)  *(volatile unsigned char *)(UART0_PHYS + x)
>
>  static void putc(const char c)
>  {
> -       while (readb(UART0_PHYS + 0x1c) & 0x2)
> +       while (UART0_ADDR(0x1c) & 0x2)
>                 /* Tx busy, wait and poll */;
>
> -       writeb(c, UART0_PHYS);
> +       UART0_ADDR(0) = c;
>  }
>
>  static void flush(void)
> --
> 1.7.9.5
>
