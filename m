From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Apr 2014 00:44:18 +0100
Subject: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
In-Reply-To: <20140408231654.GA13898@piout.net>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com> <20140408141832.GA8861@piout.net>
 <53442997.70209@i2se.com> <20140408231654.GA13898@piout.net>
Message-ID: <20140408234418.GL16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 01:16:54AM +0200, Alexandre Belloni wrote:
> On 08/04/2014 at 18:53:43 +0200, Stefan Wahren wrote :
> > i applied these 5 patches, but it doesn't fix the problem.
> > 
> > Here are my results for the pwm driver led on i.MX28:
> > 
> > version                  | trigger: none          | trigger: heartbeat
> > -----------------------------------------------------------------------------
> > 3.14                     | OK                     | NOT OK (WARNING, LED
> > permanent on)
> >   + shawn's patch        | OK                     | NOT OK (LED
> > permanent on)
> >     + russell's patches  | OK                     | NOT OK (LED
> > permanent on)
> >       + active-low       | NOT OK (inverse logic) | NOT OK (LED
> > permanent on)
> > 
> > Russell's patches work as expected, but have not influence on the heartbeat.
> > 
> 
> Yeah, I got it wrong or explained badly.
> 
> So, if without Russell's patches, your pwm is not inversed, then you would
> have to set active_low and inverse the pwm.
> If it was inversed, then you'll have to set active_low and let the pwm
> with the normal polarity. I know this is a bit contrived but this was
> exactly my point why we shouldn't call it active_low.
> 
> Can you try to switch the polarity when setting active_low ?
> 
> I'm not home, else I'll try on my i.mx28 boards...

I just tried heartbeat here, on iMX6, and it works fine.  That's with this
in the DT:

        pwmleds {
                compatible = "pwm-leds";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_cubox_i_pwm1>;

                front {
                        active-low;
                        label = "imx6:red:front";
                        pwms = <&pwm1 0 50000>;
                };
        };

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
