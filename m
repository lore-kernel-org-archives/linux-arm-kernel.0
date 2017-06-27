From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Tue, 27 Jun 2017 09:54:13 +0200
Subject: [PATCH] arm: pass endianness info to sparse
In-Reply-To: <20170626085311.GC4902@n2100.armlinux.org.uk>
References: <20170624153842.61064-1-luc.vanoostenryck@gmail.com>
 <20170626085311.GC4902@n2100.armlinux.org.uk>
Message-ID: <20170627075411.hod4skpr6htt4nax@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 09:53:11AM +0100, Russell King - ARM Linux wrote:
> On Sat, Jun 24, 2017 at 05:38:42PM +0200, Luc Van Oostenryck wrote:
> > ARM depends on the macros '__ARMEL__' & '__ARMEB__' being defined
> > or not to correctly select or define endian-specific macros,
> > structures or pieces of code.
> > 
> > These macros are predefined by the compiler but sparse knows
> > nothing about them and thus may pre-process files differently
> > from what gcc would.
> > 
> > Fix this by passing '-D__ARMEL__' or '-D__ARMEB__' to sparse,
> > depending of the endianness of the kernel, like defined by GCC.
> > 
> > Note: In most case it won't change anything since most ARMs use
> >       little-endian (but an allyesconfig would use big-endian!).
> 
> I wonder if that's a good thing - as this changes the endian conversion
> macros and ifdefs around bitfield declarations, it means that we're not
> testing the "popular" paths with an allyesconfig sparse - but then again,
> I think allyesconfig with sparse is a very bad idea, it needs to be
> targetted to the area being worked in.

The problem is that on any CONFIG_CPU_BIG_ENDIAN config, sparse
will process the wrong code after a '#if[n]def __ARMEB__'. Same,
of course with a little-endian config and '#if[n]def __ARMEL__'.

Since only two files test after __ARMEL__ :
- crypto/sha1-armv4-large.S
- crypto/sha512-core.S
most of the code are checked correctly for a little-endian config.
The same is not true for a big endian config since all the others
tests are made against __ARMEB__.

In short no big-endian config have never been sparse-checked for
endiannness problems on ARM. Worse, they are wrongly checked.

 
-- Luc Van Oostenryck
