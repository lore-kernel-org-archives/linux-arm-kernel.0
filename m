From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Jul 2011 00:04:26 -0400 (EDT)
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace
 boot_params
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F383D6CD4D@AUSP01VMBX24.collaborationhost.net>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<ADE657CA350FB648AAC2C43247A983F001F383D6CD4D@AUSP01VMBX24.collaborationhost.net>
Message-ID: <alpine.LFD.2.00.1107070003410.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, H Hartley Sweeten wrote:

> On Tuesday, July 05, 2011 7:47 PM, Nicolas Pitre wrote:
> > The boot_params member of the mdesc structure is used to provide a
> > default physical address for the ATAG list.  Since this value is fixed
> > at compile time and often based on ARCH_PHYS_OFFSET, it gets in the way
> > of runtime PHYS_OFFSET usage.
> > 
> > Let's introduce atag_offset which should contains only the relative
> > offset from start of memory instead of an absolute value, in preparation
> > to move all instance of boot_params over to it.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > ---
> >  arch/arm/include/asm/mach/arch.h |    1 +
> >  arch/arm/kernel/setup.c          |    2 ++
> >  2 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> > index 7b79a00..1bdf6e1 100644
> > --- a/arch/arm/include/asm/mach/arch.h
> > +++ b/arch/arm/include/asm/mach/arch.h
> > @@ -18,6 +18,7 @@ struct machine_desc {
> >  	unsigned int		nr;		/* architecture number	*/
> >  	const char		*name;		/* architecture name	*/
> >  	unsigned long		boot_params;	/* tagged list		*/
> > +	unsigned long		atag_offset;	/* tagged list (relative) */
> >  	const char		**dt_compat;	/* array of device tree
> >  						 * 'compatible' strings	*/
> >  
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index e0db84d..4cc3e2b 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -816,6 +816,8 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
> >  
> >  	if (__atags_pointer)
> >  		tags = phys_to_virt(__atags_pointer);
> > +	else if(mdesc->atag_offset)
> > +		tags = PAGE_OFFSET + mdesc->atag_offset;
> 
> This results in a warning...
> 
> arch/arm/kernel/setup.c: In function 'setup_arch':
> arch/arm/kernel/setup.c:820: warning: assignment makes pointer from integer without a cast

Bleh.  Fixed, thanks.


Nicolas
