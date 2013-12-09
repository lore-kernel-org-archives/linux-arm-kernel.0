From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Dec 2013 10:37:43 -0800
Subject: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use
 arch_timer_acpi_init()
In-Reply-To: <529DE21E.4080707@linaro.org>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org>
 <1386069328-22502-3-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com>
 <529DE21E.4080707@linaro.org>
Message-ID: <20131209183743.GA27562@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 09:52:30PM +0800, Hanjun Guo wrote:
> On 2013?12?03? 20:27, Linus Walleij wrote:
> >On Tue, Dec 3, 2013 at 12:15 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> >
> >>+       /* if can't be initialised from DT, try ACPI way */
> >>+       if (!arch_timer_get_rate())
> >>+               arch_timer_acpi_init();
> >>+
> >>         arch_timer_rate = arch_timer_get_rate();
> >This looks a bit fragile. Having a call like arch_timer_get_rate()
> >to check whether there is a DT node for the timer doesn't seem
> >right, can you refactor the code to provide some
> >has_arch_timer_node() or similar call instead, so it's a bit easier
> >to understand & maintain at least?
> 
> Good point, thanks for the guidance.
> I will introduce has_arch_timer_node() as you said and use
> it as follows:
> 
> if (has_arch_timer_node())
> clocksource_of_init();
> esle
> arch_timer_acpi_init(); /* try ACPI way */
> 
> Is this make sense to you?

Even when we boot with ACPI, the boot stub will still create a minimal
DTB. We should just make sure that the clocksource (which will be
architectured timers anyway, I believe?) is described in that stub.

I would rather do that than have dual-path booting in the lowlevel setup, it
increases test requirements and makes it hard for someone without ACPI hardware
to check for regressions in this code, etc.


-Olof
