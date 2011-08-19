From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2011 20:53:58 +0100
Subject: [PATCH 4/4] AM3517: Fix suspend-resume sequence
In-Reply-To: <1313754927-11992-5-git-send-email-abhilash.kv@ti.com>
References: <1313754927-11992-1-git-send-email-abhilash.kv@ti.com>
	<1313754927-11992-2-git-send-email-abhilash.kv@ti.com>
	<1313754927-11992-3-git-send-email-abhilash.kv@ti.com>
	<1313754927-11992-4-git-send-email-abhilash.kv@ti.com>
	<1313754927-11992-5-git-send-email-abhilash.kv@ti.com>
Message-ID: <20110819195358.GA18947@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 05:25:27PM +0530, Abhilash K V wrote:
> This patch fixes the crash seen while resuming with i2c devices
> enabled. This crash was happening because the interface-clocks
> were disabled in the suspend sequence, and not re-enabled on
> resumption.
> The current patch saves the value of the CM_ICLKEN1_CORE register
> before zeroing it out, and restores upon resumption. In AM3517 the
> interface clocks are enabled by the clock module ONLY during
> initialization, so the suspend sequence (in arch/arm/mach-omap2/
> sleep3517.S) has to manually turn it off before executing wfi
> and then back on again on returning from wfi, to ensure that all
> interface clocks are enabled when control returns to omap_sram_idle()
> after waking up from idle.

We don't need to know that your original implementation had a problem and
you fixed it with a later patch.  Just roll the two patches together.

When Linus talks about unnecessary churn, this is one of the reasons it
happens.  Please change your workflow to reduce the amount of changes
done - especially when you're submitting patches which create entirely
new files.
