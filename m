From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 22:54:16 +0200
Subject: MX53Loco reports half of the total memory
In-Reply-To: <CAOMZO5C6gaJUD3RTCwGqDhcojx3Thww22c+tsdC4bvTUmiSw6w@mail.gmail.com>
References: <CAOMZO5C6gaJUD3RTCwGqDhcojx3Thww22c+tsdC4bvTUmiSw6w@mail.gmail.com>
Message-ID: <20110824205415.GN31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 05:30:54PM -0300, Fabio Estevam wrote:
> Hi,
> 
> On a mx53loco board U-boot reports 1GB of total available memory:
> 
> 
> U-Boot 2011.06-04814-geee1e2f (Aug 22 2011 - 13:37:53)
> 
> CPU:   Freescale i.MX53 family rev2.1 at 800 MHz
> Reset cause: POR
> Board: MX53 LOCO
> DRAM:  1 GiB
> MMC:   FSL_ESDHC: 0, FSL_ESDHC: 1
> In:    serial
> Out:   serial
> Err:   serial
> Net:   got MAC address from fuse: 00:04:9f:01:c6:57
> FEC
> Hit any key to stop autoboot:  0
> MX53LOCO U-Boot >
> 
> When booting 3.1-rc3 only 512MB is reported:
> ...

You probably missed the following in your boot log:

Ignoring RAM at b0000000-cfffffff (vmalloc region overlap).

> ...
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 512MB = 512MB total
> Memory: 515420k/515420k available, 8868k reserved, 0K highmem
> Virtual kernel memory layout:
> ...
> 
> Shouldn't the kernel report the whole 1GB?

Try compiling the kernel with CONFIG_VMSPLIT_2G. On my board this gives:

Memory: 512MB 512MB = 1024MB total
Memory: 1035204k/1035204k available, 13372k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xe0800000 - 0xf4000000   ( 312 MB)
    lowmem  : 0x80000000 - 0xe0000000   (1536 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x803ab000   (3724 kB)
      .init : 0x803ab000 - 0x803c8000   ( 116 kB)
      .data : 0x803c8000 - 0x803ef4c0   ( 158 kB)
       .bss : 0x803ef4e4 - 0x8043cdc0   ( 311 kB)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
