From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 23:33:06 +0800
Subject: [PATCH 2/2] ARM: use DEBUG_LL infrastructural for multiplatform
 uncompress debug
In-Reply-To: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
 <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130117153303.GE29285@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Thu, Jan 17, 2013 at 11:21:59PM +0800, Shawn Guo wrote:
>  arch/arm/boot/compressed/Makefile   |    3 +++
>  arch/arm/boot/compressed/debug.S    |    3 +++
>  arch/arm/include/debug/highbank.S   |    3 +++
>  arch/arm/include/debug/imx.S        |    3 +++
>  arch/arm/include/debug/mvebu.S      |    3 +++
>  arch/arm/include/debug/picoxcell.S  |    3 +++
>  arch/arm/include/debug/socfpga.S    |    3 +++
>  arch/arm/include/debug/sunxi.S      |    3 +++
>  arch/arm/include/debug/tegra.S      |    3 +++
>  arch/arm/include/debug/uncompress.h |    8 +++++++-
>  arch/arm/include/debug/vexpress.S   |    3 +++
>  arch/arm/include/debug/zynq.S       |    3 +++
>  12 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/compressed/debug.S
> 
...
> diff --git a/arch/arm/boot/compressed/debug.S b/arch/arm/boot/compressed/debug.S
> new file mode 100644
> index 0000000..7283d5c
> --- /dev/null
> +++ b/arch/arm/boot/compressed/debug.S
> @@ -0,0 +1,3 @@
> +#define UNCOMPRESS_DEBUG
> +
> +#include "../../kernel/debug.S"
> diff --git a/arch/arm/include/debug/highbank.S b/arch/arm/include/debug/highbank.S
> index 8cad432..13056cf 100644
> --- a/arch/arm/include/debug/highbank.S
> +++ b/arch/arm/include/debug/highbank.S
> @@ -12,6 +12,9 @@
>  		.macro	addruart,rp,rv,tmp
>  		ldr	\rv, =0xfee36000
>  		ldr	\rp, =0xfff36000
> +#ifdef UNCOMPRESS_DEBUG
> +		mov	\rv, \rp
> +#endif
>  		.endm
>  
Are you fine with patching arch/arm/kernel/debug.S to have
UNCOMPRESS_DEBUG checked, so that we can avoid patching addruart
for all those platforms?

Shawn
