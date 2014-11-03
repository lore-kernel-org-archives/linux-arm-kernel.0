From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Nov 2014 09:07:36 -0800
Subject: [PATCH v4] clk: rockchip: disable unused clocks
In-Reply-To: <1414845873-26351-1-git-send-email-kever.yang@rock-chips.com>
References: <1414845873-26351-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=WrtDYaQqRsx7tfhfvvZzewFmhqRPt0vAF-i0vke5ZaFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Sat, Nov 1, 2014 at 5:44 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> -       COMPOSITE(SCLK_EMMC, "sclk_emmc", mux_mmc_src_p, 0,
> +       COMPOSITE(SCLK_EMMC, "sclk_emmc", mux_mmc_src_p, CLK_IGNORE_UNUSED,

Is there a reason why this is needed?  I took it out (AKA let eMMC get
disabled when unused) and my system booted w/ eMMC as the root
filesystem.


> -       GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 9, GFLAGS),
> +       GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 9, GFLAGS),

Is there a reason why this is needed?  I took it out (AKA let UART2
get disabled) and my system booted.

The console-related bits in my cmdline are:
  earlyprintk=ttyS2,115200n8 console=tty1 console=ttyS2,115200n8 kgdboc=ttyS2

Do you have a different cmdline where it's failing?


Other than the two above this looks sane to me (only looked at
rk3288).  At some point soon we should definitely fix the PWM and the
USB ones and then start looking at the others and see if there are any
others that can be fixed.  ...but this seems like it's moving us in
the right direction and I'd like to see it landed.


So with the above two fixes, you can add my Reviewed-by and Tested-by.
I tested this in the chromeos-3.14 tree (which has tons of backports)
on rk3288-pinky.  I tested:
* System continues to work normally (including graphics).
* WIP Suspend / Resume patches work better with this patch than
without (both normal and deep modes).


-Doug
