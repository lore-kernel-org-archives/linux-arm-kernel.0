From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 14:02:18 +0100
Subject: [PATCH v2 3/3] ARM: Add barriers to the I/O accessors
	ifARM_DMA_MEM_BUFFERABLE
In-Reply-To: <20100709121629.GE22845@n2100.arm.linux.org.uk>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<20100709110814.11333.83771.stgit@e102109-lin.cambridge.arm.com>
	<1278675696.11895.37.camel@e102109-lin.cambridge.arm.com>
	<20100709121629.GE22845@n2100.arm.linux.org.uk>
Message-ID: <1278680538.11895.49.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-09 at 13:16 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 09, 2010 at 12:41:36PM +0100, Catalin Marinas wrote:
> > This part requires a small change. It looks like the e1000e driver
> > doesn't like the do {...} while (0) constructs in the write*() accessors
> > (the E1000_WRITE_REG_ARRAY macro). Thanks to Giuseppe for finding this.
> 
> Hmm.  I think those additional parens in drivers/net/e1000e/hw.h should
> be killed off instead.  They aren't serving any useful purpose.
> 
> In fact, this is potentially dangerous - it causes write[bwl]() not to
> be 'void' - in that if you do use write[bwl]() in an expression that
> wants its return value, write[bwl]() will generate a read.  (While you
> might not use the value, you're relying on the compiler being able to
> spot that you're not using the value.)
> 
> Keeping the do { } while() there prevents write[bwl]() being used as
> an expression, and therefore avoids nasty surprises when the compiler
> decides to read the register after writing.

I haven't thought of that but yes, it could cause problems. An better
solution may be to use a "static inline void writel()" function. If you
are ok with this, I'll post a new set of patches.

-- 
Catalin
