From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 13 Jul 2016 23:18:04 -0300
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <5108278.va6WuahHro@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <2222184.ZN0KkkXgPC@hactar> <5108278.va6WuahHro@wuerfel>
Message-ID: <1678419.ODVtyXKVYJ@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 13 Juli 2016, 21:59:18 schrieb Arnd Bergmann:
> On Wednesday, July 13, 2016 3:45:41 PM CEST Thiago Jung Bauermann wrote:
> > Am Mittwoch, 13 Juli 2016, 15:13:42 schrieb Arnd Bergmann:
> > > On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > > > On Wed, Jul 13, 2016 at 10:01:33AM +0200, Arnd Bergmann wrote:
> > > > > - kboot/petitboot with all of the user space being part of the
> > > > > trusted
> > > > > boot> >
> > > > > 
> > > > >   chain: it would be good to allow these to modify the dtb as
> > > > >   needed
> > > > >   without breaking the trust chain, just like we allow grub or
> > > > >   u-boot
> > > > >   to modify the dtb before passing it to the kernel.
> > > > 
> > > > It depends on *what* we need to modify here. We can modify the
> > > > bootargs
> > > > and initrd properties as part of the kexec_file_load syscall, so
> > > > what
> > > > else would we want to alter?
> > > 
> > > I guess petitboot can also just use kexec_load() instead of
> > > kexec_file_load(), as long as the initramfs containing petitboot is
> > > trusted by the kernel.
> > 
> > For secure boot, Petitboot needs to use kexec_file_load, because of the
> > following two features which the system call enables:
> > 
> > 1. only allow loading of signed kernels.
> > 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
> > 
> >    command line and other boot inputs for the Integrity Measurement
> >    Architecture subsystem.
> > 
> > Those can't be done with kexec_load.
> 
> Can't petitboot do both of these in user space?

To be honest I'm not sure if it *can't* be done from userspace but if you do 
it from the kernel you can guarantee that any kernel image that is loaded 
gets verified and measured.

Whereas if you verify and measure the kernel in userspace then if there's a 
vulnerability in the system which allows an attacker to upload their own 
binary, then they can use kexec_load directly and bypass the verification 
and measurement.

So it's a more resilient design.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
