From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 20 Feb 2018 09:34:27 +0200
Subject: [PATCH v4 2/5] dt-bindings: gpio: add raspberry pi GPIO expander
 binding
In-Reply-To: <20180213232007.ieme6rjxgc7vidbw@rob-hp-laptop>
References: <cover.1517923836.git.baruch@tkos.co.il>
 <214ff3856c430b8045b63b25d83733b77054dfab.1517923836.git.baruch@tkos.co.il>
 <20180213232007.ieme6rjxgc7vidbw@rob-hp-laptop>
Message-ID: <20180220073427.vaxp5wkygs6pwaxi@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks again for reviewing.

On Tue, Feb 13, 2018 at 05:20:07PM -0600, Rob Herring wrote:
> On Wed, Feb 07, 2018 at 08:35:23PM +0200, Baruch Siach wrote:
> > +Raspberry Pi GPIO expander
> > +
> > +The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware. The
> > +firmware exposes a mailbox interface that allows the ARM core to control the
> > +GPIO lines on the expander.
> > +
> > +Required properties:
> > +
> > +- compatible : Should be "raspberrypi,firmware-gpio"
> > +- gpio-controller : Marks the device node as a gpio controller
> > +- #gpio-cells : Should be two.  The first cell is the pin number, and
> > +  the second cell is used to specify the gpio polarity:
> > +  0 = active high
> > +  1 = active low
> > +- firmware : Reference to the RPi firmware device node
> 
> This is the parent node. You don't need it.

OK. I guess of_get_parent() will do the trick.

> > +Example:
> > +
> > +firmware: firmware {
> > +	compatible = "raspberrypi,bcm2835-firmware";
> > +	mboxes = <&mailbox>;
> 
> No, sorry. /firmware is the container of firmware nodes. So 
> something like this:
> 
> firmware {
> 	rpi-firmware {
> 		compatible = "raspberrypi,bcm2835-firmware";
> 		mboxes = <&mailbox>;
> 		gpio {
> 		 compatible = "raspberrypi,firmware-gpio";
> 
> 		};
> 	};
> };

This is the hierarchy we currently have at arch/arm/boot/dts/bcm2835-rpi.dtsi:

/ {
        soc {
                firmware: firmware {
                        compatible = "raspberrypi,bcm2835-firmware";
                        mboxes = <&mailbox>;
                };
        };
};


Are you suggesting to add another container between 'soc' and 'firmware'? Or 
is it the 'firmware' node name that we need to change to 'rpi-firmware'?

> > +
> > +	expgpio: gpio {
> > +		 compatible = "raspberrypi,firmware-gpio";
> > +		 gpio-controller;
> > +		 #gpio-cells = <2>;
> > +		 firmware = <&firmware>;
> > +	 };
> > +};

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
