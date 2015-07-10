From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Jul 2015 12:25:22 +0100
Subject: [PATCH v3] ARM: early fixmap support for earlycon
In-Reply-To: <20150606124800.GR7557@n2100.arm.linux.org.uk>
References: <1433593888-7142-1-git-send-email-stefan@agner.ch>
 <20150606124800.GR7557@n2100.arm.linux.org.uk>
Message-ID: <20150710112522.GR7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 06, 2015 at 01:48:00PM +0100, Russell King - ARM Linux wrote:
> On Sat, Jun 06, 2015 at 02:31:28PM +0200, Stefan Agner wrote:
> > @@ -1231,7 +1272,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
> >  
> >  	early_trap_init(vectors);
> >  
> > -	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
> > +	for (addr = VMALLOC_START; addr < FIXADDR_START; addr += PMD_SIZE)
> >  		pmd_clear(pmd_off_k(addr));
> 
> You introduce a bug here - we no logner clear the very top entry of the
> page tables, which means it could contain anything - and means that the
> subsequent creation of the L2 table in early_pte_alloc() can fail.

You trimmed my reply hard, and seemingly ignored this; the v4 patch
contains exactly the same code here, and therefore continues to leave
the top of the page table uninitialised.

Not applying the v4 patch, sorry.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
