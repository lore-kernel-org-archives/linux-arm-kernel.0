From: ytk.lee@samsung.com (Yongtaek Lee)
Date: Thu, 03 Sep 2015 17:28:07 +0900
Subject: [PATCH] ARM: fix bug which VMALLOC_START is lowwer than
 0xf0000000
In-Reply-To: <20150903080028.GS21084@n2100.arm.linux.org.uk>
References: <20150903080028.GS21084@n2100.arm.linux.org.uk>
Message-ID: <1441268887-11618-1-git-send-email-ytk.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Thu, Sep 03, 2015 at 11:24:47AM +0900, Yongtaek Lee wrote:
> > default value of vmalloc_min was set 0xf0000000 for ARM by commit
> > 0536bdf3. But actually vmalloc_min is 0xef800000 not 0xf0000000.
> > 
> > VMALLOC_END - (240 << 20) - VMALLOC_OFFSET)
> > 0xff000000 - 0x0f000000 - 0x00800000 = 0xef800000
> > 
> > In case of 768MB ram without CONFIG_HIGHMEM=y, last 8MB could not be
> > allocated. Kernel log also print out warning message as below.
> > "Truncating RAM at 80000000-afffffff to -af7fffff (vmalloc region overlap)."
> > 
> > Although it could be solved by state "vmalloc=size" in cmdline but i think
> > it would be better to change default value to 232 from 240.
> > 
> > Signed-off-by: Yongtaek Lee <ytk.lee@samsung.com>
>
> I fail to see what the problem is here.  You're adjusting the size of the
> vmalloc space to accomodate the size of RAM you have.  That's not a bug.

I will explain more about problem. 
It could happened with 768MB RAM device and CONFIG_HIGHMEN is not set.
"vmalloc=size" also not stated so that default value of vmalloc_min will be 
used to calculate lowmem end address. 

before applying patch.
[    0.000000]  [0:        swapper:    0] [c0] Truncating RAM at 80000000-afffffff to -af7fffff (vmalloc region overlap).

[    0.000000]  [0:        swapper:    0] [c0] Memory: 106MB 652MB = 758MB total
[    0.000000]  [0:        swapper:    0] [c0] Memory: 669892k/669892k available, 108348k reserved, 0K highmem
[    0.000000]  [0:        swapper:    0] [c0] Virtual kernel memory layout:
[    0.000000]  [0:        swapper:    0]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]  [0:        swapper:    0]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]  [0:        swapper:    0]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]  [0:        swapper:    0]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]  [0:        swapper:    0]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]  [0:        swapper:    0]       .text : 0xc0008000 - 0xc09bbee0   (9936 kB)
[    0.000000]  [0:        swapper:    0]       .init : 0xc09bc000 - 0xc0a2b740   ( 446 kB)
[    0.000000]  [0:        swapper:    0]       .data : 0xc0a2c000 - 0xc0ac4088   ( 609 kB)
[    0.000000]  [0:        swapper:    0]        .bss : 0xc0ac4088 - 0xc0d3e7b4   (2538 kB)

after applying patch. 
[    0.000000]  [0:        swapper:    0] [c0] Memory: 106MB 660MB = 766MB total
[    0.000000]  [0:        swapper:    0] [c0] Memory: 678004k/678004k available, 108428k reserved, 0K highmem
[    0.000000]  [0:        swapper:    0] [c0] Virtual kernel memory layout:
[    0.000000]  [0:        swapper:    0]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]  [0:        swapper:    0]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]  [0:        swapper:    0]     vmalloc : 0xf0800000 - 0xff000000   ( 232 MB)
[    0.000000]  [0:        swapper:    0]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]  [0:        swapper:    0]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]  [0:        swapper:    0]       .text : 0xc0008000 - 0xc09bbee0   (9936 kB)
[    0.000000]  [0:        swapper:    0]       .init : 0xc09bc000 - 0xc0a2b740   ( 446 kB)
[    0.000000]  [0:        swapper:    0]       .data : 0xc0a2c000 - 0xc0ac4088   ( 609 kB)
[    0.000000]  [0:        swapper:    0]        .bss : 0xc0ac4088 - 0xc0d3e7b4   (2538 kB)

As i know "vmalloc=size" is not mandatory so that i think default value of
vmalloc_min is wrong. 
