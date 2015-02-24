From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Feb 2015 21:25:00 -0300
Subject: Regression: v4.0-rc1: iMX6: Hummingboard fails due to drivers/clk
 changes
In-Reply-To: <20150223235350.GS8656@n2100.arm.linux.org.uk>
References: <20150223223255.GQ8656@n2100.arm.linux.org.uk>
 <CAOMZO5ASkXoVb9KrqF4Us18-rZ7k3XqjSdhcKyO_ParXXHoWbg@mail.gmail.com>
 <20150223235350.GS8656@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5D+pSDEct2ne+7Yurn2Jd-2+ArhgZfWYPO98bRyoEpOrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 8:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The reason appears to be a lack of packets coming out of the ethernet.
> Why that is, I'm not sure (maybe a gated GPIO16 clock to the phy?)
> Given that the phy state seems frozen - it doesn't detect the cable
> being disconnected - this seems highly likely.
>
> Looking at imx6q_1588_init(), this could be a problem:
>
>         ptp_clk = of_clk_get(np, 2);
>         enet_ref = clk_get_sys(NULL, "enet_ref");
>         clksel = ptp_clk == enet_ref ? IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
>                                        IMX6Q_GPR1_ENET_CLK_SEL_PAD;
>
> since ptp_clk and enet_ref will _never_ be the same pointer.  Forcing
> that test to be always true fixes the problem.

You are right. With such change imx6q-hummingboard can NFS mount (and
so does imx6q-sabresd).
