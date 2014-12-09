From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Dec 2014 17:27:30 +0000
Subject: ARM page tables
In-Reply-To: <54872F9C.2080005@free.fr>
References: <54872F9C.2080005@free.fr>
Message-ID: <20141209172729.GK11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 06:21:32PM +0100, Mason wrote:
> On my SoC, we have two MMIO regions mapped at init:
> 
>  {
>   .virtual = (0xf0000000 + 0x00800000),
>   .pfn =((unsigned long)((0x20000000) >> 12)),
>   .length = 0x00200000,
>   .type = 0,
>  },
>  {
>   .virtual = (0xf0000000 +(0)),
>   .pfn =((unsigned long)((0) >> 12)),
>   .length = 0x00800000,
>   .type = 0,
>  },
> 
> I dumped the L1 page table descriptors, expecting to find
> entries for the MMIO regions:
> (AFAICT, the page table starts at 0xc0007000)

No, it starts at 0xc0004000.

> col_1 = entry number (hex)
> col_2 = entry value
> col_3 = string for (desc & 3)
> 
> 300 00011452 SECTION
> 301 00111452 SECTION
> 302 00211452 SECTION
> 303 00311452 SECTION
> 304 00411452 SECTION
> 305 00511452 SECTION
> 306 00611452 SECTION
> 307 00711452 SECTION
> 308 20011452 SECTION
> 309 20111452 SECTION
> 
> If I understand correctly, entry 308 means:
> VIRTUAL ADDRESS 0x3080_0000 is mapped to PHYSICAL ADDRESS 0x2000_0000
> (Is my reading correct?)

No.  If you're talking about 0x308 from an offset of 0x3000 into the
page table, that's 0x308 * 1MB + 0xc0000000 = 0xf0800000.

> But we asked to map PA 0x2000_0000 to VA 0xf080_0000 in iotable_init,
> so I'm confused...

So, with the right starting point, it works out correctly.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
