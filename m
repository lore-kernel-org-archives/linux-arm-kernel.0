From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Sep 2014 19:50:35 -0300
Subject: [PATCH 0/3] move gpt per clk parent for ipg_per to OSC
In-Reply-To: <1409729805-9741-1-git-send-email-b20788@freescale.com>
References: <1409729805-9741-1-git-send-email-b20788@freescale.com>
Message-ID: <CAOMZO5BOfsvrH3ijxKwyGemEW-B60n-+4wpDZ5xfC98efM469w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 3, 2014 at 4:36 AM, Anson Huang <b20788@freescale.com> wrote:
> Currently, gpt timer's clock is from ipg_per, and ipg_per clock is from ipg
> on most of i.MX6 series SOCs, but ipg's rate may be scaled when system enters
> low bus mode for saving power, then gpt timer's clock rate will be scaled as
> well, as system timer should be kept stable and NOT drift, better to keep gpt
> timer's clk at fixed rate, on i.MX6Q TO > 1.0, i.MX6DL and i.MX6SX, there is
> OSC clk available for gpt timer, we should enable this feature, the hardware
> design is as below:
>
> i.MX6Q TO > 1.0: GPT_CR_CLKSRC, 3b'101 selects fix clock
>     of OSC / 8 for gpt per clk;
> i.MX6DL and i.MX6SX: GPT_CR_CLKSRC, 3b'101 selects OSC
>     for gpt per clk, and we must enable GPT_CR_24MEM to
>     enable OSC clk source for gpt per, GPT_PR_PRESCALER24M
>     is for pre-scaling of this OSC clk, here set it to 8
>     to make gpt per clk is 3MHz;
> i.MX6SL: ipg_per can be from OSC directly, so no need to
>     implement this new clk source for gpt per.
>
> Anson Huang (3):
>   ARM: imx: add gpt_3m clk for i.mx6qdl
>   ARM: dts: imx6: change gpt per clk to gpt_3m on i.mx6qdl and i.mx6sx
>   ARM: imx: source gpt per clk from OSC for system timer

This patch series works fine if we use the new dtb and new kernel.

However, booting a kernel with these series applied and using an old
dtb we get a system with broken timer.

'sleep 1' takes something like 20 seconds in this case.
