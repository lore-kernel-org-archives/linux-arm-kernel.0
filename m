From: luis.henriques@canonical.com (Luis Henriques)
Date: Thu, 28 May 2015 11:50:04 +0100
Subject: [RESEND PATCH 3.18-stable v2] ARM: mvebu: do not register custom
 DMA operations when coherency is disabled
In-Reply-To: <1432117387-22435-1-git-send-email-bjorn@mork.no>
References: <1432117387-22435-1-git-send-email-bjorn@mork.no>
Message-ID: <20150528105004.GC2437@ares>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 12:23:07PM +0200, Bj?rn Mork wrote:
> Hello Sasha!
> 
> This backported mvebu fix seems to have slipped through the cracks by
> accident.  IIUC, the OpenWRT mvebu maintainer(s) are particularily
> interested in having this bug fixed for 3.18-stable.  See this thread
> for the original patch submission and discussion:
> http://permalink.gmane.org/gmane.linux.kernel.stable/127243
>

Thank you, I'm also queuing this patch for the 3.16 kernel as you
tagged it for v3.16..v3.18.

Cheers,
--
Lu?s

> I'm including the full patch below for convenicence. It still applies
> to the current 3.18-stable tree (apply with "git am --scissors" if you
> use this email as source).
> 
> I hope Thomas, Imre or Andrew can fill in the details if more
> background info is necessary...
> 
> 
> Thanks,
> Bj?rn
> 
> ---- >8 ---- >8 ----
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Subject: ARM: mvebu: do not register custom DMA operations when coherency is disabled
> Date: Thu, 12 Mar 2015 11:58:12 +0100
> 
> This patch is a partial backport of commit ef01c6c36bb8 ("ARM: mvebu:
> remove Armada 375 Z1 workaround for I/O coherency"). This commit was
> merged in v3.19, so kernel versions later than v3.19 are not affected
> by the problem that this commit fixes.
> 
> It does not make a lot of sense to backport this commit entirely,
> since it is mainly removing some no longer useful code. However, this
> commit is also making sure that the bus_register_notifier that
> register the custom DMA operations that should be used for HW I/O
> coherency does not get registered when said HW I/O coherency is not
> enabled.
> 
> This is particularly critical since we have decided to disable HW I/O
> coherency completely in all kernels < 4.0, to be on the safe side,
> while experimenting a new implementation of the HW I/O coherency in >=
> 4.0.
> 
> Without this commit, kernels earlier than 3.18 have the custom DMA
> operations normally used for HW I/O coherency registered (they don't
> do cache maintenance operations), while HW I/O coherency is
> disabled. It essentially causes every DMA transfer to transfer
> garbage.
> 
> The issue fixed by this commit was introduced by 5ab5afd8ba83 ("ARM:
> mvebu: implement Armada 375 coherency workaround"), but it was not
> visible until now since it didn't cause any problem when HW I/O
> coherency is enabled.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> v3.16..v3.18
> ---
>  arch/arm/mach-mvebu/coherency.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index 2ffccd4..01efe13 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -448,8 +448,9 @@ static int __init coherency_late_init(void)
>  			armada_375_coherency_init_wa();
>  	}
>  
> -	bus_register_notifier(&platform_bus_type,
> -			      &mvebu_hwcc_nb);
> +	if (coherency_available())
> +		bus_register_notifier(&platform_bus_type,
> +				      &mvebu_hwcc_nb);
>  
>  	return 0;
>  }
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
