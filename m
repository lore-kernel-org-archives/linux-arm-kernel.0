From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 15 Sep 2013 13:23:42 +0100
Subject: [PROPOSAL] ARM/FDT: passing multiple binaries to a kernel
In-Reply-To: <CAL_JsqKnNHywcR21XhrjFyGs1DjZnbAFybraRKmxNmELLH-qPA@mail.gmail.com>
References: <52260608.2030202@linaro.org>
 <CAL_JsqK9PjpScRO8561PhcyKkxhuL4pgMTCh2-UG_ubybJTcCw@mail.gmail.com>
 <1378284256.17510.60.camel@kazak.uk.xensource.com>
 <CAL_Jsq+82xfNCD3LmNE6VD1mp4Vzbm-hPPaMjwg9+ab3moXP_w@mail.gmail.com>
 <CACxGe6sOyNNEATsnRdu9=_nPE1q6V4MDaDKvk4QvJiSgq6jXmg@mail.gmail.com>
 <CAL_JsqKnNHywcR21XhrjFyGs1DjZnbAFybraRKmxNmELLH-qPA@mail.gmail.com>
Message-ID: <20130915122342.C82F6C42C16@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Sep 2013 20:40:54 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Sep 13, 2013 at 5:13 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Wed, Sep 4, 2013 at 5:41 PM, Rob Herring <robherring2@gmail.com> wrote:
> >>> For u-boot Andre has proposed some syntactic sugar over the "fdt"
> >>> command to make boot.scr more trivial to use. We would of course need to
> >>> implement support for using it in the relevant distro tools (but they
> >>> tend to be very distro/machine specific already, e.g. Debian's
> >>> flash-kernel)
> >>
> >> And being machine specific is a PITA. flash-kernel is certainly not
> >> something we want to expand on. There is not much love for boot.scr
> >> either. There is work to address what are not really machine
> >> differences, but largely vendor u-boot differences:
> >>
> >> http://www.mail-archive.com/u-boot at lists.denx.de/msg119025.html
> >>
> >> One option for u-boot which already supports syslinux style menu files
> >> is to adopt the syslinux multiboot parsing support:
> >>
> >> http://www.syslinux.org/wiki/index.php/Doc/mboot
> >
> > Even building it into U-Boot is problematic because it leaves older
> > machines out in the cold. Leif's port of Grub to U-Boot is far more
> > interesting since the distro can now be in control of the code that
> > loads the images and jumps into the kernel/hypervisor.
> 
> Considering there is no distro support for grub on ARM yet, it may be
> more interesting in the long run, but it is not for the short term. So
> there needs to be something that is supportable on both u-boot and
> grub (or any other bootloader)

True.

> 
> >
> >> We need to back-up and consider what this looks like in the end for
> >> all the pieces and get input from folks on grub, UEFI, and armv8. The
> >> UEFI answer may be this is a grub problem. For armv8, this proposal
> >> does match up well as the kernel boot interface for v8 is DT. Despite
> >> some claims, ACPI will not completely replace DT because of this.
> >
> > Yes, for UEFI it is absolutely an OS loader problem. UEFI provides an
> > API and runtime environment. Grub is in general moving towards a boot
> > menu system and a tool for loading images. Actual booting however
> > should be done by a separate OS loader application. For Linux, this
> > will be an in-kernel UEFI Stub. For Xen I would recommend taking the
> > Linux EFI stub code and doing the same thing. There really isn't a
> > need for a multiboot spec when you can rely on a runtime execution
> > environment for setting things up exactly as you want them.
> 
> You've lost me as well. How do you see the flow working with UEFI for
> a user running bare metal OS, installing Xen, and rebooting running
> Xen.

I see I've caused confusion. I wasn't disputing the proposed binding,
but rather stating that none of the Xen or Linux specific boot code
should be built directly into UEFI. It should be contained in a separate
UEFI OS Loader applications (GRUB + stub).

As for the question above, I see the Xen installer adding stanzas to the
Grub configuration to boo the xen kernel instead of the Linux kernel.
Here there are two options (the Xen folks can decide which is best)
a) The Xen kernel has an EFI stub which uses a "linux=" argument to
specify the Linux kernel image to load.
b) GRUB is Xen-aware and adds the extra images to the dtb.

In either case, the Xen loader is completely separate from UEFI and
therefore under our own control.

g.
