From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Sep 2012 18:35:56 +0100
Subject: [PATCH] ARM: hw_breakpoint: Clear breakpoints before enabling
 monitor mode
In-Reply-To: <1348160260-19486-1-git-send-email-sboyd@codeaurora.org>
References: <1348160260-19486-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120920173556.GQ4654@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Sep 20, 2012 at 05:57:40PM +0100, Stephen Boyd wrote:
> The reset value of the BCR, BVR, WCR, and WVR registers are all
> UNKNOWN on ARMv7. Unfortunately, reset_ctrl_regs() clears these
> registers *after* enabling monitor mode, not before, and so some
> implementations may experience UNPREDICTABLE behavior if the
> reset values of these registers are non-zero. Clear the
> breakpoints before enabling monitor mode so that we don't
> experience boot hangs/loops due to breakpoints being enabled
> out of reset.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Aha, thanks for the patch. We should definitely zero these registers before
enabling monitor mode. However...

> +/* Determine if halting mode is enabled */
> +static int halting_mode_enabled(void)
> +{
> +	u32 dscr;
> +
> +	ARM_DBG_READ(c1, 0, dscr);
> +
> +	if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN,
> +		"halting debug mode enabled. Unable to access hardware resources.\n")) {
> +		return -EPERM;
> +	}
> +	return 0;
> +}

...it looks like debug arch 7.1 defines this bit as UNKNOWN when the OS lock
is clear, so we probably shouldn't be reading it at all. I'll pour myself a
stiff drink and start reading the debug arch docs to work out what on Earth
we should do.

Stay tuned.

Will
