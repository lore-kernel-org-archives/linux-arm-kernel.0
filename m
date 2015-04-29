From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 29 Apr 2015 15:08:09 +0200
Subject: [RFC/RFT 2/6] clk: qcom: Add runtime support to handle clocks
 using PM clocks
In-Reply-To: <CAPDyKFoja9OZf+X2eaBGwTXoqFHchOz9vopLYF+wiguHXwznzw@mail.gmail.com>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
 <1429778744-13352-3-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFpVXWGeO_kbOvPbdy83aN6wxkC77ydH_2C3Bo=5QsspoA@mail.gmail.com>
 <553A21C7.4060506@codeaurora.org>
 <CAMuHMdV_WD7vay-5VC20izUWFjc8rSW4wZQq6Y3xAa+SU0Quig@mail.gmail.com>
 <7hh9s1xrut.fsf@deeprootsystems.com>
 <553EF5D4.60900@codeaurora.org>
 <CAMuHMdW8OKDODHTw=A=vCFR9PN3KUr_fiGSiNkn0Q7Q16axU6g@mail.gmail.com>
 <5540A923.8000104@codeaurora.org>
 <CAMuHMdWWv5qADWP4CMj5Kj62v_FK9JxMP6NXOpyN8GTk05raAQ@mail.gmail.com>
 <CAPDyKFoja9OZf+X2eaBGwTXoqFHchOz9vopLYF+wiguHXwznzw@mail.gmail.com>
Message-ID: <CAMuHMdXXkgTDjdYanQNUJFXqUXLtGrLCOugs94MaCvg9O7wbXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Wed, Apr 29, 2015 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Geert, thanks, I was wondering how you handle the !CONFIG_PM case for
>>> rmobile. I mean who turns the clocks on for the devices when you build
>>> with CONFIG_PM disabled?
>>
>> We still use pm_clk_add_notifier() in drivers/sh/pm_runtime.c if
>> CONFIG_PM_GENERIC_DOMAINS_OF=n. Hence the second instance of
>> pm_clk_notify() will enable the clocks at driver binding time.
>> Hardware power domains are assumed enabled by reset state/the boot
>> loader.
>
> Yes, it a bit tricky - but I guess that's the current only viable
> solution if we have when using the pm_clk API.
>
>> Given the amount of PM infrastructure involved when hardware power and
>> clock domains are involved, I think at one point we'll have to start restricting
>> our builds to CONFIG_PM=y.
>
> I don't think that would solve the problem, since you may still have
> cross SoC drivers which may be used without CONFIG_PM.

That's not as much of a problem as it sounds:
  - If the driver cares (needs to know) about the clock, it should already
    manage it itself.
  - If it doesn't care about the clock, it just needs Runtime PM support.
    That will do the right thing on platforms with (needs PM=y) and without
    (doesn't care about PM=x) clock domains.
So the bigger "problem" is making sure all drivers have at least minimal
Runtime PM support, else they can't be reused as-is on systems with PM
domains.

> So all SoC that uses a driver which expects clocks to be managed using
> PM clocks from a PM domain, will need the above "trick". Right?

One remaining issue with pm_clk_add_notifier() is that it applies to all
platform devices in the system, not just the on-SoC devices. Hence it may
inadvertently manage clocks for off-SoC devices it's not supposed to touch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
