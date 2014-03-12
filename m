From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Mar 2014 14:05:22 +0000
Subject: [PATCHv4 2/2] arm: Get rid of meminfo
In-Reply-To: <20140312133806.GH21483@n2100.arm.linux.org.uk>
References: <1392761733-32628-1-git-send-email-lauraa@codeaurora.org>
 <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
 <20140312085401.GB21483@n2100.arm.linux.org.uk> <53205CA1.1090502@ti.com>
 <20140312133806.GH21483@n2100.arm.linux.org.uk>
Message-ID: <20140312140522.GI21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:38:06PM +0000, Russell King - ARM Linux wrote:
> Try booting a machine with 2G of RAM with page offset set to 3GB and
> highmem enabled - it will fail as per the above.

BTW, simple way to test this on any ARM platform:

Build with PAGE_OFFSET=3GB and highmem enabled.  Pass vmalloc=1G on the
kernel command line to force maximal vmalloc region (which should push
lowmem down to the minimum of 32MB.)  The remainder will be highmem.

Now, with Laura's patch applied, some platforms do boot but the result
is rather odd:

vmalloc area is too big, limiting to 976MB

So, the vmalloc=1G has done the right thing here, but:

Memory: 507404K/523264K available (3839K kernel code, 230K rwdata, 1388K rodata, 211K init, 5266K bss, 15860K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc0522f34   (5228 kB)
      .init : 0xc0523000 - 0xc0557fc0   ( 212 kB)
      .data : 0xc0558000 - 0xc0591980   ( 231 kB)
       .bss : 0xc0591988 - 0xc0ab6220   (5267 kB)

something has overriden it, and we end up with no highmem.  Without
Laura's patch, it all behaves correctly:

vmalloc area is too big, limiting to 976MB
...
Memory: 507932K/523264K available (3839K kernel code, 230K rwdata, 1388K rodata, 211K init, 5266K bss, 15332K reserved, 490496K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc2800000 - 0xff000000   ( 968 MB)
    lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc0522f34   (5228 kB)
      .init : 0xc0523000 - 0xc0557fc0   ( 212 kB)
      .data : 0xc0558000 - 0xc0591980   ( 231 kB)
       .bss : 0xc0591988 - 0xc0ab6260   (5267 kB)

So... the more I look at the boot results from last night's autobuild,
the more stuff appears to be broken with this meminfo removal.

Therefore, I have to wonder what kind of testing was done with these
patches - I suspect the test consisted of "does it boot" without looking
at any of the details about what memory was where.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
