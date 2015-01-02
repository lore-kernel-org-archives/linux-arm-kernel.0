From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 Jan 2015 22:20:12 +0100
Subject: [PATCH] clk: rockchip: rk3288: Make s2r reliable by switching
 PLLs to slow mode
In-Reply-To: <1419276708-28294-1-git-send-email-dianders@chromium.org>
References: <1419276708-28294-1-git-send-email-dianders@chromium.org>
Message-ID: <2520772.QQVueoUhik@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 22. Dezember 2014, 11:31:48 schrieb Doug Anderson:
> We've been seeing some crashes at resume time on rk3288-based systems.
> On some machines they simply never wake up from suspend.  Symptoms
> include:
> 
> - System clearly got to sleep OK.  Power consumption is low, the PWM
>   for the PWM regulator has stopped, and the "global_pwroff" output
>   shows that the system is down.
> 
> - When system tries to wake up power consumption goes up.
> 
> - No kernel resume code (which was left in PMU SRAM) ran.  We added
>   some basic logging to this code (write to a location in SRAM right
>   at resume time) and didn't see the logging run.
> 
> It appears that we can fix the problem by slowing down APLL before we
> suspend.  On the system I tested things seemed reliable if I disabled
> 1.8GHz and 1.7GHz.  The Mask ROM itself tries to slow things down
> (which is why PLLs are in slow mode by the time we get to the kernel),
> but apparently it is crashing before it even gets there.
> 
> We'll be super paranoid and not just go down to 1.6GHz but we'll match
> what the Mask ROM seems to be doing and go into slow mode.  We'll also
> be safe and put all PLLs (not just APLL) into slow mode (well, except
> DPLL which is needed for SDRAM).  We'll even put NPLL into slow mode
> which the Mask ROM didn't do (not that it's used for much important
> stuff at early resume time).
> 
> Note that the old Rockchip reference code did something just like
> this, though they jammed it into pm.c instead of putting it in the
> syscore ops of the clock driver.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

applied to my clk branch for 3.20

As I already talked about with Doug on IRC (last year), I see this as a sort-
of stop-gap solution till we know the suspend requirements of the older/other 
Rockchip SoCs that do suspend slightly different and can generalize the whole 
clk suspend handling at this point.


Heiko
