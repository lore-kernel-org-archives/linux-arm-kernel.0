From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 10:46:54 +0000
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111206093709.GB2274@linaro.org>
References: <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205192605.GD29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051443190.2357@xanadu.home>
 <20111206093709.GB2274@linaro.org>
Message-ID: <20111206104654.GN14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 09:37:09AM +0000, Dave Martin wrote:
> To clarify, you're suggesting that the meanings of all other IRQ values
> would not change initially?  (i.e., we remap HW irq 0, if there is one,
> to some other random number but have a 1:1 mapping for everything else).

Even better.  Avoid the first 16 IRQ numbers altogether - so that ISA
drivers which have these numbers hard-encoded in them will see failures
if they're expecting standard ISA IRQ numbering.

We already do that with the GIC, partly because of the hardware design.
We do that on Footbridge based systems, because they may or may not have
a real ISA IRQ controller.

But.. let's make one thing clear: Alan Cox and Linus have been going on
about how IRQ0 should not be used.  Let's be crystal clear: even x86
uses IRQ0.  It happens to be the PIC timer, and that gets claimed early
on during the x86 boot.  So please don't tell me that x86 avoids IRQ0.
It doesn't.  It just happens that x86 never shows IRQ0 to anything but
the i8253 PIC driver.

So lets see how x86 squeels if we make the i8253 PIC driver reject IRQ0.
I bet that there'd be absolute fury at such a suggestion.

When x86 sorts this out, there _might_ be some more motivation to take
such comments seriously.  Until then it's more like a joke.
