From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jun 2012 10:35:56 +0100
Subject: [PATCH] RFC: ARM: Ensure backtraces console printing in sleep mode
In-Reply-To: <1338881321-10728-1-git-send-email-linus.walleij@stericsson.com>
References: <1338881321-10728-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120605093556.GG8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 09:28:41AM +0200, Linus Walleij wrote:
> From: Aurelien Gerault <aurelien.gerault-nonst@stericsson.com>
> 
> Ensuring that oops & panic messages/backtraces will be printed
> in console, even if in sleep mode (i.e. when the console is
> locked).
> 
> So, unlock the console before printing.

I don't think this is a good idea - it totally changes the locking, and
probably causes the console lock to become unbalanced, which could be a
problem if the oops was non-fatal to the kernel.

x86 also doesn't play this game either, and we really shouldn't have
different semantics here.
