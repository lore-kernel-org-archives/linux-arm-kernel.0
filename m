From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2016 17:43:38 +0200
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <20160822153258.GB21012@ulmo.ba.sec>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <5669893.Rd6yQObxH6@wuerfel> <20160822153258.GB21012@ulmo.ba.sec>
Message-ID: <9945785.T0mojj3S7F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2016 5:32:58 PM CEST Thierry Reding wrote:
> On Mon, Aug 22, 2016 at 04:42:32PM +0200, Arnd Bergmann wrote:
> > On Monday, August 22, 2016 4:02:11 PM CEST Thierry Reding wrote:
> > > > > +struct mrq_request {
> > > > > +	/** @brief MRQ number of the request */
> > > > > +	uint32_t mrq;
> > > > > +	/** @brief flags for the request */
> > > > > +	uint32_t flags;
> > > > > +} __ABI_PACKED;
> > > > 
> > > > Marking the structure as packed may result in byte-wise access, depending
> > > > on compiler flags. Is that what you intended? The structure is fully
> > > > packed already, so you won't avoid any padding here.
> > > 
> > > Agreed, the packing seems unnecessary in many places. However this is
> > > defining an ABI that's used across multiple operating systems, so the
> > > packing may still be required on some systems or toolchains to ensure
> > > the exact same format in the transport.
> > 
> > However, if __ABI_PACKED is defined to an empty string, it is different
> > in some cases.
> > 
> > Also, setting 'NO_GCC_EXTENSIONS' changes the structure layout of
> > some of the structures, by adding an extra member. If the firmware
> > has a compiler that is less than 10 years old, I'd suggest using C99
> > syntax instead, which should avoid those differences and eliminate
> > all gcc extensions.
> 
> I think this isn't only about the firmware (which, as far as I can tell,
> is always built with a non-ancient version of GCC). The same header file
> is used in other operating systems and I have no idea about the
> toolchain situation there.
> 
> As for the NO_GCC_EXTENSIONS I think that's only used to avoid empty
> structures and zero-sized arrays, which I assume not all supported
> toolchains can deal with.
>
> Sivaram, Timo: can you shed any light on the scope of operating systems
> and toolchains that we need to support? Any ideas, short of manual
> editing, that we can try to eliminate some of Arnd's concerns?

Ok. To clarify, C99 supports this syntax:

struct variable_length_struct {
	int length;
	char data[];
};

struct empty_struct {
	char nothing[];
};

which could be used in place of the gcc specific syntax in
portable code.

	Arnd
