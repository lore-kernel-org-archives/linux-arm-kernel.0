From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Mar 2016 16:41:17 +0100
Subject: [PATCH] ARM: mvebu: Fix of_clk_get() call in a non sleeping
 context
In-Reply-To: <1457446733-7137-1-git-send-email-gregory.clement@free-electrons.com>
References: <1457446733-7137-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160308164117.2a3ed3a7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Tue,  8 Mar 2016 15:18:53 +0100, Gregory CLEMENT wrote:
> of_clk_get() is called armada_xp_smp_prepare_cpus() function.

Hum? Your code is changing things to have of_clk_get() called by
armada_xp_smp_prepare_cpus(). I think you wanted to say:

"of_clk_get() is currently called in get_cpu_clk(), which it turns is
called by set_secondary_cpu_clock() during armada_xp_boot_secondary().
However, this callback is called in a context...

> This
> callback can be called in a context where it should not sleep as pointed
> when enabling CONFIG_DEBUG_ATOMIC_SLEEP. However of_clk_get() can sleep.
> 
> This patch solved this issue by moving the of_clk_get() during
> initialization by gathering the list of reference on the clock, and only
> access to this list later.

I think this doesn't solve the problem completely, because
set_secondary_cpu_clock() is still calling clk_prepare_enable(), and
the prepare step of a clock is theoretically allowed to sleep. In
practice, it doesn't sleep in our specific case, but still
clk_prepare_enable() is not good in an atomic context.

So I believe the whole approach of setting the CPU clock frequency in
armada_xp_boot_secondary() is wrong, and we should basically revert my
commit b9b1de0f4da37dac76d812a27d6065eba02dc05b, and instead find a
different solution for the resume from suspend case.

> 
> Fixes: f6cec7cd0777 ("ARM: mvebu: remove device tree parsing for cpu
> nodes")

I don't think it fixes this commit. The one it really fixes is most
probably b9b1de0f4da37dac76d812a27d6065eba02dc05b.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
