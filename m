From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Oct 2015 18:03:07 +0100
Subject: [PATCH v3] ARM: fix vdsomunge not to depend on glibc specific
 byteswap.h
In-Reply-To: <160a66a415cdb49174bc7d05b3e4dda9bba0e9d6.1444888374.git.hns@goldelico.com>
References: <160a66a415cdb49174bc7d05b3e4dda9bba0e9d6.1444888374.git.hns@goldelico.com>
Message-ID: <20151015170306.GF32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 07:52:56AM +0200, H. Nikolaus Schaller wrote:
> If the host toolchain is not glibc based then the arm kernel build
> fails with
> 
>   HOSTCC  arch/arm/vdso/vdsomunge
>   arch/arm/vdso/vdsomunge.c:48:22: fatal error: byteswap.h: No such file or directory
> 
> Observed: with omap2plus_defconfig and compile on Mac OS X with arm ELF
> cross-compiler.
> 
> Reason: byteswap.h is a glibc only header.
> 
> Solution: replace by private byte-swapping macros (taken from
> arch/mips/boot/elf2ecoff.c)
> 
> Tested to compile on Mac OS X 10.9.5 host.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/vdso/vdsomunge.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/vdso/vdsomunge.c b/arch/arm/vdso/vdsomunge.c
> index aedec81..513f9eb 100644
> --- a/arch/arm/vdso/vdsomunge.c
> +++ b/arch/arm/vdso/vdsomunge.c
> @@ -45,7 +45,6 @@
>   * it does.
>   */
>  
> -#include <byteswap.h>
>  #include <elf.h>
>  #include <errno.h>
>  #include <fcntl.h>
> @@ -59,6 +58,18 @@
>  #include <sys/types.h>
>  #include <unistd.h>
>  
> +#define swab16(x) \
> +	((unsigned short)( \
> +		(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) | \
> +		(((unsigned short)(x) & (unsigned short)0xff00U) >> 8)))

		((((x) & 0x00ff) << 8) | \
		 (((x) & 0xff00) >> 8))

> +
> +#define swab32(x) \
> +	((unsigned int)( \
> +		(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) | \
> +		(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) | \
> +		(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) | \
> +		(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24)))

		((((x) & 0x000000ff) << 24) | \
		 (((x) & 0x0000ff00) <<  8) | \
		 (((x) & 0x00ff0000) >>  8) | \
		 (((x) & 0xff000000) << 24))

We can get rid of all the casts because we know what size 'x' is in
both cases.

-- 
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
