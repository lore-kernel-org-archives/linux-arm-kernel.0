From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2010 15:50:11 +0000
Subject: [PATCH] ARM: Always generate the IT instruction when
	compilingfor Thumb-2
In-Reply-To: <20100128145530.GC24679@shareable.org>
References: <20100128145530.GC24679@shareable.org>
Message-ID: <1264693811.7064.88.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-28 at 14:55 +0000, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > On Wed, 2010-01-27 at 22:02 +0000, Russell King - ARM Linux wrote:
> > > On Tue, Jan 26, 2010 at 10:14:24AM +0000, Catalin Marinas wrote:
> > > > Current behaviour is to generate the IT instruction only for Thumb-2
> > > > code. However, the kernel helpers in entry-armv.S are compiled to ARM in
> > > > a unified syntax file (if THUMB2_KERNEL). Recent compilers warn about
> > > > missing IT instruction in unified assembly syntax files. The patch
> > > > changes the "-mimplicit-it" gas option to "always".
> > >
> > > Any downsides to this change?  Any assemblers not accepting "always"
> > > instead of "thumb" ?
> >
> > When the -mimplicit-it was merged into mainline gas, it supported all of
> > thumb, arm, always and never. We still have the old -mauto-it but that's
> > I think only valid for the CodeSourcery toolchains.
> 
> I notice there's a few "it" dotted around the kernel code now.  In
> fact, that's how I learned about it - because I thought "that can't be
> right when targetting ARM", and did some reading to learn otherwise.
> 
> With -mimplicit-it=always, they should not be needed.  So they can be
> removed from the kernel source?
> 
> Or, if it's policy to put "it" in all the places needed, wouldn't
> -mimplicit-it=arm (the gas default) be a better choice, to make sure
> they are in all the places needed?

The original Thumb-2 patches were adding these IT instructions
explicitly (quite a lot). With compiler support for automatically
generating them, the kernel can avoid explicit IT in most cases with a
few exceptions.

For things like:

1:	LDRNE	...

gas generates:

1:	IT	NE
	LDRNE	...

since you are not allowed to branch in the middle of an IT block.

But if the label 1 is used for the exception table, it should point to
LDRNE rather than IT, so we have to write the code as below and manually
insert IT:

	IT	NE
1:	LDRNE	...

-- 
Catalin
