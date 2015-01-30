From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Jan 2015 11:13:11 +0000
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
 <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
 <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
 <54C92804.5090806@codeaurora.org>
 <20150129151956.GF8951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
Message-ID: <20150130111311.GA27542@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 06:20:06PM +0000, Ard Biesheuvel wrote:
> On 29 January 2015 at 15:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Jan 28, 2015 at 06:18:44PM +0000, Timur Tabi wrote:
> >> On 01/28/2015 12:14 PM, Catalin Marinas wrote:
> >> >> >So it looks like there's a whole conversation about this already in
> >> >> >this thread that I didn't notice.  However, reading through all of it,
> >> >> >I still don't understand sure why the presence of ACPI tables is
> >> >> >insufficient to enable ACPI.
> >>
> >> > Because ACPI on arm64 is still experimental, no matter how many people
> >> > claim that it is production ready in their private setups.
> >>
> >> Fair enough.  Does this mean that passing "acpi=force" on the kernel
> >> command line is a requirement for ARM64 servers?
> >
> > Please read my other email and ideally the whole sub-thread. The
> > acpi=force should only be required if the SoC is described (from
> > firmware) by both DT and ACPI.
> >
> >> >> >In what situation would we want to ignore ACPI tables that are
> >> >> >present?
> >>
> >> > When DT tables are also present (and for the first platforms, that's
> >> > highly recommended, though not easily enforceable at the kernel level).
> >>
> >> My understanding is that the EFI stub creates a device tree (and it
> >> contains some important information), so I don't understand how we can
> >> ever have an ACPI-only platform on ARM64 servers.
> >
> > If EFI stub creates the DT itself (not passed by firmware), it will
> > write some information in the chosen node that the rest of the kernel
> > can make use of and take the appropriate decision on whether to use ACPI
> > or not. That's something that will be used by kexec and Xen as well
> > which may want to boot with ACPI tables outside an EFI environment.

For Timur's reference, here's Hanjun's proposal:

http://article.gmane.org/gmane.linux.acpi.devel/73061

> If we are going with this solution, we should also mandate that an
> ACPI enabled firmware should not supply a non-DT DTB, or we wouldn't
> spot the difference. Not sure how likely this is, but I could imagine
> a firmware setting up an initrd and hence populating the /chosen node
> in an otherwise empty DTB. In this case, the stub would not add its
> 'I-created-an-empty-dtb' property.

I think that's a sane requirement. For the normal case of UEFI firmware
booting Linux as an EFI application (stub), if the firmware passes a DTB
it _must_ contain the full SoC description and be able to boot the
kernel without acpi=force. Passing initrd is really not a feature of the
SoC to be described in DT by firmware. We leave this to the EFI stub to
transfer the command line arguments into the chosen DT node.

Apart from UEFI, we have Xen and kexec and I think the plan is to
emulate the EFI stub behaviour when starting the kernel and they'll
state whether the dtb contains SoC description or not. All we need to do
here is make sure that the EFI stub <-> kernel protocol via the /chosen
node is well documented. We won't be able to prevent, for example,
U-Boot booting Linux with ACPI but I don't see why we should care.

Anyway, rather than a "I-created-an-empty-dtb" property, I would
actually say something like "dtb-contains-no-hardware-description".
Alternatively, we could avoid any such properties and look for signs of
hardware description like more nodes than /chosen, CPU nodes, "model"
property etc. and we won't need to change the stub code at all.

-- 
Catalin
