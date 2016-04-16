From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Apr 2016 09:31:59 +0200
Subject: [PATCH V6 08/13] PCI: generic,
 thunder: update to use generic ECAM API
In-Reply-To: <CAKc_7PWFacFJZA2JpfM4RcRFVj0jyUE73HhhvmX0cKm07JGupg@mail.gmail.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <5110401.mGEq6IVFz2@wuerfel>
 <CAKc_7PWFacFJZA2JpfM4RcRFVj0jyUE73HhhvmX0cKm07JGupg@mail.gmail.com>
Message-ID: <4240660.NqlPcXaV7N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 April 2016 12:50:13 Jayachandran C wrote:
> >
> > I still think it would be better to keep the loadable PCI host drivers
> > separate from the ACPI PCI infrastructure. There are a number of
> > simplifications that we want to do to the DT based drivers in the long
> > run, so it's better if that code is not shared at this level. Abstracting
> > out the ECAM code is fine, but at that point you should be able to just
> > call it from the ACPI layer.
> 
> The issue is not with this patch (in my opinion). This patch is just
> re-arranging how thunder specific data is maintained. Earlier it was
> a container_of gen_pci, now it is ->priv of pci_config_window.
> 
> I can see the issue in patches 12 and 13 of this patchset which adds
> ACPI fixups into the thunder OF driver.

Right, I commented on this one, because it seems to rearrange the code
in order to do the later one.

> The simple approach when doing modular PCI drivers would be to make
> pci-thunder-*.c like pci-host-common.c, to be compiled in if configured.
> The fie will contain all the Thunder quirks and can export
> pci_thunder_ecam_ops.

I would argue that we should not export anything from drivers/pci/host,
those should really be standalone drivers that do not interact with other
subsystems.

How much code would you need to duplicate from thunder-ecam to have
the same functionality available in ACPI? My expectation is that it's
not really that much more compared to the code you need for sharing
a single implementation, but you get a lower complexity here, which
makes it easier to understand and to rework.

	Arnd
