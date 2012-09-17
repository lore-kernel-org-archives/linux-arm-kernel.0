From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Sep 2012 22:47:33 +0100
Subject: [PATCH v2] ARM: l2x0: make background cache ops optional for
 clean and flush range
In-Reply-To: <5057881A.9020604@gmail.com>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
 <1347890398-22088-1-git-send-email-robherring2@gmail.com>
 <20120917194733.GQ12245@n2100.arm.linux.org.uk> <5057881A.9020604@gmail.com>
Message-ID: <20120917214732.GR12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 03:29:14PM -0500, Rob Herring wrote:
> On 09/17/2012 02:47 PM, Russell King - ARM Linux wrote:
> > (a) you're not describing hardware, you're describing a feature of the
> >     Linux kernel's implementation - no, you're describing a configuration
> >     feature of the kernel.  This should not be in DT.
> > (b) you're disabling the optimization to avoid doing a lengthy line-by-line
> >     cache operation when the size is larger than the cache size, and trading
> >     it for possibly slightly quicker accesses.
> > 
> > The problem I have with this is it's likely that you've only looked at
> > "oh, this makes IO accesses faster" and not the total picture wrt the
> > effect on time taken by the DMA API.
> 
> I could easily "fix" this in the xgmac driver by using __raw_writel or
> writel_relaxed, but that would break non-coherent operation which does
> need the L2 cache barriers.

Note that in many cases, drivers do not need a barrier before every write
or after every read operation.

In terms of L2 coherency, the only time that L2 actually needs to be
touched is when your MMIO access provokes the device to read from memory.
Most accesses do not.

The solution - using the relaxed MMIO accessors, not fiddling around
with the L2 cache code.

However, there's an in-built problem here - which I'm told of by PowerPC
folk.  Apparantly, Linus refuses to accept that anyone needs relaxed MMIO
accessors and essentially says "all platforms must behave like x86 does".
I don't actually know Linus' real position, or what his position would be
if he new that without relaxed accessors, we have to do a very time
consuming operation...  It might be worth broaching the subject of true
relaxed MMIO accessors again.

The only issue with that approach is getting people who don't have the
problem (iow, x86 driver authors) to understand this issue - and that's
where I absolutely agree with Linus' apparant position...

A better solution than relaxed IO accessors maybe a barrier, but don't
call it that.  Maybe call it "pre_dma();" and "post_dma();" - that way
people won't get bogged down in barrier terminology or whatever.  They
just call "pre_dma();" before they write to a register which provokes
DMA, and "post_dma();" before they read from a register to get DMA
status.  What platforms do for each of those calls is up to them, and
whether platforms use relaxed MMIO accessors becomes their choice too.

Another but - we have a hell of a lot of drivers... and existing
accessors must work as per x86...

> It's not without precedence, but you are right that it is a questionable
> use of DT. I'm open to suggestions of how you would expose this
> configuration to platforms. We obviously don't want a compile time
> option. Some options:
> 
> - Add a flags param to l2x0_of_init to configure it
> - Add non-background version of functions and override the function ptrs
> in platform code.
> - Add a new call to configure l2 settings like this.
> - Expose the use_background_ops variable directly

- command line setting which is available to everyone whether they're using
DT or not.
