From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jun 2011 18:58:45 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1106201240240.2113-100000@iolanthe.rowland.org>
Message-ID: <201106201858.45624.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011, Alan Stern wrote:
> I thought the source of the thread had nothing to do with any recent
> changes to gcc.  Maybe I was wrong.  In any case, the issue was not the
> lack of an alignment indication but rather the unnecessary presence of
> a ((packed)) attribute causing the compiler to forget about the natural
> alignment.
> 
> To put it another way, the problem was caused by having ((packed))  
> where it wasn't needed.  You want to fix the immediate fallout of the
> problem by adding an alignment attribute, instead of fixing the problem
> itself by removing the underlying cause.

A recent change in gcc changed the default behaviour when compiling the
ehci driver on ARM, but the behaviour was already nondeterministic
because the definition of the readl/writel macros on ARM relies on
unspecified behaviour (cast to pointer with larger aligment).

We are also going to change the ARM implementation to always do 32 bit
accesses in readl/writel, but the patch that went into the ehci driver
was correct nonetheless.

	Arnd
