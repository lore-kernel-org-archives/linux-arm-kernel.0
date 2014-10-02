From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 10:39:18 +0200
Subject: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
In-Reply-To: <542C6FE9.10903@amd.com>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140917012614.GA31214@srcf.ucam.org> <542C6FE9.10903@amd.com>
Message-ID: <4872185.h11DQxW6kP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 16:19:37 Suravee Suthikulanit wrote:
> On 9/16/2014 8:26 PM, Matthew Garrett wrote:
> > On Mon, Sep 15, 2014 at 07:47:23PM -0500, suravee.suthikulpanit at amd.com wrote:
> >> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >>
> >> This patch adds ACPI match table in ahci_platform. The table includes
> >> the acpi_device_id to match AMD Seattle SATA controller with following
> >> asl structure in DSDT:
> >>
> >>      Device (SATA0)
> >>      {
> >>        Name(_HID, "AMDI0600")        // Seattle AHSATA
> >
> > There really ought to be a well-defined PNPID for AHCI, so you can _HID
> > to AMD and _CID to something generic. That way we won't have:
> >
> >> +#ifdef CONFIG_ATA_ACPI
> >> +static const struct acpi_device_id ahci_acpi_match[] = {
> >> +    { "AMDI0600", 0 }, /* AMD Seattle AHCI */
> >> +    { },
> >> +};
> >
> > utter sadness here. Really, please don't end up in a situation where we
> > need to add device-specific IDs to a generic driver.
> >
> Matthew,
> 
> Currently, there is no _CID defined for generic AHCI. We will work on 
> proposing one, and provide update patches for including the new ID.
> 

I think part of the problem is that there is no specification for what
an AHCI device should look like when it's not connected to a PCI
bus, the AHCI document published by Intel just states:

"AHCI is a PCI class device that acts as a data movement engine
between system memory and Serial ATA devices."

It also requires the PCI config space to have the PM capability
registers and (optionally) the MSI capability registers.
There are lots of chips we support in Linux with the ahci-platform
driver, but they are not actually compliant because they cannot
use the pmcap registers but instead typically rely on setting
external clock/phy/regulator/pinctrl registers.

The ARM SBSA document just requires any SATA controller to be AHCI
compliant but does not explain what that means in the case where
it's not a PCI device.

	Arnd
