From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 8 Jun 2016 22:38:10 +0200
Subject: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <20160608202651.GA23604@rob-hp-laptop>
References: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
 <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
 <20160608202651.GA23604@rob-hp-laptop>
Message-ID: <20160608203810.GF2466@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2016 at 15:26:51 -0500, Rob Herring wrote :
> On Wed, Jun 08, 2016 at 12:15:10PM +0800, Wenyou Yang wrote:
> > In order to the save power consumption, as a workaround, suspend
> > forcibly the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI
> > Interrupt Configuration Register in the SFRs while OHCI USB suspend.
> > 
> > This suspend operation must be done before the USB clock is disabled,
> > resume after the USB clock is enabled.
> > 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> > 
> > Changes in v3:
> >  - Change the compatible description for more precise.
> > 
> > Changes in v2:
> >  - Add compatible to support forcibly suspend the ports.
> >  - Add soc/at91/at91_sfr.h to accommodate the defines.
> >  - Add error checking for .sfr_regmap.
> >  - Remove unnecessary regmap_read() statement.
> > 
> >  .../devicetree/bindings/usb/atmel-usb.txt          |  6 +-
> >  drivers/usb/host/ohci-at91.c                       | 80 +++++++++++++++++++++-
> >  include/soc/at91/at91_sfr.h                        | 29 ++++++++
> >  3 files changed, 112 insertions(+), 3 deletions(-)
> >  create mode 100644 include/soc/at91/at91_sfr.h
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > index 5883b73..888deaa 100644
> > --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > @@ -3,8 +3,10 @@ Atmel SOC USB controllers
> >  OHCI
> >  
> >  Required properties:
> > - - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
> > -   used in host mode.
> > + - compatible: Should be one of the following
> > +	       "atmel,at91rm9200-ohci" for USB controllers used in host mode.
> > +	       "atmel,sama5d2-ohci" for USB controllers used in host mode
> > +	       on SAMA5D2 which can force to suspend.
> 
> Guess I wasn't clear enough before. Drop "which can force to suspend".
> 

Well, my point is that we don't need a new compatible anyway.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
