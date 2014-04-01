From: murzin.v@gmail.com (Vladimir Murzin)
Date: Tue, 1 Apr 2014 08:32:05 +0000 (UTC)
Subject: [PATCH] ARM: errata: Fix the workaround for erratum 764369
References: <1396308564-4613-1-git-send-email-nitin.garg@freescale.com>
Message-ID: <loom.20140401T103102-49@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nitin Garg <nitin.garg <at> freescale.com> writes:
>  #ifdef CONFIG_ARM_ERRATA_764369
>  	/* Cortex-A9 only */
>  	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
> -		scu_ctrl = readl_relaxed(scu_base + 0x30);
> -		if (!(scu_ctrl & 1))
> -			writel_relaxed(scu_ctrl | 0x1, scu_base + 0x30);
> +		writel_relaxed(0x1, scu_base + 0x30);
>  	}
>  #endif
> 

Hmmm.. SCU diagnostic control register is undocumented one, afaics. Anyway,
writel_* is supposed to write u32, so writing plain 0x1 sets-off other
settings, doesn't it?

Vladimir
