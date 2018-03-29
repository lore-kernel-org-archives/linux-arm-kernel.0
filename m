From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Mar 2018 21:54:14 +0100
Subject: issue with kexec/kdump on imx6ull
In-Reply-To: <20180321132548.GA32618@arthur-bzh>
References: <20180320100427.GA21933@arthur-bzh>
 <20180320104302.GG2743@n2100.armlinux.org.uk>
 <20180320150723.GH2743@n2100.armlinux.org.uk>
 <20180320171608.GB32282@arthur-bzh>
 <20180320191259.GI2743@n2100.armlinux.org.uk>
 <20180321132548.GA32618@arthur-bzh>
Message-ID: <20180329205413.GG16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 02:25:48PM +0100, Arthur LAMBERT wrote:
> Le Tuesday 20 Mar 2018 ? 19:12:59 (+0000), Russell King - ARM Linux wrote :
> > They're all included there.  Please try running kexec in debug mode
> > when loading the kernel, and report the output.
> 
> No more dtb argument with device tree file path and debug enable now.
> 
> Kexec output :
> 
> # sh kx.sh
> Try gzip decompression.
> kernel: 0x768cf008 kernel_size: 0x64a480
> MEMORY RANGES
> 0000000080000000-000000009fffffff (0)
> zImage header: 0x016f2818 0x00000000 0x0064a480
> zImage size 0x64a480, file size 0x64a480
> zImage requires 0x0065b480 bytes
> Reserved memory ranges
> 0000000088000000-000000008b1fffff (0)
> Coredump memory ranges
> 0000000080000000-0000000087ffffff (0)
> 000000008b200000-000000009fffffff (0)
> kernel symbol _stext vaddr =         80100000
> phys offset = 0x80000000, page offset = 80000000
> Using 32-bit ELF core format
> get_crash_notes_per_cpu: crash_notes addr = 8bb3a600, size = 180
> Elf header: p_type = 4, p_offset = 0x8bb3a600 p_paddr = 0x8bb3a600 p_vaddr = 0x0 p_filesz = 0xb4 p_memsz = 0xb4
> vmcoreinfo header: p_type = 4, p_offset = 0x80fd2610 p_paddr = 0x80fd2610 p_vaddr = 0x0 p_filesz = 0x1024 p_memsz = 0x1024
> Elf header: p_type = 1, p_offset = 0x80000000 p_paddr = 0x80000000 p_vaddr = 0x80000000 p_filesz = 0x8000000 p_memsz = 0x8000000
> Elf header: p_type = 1, p_offset = 0x8b200000 p_paddr = 0x8b200000 p_vaddr = 0x8b200000 p_filesz = 0x14e00000 p_memsz = 0x14e00000
> elfcorehdr: 0x8b100000
> crashkernel: [0x88000000 - 0x8b1fffff] (50M)
> memory range: [0x80000000 - 0x87ffffff] (128M)
> memory range: [0x8b200000 - 0x9fffffff] (334M)
> kernel command line: "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw  maxcpus=1 reset_devices init=/sbin/init elfcorehdr=0x8b100000 mem=50176K"
> Kernel: address=0x88008000 size=0x01fc8680
> DT    : address=0x89fd2000 size=0x0000904c
> kexec_load: entry = 0x88008000 flags = 0x280001
> nr_segments = 3
> segment[0].buf   = 0x768cf008
> segment[0].bufsz = 0x64a484
> segment[0].mem   = 0x88008000
> segment[0].memsz = 0x64b000
> segment[1].buf   = 0x996578
> segment[1].bufsz = 0x904c
> segment[1].mem   = 0x89fd2000
> segment[1].memsz = 0xa000
> segment[2].buf   = 0x996100
> segment[2].bufsz = 0x400
> segment[2].mem   = 0x8b100000
> segment[2].memsz = 0x1000
> kx.sh: kexec: success, dump kernel loaded.

>From the debug output of kexec, I think the problem has been located
with these two lines:

kernel symbol _stext vaddr =         80100000
segment[0].mem   = 0x88008000

It is standard with Linux kernels that they are loaded with a 32kB
offset to allow room for data including the page tables below the
kernel image.  kexec-tools knows about this offset.  It seems,
however, that the kernel tree you're using omits this offset and
builds the kernel to execute at a 1MB offset.

This difference is sufficient that the kernel will crash as a result.

All the offsets established to date in arch/arm/Makefile include
this 32kB offset, except, it seems, for your case - which is
presumably a vendor supplied (NXP?) or modified kernel tree.

That's the root of the problem, and I'm afraid I can't help you any
further - please complain to the vendor about this.

I suspect that they wanted to load the kernel at 1MB to avoid data
in the low 1MB of RAM, but have forgotten that both the decompressor
and the kernel itself will scribble over the 16 to 32k of memory
_below_ where it's loaded.

One way to fix this is to change the initialiser for extra_size in
kexec-tools/kexec/arch/arm/kexec-zImage-arm.c to reflect this offset,
but that will be at the expense of having to increase the crashdump
memory to allow for this offset.  It also makes kexec incompatible
with other kernels in the same way as stock kexec is incompatible
with your kernel.

The other solution is to include the 32k offset into the 1MB offset
in arch/arm/Makefile as per all the other textofs settings therein.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
