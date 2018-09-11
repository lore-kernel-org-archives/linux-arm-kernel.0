From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 11 Sep 2018 11:58:37 -0500
Subject: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
In-Reply-To: <20180910200624.4494-1-tony@atomide.com>
References: <20180910200624.4494-1-tony@atomide.com>
Message-ID: <444bae18-9737-8e13-2a0f-c08863ae1336@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 09/10/2018 03:06 PM, Tony Lindgren wrote:
> I noticed that unlike omap2 and 3 based SoCs, omap4 based SoCs keep
> the GPIO clocks enabled for GPIO level interrupts with wakeup enabled.
> This blocks deeper idle states as the whole domain will stay busy.
> 
> The GPIO clock seems to stay enabled if the wakeup register is enabled
> and a level interrupt is triggered. In that case the only way to have
> the GPIO module idle is to reset it. It is possible this has gone
> unnoticed with OSWR (Open SWitch Retention) and off mode during idle
> resetting GPIO context most GPIO instances in the earlier Android trees
> for example.
> 
> Looks like the way to deal with this is to have omap4 based SoCs
> only set wake for the duration of idle and clear level registers for
> the idle. With level interrupts we can do this as the level interrupt
> from device will be still there on resume.
> 
> I've taken the long path to fixing this to avoid yet more hard to
> read code. I've set up a quirks flag, and a struct for function
> pointers so we can use these to clean up other quirk handling easier
> in the later patches. The current level quirk handling is moved to
> the new functions.

I agree with patch in general as it seems will not break anything and
 change localized for omap4 only.
But I'd be very appreciated if you can provide more information about issue
which helps better understand it, so could you, if possible, collect dump of:
- GPIO bank regs right before entering WFI state in Idle (or as close as possible)
  I'm interesting in sysc/s, ctrl, irq's regs (+wakupen) and GPIO_DEBOUNCEN first of all
- GPIO bank CLKCTRL registers (is it "in transition" state).
in non working case.

> 
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpio/gpio-omap.c                | 145 ++++++++++++++++++------
>   include/linux/platform_data/gpio-omap.h |   2 +
>   2 files changed, 114 insertions(+), 33 deletions(-)
> 

-- 
regards,
-grygorii
