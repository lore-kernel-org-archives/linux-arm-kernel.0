From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jul 2016 09:09:55 +0100
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <CAKv+Gu9kEeVuW6Hj7HYOMojE5SLEZ69uAW2t9xZySw0uWNLcBQ@mail.gmail.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <CAKv+Gu9kEeVuW6Hj7HYOMojE5SLEZ69uAW2t9xZySw0uWNLcBQ@mail.gmail.com>
Message-ID: <20160713080955.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 09:47:56AM +0200, Ard Biesheuvel wrote:
> On 13 July 2016 at 09:36, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Jul 13, 2016 at 02:59:51PM +1000, Stewart Smith wrote:
> >> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> >> > On Tue, Jul 12, 2016 at 10:58:05PM +0200, Petr Tesarik wrote:
> >> >> I'm not an expert on DTB, so I can't provide an example of code
> >> >> execution, but you have already mentioned the /chosen/linux,stdout-path
> >> >> property. If an attacker redirects the bootloader to an insecure
> >> >> console, they may get access to the system that would otherwise be
> >> >> impossible.
> >> >
> >> > I fail to see how kexec connects with the boot loader - the DTB image
> >> > that's being talked about is one which is passed from the currently
> >> > running kernel to the to-be-kexec'd kernel.  For ARM (and I suspect
> >> > also ARM64) that's a direct call chain which doesn't involve any
> >> > boot loader or firmware, and certainly none that would involve the
> >> > passed DTB image.
> >>
> >> For OpenPOWER machines, kexec is the bootloader. Our bootloader is a
> >> linux kernel and initramfs with a UI (petitboot) - this means we never
> >> have to write a device driver twice: write a kernel one and you're done
> >> (for booting from the device and using it in your OS).
> >
> > I think you misunderstood my point.
> >
> > On ARM, we do not go:
> >
> >         kernel (kexec'd from) -> boot loader -> kernel (kexec'd to)
> >
> > but we go:
> >
> >         kernel (kexec'd from) -> kernel (kexec'd to)
> >
> > There's no intermediate step involving any bootloader.
> >
> > Hence, my point is that the dtb loaded by kexec is _only_ used by the
> > kernel which is being kexec'd to, not by the bootloader, nor indeed
> > the kernel which it is loaded into.
> >
> > Moreover, if you read the bit that I quoted (which is what I was
> > replying to), you'll notice that it is talking about the DTB loaded
> > by kexec somehow causing the _bootloader_ to be redirected to an
> > alternative console.  This point is wholely false on ARM.
> >
> 
> The particular example may not apply, but the argument that the DTB
> -as a description of the hardware topology- needs to be signed if the
> kernel is also signed is valid. We do the same in the UEFI stub, i.e.,
> it normally takes a dtb= argument to allow the DTB to be overridden,
> but this feature is disabled when Secure Boot is in effect. By the
> same reasoning, if any kind of kexec kernel image validation is in
> effect, we should either validate the DTB image as well, or disallow
> external DTBs and only perform kexec with the kernel's current DTB
> (the blob it was booted with, not the unflattened data structure)

*Sigh*  yes, I know full well, which is why I said what I said in my
_first_ reply:

"However, your point is valid as an attacker can redirect the console
 and/or mounted root on the to-be-kexec'd kernel if they can modify
 the DTB - and there's a whole host of subtle ways to do that, not
 necessarily just modification of the kernel command line."

and I went on to raise a valid point about the necessity to do that
for crashdump, which has been _completely_ ignored.

So, I just stopped reading your reply after the first three lines,
because we are in fact in agreement... but thanks for trying to waste
my time.

Please, keep with the overall discussion, and stop replying to a single
email as a whole point in isolation to every other email in the thread.
And stop bikeshedding, by picking up on the easy stuff but ignoring the
more fundamental points, like the crashdump issue I mentioned in my
first reply and now this reply.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
