From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 29 Feb 2012 11:47:25 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <1330509362.4270.20.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1330360043.8557.302.camel@zakaz.uk.xensource.com>
 <20120227180355.GB2023@linaro.org>
 <1330371219.10008.34.camel@dagon.hellion.org.uk>
 <20120228102040.GB2063@linaro.org>
 <1330426133.31269.70.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.00.1202281149210.23091@kaball-desktop>
 <20120229093436.GA2077@linaro.org>
 <1330509362.4270.20.camel@zakaz.uk.xensource.com>
Message-ID: <20120229114725.GB2077@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 09:56:02AM +0000, Ian Campbell wrote:
> On Wed, 2012-02-29 at 09:34 +0000, Dave Martin wrote:
> > On Tue, Feb 28, 2012 at 12:28:29PM +0000, Stefano Stabellini wrote:
> 
> > > I don't have a very strong opinion on which register we should use, but
> > > I would like to avoid r7 if it is already actively used by gcc.
> > 
> > But there is no framepointer for Thumb-2 code (?)
> 
> Peter Maydell suggested there was:
> > r7 is (used by gcc as) the Thumb frame pointer; I don't know if this
> > makes it worth avoiding in this context.
> 
> Sounds like it might be a gcc-ism, possibly a non-default option?

I seem to remember discussions about some cruft in gcc related to this.
gcc actually barfs at you if you try to allocate r7 to inline asm
without -fomit-frame-pointer.  That use for r7 really relates to the
legacy ABI, so this may be a bug.

> Anyway, I think r12 will be fine for our purposes so the point is rather
> moot.

Yes, it sounds like it.  If that r7 issue is a gcc bug, this would avoid
it.

If you leave the job of putting the right constant into r12 up to gcc,
it should generate reasonable for you without having to code it
explicitly anyway:

	register int hvc_num asm("r12") = 0xDEADBEEF;

	asm volatile (
		"hvc	0"
		:: "r" (hvc_num)
	)

Cheers
---Dave
