From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 4 Sep 2013 09:44:16 +0100
Subject: [PROPOSAL] ARM/FDT: passing multiple binaries to a kernel
In-Reply-To: <CAL_JsqK9PjpScRO8561PhcyKkxhuL4pgMTCh2-UG_ubybJTcCw@mail.gmail.com>
References: <52260608.2030202@linaro.org>
 <CAL_JsqK9PjpScRO8561PhcyKkxhuL4pgMTCh2-UG_ubybJTcCw@mail.gmail.com>
Message-ID: <1378284256.17510.60.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-09-03 at 17:00 -0500, Rob Herring wrote:
> On Tue, Sep 3, 2013 at 10:53 AM, Andre Przywara
> <andre.przywara@linaro.org> wrote:
> > Hi,
> >
> > a normal Linux kernel currently supports reading the start and end address
> > of a single binary blob via the FDT's /chosen node.
> > This will be interpreted as the location of an initial RAM disk.
> >
> > The Xen hypervisor itself is a kernel, but needs up to _two_ binaries for
> > proper operation: a Dom0 Linux kernel and it's associated initrd.
> > On x86 this is solved via the multiboot protocol used by the Grub
> > bootloader, which supports to pass an arbitrary number of binary modules to
> > any kernel.
> >
> > Since in the ARM world we have the versatile device tree, we don't need to
> > implement the mulitboot protocol.
> 
> But surely there would be some advantage of reuse by using the
> multi-boot protocol since Xen, grub, and OS tools already support it
> for x86.

Multiboot is pretty x86 specific (although MB2 has a MIPS port) and
covers more stuff than we strictly require (e.g. on x86 it has
requirements around which processor mode you enter in, has paging
enabled etc).

> > So I'd like to propose a new binding which denotes binary modules a kernel
> > can use at it's own discretion.
> > The need is triggered by the Xen hypervisor (which already uses a very
> > similar scheme), but the approach is deliberately chosen to be as generic as
> > possible to allow future uses (like passing firmware blobs for devices or
> > the like).
> > Credits for this go to Ian Campbell, who started something very similar [1]
> > for the Xen hypervisor. The intention of this proposal is to make this
> > generic and publicly documented.
> 
> Can you describe how you see the boot flow working starting with OS
> installer writes kernel, initrd, xen and ??? to disk.

Kernel and initrd are written to /boot in the usual way (probably from
kernel.deb or whatever). Xen would also normally come from a distro
package (also in /boot).

> How does the bootloader know what to load?

It's in the bootloader config, e.g. boot.scr or grub.cfg, which are
either hand written or produced by the distros tooling.

grub on ARM could consume the same stanzas as are used by grub on x86 to
boot Xen (which are produced by update-grub):
        echo    'Loading Xen 4.1-amd64 ...'
        multiboot       /xen-4.1-amd64.gz placeholder  
        echo    'Loading Linux 3.10-2-amd64 ...'
        module  /vmlinuz-3.10-2-amd64 placeholder root=/dev/mapper/disks-root ro resume=/dev/mapper/disks-swap quiet
        echo    'Loading initial ramdisk ...'
        module  /initrd.img-3.10-2-amd64

Since there is no multiboot on ARM (and never will be) this is safe.

If multiboot ever does come to ARM it will necessarily be multiboot2
which uses a different keyword.

For u-boot Andre has proposed some syntactic sugar over the "fdt"
command to make boot.scr more trivial to use. We would of course need to
implement support for using it in the relevant distro tools (but they
tend to be very distro/machine specific already, e.g. Debian's
flash-kernel)

>  The OS may not have access to the dtb,
> so this has to be described to the bootloader as well.

Right. The proposal is not for the OS to frob the DTB to support this
protocol but to configure the bootloader to do it.

Ian.
