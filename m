From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 24 Jan 2014 06:42:54 +0100
Subject: [PATCH 1/2] PWM: let of_xlate handlers check args count
In-Reply-To: <20140123173642.GZ15937@n2100.arm.linux.org.uk>
References: <20140123083714.3c6e86ae@ipc1.ka-ro>
 <1390467898-9216-1-git-send-email-s.hauer@pengutronix.de>
 <1390467898-9216-2-git-send-email-s.hauer@pengutronix.de>
 <20140123115632.6d3f1a58@ipc1.ka-ro>
 <20140123110444.GI16215@pengutronix.de>
 <20140123165349.GY15937@n2100.arm.linux.org.uk>
 <20140123173642.GZ15937@n2100.arm.linux.org.uk>
Message-ID: <20140124064254.0369084d@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Russell King - ARM Linux wrote:
> On Thu, Jan 23, 2014 at 04:53:50PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Jan 23, 2014 at 12:04:44PM +0100, Sascha Hauer wrote:
> > > On Thu, Jan 23, 2014 at 11:56:32AM +0100, Lothar Wa?mann wrote:
> > > > Hi,
> > > > 
> > > > Sascha Hauer wrote:
> > > > > of_pwm_n_cells for the of_xlate handler is stored in struct pwm_chip,
> > > > > but it is only ever used by the of_xlate handler itsel. Remove
> > > > > of_pwm_n_cells from struct pwm_chip and let the handler do the argument
> > > > > count checking to simplify the code.
> > > > > 
> > > > This still does not make the PWM_POLARITY flag in the pwms node
> > > > optional as was the goal because of_parse_phandle_with_args() requires
> > > > at least #pwm-cells arguments in the node.
> > > > 
> > > > So, with a DT configuration like:
> > > > pwm0: pwm at 0 {
> > > > 	#pwm-cells = <3>;
> > > > };
> > > > backlight {
> > > > 	pwms = <&pwm0 0 100000>;
> > > > };
> > > 
> > > We misunderstood each other. My goal was to allow the driver to also
> > > work with old devicetrees which specify #pwm-cells = <2>, not to allow
> > > inconsistent devicetrees like the snippet above.
> > 
> > In which case, the patch I've posted seems to do that job too... I'm
> > just about to test out the three-cell version.
> 
> Okay, this works, but there's a problem with pwm-leds.
> 
> When the duty cycle is set to zero (when you set the brightness to zero)
> pwm-leds decides to disable the PWM after configuring it.  This causes
> the PWM output to be driven low, causing the LED to go to maximum
> brightness.
> 
> So, using the inversion at PWM level doesn't work.
> 
The problem is that the driver calls pwm_disable() when the duty cycle is 0.
This sets the PWM output low independent from the output polarity setting.

> To make this work correctly, we really need pwm-leds to do the inversion
> rather than setting the inversion bit in hardware.
> 
The same holds for the pwm-backlight driver.

The easiest fix would be not to call pwm_disable() even for a zero duty
cycle.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
