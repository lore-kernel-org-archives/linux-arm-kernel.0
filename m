From: mporter@linaro.org (Matt Porter)
Date: Fri, 25 Apr 2014 09:51:41 -0400
Subject: [PATCH v2 00/10] ARM: bcm: SCM and L2 cache code cleanup
In-Reply-To: <1398117191-2433-1-git-send-email-elder@linaro.org>
References: <1398117191-2433-1-git-send-email-elder@linaro.org>
Message-ID: <20140425135141.GE1127@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 04:53:01PM -0500, Alex Elder wrote:
> This series cleans up a number of things in the code that issues
> secure monitor ("smc") requests for the bcm281xx and bcm21664 SoC
> families.  This code is currently used only for enabling the level-2
> cache.
> 
> There are some bug fixes and other improvements.  An assembly
> language file containing a single function has been eliminated by
> re-implementing the code using inline assembly.  Some comments have
> been expanded and clarified.  Kernel configuration options allow
> finer-grained control over how this code gets built.  Finally, the
> "kona.c" and "kona.h" files are renamed to reflect the fact that
> only contain code related to level-2 cache support.

Applied the series to mach-bcm for-3.16/cleanup

Thanks,
Matt

> 
> This series is based on v3.15-rc2, and depends on one patch posted
> previously:
>     [PATCH v4] mach-bcm: clean up config and build targets
>     https://lkml.org/lkml/2014/4/15/303
> 
> It is available here:
>     http://git.linaro.org/landing-teams/working/broadcom/kernel.git
>     Branch review/bcm-smc-cleanup-v2
> 
> 					-Alex
> 
> History:
> v2: - Followed two suggestions from Russell King.  Rebased to v3.15-rc2
> 
> Alex Elder (10):
>   ARM: bcm: use memory accessors for ioremapped area
>   ARM: bcm: err, don't BUG() on SMC init failures
>   ARM: bcm: clean up SMC code
>   ARM: bcm: have bcm_kona_smc() return request result
>   ARM: bcm: don't special-case CPU 0 in bcm_kona_smc()
>   ARM: bcm: config option for l2 cache support
>   ARM: bcm: tidy up a few includes
>   ARM: bcm: use inline assembly for "smc" request
>   ARM: bcm: rewrite commentary for bcm_kona_do_smc()
>   ARM: bcm: rename "kona.h" and "kona.c"
> 
>  arch/arm/mach-bcm/Kconfig                     |  12 ++-
>  arch/arm/mach-bcm/Makefile                    |  10 +-
>  arch/arm/mach-bcm/bcm_kona_smc.c              | 136 +++++++++++++++++++-------
>  arch/arm/mach-bcm/bcm_kona_smc.h              |  52 +---------
>  arch/arm/mach-bcm/bcm_kona_smc_asm.S          |  41 --------
>  arch/arm/mach-bcm/board_bcm21664.c            |   5 +-
>  arch/arm/mach-bcm/board_bcm281xx.c            |   2 +-
>  arch/arm/mach-bcm/{kona.c => kona_l2_cache.c} |  16 +--
>  arch/arm/mach-bcm/{kona.h => kona_l2_cache.h} |   6 +-
>  9 files changed, 136 insertions(+), 144 deletions(-)
>  delete mode 100644 arch/arm/mach-bcm/bcm_kona_smc_asm.S
>  rename arch/arm/mach-bcm/{kona.c => kona_l2_cache.c} (80%)
>  rename arch/arm/mach-bcm/{kona.h => kona_l2_cache.h} (80%)
> 
> -- 
> 1.9.1
> 
