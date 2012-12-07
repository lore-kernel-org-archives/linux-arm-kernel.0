From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 7 Dec 2012 10:43:49 +0100
Subject: What value for max_pfn on ARM ?
Message-ID: <20121207094348.GB32721@izard-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

While trying to use the /proc/kpagecount and /proc/kpageflags to debug a
memory issue on a 2.6.32 kernel, I encountered a code segment that does
not seem to work to work as designed on my ARM platform.  The kpage*
entries provide information on memory PFNs, and are supposed to return 8
bytes of data for each page frame of physical memory in the system. 
(see Documentation/vm/pagemap.txt for more details)

Both entries use the same algorithm to determine a conversion between
the file offset and the PFN. This conversion takes the following
assumption as granted: valid memory PFNs are comprised between 0 and
max_pfn-1. After returning values for (max_pfn-1), the proc entry
reports an End-Of-File condition.

But on my platform, which uses the flat memory modem, the physical
memory is located at 0xC0000000, and thus the valid PFN range starts at
0xC00000. This means that when I use ?od? to read the contents of the
entry, I only get information for invalid entries, between 0 and
max_pfn, and thus I get no relevant information.

It is possible to seek after the EOF, to start reading the PFNs at an
arbitrary offset. It is the most logical way of using this facility, as
the values recovered in /proc/<pid>/pagemap are the absolute value of
the PFN. As a result, this means that this issue is not blocking when
using tools like smem (http://www.selenic.com/smem/), which were
designed to work with this subsystem.

>From what I read in other architectures, it seems that the most common
case for max_pfn is that this variable really contains the maximum value
for all PFNs in the system, the first valid PFN is ARCH_PFN_OFFSET, and
the number of valid PFNs is max_mapnr. In the FLATMEM model, the
assertion (max_pfn - ARCH_PFN_OFFSET == max_mapnr) is true. 

But for ARM and ARM64, we are using PHYS_PFN_OFFSET in addition to
ARCH_PFN_OFFSET, and in the FLATMEM model (max_pfn == max_mapnr) is true.

I am looking for answers to the following questions:
- What is the use of PHYS_PFN_OFFSET in ARM platforms ?
- Can we safely stop to use it, and use the more common case, with only
  ARCH_PFN_OFFSET ?
- If not, how can we recover the number of the last valid PFN, for all
  architectures ?

Best regards,
-- 
Romain Izard
