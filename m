From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Sep 2018 17:28:41 -0700
Subject: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
In-Reply-To: <CACRpkdbXuvWyp+UzxAjKo85bTBvdFuYXMt+wo56eN9KWOcLW+g@mail.gmail.com>
References: <20180910200624.4494-1-tony@atomide.com>
 <CACRpkdbXuvWyp+UzxAjKo85bTBvdFuYXMt+wo56eN9KWOcLW+g@mail.gmail.com>
Message-ID: <20180919002841.GN5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [180918 23:33]:
> On Mon, Sep 10, 2018 at 1:06 PM Tony Lindgren <tony@atomide.com> wrote:
> 
> > I noticed that unlike omap2 and 3 based SoCs, omap4 based SoCs keep
> > the GPIO clocks enabled for GPIO level interrupts with wakeup enabled.
> > This blocks deeper idle states as the whole domain will stay busy.
> >
> > The GPIO clock seems to stay enabled if the wakeup register is enabled
> > and a level interrupt is triggered. In that case the only way to have
> > the GPIO module idle is to reset it. It is possible this has gone
> > unnoticed with OSWR (Open SWitch Retention) and off mode during idle
> > resetting GPIO context most GPIO instances in the earlier Android trees
> > for example.
> >
> > Looks like the way to deal with this is to have omap4 based SoCs
> > only set wake for the duration of idle and clear level registers for
> > the idle. With level interrupts we can do this as the level interrupt
> > from device will be still there on resume.
> >
> > I've taken the long path to fixing this to avoid yet more hard to
> > read code. I've set up a quirks flag, and a struct for function
> > pointers so we can use these to clean up other quirk handling easier
> > in the later patches. The current level quirk handling is moved to
> > the new functions.
> >
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Keerthy <j-keerthy@ti.com>
> > Cc: Tero Kristo <t-kristo@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Do we have a conclusion on this? Shall I apply the patch on
> an immutable branch and pull into next, or do you folks need
> more time?

Thanks for checking, let's wait on this. There are few more things
I still need to check and test before reposting.

Regards,

Tony
