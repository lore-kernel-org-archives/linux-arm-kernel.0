From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 8 Oct 2015 14:26:01 +0800
Subject: [PATCH v3 08/10] Doc: usb: ci-hdrc-usb2: add
 tx(rx)-burst-config-dword for binding doc
In-Reply-To: <1439546557.13210.52.camel@pengutronix.de>
References: <1438931747-25209-1-git-send-email-peter.chen@freescale.com>
 <1438931747-25209-9-git-send-email-peter.chen@freescale.com>
 <1439541450.13210.31.camel@pengutronix.de>
 <20150814084050.GE11072@shlinux2>
 <1439546557.13210.52.camel@pengutronix.de>
Message-ID: <20151008062600.GA21057@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 12:02:37PM +0200, Lucas Stach wrote:
> Am Freitag, den 14.08.2015, 16:40 +0800 schrieb Peter Chen:
> > On Fri, Aug 14, 2015 at 10:37:30AM +0200, Lucas Stach wrote:
> > > Am Freitag, den 07.08.2015, 15:15 +0800 schrieb Peter Chen:
> > > > It is used to override the default setting for burst size, changing
> > > > burst size takes effect only when the SBUSCFG.AHBBRST = 0.
> > > > 
> > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > > > index d52a747..d71ef07 100644
> > > > --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > > > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > > > @@ -37,6 +37,14 @@ Optional properties:
> > > >    property is used to change AHB burst configuration, check the chipidea
> > > >    spec for meaning of each value. If this property is not existed, it
> > > >    will use the reset value.
> > > > +- tx-burst-size-dword: it is vendor dependent, the tx burst size in dword
> > > > +  (4 bytes), This register represents the maximum length of a the burst
> > > > +  in 32-bit words while moving data from system memory to the USB
> > > > +  bus, changing this value takes effect only the SBUSCFG.AHBBRST is 0.
> > > 
> > > The last bits about SBUSCFG.AHBBRST don't make any sense in the DT
> > > binding. The DT writer doesn't know about the SBUSCFG.AHBBRST value and
> > > should not care either.
> > > If someone sets the burst size to something
> > > non-standard in the DT, the driver should make sure to enable to
> > > necessary bits to make this setting take effect.
> > 
> > The SBUSCFG.AHBBRST property description is just above this one,
> > and the user should read the spec for changing these system
> > configuration parameters.
> > 
> This is not clear from the description. This should read something like
> "The value of this property will only take effect if property
> ahb-burst-config is set to 0."

Thanks, will change.

> 
> The DT binding should be coherent and understandable without reading the
> DW USB spec and/or the code. Please take some care about this.
> 
> > This requirement is from the spec, and the code logic makes sure
> > the burst size changes only when SBUSCFG.AHBBRST is 0, since the
> > hardware will only change burst size if SBUSCFG.AHBBRST is 0.
> > 
> > > 
> > > Also both those descriptions are missing a description to what value the
> > > burst sizes will be set if the DT properties are not found. If it's
> > > implementation defined spell this out in the doc.
> > 
> > It is optional property, if without this property, it will use the
> > default value.
> > 
> Then specify this in the binding. Again, the binding is a spec that one
> should be able to understand without reading the code.
> 
> "If this property is missing the reset defaults of the hardware
> implementation will be used."
> 

Thanks, will change.

> > > 
> > > Are there really cases where it makes sense to set RX and TX burst sizes
> > > to different values?
> > 
> > Yes, the default burst size is the same for all SoCs, but the bus
> > burst size may be larger for some SoCs.
> > 
> This question wasn't meant to dispute the RX/TX burst size
> configuration, but I'm questioning if it really makes sense to set them
> to different values. Do we really need 2 properties for this, or is 1
> enough?
> 
> Do you see any use case where someone would like to do something like:
> tx-burst-size-dword = <0x8>;
> rx-burst-size-dword = <0x10>;
> 

For Freelscae i.mx current design, the tx/rx burst size are always the same,
but not sure if it is always true for others or for future design.

-- 

Best Regards,
Peter Chen
