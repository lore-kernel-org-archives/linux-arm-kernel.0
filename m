From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 11 Mar 2015 12:42:22 +0100
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
 <20150311105307.GW28806@sirena.org.uk>
 <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
Message-ID: <1426074142.30734.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 11.03.2015, 16:33 +0530 schrieb Viresh Kumar:
> On 11 March 2015 at 16:23, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Mar 10, 2015 at 08:20:43AM +0530, Viresh Kumar wrote:
> >
> > Please don't send upstream e-mail to my work account, I use this address
> > pretty consistently for upstream.  Upstream mail to my work account
> > frequently ends up unread.
> 
> Sorry about that, I did exactly opposite of this earlier :(
> 
> >> On 6 March 2015 at 11:19, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> >> > On 5 March 2015 at 17:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> >> > About putting
> >> > those stuff into regulator driver, I think you mean creating a
> >> > "virtual regulator
> >> > device" and put all the voltage controlling complex into the driver, right?
> >> > Maybe it's a good idea in this case, but I am sure if this kind of
> >> > virtual regulator is acceptable.
> >
> >> @Mark: Is this allowed to create virtual regulator for a CPU ?
> >
> > I don't really know what the above means or what problem it's supposed
> > to solve.
> 
> On mediatek platform, they need to configure two regulators in order to change
> DVFS state of the big cluster. The generic cpufreq-dt driver and earlier OPP
> bindings have support for a single regulator only and so what Pi-cheng tried
> to do is,
> - Configure one of the regulators using cpufreq-dt
> - And other one using cpufreq frequency change notifiers
> 
> This looks awkward..
> 
> What I suggested was to create another virtual regulator for CPU which will
> eventually configure both the regulators. And so the question that such
> virtual regulators are allowed or not.

Instead of creating virtual regulators I would be strongly in favor of
reviving the voltage-domain work. That would allow us to push all those
voltage dependencies we have seen on various SoCs into the domain
handling code and don't care about it in the drivers.

In that case cpufreq-dt wouldn't control a regulator directly, but
request a specific voltage from the domain the CPUs are located in and
those in turn would control the regulators supplying them.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
