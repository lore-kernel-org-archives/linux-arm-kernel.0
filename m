From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Jan 2013 16:06:54 +0000
Subject: [PATCH 07/16] ARM: bL_platsmp.c: close the kernel entry gate
 before hot-unplugging a CPU
In-Reply-To: <20130115184037.GE1983@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-8-git-send-email-nicolas.pitre@linaro.org>
 <20130114163755.GB31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141151510.6300@xanadu.home>
 <20130114170028.GD31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141207360.6300@xanadu.home>
 <20130114182604.GL23505@n2100.arm.linux.org.uk>
 <20130115184037.GE1983@linaro.org>
Message-ID: <20130116160654.GC31318@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 06:40:37PM +0000, Dave Martin wrote:
> On Mon, Jan 14, 2013 at 06:26:04PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 14, 2013 at 12:15:07PM -0500, Nicolas Pitre wrote:
> > > The same could be said about the outer cache ops.  If a DSB is needed 
> > > for their intent to be valid, then why isn't this DSB always implied by 
> > > the corresponding cache op calls?
> > 
> > Hmm, just been thinking about this.
> > 
> > The L2x0 calls do contain a DSB but it's not obvious.  They hold a
> > raw spinlock, and when that spinlock is dropped, we issue a dsb and
> > sev instruction.
> > 
> > Whether the other L2 implementations do this or not I'm not sure -
> > but the above is a requirement of the spinlock implementation, and
> > it just happens to provide the right behaviour for L2x0.
> > 
> > But... we _probably_ don't want to impose that down at the L2 cache
> > level of things - at least not for DMA ops, particular for the sanity
> > of the scatter-list operating operations.  We really want to avoid
> > doing one DSB per scatterlist entry, doing one DSB per scatterlist
> > operation instead.
> > 
> > That does affect how the L2 cache API gets used - maybe we want to
> > separate out the DMA stuff from the other users so that we can have
> > dsbs in that path for non-DMA users.
> > 
> > Thoughts?
> 
> Perhaps the existing functions could be renamed to things like:
> 
> outer_XXX_flush_range()
> outer_XXX_sync()
> 
> Where XXX is something like "batch" or "background".  Optionally these
> could be declared somewhere separate to discourage non-DMA code from
> using them.  Other code could still want to do batches of outer cache
> operations efficiently, but I guess DMA is the main user.

There can be some confusion with using 'background' name because both
PL310 and L2X0 have background operations (the former only for the
set/way ops). But in software you need to ensure the completion of such
operations otherwise the L2 controller behaviour can be unpredictable.

So you just want to drop the barriers (outer_sync and dsb), maybe could
use the 'relaxed' suffix which matches the I/O accessors.

-- 
Catalin
