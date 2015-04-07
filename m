From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 7 Apr 2015 23:16:38 +0200
Subject: [PATCH 3.18-stable v2] ARM: mvebu: do not register custom DMA
 operations when coherency is disabled
In-Reply-To: <1426157892-1705-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1426157892-1705-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150407231638.0993cb16@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Any reason why this patch hasn't been included in 3.18-stable? It is
a very important patch fixing a major regression. What needs to be done
to get it merged in 3.18 ?

Thanks,

Thomas

On Thu, 12 Mar 2015 11:58:12 +0100, Thomas Petazzoni wrote:
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



-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
