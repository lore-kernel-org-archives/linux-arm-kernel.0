From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 15:59:14 +0100
Subject: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
In-Reply-To: <CAKohpomsqCnEcSeuqtZcYOC6bgTrGmc8zXTm6cA72q+hr=LBsQ@mail.gmail.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
 <5607434.rlEIdu4yyh@wuerfel>
 <CAKohpomsqCnEcSeuqtZcYOC6bgTrGmc8zXTm6cA72q+hr=LBsQ@mail.gmail.com>
Message-ID: <3594266.ci9lGXQ9iA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 20:18:10 Viresh Kumar wrote:
> On 1 December 2014 at 19:35, Arnd Bergmann <arnd@arndb.de> wrote:
> > I guess a string would be better here, the idea here was to
> > have a different bool property per driver, which would also
> > work.
> 
> Hmm, I will prefer string as we don't need to define any more bindings then
> for new drivers.

Right. You'd still need to define the known values though, so in
effect it's not much of a difference. I have no problem with 
a string property though.

> >> > @@ -367,29 +404,19 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
> >> >         if (!IS_ERR(cpu_reg))
> >> >                 regulator_put(cpu_reg);
> >> >
> >> > -       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
> >> > -
> >>
> >> We still need this, and its about how clocks are shared between CPUs.
> >
> > I didn't see where this comes from. Who is setting up this platform
> > data?
> 
> Mvebu is using it to communicate that all CPUs have separate
> clock lines.

I still don't see where it does that. All I see for mvebu is

	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);

without any platform data. I see this patch
http://lists.linaro.org/pipermail/linaro-kernel/2014-September/017693.html
on the mailing list, but it's not in linux-next, and it obviously
would not work any more with the patch I proposed. Instead I suppose
you would use a different string to match against for the case of
separate clocks.

	Arnd
