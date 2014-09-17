From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Sep 2014 13:18:20 +0100
Subject: [PATCH] ARM: hw_breakpoint: Trap undef instruction exceptions
 on wake-up
In-Reply-To: <1410955036-1956-1-git-send-email-geert+renesas@glider.be>
References: <1410955036-1956-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20140917121820.GR12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 01:57:16PM +0200, Geert Uytterhoeven wrote:
> If power area D4, which contains the Coresight-ETM hardware block, is
> powered down on R-Mobile A1 (r8a7740), the kernel crashes when
> suspending from s2ram with:
> 
>     Internal error: Oops - undefined instruction: 0 [#1] ARM
> 
> This happens because dbg_cpu_pm_notify() calls reset_ctrl_regs(), which
> can't access the debug registers as the debug module is powered down.
> 
> Protect the call to reset_ctrl_regs() by an undefined instruction hook,
> like was done in commit 0d352e3d006c9589 ("ARM: hw_breakpoint: trap
> undef instruction exceptions in reset_ctrl_regs") for another caller.

I'd prefer a better solution to this (such as tracking whether the ETM
block is powered down).  This feels very much like a hack than a good
solution.

Also, the undefined instruction hook was not supposed to be used in this
way - certainly *not* dynamically like this.  While the lookup of the
undef handler is done in a safe atomic way, calling the resulting
function is outside of the locks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
