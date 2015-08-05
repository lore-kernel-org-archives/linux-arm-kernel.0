From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 5 Aug 2015 20:03:12 +0100
Subject: [PATCH 3/4] arm64: Juno: Add HDLCD support to the Juno boards.
In-Reply-To: <20150805175303.GB7557@n2100.arm.linux.org.uk>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
 <1438784892-27888-4-git-send-email-Liviu.Dudau@arm.com>
 <20150805175303.GB7557@n2100.arm.linux.org.uk>
Message-ID: <20150805190312.GA31066@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 06:53:03PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 05, 2015 at 03:28:11PM +0100, Liviu Dudau wrote:
> > +		hdmi-transmitter at 71 {
> >  			compatible = "nxp,tda998x";
> >  			reg = <0x71>;
> > +			port {
> > +				tda998x_1_input: endpoint at 0 {
> > +					remote-endpoint = <&hdlcd1_output>;
> > +				};
> > +
> > +				tda998x_1_output: endpoint at 1 {
> > +					remote-endpoint = <&hdmi1_connector_output>;
> > +				};
> > +			};

Hi Russell,

Thanks for reviewing this, I will integrate your comments in the
next revision.

> 
> This isn't compliant with the TDA998x binding, and is very likely to
> screw Jean's work on adding audio support.  See emails on lakml and
> Documentation/devicetree/bindings/drm/i2c/tda998x.txt (which looks
> like it needs updating to include the ports stuff.)

I have to confess that I am not entirely up to speed with the TDA19988
situation at the moment. Andrew Jackson was dealing with that and
working with Jean to get that in the upstream, but his contract has
ended and he has moved to other things. While I did get through a
(limited) set of patches that Jean has sent around, I'm a bit confused
about the latest state of play. Is there an authoritative source from
where I can grab the patches that are going to be in 4.3? Otherwise,
as far as the current patchset base (4.2-rc2) is concerned, I am
compliant with the bindings if you ignore the port subnode (see further
below). I am happy to update the patchset to match what is going into
mainline, but just reading the emails in the mailing list I'm not
exactly sure on the sequencing of things here.

> 
> Also, the whole question of representing connectors in a DRM model is
> yet to be established.  Yes, DT should describe the hardware, but we
> don't yet know _how_ to describe physical connectors with stuff
> implemented on top of DRM yet, and we have nothing that makes use of
> this.

Please help me understand the current situation: you have added
support for components that the video drivers can use and the bindings
for that are described in Documentation/devicetree/bindings/media/video-interfaces.txt.
According to that document my patch should be compliant once I add the
reg= property. Is that something that cannot be used with tda998x driver
or is there any other reason why you think the patch is not compliant?

If you are referring to connecting an encoder with a HDMI connector, I
have tested that and it seems to work, although my situation is simple
because there are no options in my setup: one HDLCD connects to one TDA19988
which connects to one HDMI output.

> 
> Also note that ePAPR requires a reg= property if you specify a
> unit-address (the bit after the @ sign) so the above is non-compliant
> with ePAPR as well.

Thanks, I will add the reg property.

Best regards,
Liviu

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
