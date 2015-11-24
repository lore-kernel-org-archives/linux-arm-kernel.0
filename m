From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 16:13:06 -0800
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <6359949.bhCrxaQvmL@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <133921941.Qfq59EaTOs@wuerfel>
 <20151123213206.GG19156@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
Message-ID: <20151124001306.GI19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23, Arnd Bergmann wrote:
> 
> Ok, thanks for the confirmation.
> 
> Summarizing what we've found, I think we can get away with just
> introducing two Kconfig symbols ARCH_MULTI_V7VE and CPU_V7VE.
> Most CPUs fall clearly into one category or the other, and then
> we can allow LPAE to be selected for V7VE-only build but not
> for plain V7, and we can unconditionally build the kernel with
> 
> arch-$(CONFIG_CPU_32v7VE)  = -D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7ve,-march=armv7-a -mcpu=cortex-a15)
> 

This causes compiler spew for me:

  warning: switch -mcpu=cortex-a15 conflicts with -march=armv7-a switch

Removing -march=armv7-a from there makes it quiet.

Also, it's sort of feels wrong to have -mcpu in a place where
we're exclusively doing -march. Perhaps the fallback should be
bog standard -march=armv7-a? (or the fallback for that one
"-march=armv5t -Wa$(comma)-march=armv7-a")?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
