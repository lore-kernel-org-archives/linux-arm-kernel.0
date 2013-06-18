From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Jun 2013 11:39:06 -0600
Subject: [PATCH v3 05/12] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <1371554737-25319-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130618173906.GC2204@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 08:25:30AM -0300, Ezequiel Garcia wrote:
> The address decoding window to access the BootROM should not be
> allocated programatically, but instead declared in the device tree.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>  arch/arm/mach-mvebu/platsmp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> index 93f2f3a..d419fac 100644
> +++ b/arch/arm/mach-mvebu/platsmp.c
> @@ -118,7 +118,6 @@ void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
>  	set_secondary_cpus_clock();
>  	flush_cache_all();
>  	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
> -	mvebu_mbus_add_window("bootrom", 0xfff00000, SZ_1M);
>  }

I think some kind of test is needed here. As I understand it the SMP
startup uses a trampoline in the boot rom and the boot rom *must* be
mapped to 0xfff00000 ?

Verifying the DT is setup this way and aborting if it is not seems
like a good idea..

Jason
