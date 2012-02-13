From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Feb 2012 20:17:21 +0100
Subject: No clkdev vs smp_twd.c
In-Reply-To: <op.v9k40vvx2s3iss@ecaz>
References: <op.v9k40vvx2s3iss@ecaz>
Message-ID: <CACRpkda-Oth52Ww853VQfo_p3H6EwTxyh2qHMTb5yWsmF7TXLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2012 at 10:37 PM, Imre Kaloz <kaloz@openwrt.org> wrote:

> I've just noticed, that your changes broke smp_twd on platforms without
> clkdev support.
>
> Committing out the changes in
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=5def51b0f827931bb559e6195060d774894fc9f9
> get me over the following errors:
>
> arch/arm/kernel/built-in.o: In function `twd_timer_setup':
> io.c:(.cpuinit.text+0x42c): undefined reference to `clk_get_sys'
> io.c:(.cpuinit.text+0x44c): undefined reference to `clk_enable'
> io.c:(.cpuinit.text+0x468): undefined reference to `clk_put'
> io.c:(.cpuinit.text+0x5ec): undefined reference to `clk_get_rate'
> make[5]: *** [vmlinux] Error 1
>
> Do you have a fix in the pipeline maybe?

What exact system and defconfig is this, so I can reproduce
the problem?

If you're not using clkdev I think the above functions need to be
implemented anyway, since they're part of the <linux/clk.h>
contract so then it'd be a patch to add some stubs to the clock
implementation for your platform, but we might want to add an #ifdef
for the !HAVE_CLK case if you have no clocks at all.
(OTH: correct me if I get this wrong...)

Yours,
Linus Walleij
