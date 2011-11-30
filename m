From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Nov 2011 17:54:10 +0000
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <1322673302.3180.25.camel@hornet.cambridge.arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
Message-ID: <20111130175410.GJ2045@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 05:15:02PM +0000, Pawel Moll wrote:
> On Wed, 2011-11-30 at 15:37 +0000, Dave Martin wrote:
> >
> > This results in a uImage which is a bit broken if using a normal u-Boot
> > configured for vexpress-v2p-ca9, because the bootloader makes some
> > memory map assumptions, and anyway we don't expect the kernel to work
> > unless it's loaded at the start of RAM:
> > 
> > 
> > ## Booting kernel from Legacy Image at 62000400 ...
> >    Image Name:   Linux-3.2.0-rc3+
> >    Image Type:   ARM Linux Kernel Image (uncompressed)
> >    Data Size:    2464984 Bytes = 2.4 MiB
> >    Load Address: 80008000
> >    Entry Point:  80008000
> >    Verifying Checksum ... OK
> > ## Loading init Ramdisk from Legacy Image at 80ffffc0 ...
> >    Image Name:
> >    Image Type:   ARM Linux RAMDisk Image (uncompressed)
> >    Data Size:    2216523 Bytes = 2.1 MiB
> >    Load Address: 81000000
> >    Entry Point:  81000000
> >    Verifying Checksum ... OK
> > ## Flattened Device Tree blob at 80ffc000
> >    Booting using the fdt blob at 0x80ffc000
> >    Loading Kernel Image ... OK
> > OK
> >    Loading Ramdisk to 7fcd3000, end 7fef024b ... OK
> >    Loading Device Tree to 7fcce000, end 7fcd2779 ... OK
> > 
> > Starting kernel ...
> > 
> > Uncompressing Linux... done, booting the kernel.
> > Booting Linux on physical CPU 0
> > Initializing cgroup subsys cpuset
> > Linux version 3.2.0-rc3+ (davem at e103592) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3) ) #12 SMP Wed Nov 30 15:10:19 GMT 2011
> > CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=10c53c7d
> > CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > Machine: ARM Versatile Express, model: V2P-CA9
> > bootconsole [earlycon0] enabled
> > Ignoring RAM at 60000000-7fffffff (vmalloc region overlap).
> > Ignoring RAM at 60000000-9fffffff (vmalloc region overlap).
> > INITRD: 0x7fcd3000+0x0021d24b is not a memory region - disabling initrd
> > Memory policy: ECC disabled, Data cache writeall
> > Cheers
> > ---Dave
> > 
> > 
> > oc
> > 
> > <HANG>
> 
> Yes, this is known problem with U-boot. Could you try again with
> "mem=512M" parameter?

The "ignoring RAM" messages go away...

## Booting kernel from Legacy Image at 62000400 ...
   Image Name:   Linux-3.2.0-rc3+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2307920 Bytes = 2.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 80ffffc0 ...
   Image Name:
   Image Type:   ARM Linux RAMDisk Image (uncompressed)
   Data Size:    2216523 Bytes = 2.1 MiB
   Load Address: 81000000
   Entry Point:  81000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80ffc000
   Booting using the fdt blob at 0x80ffc000
   Loading Kernel Image ... OK
OK
   Loading Ramdisk to 7fcd3000, end 7fef024b ... OK
   Loading Device Tree to 7fcce000, end 7fcd2779 ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Initializing cgroup subsys cpuset
Linux version 3.2.0-rc3+ (davem at e103592) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3) ) #18 Wed Nov 30 15:54:02 GMT 2011
CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: ARM Versatile Express, model: V2P-CA9
bootconsole [earlycon0] enabled
INITRD: 0x7fcd3000+0x0021d24b is not a memory region - disabling initrd
Memory policy: ECC disabled, Data cache writeback


... but the kernel still hangs.

U-Boot's built-in assumption about using addresses around 0x7f000000 to
relocate the dtb and initrd are clearly a problem here, though if that
was the only problem, the kernel would have booted further than this...

It would be nice to know what's going on here, but I'm reasonably
convinced that we're just booting the kernel in a silly way here, and
U-Boot really needs to be fixed to avoid the fixed-load-address
limitation.

 
> > If I strip the uImage and rebuild it with -a 0x60008000 -e 0x60008000
> > and no other changes, that's sufficient to give me a fully booting
> > kernel.  I can also boot a single image on v2p-ca9 both with and without
> > a dtb in this configuration.
> > 
> > I'm using a Linaro u-Boot from a couple of releses ago; it's possible
> > things have changed since.
> > 
> > Do you know of any specific u-Boot version which shouldn't have these
> > problems?
> > 
> > Was the hard-coded uImage load address/entry point problem ever fixed?
> > (It totally defeats loading a single uImage on multiple board variants.)
> 
> I simply don't use U-boot at all, what solves the problem
> "systematically" ;-) I wonder if it was possible to override the
> load/entry address in the runtime?

I believe not, but there have been some discussions about loading to a
default "start of RAM" location if the uImage's load address/entry point
are zero, or having some header flag to indicate this.

I don't know about the implementation status of this, though.


Tixy, do you know anything about the current status of this issue in
U-Boot?  Do you have a workaround for it?

Cheers
---Dave
