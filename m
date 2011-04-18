From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Apr 2011 17:18:17 +0100
Subject: [RFC PATCH v2] Consolidate SRAM support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CA31B27@dbde02.ent.ti.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110418085259.GA26044@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024CA31B27@dbde02.ent.ti.com>
Message-ID: <20110418161817.GB26044@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 09:42:10PM +0530, Nori, Sekhar wrote:
> I was able to test this on DaVinci (DA850 suspend-to-RAM) with
> the following additional changes:
> 
> There was a sram_free call remaining in pm.c file.

Hmm, wonder why my build for DaVinci didn't pick that up.  Thanks for
that and I'll merge it in.

> diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
> index fb5e72b..dcb8e9d 100644
> --- a/arch/arm/mach-davinci/sleep.S
> +++ b/arch/arm/mach-davinci/sleep.S
> @@ -50,6 +50,8 @@
>   * 	r4: contains virtual address of the DEEPSLEEP register
>   */
>  ENTRY(davinci_cpu_suspend)
> +	.align 3
> +

I think you want the .align 3 on the line before ENTRY().

> The davinci audio driver in sound/soc/davinci/davinci-pcm.c uses
> the sram allocator too and would need to be converted to the
> new API.

Ah, right - I'll sort that too.  Slightly annoying that sound stuff
is outside the drivers/ subdir.
