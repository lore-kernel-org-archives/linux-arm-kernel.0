From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Feb 2016 16:47:42 +0000
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <64215923.Y25jP5YYZ2@wuerfel>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <3699765.F7sfuMCyKT@wuerfel>
 <HK2PR06MB05616AAF67B15C7A2BDC4F608AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <64215923.Y25jP5YYZ2@wuerfel>
Message-ID: <20160219164742.GZ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 04:59:43PM +0100, Arnd Bergmann wrote:
> On Friday 19 February 2016 15:36:23 Chris Brandt wrote:
> > On 19 Feb 2016, Arnd Bergmann wrote:
> > 
> > > For PHYS_OFFSET, parsing the DT doesn't help at all because we only
> > > need it for XIP_KERNEL (more or less at least) which cannot patch
> > > the kernel image at boot time, so knowing that the address is wrong
> > > also doesn't help you.
> > > 
> > > 	Arnd
> > 
> > OK, at first I was thinking that PHYS_OFFSET was only used early in boot as a pointer to valid RAM before the DT was read (in head.S and head-nommu.S). Hence, you could pass in the pointer in via another CPU register like the DT pointer is passed in.
> > 
> > But, now I see that PHYS_OFFSET is used all over the place as a hard coded #define, hence your comment "which cannot patch the kernel image at boot time"
> > 
> > So, I retract my thought...it has to be configured at build-time (unless of course you turn it into a global variable everywhere...which might be an even bigger mess)
> > 
> 
> BTW, I've tried removing the patching in CONFIG_PHYS_VIRT and replaced it
> with references to __pv_phys_pfn_offset, which surprisingly only grew
> .text from 4901692 to 4904300 bytes, so the size overhead of doing this
> would be close to zero.

The next job is to perf the resulting kernel - because you will have
the additional overhead of loading the offset.  Size is not everything,
contary to popular beliefs.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
