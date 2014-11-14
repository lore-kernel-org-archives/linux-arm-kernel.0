From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Nov 2014 16:31:24 +0000
Subject: [PATCH 0/6] arm64: alternatives runtime patching
In-Reply-To: <2041011.PXfvHs4Xp7@wuerfel>
References: <1415980452-20366-1-git-send-email-andre.przywara@arm.com>
 <2041011.PXfvHs4Xp7@wuerfel>
Message-ID: <20141114163123.GC6755@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 04:20:10PM +0000, Arnd Bergmann wrote:
> On Friday 14 November 2014 15:54:06 Andre Przywara wrote:
> > This series introduces alternatives runtime patching to arm64.
> > This allows to patch assembly instruction at runtime to either
> > fix hardware bugs or optimize for certain hardware features. Look
> > at patch 5/6 for an example on how to use this.
> 
> Does it provide a measurable performance benefit? The implementation
> seems ok, but we should only add the complexity for things that
> actually need it and can't be handled just as well with a run-time
> conditional.

I'm not a fan of run-time code patching, however, I'm not sure we can
avoid them long term in an optimal way.

One example is errata workarounds we cannot predict. They may require
changing of a critical code path.

Another example is code like local_irq_disable which at some point we
may want to implement using GICv3 priority mask rather than PSTATE.I bit
change to allow NMI via standard IRQ.

And another big use-case I can't yet talk openly about is architecture
extensions.

What I would like to see at some point is a way to choose alternatives
at run-time via branches rather than code patching or even deciding at
compile time what features we have. These would help with debugging.

-- 
Catalin
