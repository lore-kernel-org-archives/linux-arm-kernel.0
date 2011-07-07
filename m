From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 21:53:04 +0100
Subject: [PATCH] ARM: get rid of a few StrongARM cache-related build
	time constants
In-Reply-To: <alpine.LFD.2.00.1107071438200.14596@xanadu.home>
References: <1309919636-20546-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706075542.GK8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107060912490.14596@xanadu.home>
	<20110707170631.GB20403@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107071438200.14596@xanadu.home>
Message-ID: <20110707205304.GF20403@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 02:43:15PM -0400, Nicolas Pitre wrote:
> On Thu, 7 Jul 2011, Russell King - ARM Linux wrote:
> 
> > On Wed, Jul 06, 2011 at 09:21:33AM -0400, Nicolas Pitre wrote:
> > > Could you test this patch as well?  You're the only one I know who might 
> > > still have access to the affected hardware.
> > 
> > Tested on Assabet, and unfortunately, this doesn't work on its own because
> > we don't permit iotable_init() to create pages with MT_CACHECLEAN and
> > MT_MINICLEAN.
> > 
> > <4>BUG: map for 0xe0000000 at 0xfffe0000 can not be mapped using pages, ignoring.
> > <4>BUG: map for 0xe0004000 at 0xfffe4000 can not be mapped using pages, ignoring.
> > <4>BUG: map for 0xe0008000 at 0xfffe8000 can not be mapped using pages, ignoring.
> > <4>BUG: map for 0xe000c000 at 0xfffec000 can not be mapped using pages, ignoring.
> > 
> > The fix is below (probably with offsets):
> 
> Great. Are you providing an ACK or tested-by with this patch folded in?
> 
> > @@ -506,16 +488,8 @@ static void __init build_mem_type_table(void)
> >  	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
> >  	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask;
> >  	mem_types[MT_ROM].prot_sect |= cp->pmd;
> > +	mem_types[MT_CACHECLEAN].prot_pte |= kern_pgprot;
> >  
> Doesn't MT_MINICLEAN require kern_pgprot as well?

Only if you think the result of orring:

#define L_PTE_MT_WRITEBACK      (_AT(pteval_t, 0x03) << 2)      /* 0011 */
#define L_PTE_MT_MINICACHE      (_AT(pteval_t, 0x06) << 2)      /* 0110 (sa1100, xscale) */

together would make sense... it'd make it:

#define L_PTE_MT_WRITEALLOC     (_AT(pteval_t, 0x07) << 2)      /* 0111 */

though, so I don't think so.
