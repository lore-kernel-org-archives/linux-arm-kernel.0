From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Dec 2014 17:25:11 -0200
Subject: [PATCH 1/3] ARM: imx6sx: Set PLL2 as parent of QSPI clocks
In-Reply-To: <20141216072921.GD2411@dragon>
References: <1417788802-13219-1-git-send-email-festevam@gmail.com>
 <20141216072921.GD2411@dragon>
Message-ID: <CAOMZO5AdNe6LOOtvnFZZN4rBVt6rCR0urPugzqo-DyquQL9nng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Dec 16, 2014 at 5:29 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> What is the original parent clock, and how does that cause a division by
> zero error?

The default qspi2_clk_sel contains '110' which is marked as 'reserved'
in the reference manual.

This causes the qspi2 to look like this in the clock tree:

 dummy                                    4            4           0          0
    qspi2_sel                             1            1           0          0
       qspi2_pred                         1            1           0          0
          qspi2_podf                      1            1           0          0
             gpmi_io                      0            0           0          0
             qspi2                        1            1           0

A 'dummy' clock gets assigned as parent.

This is will cause the division by zero when the qspi driver calls
clk_set_rate().

I will send a v2 with such explanation.
