From: mpeg.blue@free.fr (Mason)
Date: Tue, 09 Dec 2014 18:21:32 +0100
Subject: ARM page tables
Message-ID: <54872F9C.2080005@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

On my SoC, we have two MMIO regions mapped at init:

  {
   .virtual = (0xf0000000 + 0x00800000),
   .pfn =((unsigned long)((0x20000000) >> 12)),
   .length = 0x00200000,
   .type = 0,
  },
  {
   .virtual = (0xf0000000 +(0)),
   .pfn =((unsigned long)((0) >> 12)),
   .length = 0x00800000,
   .type = 0,
  },

I dumped the L1 page table descriptors, expecting to find
entries for the MMIO regions:
(AFAICT, the page table starts at 0xc0007000)

col_1 = entry number (hex)
col_2 = entry value
col_3 = string for (desc & 3)

300 00011452 SECTION
301 00111452 SECTION
302 00211452 SECTION
303 00311452 SECTION
304 00411452 SECTION
305 00511452 SECTION
306 00611452 SECTION
307 00711452 SECTION
308 20011452 SECTION
309 20111452 SECTION

If I understand correctly, entry 308 means:
VIRTUAL ADDRESS 0x3080_0000 is mapped to PHYSICAL ADDRESS 0x2000_0000
(Is my reading correct?)

But we asked to map PA 0x2000_0000 to VA 0xf080_0000 in iotable_init,
so I'm confused...

Also, looking at entry 300:
VA 0x3000_0000 to PA 0
but we asked for VA 0xf000_0000 didn't we?

Can someone clear my confusion?

Regards.
