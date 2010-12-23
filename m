From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 23 Dec 2010 21:42:22 +0300
Subject: [PATCH] video: imxfb: Fix the maximum value for yres
In-Reply-To: <1293124671-29426-1-git-send-email-fabio.estevam@freescale.com>
References: <1293124671-29426-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <4D13980E.4010500@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Fabio Estevam wrote:

> MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.

> Fix the maximum value for yres.

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
[...]

> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 5c363d0..5d2d337 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -55,8 +55,10 @@
>  
>  #ifdef CONFIG_ARCH_MX1
>  #define SIZE_YMAX(y)	((y) & 0x1ff)
> +#define YMAX_MASK	0x1ff
>  #else
>  #define SIZE_YMAX(y)	((y) & 0x3ff)
> +#define YMAX_MASK	0x3ff
>  #endif

    I'd done the following, to avoid the code duplication:

#ifdef CONFIG_ARCH_MX1
#define YMAX_MASK	0x1ff
#else
#define YMAX_MASK	0x3ff
#endif
#define SIZE_YMAX(y)	((y) & YMAX_MASK)

WBR, Sergei
