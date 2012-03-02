From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Mar 2012 16:19:35 -0500 (EST)
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <1330526664.4270.128.camel@zakaz.uk.xensource.com>
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
 <20120229125826.GC2077@linaro.org>
 <1330526664.4270.128.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.LFD.2.02.1203021615350.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Feb 2012, Ian Campbell wrote:

> On Wed, 2012-02-29 at 12:58 +0000, Dave Martin wrote:
> > On Wed, Feb 29, 2012 at 09:56:02AM +0000, Ian Campbell wrote:
> > > On Wed, 2012-02-29 at 09:34 +0000, Dave Martin wrote:
> > > > On Tue, Feb 28, 2012 at 12:28:29PM +0000, Stefano Stabellini wrote:
> > > 
> > > > > I don't have a very strong opinion on which register we should use, but
> > > > > I would like to avoid r7 if it is already actively used by gcc.
> > > > 
> > > > But there is no framepointer for Thumb-2 code (?)
> > > 
> > > Peter Maydell suggested there was:
> > > > r7 is (used by gcc as) the Thumb frame pointer; I don't know if this
> > > > makes it worth avoiding in this context.
> > > 
> > > Sounds like it might be a gcc-ism, possibly a non-default option?
> > > 
> > > Anyway, I think r12 will be fine for our purposes so the point is rather
> > > moot.
> > 
> > Just had a chat with some tools guys -- apparently, when passing register
> > arguments to gcc inline asms there really isn't a guarantee that those
> > variables will be in the expected registers on entry to the inline asm.
> > 
> > If gcc reorders other function calls or other code around the inline asm
> > (which it can do, except under certain controlled situations), then
> > intervening code can clobber any registers in general.
> > 
> > Or, to summarise another way, there is no way to control which register
> > is used to pass something to an inline asm in general (often we get away
> > with this, and there are a lot of inline asms in the kernel that assume
> > it works, but the more you inline the more likely you are to get nasty
> > surprises).  There is no workaroud, except on some architectures where
> > special asm constraints allow specific individual registers to be
> > specified for operands (i386 for example).
> 
> I had assumed I just couldn't find the right syntax. Useful to know that
> I couldn't find it because it doesn't exist!

It does exist.  See my previous reply to this thread.

You can find this syntax described in section 6.44.2 "Specifying 
Registers for Local Variables" in gcc v4.6.1 (possibly another section 
number in the documentation for a different gcc version).


Nicolas
