From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Aug 2016 10:43:39 +0100
Subject: [PATCH 2/2] arm: apply more __ro_after_init
In-Reply-To: <1464979224-2085-3-git-send-email-keescook@chromium.org>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org>
 <1464979224-2085-3-git-send-email-keescook@chromium.org>
Message-ID: <20160810094339.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 11:40:24AM -0700, Kees Cook wrote:
> @@ -1309,16 +1309,11 @@ void __init arm_mm_memblock_reserve(void)
>   * Any other function or debugging method which may touch any device _will_
>   * crash the kernel.
>   */
> +static char vectors[PAGE_SIZE * 2] __ro_after_init __aligned(PAGE_SIZE);
>  static void __init devicemaps_init(const struct machine_desc *mdesc)
>  {
>  	struct map_desc map;
>  	unsigned long addr;
> -	void *vectors;
> -
> -	/*
> -	 * Allocate the vector page early.
> -	 */
> -	vectors = early_alloc(PAGE_SIZE * 2);

This one is not appropriate.  We _do_ write to these pages after init
for FIQ handler updates.  See set_fiq_handler().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
