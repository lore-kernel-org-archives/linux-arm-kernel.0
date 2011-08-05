From: dilinger@queued.net (Andres Salomon)
Date: Fri, 5 Aug 2011 06:44:47 -0700
Subject: [PATCH RFC v1] ARM: olpc: Add support for calling into the
	XO-1.75's OpenFirmware (OFW)
In-Reply-To: <20110805081143.GF28651@trinity.fluff.org>
References: <20110804162551.2b92b2cf@debxo>
	<20110805081143.GF28651@trinity.fluff.org>
Message-ID: <20110805064447.6900cac2@debxo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Aug 2011 09:11:44 +0100
Ben Dooks <ben-linux@fluff.org> wrote:

> On Thu, Aug 04, 2011 at 04:25:51PM -0700, Andres Salomon wrote:
> > Add support for saving OFW's cif, and later calling into it to run
> > OFW commands from the kernel.  OFW remains resident in memory after
> > boot, and the physical/virtual addresses are passed in a boot tag.
> > We parse that, and map the addresses.
> > 
> > This is currently only used by the OLPC XO-1.75, so it's named
> > olpc_ofw().
> > 
> > Signed-off-by: Andres Salomon <dilinger@queued.net>
> > ---
> >  Documentation/arm/Setup                  |    2 +
> >  arch/arm/Kconfig                         |    8 ++
> >  arch/arm/include/asm/olpc_ofw.h          |   23 ++++++
> >  arch/arm/include/asm/setup.h             |   24 ++++++
> >  arch/arm/mach-mmp/Makefile               |    1 +
> >  arch/arm/mach-mmp/include/mach/vmalloc.h |    2 +-
> >  arch/arm/mach-mmp/olpc-xo-1-75.c         |    7 ++
> >  arch/arm/mach-mmp/olpc_ofw.c             |  118
> > ++++++++++++++++++++++++++++++ 8 files changed, 184 insertions(+),
> > 1 deletions(-) create mode 100644 arch/arm/include/asm/olpc_ofw.h
> >  create mode 100644 arch/arm/mach-mmp/olpc_ofw.c
> > 
> > 
> > I'm looking for input on our mechanism for calling into OLPC's
> > openfirmware on arm.  Some of the x86 folks are cc'd
> > as they had lots of comment when we did this for x86 OLPC machines.
> > 
> > There's a device tree patch on top of this that can be seen here:
> > http://dev.laptop.org/git/olpc-3.0/patch/?id=12377851f9a64a9e2098adf09f858bed7d3eae7c
> > 
> > Unlike the XO-1, I'd like to get this OFW communication mechanism
> > ACKed prior to OLPC's mass production of these units.
> > 
[...]
> >  
> >  source "drivers/Kconfig"
> > diff --git a/arch/arm/include/asm/olpc_ofw.h
> > b/arch/arm/include/asm/olpc_ofw.h new file mode 100644
> > index 0000000..5346e9f
> > --- /dev/null
> > +++ b/arch/arm/include/asm/olpc_ofw.h
> > @@ -0,0 +1,23 @@
> > +#ifndef _ASM_ARM_OLPC_OFW_H
> > +#define _ASM_ARM_OLPC_OFW_H
> > +
> > +#ifdef CONFIG_OLPC
> > +
> > +/* run an OFW command by calling into the firmware */
> > +#define olpc_ofw(name, args, res) \
> > +	__olpc_ofw((name), ARRAY_SIZE(args), args,
> > ARRAY_SIZE(res), res) +
> > +extern int __olpc_ofw(const char *name, int nr_args, const void
> > **args,
> > +		int nr_res, void **res);
> > +
> > +/* map OFW's page tables into kernel memory */
> > +extern void setup_olpc_ofw_mapping(void);
> > +
> > +/* check if OFW was detected during boot */
> > +extern bool olpc_ofw_present(void);
> > +
> > +#else /* !CONFIG_OLPC */
> > +static inline void setup_olpc_ofw_mapping(void) { }
> > +#endif /* !CONFIG_OLPC */
> > +
> > +#endif /* _ASM_ARM_OLPC_OFW_H */
> > diff --git a/arch/arm/include/asm/setup.h
> > b/arch/arm/include/asm/setup.h index ee2ad8a..c75889e 100644
> > --- a/arch/arm/include/asm/setup.h
> > +++ b/arch/arm/include/asm/setup.h
> > @@ -143,6 +143,25 @@ struct tag_memclk {
> >  	__u32 fmemclk;
> >  };
> >  
> > +/* OLPC OpenFirmware callback parameters: see
> > arch/arm/mach-mmp/olpc_ofw.c */ +#define ATAG_OLPC_OFW
> > 0x41000502 +
> > +struct tag_olpc_ofw {
> > +	__u32 cif_handler;	/* callback into OFW */
> > +
> > +	/* map_desc one - OFW's main memory */
> > +	__u32 ofw_va;
> > +	__u32 ofw_pfn;		/* physical address's PFN */
> > +	__u32 ofw_length;
> > +	__u32 ofw_mem_type;	/* MT_ */
> > +
> > +	/* map_desc two - OFW's frame buffer */
> > +	__u32 fb_va;
> > +	__u32 fb_pfn;		/* physical address's PFN */
> > +	__u32 fb_length;
> > +	__u32 fb_mem_type;	/* MT_ */
> > +};
> > +
> 
> The new booting method for OF on ARM is pass a pointer to the dtb
> via r2 instead of the ATAGs. You can get rid of ATAGs completely
> at this point.
> 

This is not (only) about the device tree.  It's about calling into
OFW.  For example, one could break into OFW to debug crashed hardware
(or software, I support) by hooking up a sysrq to call
olpc_ofw("enter").  Building the device tree is just one of the things
that we do.

> >  struct tag {
> >  	struct tag_header hdr;
> >  	union {
> > @@ -165,6 +184,11 @@ struct tag {
> >  		 * DC21285 specific
> >  		 */
> >  		struct tag_memclk	memclk;
> > +
> > +		/*
> > +		 * OLPC specific - for OLPC's OpenFirmware
> > implementation
> > +		 */
> > +		struct tag_olpc_ofw	olpc_ofw;
> >  	} u;
> >  };
> >  
