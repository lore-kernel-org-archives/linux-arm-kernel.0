From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Apr 2015 18:26:57 +0100
Subject: [PATCH 4/7] ARM: cache-v7: optimise branches in
 v7_flush_cache_louis
In-Reply-To: <20150409134656.GX12732@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <2570741.Vc3c6Ovx3m@wuerfel>
 <20150409082116.GV12732@n2100.arm.linux.org.uk>
 <2927556.fYRDzU3Hag@wuerfel>
 <20150409134656.GX12732@n2100.arm.linux.org.uk>
Message-ID: <20150409172657.GL23861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 02:46:56PM +0100, Russell King - ARM Linux wrote:
> diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
> index 7d807cfd8ef5..0f2055fe21af 100644
> --- a/arch/arm/lib/bitops.h
> +++ b/arch/arm/lib/bitops.h
> @@ -14,7 +14,7 @@ UNWIND(	.fnstart	)
>  #if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
>  	.arch_extension	mp
>  	ALT_SMP(W(pldw)	[r1])
> -	ALT_UP(W(nop))
> +	ALT_UP(nop)

So for cases like this, we end up with two NOPs on Thumb-2 UP. Depending
on the microarchitecture implementation, we may have two instructions in
the pipeline to execute instead of one.

-- 
Catalin
