From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Sep 2011 15:40:16 +0100
Subject: [PATCH] ARM: alignment: setup alignment handler earlier
In-Reply-To: <87ehzstr07.fsf@vostro.fn.ogness.net>
References: <87ehzstr07.fsf@vostro.fn.ogness.net>
Message-ID: <20110907144016.GA30719@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 02:35:04PM +0100, John Ogness wrote:
> From 6f3f381800367127dc6430d9b9fa9bd6fc6d8ed0 Mon Sep 17 00:00:00 2001
> From: John Ogness <john.ogness@linutronix.de>
> 
> The alignment exception handler is setup fairly late in
> the boot process (fs_initcall). However, with newer gcc
> versions and the compiler option -fconserve-stack, code
> accessing unaligned data is generated in functions that
> are called earlier, for example pcpu_dump_alloc_info().
> This results in unhandled alignment exceptions during
> boot. By setting up the exception handler sooner, we
> reduce the window where a compiler may generate code
> accessing unaligned data.

While this reduces the window and fixes this particular case, it still
doesn't solve the problem. We never know when some unaligned access
would be generated for some earlier code.

I would just make sure that SCTLR.A bit is always cleared on ARMv6+,
independent of CONFIG_ALIGNMENT_TRAP.

-- 
Catalin
