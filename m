From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 Mar 2011 09:23:36 +0100
Subject: CONFIG_ARM_DMA_MEM_BUFFERABLE and readl/writel weirdness
In-Reply-To: <4D6D9C03.2080906@codeaurora.org>
References: <4D6D9C03.2080906@codeaurora.org>
Message-ID: <201103020923.36796.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2011 02:23:15 Saravana Kannan wrote:
> There are so many other drivers that don't use or care about DMA and 
> might still want to ensure some ordering constraints between their 
> readl(s)/writel(s). They can't depend on readl/writel taking care of it 
> for them since their code could be used in a kernel configuration that 
> doesn't enable this config.

What exactly are the ordering constraints, do you need the full
dmb() for readl() and dsb() for writel(), or just a compiler barrier?

I think we need the barrier() even for the relaxed variant, but 
that is fairly lightweight. What would be a reason to have more?

> Firstly, I don't know how many people noticed this and realize they 
> can't depend on readl/writel to take care of the mb()s for them. Seems 
> like an unnecessary encouragement to make mistakes when it didn't need 
> to be so.
> 
> Secondly, even if they realize they have to take care of it, they will 
> have to continue using mb()s in to force ordering between their 
> reads/writes. So, are we depending on the compiler to optimize these 
> extra mb() out in the case where the config is enabled? I'm not sure it 
> will be able to optimize out the extra mb()s in all cases.

The compiler certainly won't merge multiple inline assembly statements,
but multiple barrier() statements don't make it worse than just one.
barrier() just forces accessing variables from memory that could otherwise
be kept in registers.

The other problems we still need to fix are the complete absence of
barriers in inb()/outb() style accessors, which are meant to be stricter
than readl()/writel(), and the fact that we rely on undefined behavior
in gcc regarding the atomicity of multi-byte accesses, as we recently
found out when a new gcc turned a readl into byte accesses.

	Arnd
