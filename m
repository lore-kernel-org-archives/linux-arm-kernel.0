From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Jan 2013 13:49:41 -0500 (EST)
Subject: [PATCH 07/16] ARM: bL_platsmp.c: close the kernel entry gate
 before hot-unplugging a CPU
In-Reply-To: <20130114182604.GL23505@n2100.arm.linux.org.uk>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-8-git-send-email-nicolas.pitre@linaro.org>
 <20130114163755.GB31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141151510.6300@xanadu.home>
 <20130114170028.GD31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141207360.6300@xanadu.home>
 <20130114182604.GL23505@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1301141335560.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jan 2013, Russell King - ARM Linux wrote:

> On Mon, Jan 14, 2013 at 12:15:07PM -0500, Nicolas Pitre wrote:
> > The same could be said about the outer cache ops.  If a DSB is needed 
> > for their intent to be valid, then why isn't this DSB always implied by 
> > the corresponding cache op calls?
> 
> Hmm, just been thinking about this.
> 
> The L2x0 calls do contain a DSB but it's not obvious.  They hold a
> raw spinlock, and when that spinlock is dropped, we issue a dsb and
> sev instruction.
> 
> Whether the other L2 implementations do this or not I'm not sure -
> but the above is a requirement of the spinlock implementation, and
> it just happens to provide the right behaviour for L2x0.
> 
> But... we _probably_ don't want to impose that down at the L2 cache
> level of things - at least not for DMA ops, particular for the sanity
> of the scatter-list operating operations.  We really want to avoid
> doing one DSB per scatterlist entry, doing one DSB per scatterlist
> operation instead.
> 
> That does affect how the L2 cache API gets used - maybe we want to
> separate out the DMA stuff from the other users so that we can have
> dsbs in that path for non-DMA users.
> 
> Thoughts?

The dsb or its intended effect could be confined to outer_sync() and 
then cache_sync() removed from l2x0_flush_range().  That would allow the 
sync to be applied when appropriate.  However that suffers the same API 
intent mismatch I was talking about.

Maybe adding some asynchronous methods to outer_cache (that could 
default to the synchronous calls) where the name of the function clearly 
implies a posted operation would be a better solution.  In that case the 
effect of the operation would be assumed complete only after a 
terminating outer_sync().


Nicolas
