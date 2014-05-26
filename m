From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 26 May 2014 15:58:17 +0200
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
In-Reply-To: <CAKohponzJma6yNueMef2Q4k+qT-n7boV0tx0pCqjFmuQWj6TXg@mail.gmail.com>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
 <1401101131.4829.29.camel@weser.hi.pengutronix.de>
 <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
 <1401107748.4829.39.camel@weser.hi.pengutronix.de>
 <CAKohpo=ncHUmtJOEw4FZG1BWUSuiQK4n+ETEMJWJj9UoPz2cnw@mail.gmail.com>
 <1401109863.4829.46.camel@weser.hi.pengutronix.de>
 <CAKohponzJma6yNueMef2Q4k+qT-n7boV0tx0pCqjFmuQWj6TXg@mail.gmail.com>
Message-ID: <1401112697.4829.56.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 26.05.2014, 19:14 +0530 schrieb Viresh Kumar:
> On 26 May 2014 18:41, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> Just to mention that I am trying to help you and am not opposing any
> change. We can add this field if its really required and I am just trying
> to understand your problem and if we can solve it with current code.
> 
I understand this and I think we are having a productive conversation
here. I just wanted to make it clear that the currently existing
voltage-tolerance property isn't sufficient for the use-cases I have in
mind.

> > No, setting voltage-tolerance to zero means I don't accept any tolerance
> > at all. Though in practice I have a variable tolerance as I just have a
> > fixed maximum voltage for the chip.
> >
> > For example the i.MX53 has a fixed maximum voltage of 1.4V on the cpu
> > rail, so for the slowest OPP the acceptable voltage range is 0.8V to
> > 1.4V, for the fastest OPP the range is 1.3V to 1.4V.
> >
> > So if someone connects a fixed 1.3V regulator, I want to still be able
> > to use all OPPs, even though the slowest OPP wants 0.8V ideally. If I
> > were to use a tolerance I would have to set is to some relatively strict
> > value, in order to not exceed the maximum voltage at the highest OPP,
> > but this would mean I could not use the slowest OPP because it's out of
> > the tolerance range.
> 
> I understood the problem now. But I feel there is nothing imx specific here.
> It should be a general concern and I want to know how are people
> working around it currently.
> 
I think the voltage-tolerance property is ok for SoCs where we have a
strictly defined voltage level for one OPP and where the tolerance is
used to account for the fact that most regulators can only closely, but
not exactly, match the OPP defined voltage.

> IOW can we say that you want tolerance to work only on the positive
> side? But no tolerance on the -ve side ?
> 
Right, the OPP defined voltages are minimum voltages for the OPP
frequency, so we should not undercut them.

> Also, your example dts says that you do have different voltage levels
> for each frequency but actually the regulator may only support a
> single voltage. i.e. 1.4 volts.
> 
Right, the OPP in my example define the minimum required voltage for
each frequency. This is in accordance to the OPP binding. But for this
chip the datasheet explicitly says that it is ok to power the cpu rail
with up to 1.4V, regardless of the current operating frequency. So this
1.4V is really the upper bound I would like to pass to the regulator
framework. This ensures that the driver still works properly even if the
external regulator can't scale down to the minimum (or in other words
optimal) voltage.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
