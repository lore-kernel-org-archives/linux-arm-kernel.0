From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 2 Oct 2014 11:42:13 +0200
Subject: [PATCH v2 2/4] ARM: exynos: Ensure PM domains are powered at
 initialization
In-Reply-To: <6158232.Yd6ncToJoF@vostro.rjw.lan>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
 <1412174494-15346-3-git-send-email-ulf.hansson@linaro.org>
 <542C2972.9070002@samsung.com> <6158232.Yd6ncToJoF@vostro.rjw.lan>
Message-ID: <CAPDyKFrRw-cATC0r7y6jyr2jiu2z8tKjETs0nmeOhEeuW8=hRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 October 2014 21:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, October 01, 2014 06:18:58 PM Sylwester Nawrocki wrote:
>> On 01/10/14 16:41, Ulf Hansson wrote:
>> > At ->probe() it's common practice for drivers/subsystems to bring their
>> > devices to full power and without depending on CONFIG_PM_RUNTIME.
>> >
>> > We could also expect that drivers/subsystems requires their device's
>> > corresponding PM domains to be powered, to successfully complete a
>> > ->probe() sequence.
>> >
>> > Align to the behavior above, by ensuring all PM domains are powered
>> > prior initialization of a generic PM domain.
>> >
>> > Do note, since the generic PM domain will try to power off unused PM
>> > domains at late_init, there should be no increased power consumption
>> > over time, but potentially during boot.
>>
>> Wouldn't it be a better idea to power on the power domains which are
>> turned off only when CONFIG_PM_RUNTIME is not enabled ? I had a plan
>> to submit a patch doing that but unfortunately this has fallen through
>> the cracks. At the moment mach-exynos/pm_domains.c is not even built in
>> when CONFIG_PM_RUNTIME is disabled.

Yes, that's the approach I also intend to take in the next step.

But, it's not that simple. Since this requires a mechanism for drivers
to bring their device's PM domains into power state prior doing probe.
We don't have such today. I do have some ideas about this, but I think
we need to keep that as a separate discussion.

>>
>> I don't like the behaviour introduced in this patch to be the default,
>> i.e. turning all possible power domains during boot sequence, even if
>> some are not used and not needed. While we're trying to decrease the
>> power consumption in any possible way this doesn't help at all.

This will hit only during boot, until late_init. Unless you have a
platform that keeps rebooting all the time, is this really a big
worry?

Still, I certainly agree that we should strive for a solution where
it's possible to leave PM domains powered off at init. It's should be
too hard to support this from genpd point of view, but
drivers/subsystems will need some adaptations.

>
> Agreed (as stated before).
>
> And I'm wondering why that comment of mine was ignored?

Sorry, if missed to comment of that. I guess I have at this point.

Kind regards
Uffe
