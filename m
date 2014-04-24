From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 24 Apr 2014 16:09:00 +0200
Subject: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM
 with the PM core
In-Reply-To: <CAPDyKFr02yyhGNncYX2AgBXTA3Sc0AGQcExjtLvQ5QU0_=YJwg@mail.gmail.com>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
 <1398334403-26181-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFr02yyhGNncYX2AgBXTA3Sc0AGQcExjtLvQ5QU0_=YJwg@mail.gmail.com>
Message-ID: <CAMuHMdV=g13MnhhUDk9CFT+J5QPEryzO9HRSJFALJMfKi1Dn8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Thu, Apr 24, 2014 at 3:11 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> +static int of_clk_register(struct device *dev, struct clk *clk)
>> +{
>> +       int error;
>> +
>> +       if (!dev->pm_domain) {
>> +               error = pm_clk_create(dev);
>> +               if (error)
>> +                       return error;
>> +
>> +               dev->pm_domain = &of_clk_pm_domain;
>
> I am concerned about how this will work in conjunction with the
> generic power domain.
>
> A device can't reside in more than one pm_domain; thus I think it
> would be better to always use the generic power domain and not have a
> specific one for clocks. Typically the genpd should invoke
> pm_clk_resume|suspend from it's runtime PM callbacks.

On shmobile SoCs supporting power domains, the power domain is
overridden later by calling rmobile_add_devices_to_domains() and friends.

My patch doesn't change that: the code behaved the same in the
non-multi-platform case before: dev->pm_domain as set from
drivers/sh/pm_runtime.c was overridden later.

I'll have a deeper look into the power domain code later anyway.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
