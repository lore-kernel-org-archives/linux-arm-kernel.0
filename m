From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 7 Mar 2015 12:29:33 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150307110645.GW3989@piout.net>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
 <20150307091846.GN23367@worktop.ger.corp.intel.com>
 <20150307102056.GA28436@gradator.net> <20150307103939.GA17964@amd>
 <20150307110645.GW3989@piout.net>
Message-ID: <20150307112932.GA1372@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2015-03-07 12:06:45, Alexandre Belloni wrote:
> On 07/03/2015 at 11:39:39 +0100, Pavel Machek wrote :
> > > The Atmel watchdog can't be stopped once it's started. This is actually 
> > > very useful so we can reset if suspend or resume failed, the only 
> > > drawback is that you have to wake up from time to time (e.g. by using 
> > > the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.
> > 
> > Yeah. So you do "echo mem > /sys/power/state", and few seconds/minutes
> > after watchdog kills the system. But you did not ask for dead system,
> > you asked for suspend.
> > 
> > And while that behaviour is useful for you, I don't think it is
> > exactly useful behaviour, nor it is the behaviour user would expect.
> > 
> 
> I think you misunderstood, that is exactly the expected behaviour. This
> is hardware defined. Once the watchdog is started, nobody can stop it.
> Trying to change the mode register will result in a reset of the
> SoC.

Well, it boils down to "what is stronger". Desire to suspend the
system, or desire to reboot the system.

It is "echo mem > state", not "echo reboot > state".

> It is documented in the datasheet and any user wanting another behaviour
> is out of luck.

Actaully, your platform should just refuse to enter suspend-to-RAM
when hw watchdog is enabled.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
