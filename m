From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Apr 2014 15:41:08 +0100
Subject: [PATCH] arm: Fix DEBUG_LL for multi-platform kernels (without
 PL01X)
In-Reply-To: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
References: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140404144108.GD7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 12:17:49PM +0100, Daniel Thompson wrote:
> When building a multi_v7_defconfig kernel it is not possible to configure
> DEBUG_LL to use any serial device except a ARM Primecell PL01X, or more
> accurately and worse, it is possible to configure a different serial
> device but KConfig does not honour this request.
> 
> The happens because the multi-platform mode may include ARCH_SPEAR13XX
> and this forcibly engages DEBUG_UART_PL01X to provide some kind of
> compatibility with single platform builds (SPEAr supports both single and
> multi-platform). This in turn causes DEBUG_LL_INCLUDE to wedge at
> debug/pl01x.S.
> 
> Problem is fixed by only deploying the compatibility options for SPEAr
> when ARCH_MULTIPLATFORM is not set.

I think it's probably about time we killed the def_bool and just made
this a plain 'bool'.  The affected platforms should be using
DEBUG_LL_UART_PL01X by now.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
