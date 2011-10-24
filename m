From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 Oct 2011 08:55:09 +0200
Subject: [RFC PATCH 04/15] ARM: uncompress: Only call arch_decomp_setup
	when needed
In-Reply-To: <1319404245-12740-4-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
	<1319404245-12740-4-git-send-email-zoss@devai.org>
Message-ID: <20111024065508.GN15299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 11:10:34PM +0200, Zoltan Devai wrote:
> As only the minority of the machines uses arch_decomp_setup,
> ifdef it out when not needed, to avoid needless defines in
> all uncompress.h files.
> 
> Machines using this feature should add
	#define ARCH_HAVE_DECOMP_SETUP
> in their uncompress.h headers.

I guess this was removed by git-commit.

> 
> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
>  arch/arm/boot/compressed/misc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
> index 8e2a8fc..a4b8df2 100644
> --- a/arch/arm/boot/compressed/misc.c
> +++ b/arch/arm/boot/compressed/misc.c
> @@ -142,7 +142,9 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
>  	free_mem_end_ptr	= free_mem_ptr_end_p;
>  	__machine_arch_type	= arch_id;
>  
> +#ifdef ARCH_HAVE_DECOMP_SETUP
>  	arch_decomp_setup();
> +#endif /* ARCH_HAVE_DECOMP_SETUP */
This is a place that needs some care for multi-SoC. I don't know if
there are any ideas how to handle it, but using a cpp symbol won't work
I guess. So I think it's not worth to touch arch_decomp_setup without
solving the multi-SoC case.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
