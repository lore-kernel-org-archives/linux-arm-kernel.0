From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Jan 2015 23:11:20 +0000
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <54CA7F94.6000305@redhat.com>
References: <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
 <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
 <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
 <54C92804.5090806@codeaurora.org>
 <20150129151956.GF8951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
 <54CA7A42.5080800@codeaurora.org>
 <CAKv+Gu_a6_zjt=MsRuQH2rr05XxDayy0gACtbPXZaDAyhWrigg@mail.gmail.com>
 <54CA7D4A.5090709@codeaurora.org> <54CA7F94.6000305@redhat.com>
Message-ID: <20150129231120.GA23786@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 06:44:36PM +0000, Jon Masters wrote:
> On 01/29/2015 01:34 PM, Timur Tabi wrote:
> > On 01/29/2015 12:28 PM, Ard Biesheuvel wrote:
> >> The UEFI stub in the kernel uses the DTB file format (FDT) to pass
> >> information about the UEFI memory map and system table to the kernel.
> >> It does so even if there is no device tree that describes the
> >> platform. In this case, the file only contains a /chosen DT node, and
> >> nothing else, and it is up to the kernel to figure out that it can ask
> >> UEFI for a set of ACPI tables that it can use instead to configure the
> >> system. Otherwise, the /chosen node properties are added to a device
> >> tree that contains the full platform description.
> >>
> >> The problem is that we have to decide how to distinguish a
> >> conventional device tree DTB from a DTB that only exists to
> >> communicate the UEFI entry points.
> > 
> > Ah, that's exactly what I'm seeing.  The UEFI stub in our kernel 
> > generates a DTB, and therefore I always need to put acpi=force on our 
> > kernel command line.

To Timur: that's because you use a set of patches that are still under
development and not yet agreed as being upstream ready. There is a
sub-thread on this topic and even a patch from Ard on how EFI stub can
tell the kernel whether DT as any SoC description or not. This needs
further discussion since similar feature is needed by kexec and Xen.

> I expect some of the distros to patch ACPI always enabled. So from my
> point of view this affects only those wanting to follow upstream.

Sorry Jon but statements like this make me wonder whether we should
simply let the whole ARM ACPI be an out of tree distro business. We
spend a long time discussing OS-agnostic firmware implementation,
planning mini-summits, just to get certain Linux distro representative
stating that the kernel-firmware interface we discuss here only matters
for those planning to follow upstream. Certain Linux distros will play
by other rules.

I'm trying to get some consensus here, coming with arguments why DT
has priority over ACPI while still allowing ACPI-only firmware and you
pretty much state that vendors picking a distro kernel rather than
mainline don't need to bother. How does this work with Red Hat's stand
on upstream first? Not having ACPI in mainline yet is not an excuse;
there have been reasonable technical arguments and it's now a matter of
time until they (well, part of them) are sorted, nothing political
(what's political is distros patching the kernel to disable DT booting
on purpose).

-- 
Catalin
