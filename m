From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jan 2016 10:07:13 +0100
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <20160120034839.GA16222@shlinux2>
References: <4405270.vcz87Q878u@wuerfel>
 <Pine.LNX.4.44L0.1601191009190.1727-100000@iolanthe.rowland.org>
 <20160120034839.GA16222@shlinux2>
Message-ID: <2538302.jXP5WXojXY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 January 2016 11:48:39 Peter Chen wrote:
> > 
> > > Alternatively, you could use one of the high bits of the 'reg' value
> > > to indicate which root hub is used. I'm sure that would work as
> > > well, but be less obvious.
> > 
> > It's probably best to stick with the same numbering that the hardware 
> > uses.
> 
> Seems we are talking about root hub, not the device in the
> root hub. So for multiple ports controller, we have to own node for 
> root hub. Assume your example, there is a genesys HUB at physical
> port 1, I suggest a dts node description like below, please correct
> me if anything wrong.
> 
> &usb1 {
>         roothub_1: nxp at 1 {
>                 compatible = "usb15a2,007d";
>                 reg = <0x01>;
> 
>                 hub: genesys at 1 {
>                         compatible = "usb05e3,0608";
>                         reg = <0x01>;
>                 };
>         };
> 
>         roothub_2: nxp at 2 {
>                 compatible = "usb15a2,007d";
>                 reg = <0x02>;
>         };
> 
>         ...
> 
>         roothub_7: nxp at 7 {
>                 compatible = "usb15a2,007d";
>                 reg = <0x07>;
> 
>                 hub: genesys at 1 {
>                         compatible = "usb05e3,0608";
>                         reg = <0x01>;
>                 };
>         };
> 
>         ...
> 
>         roothub_9: nxp at 9 {
>                 compatible = "usb15a2,007d";
>                 reg = <0x09>;
>         };
> };

This looks wrong to me: if I understand it right, you are now modeling
each port of the root hub as a separate hub, so you end up with
a total of 11 hub nodes when there should only be one or two.

	Arnd
