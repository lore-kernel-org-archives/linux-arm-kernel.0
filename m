From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 11 Feb 2013 11:41:40 +0000
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
In-Reply-To: <20130210185812.GI20212@lunn.ch>
References: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
 <20130208213441.014343E2C27@localhost> <20130210185812.GI20212@lunn.ch>
Message-ID: <20130211114140.D47AF3E1E7B@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 10 Feb 2013 19:58:12 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> > > +* QNAP Power Off
> > > +
> > > +QNAP NAS devices have a microcontroller controlling the main power
> > > +supply. This microcontroller is connected to UART1 of the Kirkwood and
> > > +Orion5x SoCs. Sending the charactor 'A', at 19200 baud, tells the
> > > +microcontroller to turn the power off. This driver adds a handler to
> > > +pm_power_off which is called to turn the power off.
> > > +
> > > +Required Properties:
> > > +- compatibile: Should be "qnap,power-off"
> > 
> > It would do well to have the model number embedded into this compatible
> > string since it is unlikely that every single QNAP device will use the
> > same controller interface.
> 
> Hi Grant
> 
> All QNAP devices known to mainline use this same controller interface.
> 
> So that would be ts109, ts209, ts409, ts119, ts219, ts419, plus a few
> other models which we don't differentiate, like ts219P and ts219P+.
> 
> Any suggestions what to use in the compatible string?

for the ts109: compatible = "qnap,ts109-poweroff";
for the others: compatible = "qnap,ts[model]-poweroff", "qnap,ts109-poweroff";

That is the usual way things are done. The newer model claims
compatibility with the older. Some have also tried to use a 'generic'
value for claiming compatibility (ie. "qnap,tsxxx-poweroff") but I don't
recommend that because generic values aren't 'anchored' to any real
piece of hardware.

Instead 'qnap,ts109-poweroff' is used as the 'generic' version with the
advantage that when new hardware appears that doesn't conform you simply
drop the string for the older version.

It is also recommended to also include the specific model number simply
as a mechanism to test for quirks if ever needed... not critical though
for system level devices since the top level system model property can
also be used for that.

g.
