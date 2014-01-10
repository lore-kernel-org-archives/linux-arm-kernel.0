From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 11 Jan 2014 00:02:48 +0100
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <20140110194437.GJ18269@obsidianresearch.com>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
 <20140102194924.GA3321@obsidianresearch.com>
 <1388702192.16958.54.camel@hastur.hellion.org.uk>
 <20140102230832.GB9339@obsidianresearch.com>
 <20140110192032.GQ19878@titan.lakedaemon.net>
 <20140110194437.GJ18269@obsidianresearch.com>
Message-ID: <20140110230248.GO9681@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > So, I'd prefer to handle this more gracefully.  I don't have much
> > experience at the low-level init of the caches, couldn't we enable and
> > flush rather than throwing the error?
> 
> It cannot be solved in cache-feroceon-l2.c.
> 
> In many cases you won't even get that far:
> - It will blow up in head.S when the cache is off: decompressor wrote
>   writeback data to into the L2 and uncached fetches see memory
>   content prior to decompression
> - It will blow up after head.S enables the L1: decompressor wrote
>   data into the L2 but the relocation writes done with the L1 off
>   made changes to memory that were not captured in the L2.

My impression with booting a lot of times while doing i bisect, was
that it got as far as:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.13.0-rc1-dirty (lunn at laptop) (gcc version 4.4.5 (Debian 4.4.5-8) ) #7 PREEMPT Fri Jan 3 09:25:07 CST 2014           
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: Marvell Kirkwood (Flattened Device Tree), model: QNAP TS219 family
Memory policy: ECC disabled, Data cache writeback

every time.

It frequently got as far as

Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/sda2 console=ttyS0,115200 earlyprintk
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512704K/524288K available (4693K kernel code, 247K rwdata, 1264K rodata, 154K init, 616K bss, 11584K reserved)              
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc05d9678   (5958 kB)
      .init : 0xc05da000 - 0xc0600ab0   ( 155 kB)
      .data : 0xc0602000 - 0xc063fcc0   ( 248 kB)
       .bss : 0xc063fccc - 0xc06d9ef0   ( 617 kB)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
NR_IRQS:114  
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms

And never made it past

Console: colour dummy device 80x30
Calibrating delay loop... 1587.60 BogoMIPS (lpj=7938048)

with L2 enabled.

Now clearly there is a difference between how far it got before
everything stops, and the point where corruption has occurred and
unavoidable death is going to happen sometime in the future.

It does however seem possible to insert platform specific code soon
after it prints:

Machine: Marvell Kirkwood (Flattened Device Tree), model: QNAP TS219 family

but i never got around to trying to disable and flush L2 at that
point. And the hardware is now also on the other side of the pond, and
i have no way to remotely power cycle it.

  Andrew
