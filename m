From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Aug 2011 17:02:34 +0100
Subject: [PATCH] mach-davinci: fix cache flush build error
In-Reply-To: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
References: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110802160234.GH19079@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 05:48:38PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The TNET variant of DaVinci compiles some code that it shares
> with other DaVinci variants, however it has a V6 CPU rather than
> an ARM926T, thus the hardcoded call to arm926_flush_kern_cache_all()
> in sleep.S will obviously fail, and we need to build with the
> v6_flush_kern_cache_all() call instead. This was triggered by
> manually altering the DaVinci config to build the TNET version.
> 
> Cc: Dave Martin <dave.martin@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This is just an ifdef to get the DaVinci TNET variant to compile,
> if there is a way to call out to some abstract flush function in a
> MULTI CPU/cache configuration from _assembler_ code, please tell me,
> 
> I'm not all that happy about this since it blocks proper multiboard
> support for DaVinci, would be nice to find a better solution.

Davinci seems to be a special case where it somehow preserves all state
even in deep sleep, which makes the generic cpu_suspend() not ideal for
it.

Or maybe that's just an oversight in the existing code - I don't know
so I haven't touched it.  I've been hoping that Davinci people can sort
it out...
