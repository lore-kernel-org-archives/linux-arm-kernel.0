From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 24 Jul 2014 15:14:12 +0100
Subject: [PATCH v2 1/3] usb: host: st-hcd: Add USB HCD support for STi SoCs
In-Reply-To: <5967609.vndF2bDyS1@wuerfel>
References: <1406199616-10533-1-git-send-email-peter.griffin@linaro.org>
 <11018717.Ey5qEJxGNJ@wuerfel>
 <20140724122254.GA15266@griffinp-ThinkPad-X1-Carbon-2nd>
 <5967609.vndF2bDyS1@wuerfel>
Message-ID: <20140724141412.GA21823@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


<snip>
> > 
> > I'm of course happy to change it if required. I see looking through that a lot 
> > of other platforms do it the way you describe with a
> > 
> > ehci-<platname>.c and ohci-<platname>.c
> 
> Right. We are trying to  gradually move some of them over to use the
> generic *hci-platform.c drivers though.

Right, ok I understand.
 
> > > Depending on what kind of special requirements the ST version has,
> > > this can be done either by using the generic ohci/ehci bindings
> > > with extensions where necessary, or by creating a new binding and
> > > new driver files that use 'ohci_init_driver'/'ehci_init_driver'
> > > to inherit from the common code.
> > > 
> > > The first of the two approaches is preferred.
> > 
> > We don't have anything particularly special, just a couple of reset lines,
> > clock, phy, etc.
> 
> Ok, good. Please see Documentation/devicetree/bindings/usb/usb-?hci.txt
> then. You might actually be able to just use the existing drivers
> without new code by just adding the proper DT nodes that follow these
> bindings.

The only issues I can see with the generic versions are: -
1) We also have a powerdown line in addition to the reset line both of which are 
exposed via reset controller API, so I would need to add that into ehci-platform
and ohci-platform.

2) We have a magic poke in st_ehci_configure_bus of the current driver to configure
the AHB to ST bus protocol convertor IP. I'm not quite sure where I could hook that
in (sorry... slightly pulling back on my "nothing special comment" a bit ;-).

3) We also set the rate of the ohci clock, which the generic driver doesn't do.

regards,

Peter.
