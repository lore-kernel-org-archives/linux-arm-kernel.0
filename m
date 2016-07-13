From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Jul 2016 10:41:28 +0100
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <5352106.oQ0Ff9gWJA@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712145010.GA8447@leverpostej>
 <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
 <5352106.oQ0Ff9gWJA@wuerfel>
Message-ID: <20160713094127.GC14522@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 10:01:33AM +0200, Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 10:36:14 AM CEST Dave Young wrote:
> > On 07/12/16 at 03:50pm, Mark Rutland wrote:
> > > On Tue, Jul 12, 2016 at 04:24:10PM +0200, Arnd Bergmann wrote:
> > > > On Tuesday, July 12, 2016 10:18:11 AM CEST Vivek Goyal wrote:
> > > 
> > > /proc/devicetree (aka /sys/firmware/devicetree) is a filesystem derived
> > > from the raw DTB (which is exposed at /sys/firmware/fdt).
> > > 
> > > The blob that was handed to the kernel at boot time is exposed at
> > > /sys/firmware/fdt.
> > 
> > I believe the blob can be read and passed to kexec kernel in kernel code without
> > the extra fd.
> > 
> > But consider we can kexec to a different kernel and a different initrd so there
> > will be use cases to pass a total different dtb as well. From my understanding
> > it is reasonable but yes I think we should think carefully about the design.
> 
> Ok, I can see four interesting use cases here:
> 
> - Using the dtb that the kernel has saved at boot time. Ideally this should not
>   require an additional step of signing it, since the running kernel already
>   trusts it.

We have sufficient information from the existing kexec_file_load syscall
prototype to do this in-kernel.

> - A dtb blob from the file system that was produced along with the kernel image.
>   If we require a signature on the kernel, the the same requirement should be
>   made on the dtb. Whoever signs the kernel can also sign the dtb.
>   The tricky part here is the kernel command line that is part of the dtb
>   and that may need to be modified.

I suspect that for this case, following the example of the existing
sycall, we'd allow the kernel to modify bootargs and initrd properties
after verfiying the signature of the DTB.

The big question is whether this is a realistic case on a secure boot
system.

> - Modifying the dtb at for any of the reasons I listed: This should always
>   be possible when we do not use secure boot, just like booting an unsigned
>   kernel is.

This is possible with the existing kexec_load syscall, for the non
secure boot case.

> - kboot/petitboot with all of the user space being part of the trusted boot
>   chain: it would be good to allow these to modify the dtb as needed without
>   breaking the trust chain, just like we allow grub or u-boot to modify the dtb
>   before passing it to the kernel.

It depends on *what* we need to modify here. We can modify the bootargs
and initrd properties as part of the kexec_file_load syscall, so what
else would we want to alter?

Thanks,
Mark.
