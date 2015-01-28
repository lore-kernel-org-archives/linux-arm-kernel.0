From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 28 Jan 2015 13:29:56 +0100
Subject: [PATCH] ARM: mvebu: don't set the PL310 in I/O coherency mode
 when I/O coherency is disabled
In-Reply-To: <1422446145-24447-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1422446145-24447-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <54C8D644.6050709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Andrew,

On 28/01/2015 12:55, Thomas Petazzoni wrote:
> Since commit f2c3c67f00 (merge commit that adds commit "ARM: mvebu:
> completely disable hardware I/O coherency"), we disable I/O coherency
> on Armada EBU platforms.
> 
> However, we continue to initialize the coherency fabric, because this
> coherency fabric is needed on Armada XP for inter-CPU
> coherency. Unfortunately, due to this, we also continued to execute
> the coherency fabric initialization code for Armada 375/38x, which
> switched the PL310 into I/O coherent mode. This has the effect of
> disabling the outer cache sync operation: this is needed when I/O
> coherency is enabled to work around a PCIe/L2 deadlock. But obviously,
> when I/O coherency is disabled, having the outer cache sync operation
> is crucial.
> 
> Therefore, this commit fixes the armada_375_380_coherency_init() so
> that the PL310 is switched to I/O coherent mode only if I/O coherency
> is enabled.
> 
> Without this fix, all devices using DMA are broken on Armada 375/38x.

Without this fix on my Armada 375 DB board, the kernel hang during the XOR
engine self-test. This fix is really something we should have in 3.19-rc.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
and also
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org>
> ---
> This fix is needed in 3.19-rc, and in all stable kernel releases in
> which f2c3c67f00 was added.
> 
> In mainline, it is not strictly needed, since we have since then
> re-enabled I/O coherency using automatic barriers.
> 
> Commit applies on top of 3.19-rc6, and has been tested on Armada XP,
> Armada 375 and Armada 38x, by checking that the XOR engine self-tests
> are working properly, which is a good indication that DMA and I/O
> coherency is minimally working. Without the fix, the XOR engine
> self-tests were not even working on Armada 38x.
> 
>  arch/arm/mach-mvebu/coherency.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index caa21e9..ccef880 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -190,6 +190,13 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
>  	arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
>  
>  	/*
> +	 * We should switch the PL310 to I/O coherency mode only if
> +	 * I/O coherency is actually enabled.
> +	 */
> +	if (!coherency_available())
> +		return;
> +
> +	/*
>  	 * Add the PL310 property "arm,io-coherent". This makes sure the
>  	 * outer sync operation is not used, which allows to
>  	 * workaround the system erratum that causes deadlocks when
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
