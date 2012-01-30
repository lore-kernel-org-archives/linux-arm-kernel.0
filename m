From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 30 Jan 2012 06:56:31 +0100
Subject: [FOR 3.4 PATCH 5/6] atmel/nand: add DT support
In-Reply-To: <CAPnjgZ0uTwFwaK2Dxdna7p6zrj9OZdV=CxT1eGsT+M5Aa+SJNA@mail.gmail.com>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
 <1327727444-23908-5-git-send-email-plagnioj@jcrosoft.com>
 <CAPnjgZ0uTwFwaK2Dxdna7p6zrj9OZdV=CxT1eGsT+M5Aa+SJNA@mail.gmail.com>
Message-ID: <20120130055631.GG705@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:31 Sun 29 Jan     , Simon Glass wrote:
> Hi,
> 
> On Fri, Jan 27, 2012 at 9:10 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > use a local copy of board informatin and fill with DT data
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Cc: linux-mtd at lists.infradead.org
> > ---
> > ?.../devicetree/bindings/mtd/atmel-nand.txt ? ? ? ? | ? 41 ++++++++
> > ?drivers/mtd/nand/atmel_nand.c ? ? ? ? ? ? ? ? ? ? ?| ?107 ++++++++++++++++----
> > ?2 files changed, 130 insertions(+), 18 deletions(-)
> > ?create mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> > new file mode 100644
> > index 0000000..a910ab9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> > @@ -0,0 +1,41 @@
> > +Atmel NAND flash
> > +
> > +Required properties:
> > +- compatible : "atmel,at91rm9200-nand".
> > +- reg : should specify localbus address and size used for the chip,
> > + ? ? ? and if availlable the ECC.
> > +- atmel,nand-addr-offset : offset for the address latch.
> > +- atmel,nand-cmd-offset : offset for the command latch.
> > +- #address-cells, #size-cells : Must be present if the device has sub-nodes
> > + ?representing partitions.
> > +
> > +- gpios : specifies the gpio pins to control the NAND device. detect is an
> > + ?optional gpio and may be set to 0 if not present.
> 
> What does this mean please? What is 'detect' and what 'control' do the
> gpios provide?
> 
> Below you have two GPIOs pioC 13 and pioC 14. I think the binding
> should document the two GPIOs, the order, and what they are for.
no as it's said in the binding the detect pin is optional
> 
> > +
> > +Optional properties:
> > +- nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
> > + ?Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
> > + ?"soft_bch".
> > +- nand-bus-width : 8 or 16 bus width if not present 8
> > +- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
> > +
> > +Examples:
> > +nand0: nand at 40000000,0 {
> > + ? ? ? compatible = "atmel,at91rm9200-nand";
> > + ? ? ? #address-cells = <1>;
> > + ? ? ? #size-cells = <1>;
> > + ? ? ? reg = <0x40000000 0x10000000
> > + ? ? ? ? ? ? ?0xffffe800 0x200
> > + ? ? ? ? ? ? >;
> > + ? ? ? atmel,nand-addr-offset = <21>;
> > + ? ? ? atmel,nand-cmd-offset = <22>;
> > + ? ? ? nand-on-flash-bbt = <1>;
> > + ? ? ? nand-ecc-mode = "soft";
> > + ? ? ? gpios = <&pioC 13 0
> > + ? ? ? ? ? ? ? ?&pioC 14 0
> > + ? ? ? ? ? ? ? ?0
> 
> Sorry, I haven't seen this before, perhaps it is a standard thing in
> Linux. Does 0 mean end of list? Can we not just use the property's
> size value for this?
0 means not used as specified in the DT

Best Regards,
J.
