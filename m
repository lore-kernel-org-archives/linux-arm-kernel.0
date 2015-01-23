From: neilb@suse.de (NeilBrown)
Date: Sat, 24 Jan 2015 09:28:42 +1100
Subject: [PATCH 12/13] ARM: dts: omap3-gta04: uart4 is not connected, so
 mark it "disabled"
In-Reply-To: <20150122214052.GY7718@atomide.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
 <1421959099-28319-13-git-send-email-marek@goldelico.com>
 <20150122214052.GY7718@atomide.com>
Message-ID: <20150124092842.2441d3c6@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jan 2015 13:40:53 -0800 Tony Lindgren <tony@atomide.com> wrote:

> * Marek Belisko <marek@goldelico.com> [150122 12:42]:
> > From: NeilBrown <neil@brown.name>
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> > index 228e79b..8d2b0a1 100644
> > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > @@ -357,6 +357,10 @@
> >  	pinctrl-0 = <&uart3_pins>;
> >  };
> >  
> > +&uart4 {
> > +	status = "disabled";
> > +};
> > +
> 
> This you probably want to avoid from PM point of view. Depending on
> bootloader state of uart4, Linux may or may not be able to hit any
> deeper power states.
> 
> Marking something with status = "disabled" in dts causes the device
> entry not even to be created. That means hwmod won't be able to reset
> and idle this device during boot.
> 
> The uart4 device is there for sure even if not muxed and in incomplete
> state. You may want to also check other places where you're using
> status = "disabled" for the same reasons.

That's ... unfortunate.  Would that apply to the MCBSPs too?  They are
disabled by default so you would need to explicitly enable them all for
sensible behaviour....

Hopefully there is some way to mark as device as "this is not used, make sure
it is turned off and stays off" ???

Thanks for the heads-up.  I'll have a look and see exactly what is happening.

BTW, on the topic of OMAP UARTs and power saving...
 I note that there are now two drivers for the OMAP3 UART - omap-serial and
 8250_omap.
 I also note that your commit:

commit a2fc36613ac1af2e92cbed7af80bc72d8114dd50
    ARM: OMAP3: Use manual idle for UARTs because of DMA errata

 is incompatible with omap-serial.  In particular, if I enable runtime
 suspend of the serial port by setting the autosuspend_timeout, then incoming
 characters will no longer wake the port (if I revert your patch incoming
 chars do wake the port).
 This could (I think) be fixed by enabling the RX/CTS interrupt.  However if
 omap-serial is being deprecated, then there probably isn't any point.

 So: what is the longer term expectation for these drivers?  Should we be
 switching over to 8250?

Thanks,
NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150124/ad6c075c/attachment.sig>
