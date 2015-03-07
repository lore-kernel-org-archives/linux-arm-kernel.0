From: gradator@gradator.net (Sylvain Rochet)
Date: Sat, 7 Mar 2015 12:46:08 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150307112932.GA1372@amd>
References: <20150304183809.GD22156@leverpostej>
 <20150305095306.3db98ac8@bbrezillon>
 <20150305105308.GA13617@leverpostej>
 <20150305121723.1da0d016@bbrezillon>
 <20150305115307.GA14093@leverpostej>
 <20150307091846.GN23367@worktop.ger.corp.intel.com>
 <20150307102056.GA28436@gradator.net> <20150307103939.GA17964@amd>
 <20150307110645.GW3989@piout.net> <20150307112932.GA1372@amd>
Message-ID: <20150307114608.GA30011@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Mar 07, 2015 at 12:29:33PM +0100, Pavel Machek wrote:
> On Sat 2015-03-07 12:06:45, Alexandre Belloni wrote:
> > On 07/03/2015 at 11:39:39 +0100, Pavel Machek wrote :
> > > > The Atmel watchdog can't be stopped once it's started. This is actually 
> > > > very useful so we can reset if suspend or resume failed, the only 
> > > > drawback is that you have to wake up from time to time (e.g. by using 
> > > > the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.
> > > 
> > > Yeah. So you do "echo mem > /sys/power/state", and few seconds/minutes
> > > after watchdog kills the system. But you did not ask for dead system,
> > > you asked for suspend.
> > > 
> > > And while that behaviour is useful for you, I don't think it is
> > > exactly useful behaviour, nor it is the behaviour user would expect.
> > > 
> > 
> > I think you misunderstood, that is exactly the expected behaviour. This
> > is hardware defined. Once the watchdog is started, nobody can stop it.
> > Trying to change the mode register will result in a reset of the
> > SoC.
> 
> Well, it boils down to "what is stronger". Desire to suspend the
> system, or desire to reboot the system.
> 
> It is "echo mem > state", not "echo reboot > state".

Maybe we should warn the watchdog is enabled and the system is going to 
reboot if nothing woke-up the system before the watchdog expire, but the 
maximum watchdog is 16s so it can't get unnoticed during development, I 
am confident embedded engineers are smart enough to understand what is 
happening without a displayed warning :-)


> > It is documented in the datasheet and any user wanting another behaviour
> > is out of luck.
> 
> Actaully, your platform should just refuse to enter suspend-to-RAM
> when hw watchdog is enabled.

Yeah that's what I said, hardware watchdog or suspend: chose one or use 
the software watchdog instead or "hack" around the way I am doing ;-)


Sylvain
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150307/a1c46715/attachment-0001.sig>
