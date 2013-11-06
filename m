From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Nov 2013 01:08:35 +0100
Subject: [PATCHv4] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <20131101101346.GK27864@ulmo.nvidia.com>
References: <20131019104555.GI18477@ns203013.ovh.net>
 <001e01ced692$267a6d90$736f48b0$%han@samsung.com>
 <20131101101346.GK27864@ulmo.nvidia.com>
Message-ID: <3967459.E0IoUGONBn@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Friday 01 November 2013 11:13:47 Thierry Reding wrote:
> On Fri, Nov 01, 2013 at 08:37:23AM +0900, Jingoo Han wrote:
> > On Wednesday, October 23, 2013 5:02 AM, Thierry Reding wrote:
> > > On Tue, Oct 22, 2013 at 05:34:45PM +0200, Jean-Christophe PLAGNIOL-
VILLARD wrote:
> > > > On 09:23 Tue 22 Oct     , Thierry Reding wrote:
> > > > > On Tue, Oct 22, 2013 at 06:58:33AM +0200, Jean-Christophe PLAGNIOL-
VILLARD wrote:
> > > > > > On 11:13 Mon 21 Oct     , Denis Carikli wrote:
> > > > > > > Cc: Richard Purdie <rpurdie@rpsys.net>
> > > > > > > Cc: Jingoo Han <jg1.han@samsung.com>
> > > > > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > > > > > Cc: Pawel Moll <pawel.moll@arm.com>
> > > > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > > > > > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > > > > > > Cc: devicetree at vger.kernel.org
> > > > > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > > > > Cc: linux-arm-kernel at lists.infradead.org
> > > > > > > Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> > > > > > > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > > > > > > Cc: Eric B?nard <eric@eukrea.com>
> > > > > > > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > > > > > ---
> > > > > > > ChangeLog v3->v4:
> > > > > > > - The default-brightness property is now optional, it defaults
> > > > > > > to 1 if not set.> > > > > 
> > > > > > by default we set OFF not ON
> > > > > > 
> > > > > > do not actiate driver or properti by default you can not known to
> > > > > > consequence on the hw
> > > > > 
> > > > > Turning on a backlight by default is what pretty much every
> > > > > backlight driver does. I personally think that's the wrong default,
> > > > > I even tried to get some discussion started recently about how we
> > > > > could change this. However, given that this has been the case for
> > > > > possibly as long as the subsystem has existed, suddenly changing it
> > > > > might cause quite a few of our users to boot the new kernel and not
> > > > > see their display come up. As with any other ABI, this isn't
> > > > > something we can just change without a very good migration path.
> > > > 
> > > > I'm sorry but the blacklight descibe in DT have nothing to do with the
> > > > common pratice that the current driver have today
> > > 
> > > That's not at all what I said. What I said was that the majority of
> > > backlight drivers currently default to turning the backlight on when
> > > probed. Therefore I think it would be consistent if this driver did the
> > > same.
> > > 
> > > I also said that I don't think it's a very good default, but at the same
> > > time we can't just go and change the default behaviour at will because
> > > people may rely on it.
> > 
> > I agree with your opinion.
> > But, I can't decide how to change it.
> 
> One solution that Stephen proposed was to make all DT-based setups use a
> new default (off). An advantage of that is that such setups are still
> fairly actively being worked on, so we can probably get early adopters
> to cope with the new default.
> 
> Looking through some DTS files it seems that many use the pwm-backlight
> driver. So if we can get some concensus from all the users that changing
> the default would be okay, then I think we could reasonably change it.
> 
> Another solution perhaps would be to add a property to DT which encodes
> the default state of the backlight on boot. This used to be impossible
> because the general concensus was that DT should describe hardware only
> and not software policy. During the kernel summit this requirement was
> somewhat relaxed and it should now be okay to describe system
> configuration data, and I think this would be a good match. If the
> system is designed to keep the backlight off by default because some
> other component (display panel driver) is meant to turn it on later,
> that's system configuration data, right?
> 
> Perhaps a boolean property could be used:
> 
> 	backlight {
> 		compatible = "pwm-backlight";
> 
> 		...
> 
> 		backlight-default-off;
> 	};
> 
> > > > put on by default if wrong specially without the property define. Even
> > > > put it on by default it wrong as the bootloader may have set it
> > > > already for splash screen and to avoid glitch the drivers need to
> > > > detect this.
> > > 
> > > I agree that would be preferable, but I don't know of any way to detect
> > > what value the bootloader set a GPIO to. The GPIO API requires that you
> > > call gpio_direction_output(), and that requires a value parameter which
> > > will be used as the output level of the GPIO.
> > 
> > Jean-Christophe's point is right.
> > 
> > We may need to discuss 'the way to detect what value the bootloader
> > set a GPIO to'.
> 
> Since some GPIO hardware simply can't do it, I guess we could resolve to
> passing such information via DT. That obviously won't work for non-DT
> setups, but I guess that's something we could live with.

For what it's worth, the pcf857x GPIO controllers suffer from this problem, 
and the solution was to use a DT property to specify the initial GPIOs state. 
The driver can thus implement gpio_get_value() properly and the hardware 
limitation is hidden from the clients.

https://lkml.org/lkml/2013/9/21/105

> One possibility would be to supplement the backlight-default-off property
> with another property (backlight-boot-on) that can be passed on to the
> kernel from the bootloader to signal that it has turned the backlight on.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/83d67344/attachment.sig>
