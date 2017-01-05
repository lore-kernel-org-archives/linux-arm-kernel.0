From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 5 Jan 2017 15:23:24 -0800
Subject: [PATCH] ARM: hw_breakpoint: blacklist Scorpion CPUs
In-Reply-To: <1483637556-3974-1-git-send-email-mark.rutland@arm.com>
References: <1483637556-3974-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170105232324.GL17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05, Mark Rutland wrote:
> On APQ8060, the kernel crashes in arch_hw_breakpoint_init, taking an
> undefined instruction trap within write_wb_reg. This is because Scorpion
> CPUs erroneously appear to set DBGPRSR.SPD when WFI is issued, even if
> the core is not powered down. When DBGPRSR.SPD is set, breakpoint and
> watchpoint registers are treated as undefined.
> 
> It's possible to trigger similar crashes later on from userspace, by
> requesting the kernel to install a breakpoint or watchpoint, as we can
> go idle at any point between the reset of the debug registers and their
> later use. This has always been the case.
> 
> Given that this has always been broken, no-one has complained until now,
> and there is no clear workaround, disable hardware breakpoints and
> watchpoints on Scorpion to avoid these issues.

I believe the workaround is to read DBGPRSR after exit from WFI?
I'm fine with the blacklisting approach though.

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: stable at vger.kernel.org
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
