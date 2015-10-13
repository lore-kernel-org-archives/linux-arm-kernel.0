From: lftan@altera.com (Ley Foon Tan)
Date: Tue, 13 Oct 2015 15:47:41 +0800
Subject: [PATCH v8 3/6] pci:host: Add Altera PCIe host controller driver
In-Reply-To: <7064179.1W3LTfFPxP@wuerfel>
References: <1444297394-3122-1-git-send-email-lftan@altera.com>
 <CAFiDJ58oMa6rgQe_STCiWRpdL+P22BN1=Nin_+QnLXC9RGiSzQ@mail.gmail.com>
 <20151009231540.GE16112@localhost> <7064179.1W3LTfFPxP@wuerfel>
Message-ID: <CAFiDJ59=PaZ_MaHU_AZp756c-DC_BR7x6=oACntqD=jw0s6XBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 8:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Friday 09 October 2015 18:15:40 Bjorn Helgaas wrote:
> >
> > I don't know if this should be a kernel taint, a simple warning in
> > dmesg, or what.  I guess the tainting mechanism is probably too
> > general-purpose for this, and add_taint() doesn't give any dmesg
> > indication.  We wouldn't see the taint unless the problem actually
> > caused an oops or panic.  In this case, I think I want a clue in dmesg
> > so we have a chance of seeing it even if there is no oops.  So
> > probably something like a dev_warn("non-compliant config accesses")
> > would work.
> >
> > You really should double-check with the hardware guys, because it's
> > pretty obvious that the PCI spec requires 1- and 2-byte config
> > accesses to work correctly.  For example, if you read/modify/write to
> > update PCI_COMMAND, you will inadvertently clear the RW1C bits in
> > PCI_STATUS.
>
> Would it help to require a DT property here that flags the device
> as having a broken config space?
>
> Then we could implement both in the driver, and only use the
> RMW based implementation if the firmware describes the device
> as "altera,broken-pci-config-space".
>

I have checked the PCI/TLP specification, the address needs to be
4-byte aligned. But, we can use "byte enable" field to update specific
bytes.
For example, if byte enable is 0x3 (0011b), that mean it only update
lower 2 bytes. By doing this, we can resolve the RW1C issue here.
I will update the driver with this in next revision.

Thanks for reviewing.

Regards
Ley Foon
