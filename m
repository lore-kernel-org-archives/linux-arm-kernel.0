From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 29 Jun 2017 15:13:23 +0100
Subject: [PATCH] arm64: fix endianness annotation for
 __apply_alternatives()/get_alt_insn()
In-Reply-To: <20170629132645.difv6xdjrkp5qvlh@ltop.local>
References: <20170628145557.24454-1-luc.vanoostenryck@gmail.com>
 <20170629102851.GF14607@arm.com>
 <20170629132645.difv6xdjrkp5qvlh@ltop.local>
Message-ID: <20170629141323.GH11040@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 03:26:47PM +0200, Luc Van Oostenryck wrote:
> On Thu, Jun 29, 2017 at 11:28:51AM +0100, Will Deacon wrote:
> > On Wed, Jun 28, 2017 at 04:55:57PM +0200, Luc Van Oostenryck wrote:
> > > get_alt_insn() is used to read and create ARM instructions, which
> > > are always stored in memory in little-endian order. These values
> > > are thus correctly converted to/from native order when processed
> > > but the pointers used to hold the address of these instructions
> > > are declared as for native order values.
> > > 
> > > Fix this by declaring the pointers as __le32* instead of u32* and
> > > make the few appropriate needed changes.
> > > 
> > > +		origptr = (__le32 __force *) ALT_ORIG_PTR(alt);
> > > +		replptr = (__le32 __force *) ALT_REPL_PTR(alt);
> > 
> > Why is the __force needed here?
> 
> Because of the cast to u32* in:
> 	#define ALT_ORIG_PTR(a)         __ALT_PTR(a, orig_offset)
> 	#define ALT_REPL_PTR(a)         __ALT_PTR(a, alt_offset)
> 	#define __ALT_PTR(a,f)          (u32 *)((void *)&(a)->f + (a)->f)
> 
> Of course, if this (u32*) is not really needed, then the __force
> is also not needed.
> 
> And since, it seems indeed to be the case, I'll gladly sent a patch:
> 	-#define __ALT_PTR(a,f)          (u32 *)((void *)&(a)->f + (a)->f)
> 	+#define __ALT_PTR(a,f)          ((void *)&(a)->f + (a)->f)
> if it suits you.

Given __ALT_PTR is intended to give a pointer to A64 instructions, which
are in le32 format, wouldn't it make more sense for __ALT_PTR to cast to
__le32 * ?

Thanks,
Mark.
