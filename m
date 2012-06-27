From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 27 Jun 2012 08:19:44 +0200
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <4FE9EFD8.6010608@wwwdotorg.org>
References: <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
 <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
 <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
 <4FE4A4B3.9010200@wwwdotorg.org> <4FE4AB2F.8090402@wwwdotorg.org>
 <20120625063456.GB11469@avionic-0098.adnet.avionic-design.de>
 <4FE9EFD8.6010608@wwwdotorg.org>
Message-ID: <20120627061944.GB8496@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:22:32AM -0600, Stephen Warren wrote:
> On 06/25/2012 12:34 AM, Thierry Reding wrote:
> > On Fri, Jun 22, 2012 at 11:28:15AM -0600, Stephen Warren wrote:
> >> On 06/22/2012 11:00 AM, Stephen Warren wrote:
> >>> On 06/22/2012 05:00 AM, Thierry Reding wrote: ...
> >>>> Stephen: can you try to find out whether the Tegra PCIe
> >>>> controller indeed implements ECAM, or if this scheme is
> >>>> actually just a proprietary variant?
> >>> 
> >>> Sure. I have added this request to the bug I filed requesting
> >>> more complete PCIe host documentation.
> >> 
> >> I've received unofficial confirmation that we do indeed implement
> >> a non-standard/non-ECAM mapping, and what's in our driver matches
> >> our HW.
> > 
> > What I don't quite see yet is how the extended configuration space
> > is supposed to work with the current driver. The PCIE_CONF_* macros
> > don't provide for registers >= 256. Passing a value higher than
> > that will mess with the device function field.
> 
> The current downstream driver is incorrect for that case. We should be
> updating it (at least, I filed a bug to do this).
> 
> Here's how the HW works (I believe this information should be in some
> future version of the TRM):

Definitely. I'm having a hard time grasping all of this by just looking
at the code. Some sort of functional description (like what you provide
here) would be really useful.

> There are 3 address spaces:
> 
> * The CPU bus.
> 
> * An internal (to the PCIe controller) 40-bit address space.
> Apparently the layout is HyperTransport-based. Whether HT defines
> this, or whether our HW engineers are referring to our particular
> implementation of HT, I'm not sure.
> 
> * The PCIe external bus.
> 
> Accesses from the CPU to the PCIe controller's 1GB aperture are mapped
> into the 40-bit bus using the BAR configurations in the PCIe
> controller; I believe this is what tegra_pcie_setup_translations() is
> configuring in our downstream driver.
> 
> Accesses are then mapped from this 40-bit bus to the external 32-bit
> bus, I believe using a hard-coded mapping, which I believe may be
> inherited from (our implementation of?) HyperTransport

This seems to be what is referred to as the FPCI in the TRM and the
driver.

> For config and extended config accesses the mapping from the internal
> to external bus is as follows:
> 
> In the case of PCICFG space,
> addr[39:28]=12'hFDF,
> addr[27:24]=4'hE means type 0 and addr[27:24]=4'hF means type 1,
> addr[23:16]=bus number
> addr[15:11]=device number
> addr[10:8]=function number
> addr[7:0]=register number
> 
> In the case of EXTCFG space,
> addr[39:32]=8'hFE,
> addr[31:28]=4'h0 means type 0 and addr[31:28]=4'h1 means type 1,
> addr[27:24]=upper register number (i.e. register number[11:8])
> addr[23:16]=bus number
> addr[15:11]=device number
> addr[10:8]=function number
> addr[7:0]=register number (i.e. register number[7:0])
> 
> (in actual fact, the HW matches the top 16 or 12 bits to determine
> config/ext-config and transaction type, so the top two fields in the
> lists above should really be considered merged)

Yes, this actually matches with the driver. Config space accesses are
mapped to 0xfdff0000 and ext. config space accesses go to 0xfe100000.

> I hope this helps!

I don't know how this works out for what Bjorn had in mind, but at least
it'll allow the driver to be fixed for extended config space accesses.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/1018957d/attachment.sig>
