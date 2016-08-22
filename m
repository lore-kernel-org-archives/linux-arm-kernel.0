From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Aug 2016 17:32:58 +0200
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <5669893.Rd6yQObxH6@wuerfel>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <2059006.oN1pE0IkCo@wuerfel> <20160822140211.GE17367@ulmo.ba.sec>
 <5669893.Rd6yQObxH6@wuerfel>
Message-ID: <20160822153258.GB21012@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 04:42:32PM +0200, Arnd Bergmann wrote:
> On Monday, August 22, 2016 4:02:11 PM CEST Thierry Reding wrote:
> > On Mon, Aug 22, 2016 at 03:34:15PM +0200, Arnd Bergmann wrote:
> > > On Friday, August 19, 2016 7:32:26 PM CEST Thierry Reding wrote:
> > > > diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
> > > > new file mode 100644
> > > > index 000000000000..0aaef5960e29
> > > > --- /dev/null
> > > > +++ b/include/soc/tegra/bpmp-abi.h
> > > > +#ifndef _ABI_BPMP_ABI_H_
> > > > +#define _ABI_BPMP_ABI_H_
> > > > +
> > > > +#ifdef LK
> > > > +#include <stdint.h>
> > > > +#endif
> > > > +
> > > > +#ifndef __ABI_PACKED
> > > > +#define __ABI_PACKED __attribute__((packed))
> > > > +#endif
> > > > +
> > > > +#ifdef NO_GCC_EXTENSIONS
> > > > +#define EMPTY char empty;
> > > > +#define EMPTY_ARRAY 1
> > > > +#else
> > > > +#define EMPTY
> > > > +#define EMPTY_ARRAY 0
> > > > +#endif
> > > > +
> > > > +#ifndef __UNION_ANON
> > > > +#define __UNION_ANON
> > > > +#endif
> > > 
> > > Maybe keep these all out of the kernel?
> > 
> > This was discussed a little in an earlier posting. This header file is
> > maintained by the BPMP firmware team and using it verbatim means little
> > to no effort required to update it.
> 
> The usual recommendation is to just use Linux coding style in shared
> files, and possibly add another header that provides the required
> definitions. Otherwise you end up with people randomly cleaning up
> the file later ;-)

I dug up the discussion from earlier:

	http://patchwork.ozlabs.org/patch/644643/

Some people from our BPMP firmware team objected to this file being
modified in any way because it would make subsequent updates needlessly
difficult.

There's also at least one precedent, albeit with style a lot closer to
Linux:

	include/linux/mfd/cros_ec_commands.h

I don't mind much either way. The file is at least well documented and
consistent in itself. If you or anyone else insists, I can make a pass
and mold this into something that adheres to the kernel coding style.

> > > > +struct mrq_request {
> > > > +	/** @brief MRQ number of the request */
> > > > +	uint32_t mrq;
> > > > +	/** @brief flags for the request */
> > > > +	uint32_t flags;
> > > > +} __ABI_PACKED;
> > > 
> > > Marking the structure as packed may result in byte-wise access, depending
> > > on compiler flags. Is that what you intended? The structure is fully
> > > packed already, so you won't avoid any padding here.
> > 
> > Agreed, the packing seems unnecessary in many places. However this is
> > defining an ABI that's used across multiple operating systems, so the
> > packing may still be required on some systems or toolchains to ensure
> > the exact same format in the transport.
> 
> However, if __ABI_PACKED is defined to an empty string, it is different
> in some cases.
> 
> Also, setting 'NO_GCC_EXTENSIONS' changes the structure layout of
> some of the structures, by adding an extra member. If the firmware
> has a compiler that is less than 10 years old, I'd suggest using C99
> syntax instead, which should avoid those differences and eliminate
> all gcc extensions.

I think this isn't only about the firmware (which, as far as I can tell,
is always built with a non-ancient version of GCC). The same header file
is used in other operating systems and I have no idea about the
toolchain situation there.

As for the NO_GCC_EXTENSIONS I think that's only used to avoid empty
structures and zero-sized arrays, which I assume not all supported
toolchains can deal with.

Sivaram, Timo: can you shed any light on the scope of operating systems
and toolchains that we need to support? Any ideas, short of manual
editing, that we can try to eliminate some of Arnd's concerns?

> > > > +struct cmd_clk_set_rate_request {
> > > > +	int32_t unused;
> > > > +	int64_t rate;
> > > > +} __ABI_PACKED;
> > > 
> > > This structure actually has a non-aligned struct member, but you
> > > can write that as
> > > 
> > > struct cmd_clk_set_rate_request {
> > > 	int32_t unused;
> > > 	int64_t rate;
> > > } __attribute__((packed, aligned(4)));
> > > 
> > > to still use a default four-byte alignment.
> > 
> > I thought the original would yield something like this in memory:
> > 
> > 	[unused]
> > 	[rate  ]
> > 	[rate  ]
> > 
> > because packing makes sure to avoid any padding introduced for natural
> > alignment. Isn't __attribute__((packd, aligned(4))) going to yield the
> > exact same layout?
> 
> Yes, only the alignment of the structure itself is changed, not
> the contents. The main difference is that accessing 'rate' on
> a target machine without unaligned access will use two 32-bit
> loads rather than eight 8-bit loads.
> 
> Also, embedding this structure in another one is different
> (in theory, I don't expect this to actually appear somewhere):
> 
> struct example {
> 	char a;
> 	struct cmd_clk_set_rate_request b;
> };
> 
> would currently be 13 bytes long, with the alignment I suggested you
> get three bytes of padding after 'a'.

Something that just occurred to me now is that the field that causes the
misalignment is actually unused. I can only imagine that some earlier
version of the ABI must have used it for some purpose and then it was
deprecated but kept for backwards-compatibility.

Sivaram, Timo: any ideas how this came about?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/894ce248/attachment.sig>
