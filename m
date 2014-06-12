From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 12 Jun 2014 14:09:20 -0700
Subject: [PATCH 1/3] clk: exynos-audss: Keep the parent of mout_audss
 always enabled
In-Reply-To: <CAC5m3BwR9WhiiDqUw1A6FjmzAnQ02xCBxOeAaY2nt3CRqTz+oQ@mail.gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-2-git-send-email-tushar.b@samsung.com>
 <20140611165027.6562.64928@quantum>
 <CAC5m3BwR9WhiiDqUw1A6FjmzAnQ02xCBxOeAaY2nt3CRqTz+oQ@mail.gmail.com>
Message-ID: <20140612210920.6562.96815@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tushar Behera (2014-06-12 00:29:23)
> On Wed, Jun 11, 2014 at 10:20 PM, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Tushar Behera (2014-06-10 22:32:17)
> >> When the output clock of AUDSS mux is disabled, we are getting kernel
> >> oops while doing a clk_get() on other clocks provided by AUDSS. Though
> >> user manual doesn't specify this dependency, we came across this issue
> >> while disabling the parent of AUDSS mux clocks.
> >
> > Hi Tushar,
> >
> > Can you help me understand better what the actual problem is? What is
> > the root cause of the kernel oops?
> 
> Currently AUDSS mux has two parents, XXTI crystal and MAU_EPLL clock.
> As per observation, when the output of AUDSS mux is gated, we are not
> able to do any operation on the clocks provided by MAU block (mostly
> the clocks used by ADMA and audio blocks).

I tried to get a datasheet for Exynos 54xx but could not find it. I even
looked at the public 5250 data sheet, but it is completely missing
Chapter 34, "Audio Subsystem", which apparently contains Figure 34-3,
"Clock names and clock tree diagram of MAUDIO_BLK".

So without any clue about your hardware (not for lack of trying) I would
guess that somewhere in the parent hierarchy you have an interface clock
which must be enabled in order for you to touch the registers pertaining
to the downstream audio clocks.

The right way to handle this requires two steps:

1) model your interface clock in the Linux clock framework if you
haven't already (I assume it is a gate clock, or the child of a gate
clock)

2) the clk_ops callbacks for the affected audio clocks should wrap their
operations (i.e. critical secion) with a clk_enable/clk_disable pair,
where the clock being enables/disable is the interface clock mentioned
above in #1

The CCF is reentrant, so you can do this by simply using the top-level
clk.h API from within your clk_ops callbacks.

I might be totally wrong about the cause of the hang, but that's my best
guess based on everyone's bug reports.

Regards,
Mike

> 
> >
> > You mention calling clk_get on child clocks of the AUDSS mux fails, but
> > I cannot imagine why. How can the enable/disable state of a clock affect
> > the ability to clk_get other clocks?
> >
> 
> I might have a little vogue while updating the commit message
> (mentioning about clk_get which surely is only a s/w operation), but
> there is definitely some issue with handling those clocks under given
> scenario.
> 
> I am on leave till end of this week, so I will update you more with
> the logs on Monday.
> 
> Thanks,
> --
> Tushar
