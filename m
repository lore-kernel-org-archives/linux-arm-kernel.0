From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Oct 2009 12:12:04 +0000
Subject: [PATCH] Use Normal uncached memory rather than Strongly
	Ordered on ARMv6+
In-Reply-To: <20091023213307.GB29639@n2100.arm.linux.org.uk>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
	<20091023123600.GB22853@n2100.arm.linux.org.uk>
	<1256316861.6564.154.camel@pc1117.cambridge.arm.com>
	<20091023171227.GA29639@n2100.arm.linux.org.uk>
	<20091023213307.GB29639@n2100.arm.linux.org.uk>
Message-ID: <1256559124.5282.54.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-23 at 22:33 +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 23, 2009 at 06:12:27PM +0100, Russell King - ARM Linux wrote:
> > As far as I'm concerned, we've spent far too long discussing this issue -
> > there's nothing really to discuss.  We need dma_alloc_coherent() to use
> > its own page protection modifier, which causes it to behave the same as
> > dma_alloc_writecombine() on ARMv7, and with the existing behaviour (for
> > the time being) on ARMv6 and below.  We should leave pgprot_noncached()
> > well alone until we know that its other places need to be changed.
> 
> And here is the patch which does this.  Note that it also ensures that
> NX is set for these pages on both ARMv6 and later.

With Abhijeet's comment for mb(), I'm ok with the patch.

There are a few other explicit uses for pgprot_noncached() in the kernel
but I don't think they affect us yet. Some of them could probably be
changed to writecombine.

For /dev/mem, I still think we should do what IA-64 or PPC do - using
cached or writecombine if it is known to be RAM (yes, I know what you
said in the previous e-mails, it's not simple but I'll try to post
another patch for that).

-- 
Catalin
