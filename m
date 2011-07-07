From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Jul 2011 14:43:15 -0400 (EDT)
Subject: [PATCH] ARM: get rid of a few StrongARM cache-related build time
	constants
In-Reply-To: <20110707170631.GB20403@n2100.arm.linux.org.uk>
References: <1309919636-20546-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706075542.GK8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107060912490.14596@xanadu.home>
	<20110707170631.GB20403@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107071438200.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Russell King - ARM Linux wrote:

> On Wed, Jul 06, 2011 at 09:21:33AM -0400, Nicolas Pitre wrote:
> > Could you test this patch as well?  You're the only one I know who might 
> > still have access to the affected hardware.
> 
> Tested on Assabet, and unfortunately, this doesn't work on its own because
> we don't permit iotable_init() to create pages with MT_CACHECLEAN and
> MT_MINICLEAN.
> 
> <4>BUG: map for 0xe0000000 at 0xfffe0000 can not be mapped using pages, ignoring.
> <4>BUG: map for 0xe0004000 at 0xfffe4000 can not be mapped using pages, ignoring.
> <4>BUG: map for 0xe0008000 at 0xfffe8000 can not be mapped using pages, ignoring.
> <4>BUG: map for 0xe000c000 at 0xfffec000 can not be mapped using pages, ignoring.
> 
> The fix is below (probably with offsets):

Great. Are you providing an ACK or tested-by with this patch folded in?

> @@ -506,16 +488,8 @@ static void __init build_mem_type_table(void)
>  	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
>  	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask;
>  	mem_types[MT_ROM].prot_sect |= cp->pmd;
> +	mem_types[MT_CACHECLEAN].prot_pte |= kern_pgprot;
>  
Doesn't MT_MINICLEAN require kern_pgprot as well?


Nicolas
