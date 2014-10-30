From: dianders@chromium.org (Doug Anderson)
Date: Thu, 30 Oct 2014 13:28:16 -0700
Subject: [PATCH v2] clk: rockchip: disable unused clocks
In-Reply-To: <1414676335-20203-1-git-send-email-kever.yang@rock-chips.com>
References: <1414676335-20203-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=Xu_PE_CXrj3YkeAZU5uoFfa3Jkmf7rQXxL0Zs7YmvJVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Thu, Oct 30, 2014 at 6:38 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> The rockchip clock driver use CLK_IGNORE_UNUSED flag to make sure
> all the clocks are available like default power on state.
> We have implement the clock manage in most of rockchip drivers,
> it is time to remove it for power save.
> Instead we add CLK_IGNORE_UNUSED for some clock nodes which should
> be on during boot or no module driver in kernel will initialize it.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
> Changes in v2:
> - get some clock ID back
> - add CLK_IGNORE_UNUSED tag for aclk_strc and aclk_core in clk-rk3188.c
> - add CLK_IGNORE_UNUSED tag for rk3288 dwc2
>
>  drivers/clk/rockchip/clk-rk3188.c |  36 +++++-----
>  drivers/clk/rockchip/clk-rk3288.c | 148 +++++++++++++++++++-------------------
>  drivers/clk/rockchip/clk.c        |   9 ---
>  3 files changed, 92 insertions(+), 101 deletions(-)

I'm on a system that's actually using the PWM regulator (rk3288-pinky)
based on the one in EVB.  On this system your patch makes it crash
about half the time at bootup (if the PWM stopped when the level was
high it will overvolt but not crash and if the PWM stopped when the
level was low it will undervolt and crash).

It turns out that there's a bug in the rk3288.dts where it's
referencing PCLK_PWM instead of PCLK_RKPWM.  I'll send up a patch for
that as soon as I finish testing everything.  ...but even when fixing
that there are still problems:

* There's a period of time during init time where the PLL clock will
be not be enabled.  That's a problem.  It's slightly hidden by the
fact that we might have the PWM backlight on, though.

* At the moment the PWM regulator isn't actually "enabled" by default
(it's left on by the BIOS but nothing in the system actually enables
it).


I'll see if I can come up with some patches to fix those issues, but
for now it might be wise to leave "pclk_rkpwm" as CLK_IGNORE_UNUSED.


I'll also note that with your patch (even after fixing the above):
* Graphics stops working for me totally.

* Something like 1% of the time the system locks up on reboot in my
reboot tests.  I still need to confirm to be 100% sure that this was
caused by your patch though...
