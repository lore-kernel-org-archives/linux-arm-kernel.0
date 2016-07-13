From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 13 Jul 2016 15:45:41 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <7352796.seiSnHrYPy@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160713094127.GC14522@leverpostej> <7352796.seiSnHrYPy@wuerfel>
Message-ID: <2222184.ZN0KkkXgPC@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 13 Juli 2016, 15:13:42 schrieb Arnd Bergmann:
> On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > On Wed, Jul 13, 2016 at 10:01:33AM +0200, Arnd Bergmann wrote:
> > > - kboot/petitboot with all of the user space being part of the trusted
> > > boot> > 
> > >   chain: it would be good to allow these to modify the dtb as needed
> > >   without breaking the trust chain, just like we allow grub or u-boot
> > >   to modify the dtb before passing it to the kernel.
> > 
> > It depends on *what* we need to modify here. We can modify the bootargs
> > and initrd properties as part of the kexec_file_load syscall, so what
> > else would we want to alter?
> 
> I guess petitboot can also just use kexec_load() instead of
> kexec_file_load(), as long as the initramfs containing petitboot is
> trusted by the kernel.

For secure boot, Petitboot needs to use kexec_file_load, because of the 
following two features which the system call enables:

1. only allow loading of signed kernels.
2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
   command line and other boot inputs for the Integrity Measurement
   Architecture subsystem.

Those can't be done with kexec_load.

As for what we need to modify, Petitboot does the following modifications to 
the DTB:

1. Set /chosen/linux,stdout-path based on which console is being used to 
interact with it, as Stewart mentioned in another email.
2. Set display properties on /pciex at n/.../vga at 0 in machines with an 
OpenFirmware framebuffer.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
