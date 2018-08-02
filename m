From: mpatocka@redhat.com (Mikulas Patocka)
Date: Thu, 2 Aug 2018 15:31:15 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a 
strange problem.

When I use the links browser in graphics mode on the framebuffer, I get 
occasional pixel corruption. Links does memcpy, memset and 4-byte writes 
on the framebuffer - nothing else.

I found out that the pixel corruption is caused by overlapping unaligned 
stp instructions inside memcpy. In order to avoid branching, the arm64 
memcpy implementation may write the same destination twice with different 
alignment. If I put "dmb sy" between the overlapping stp instructions, the 
pixel corruption goes away.

This seems like a hardware bug. Is it a known errata? Do you have any 
workarounds for it?

I tried AMD card (HD 6350) and NVidia (NVS 285) and both exhibit the same 
corruption. OpenGL doesn't work (it results in artifacts on the AMD card 
and lock-up on the NVidia card), but it's quite expected if even simple 
writing to the framebuffer doesn't work.

Mikulas
