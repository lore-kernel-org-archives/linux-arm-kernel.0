From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Thu, 3 Dec 2015 10:41:31 +0000
Subject: [RFC PATCH 4/4] mfd: syscon: add ACPI support
In-Reply-To: <2299982.06P4iKpkWk@wuerfel>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <1449047368-5768-5-git-send-email-wangkefeng.wang@huawei.com>
 <2299982.06P4iKpkWk@wuerfel>
Message-ID: <20151203104131.GA11655@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 11:44:51AM +0100, Arnd Bergmann wrote:
> On Wednesday 02 December 2015 17:09:28 Kefeng Wang wrote:
> > This enables syscon with ACPI support.
> > syscon_regmap_lookup_by_dev_property() function was added. With helper
> > device_get_reference_node() and acpi_dev_find_plat_dev(), it can be used
> > in both DT and ACPI.
> > 
> > The device driver can obtain syscon using _DSD method in DSDT, an example
> > is shown below.
> > 
> >     Device(CTL0) {
> >           Name(_HID, "HISI0061")
> >           Name(_CRS, ResourceTemplate() {
> >                   Memory32Fixed(ReadWrite, 0x80000000, 0x10000)
> >           })
> >     }
> > 
> >     Device(DEV0) {
> >           Name(_HID, "HISI00B1")
> >           Name(_CRS, ResourceTemplate() {
> >                   Memory32Fixed(ReadWrite, 0x8c030000, 0x10000)
> >                   Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive){ 192 }
> >           })
> > 
> >           Name (_DSD, Package () {
> >               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >               Package () {
> >                   Package () {"syscon",Package() {\_SB.CTL0} }
> >               }
> >           })
> >     }
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> This sounds like a bad idea:
> 
> syscon is basically a hack to let us access register that the SoC designer
> couldn't fit in anywhere sane. We need something like this with devicetree
> because we decided not to have any interpreted bytecode to do this behind
> our back.
> 
> With ACPI, the same thing is done with AML, which is actually nicer than
> syscon (once you have to deal with all the problems introduced by AML).
> 
> Use that instead.
> 

I have to agree with Arnd here, this is specifically why it was chosen
to use ACPI on machines to move all these "hacks" to AML.

This leaves your driver being generic and any "special" initialisation
can be supplied by the OEM through the ACPI tables.

Graeme
