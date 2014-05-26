From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 26 May 2014 15:11:03 +0200
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
In-Reply-To: <CAKohpo=ncHUmtJOEw4FZG1BWUSuiQK4n+ETEMJWJj9UoPz2cnw@mail.gmail.com>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
 <1401101131.4829.29.camel@weser.hi.pengutronix.de>
 <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
 <1401107748.4829.39.camel@weser.hi.pengutronix.de>
 <CAKohpo=ncHUmtJOEw4FZG1BWUSuiQK4n+ETEMJWJj9UoPz2cnw@mail.gmail.com>
Message-ID: <1401109863.4829.46.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 26.05.2014, 18:26 +0530 schrieb Viresh Kumar:
> On 26 May 2014 18:05, Lucas Stach <l.stach@pengutronix.de> wrote:
[...]
> 
> > 2. Usage of a fixed max voltage, rather than a voltage-tolerance. i.MX5
> > has a fixed maximum voltage, which is valid across all operating points.
> > I'm really opposed to using a tolerance value, where we instead could
> > have a well defined range. So for merging imx5-cpufreq into cpufreq-cpu0
> > this driver really need to handle this case.
> > Does adding a separate property for this, while keeping the
> > voltage-tolerance for the existing users, sound like a change you would
> > accept?
> 
> It looks you can just send voltage-tolerance to "zero" and this should work
> for you.. No need of another field.
> 
No, setting voltage-tolerance to zero means I don't accept any tolerance
at all. Though in practice I have a variable tolerance as I just have a
fixed maximum voltage for the chip.

For example the i.MX53 has a fixed maximum voltage of 1.4V on the cpu
rail, so for the slowest OPP the acceptable voltage range is 0.8V to
1.4V, for the fastest OPP the range is 1.3V to 1.4V.

So if someone connects a fixed 1.3V regulator, I want to still be able
to use all OPPs, even though the slowest OPP wants 0.8V ideally. If I
were to use a tolerance I would have to set is to some relatively strict
value, in order to not exceed the maximum voltage at the highest OPP,
but this would mean I could not use the slowest OPP because it's out of
the tolerance range.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
