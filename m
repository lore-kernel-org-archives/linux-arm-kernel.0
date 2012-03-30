From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 30 Mar 2012 12:38:40 +0200
Subject: [PATCH v5 04/16] pwm: Add table-based lookup for static mappings
In-Reply-To: <20120330101800.GD21950@opensource.wolfsonmicro.com>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-5-git-send-email-thierry.reding@avionic-design.de>
 <20120329220342.GK4153@opensource.wolfsonmicro.com>
 <20120330050641.GA21823@avionic-0098.mockup.avionic-design.de>
 <20120330101800.GD21950@opensource.wolfsonmicro.com>
Message-ID: <20120330103840.GB961@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown wrote:
> On Fri, Mar 30, 2012 at 07:06:41AM +0200, Thierry Reding wrote:
> > * Mark Brown wrote:
> 
> > > The clock and regulator APIs namespace the consumers by struct device -
> > > might this not be sensible here?  pwm_get() does already take the device
> > > as an argument.  It'd feel safer, and for example there's plenty of
> > > phones out there with two backlit displays...
> 
> > That's actually how this is supposed to work. "pwm-backlight" in the above
> > case is matched against the name of the struct device that you pass in to
> > pwm_get(). The only difference, at least as far as I can tell, to the clock
> > and regulator APIs is that a second name is not listed explicitly in the
> > lookup table.
> 
> Both clock and regulator APIs map (source) -> (dev, name).  This only
> has a mapping (source) -> (dev).
> 
> > So compared with the clock and regulator APIs it doesn't make too much sense
> > to pass both the struct device and the name to pwm_get() because it will
> > match the device name against the consumer name in the lookup table first and
> > only use the passed name if no match was found.
> 
> This is different to what the clock and regulator APIs do - they look up
> the name in the context of the struct device.  This is because...
> 
> > In case you have two backlight devices I would expect the following to work:
> 
> > 	static struct pwm_lookup board_pwm_lookup[] = {
> > 		PWM_LOOKUP("tegra-pwm", 0, "pwm-backlight.0"),
> > 		PWM_LOOKUP("tegra-pwm", 1, "pwm-backlight.1"),
> > 	};
> 
> ...if a single device uses more than one PWM then the above scheme won't
> work - unless I'm missing something?

Right, now it makes more sense. So basically if I have a single device using
two PWM devices, then I'll need to have something like this:

	static struct pwm_lookup board_pwm_lookup[] = {
		PWM_LOOKUP("tegra-pwm", 0, "pwm-foo.0", "bar"),
		PWM_LOOKUP("tegra-pwm", 1, "pwm-foo.0", "baz"),
	};

And then of course I'll need to have a second field by which the PWM device
can be identified. Good, I'll fix that up for the next round.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120330/c9e19b10/attachment.sig>
