From: dianders@chromium.org (Doug Anderson)
Date: Sat, 6 Jun 2015 20:43:04 -0700
Subject: [PATCH v4 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <5573B1CA.1050204@rock-chips.com>
References: <1433523923-4755-1-git-send-email-wxt@rock-chips.com>
 <1433523923-4755-2-git-send-email-wxt@rock-chips.com>
 <CAD=FV=XGOVpAA5+NQ8O910T=CPrYKfTseBXfNbR4EkenzDECaQ@mail.gmail.com>
 <5573B1CA.1050204@rock-chips.com>
Message-ID: <CAD=FV=VswV+MAgYr084VOxQynHrL1fdwnVb4b_W_bHUZgoW4mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Sat, Jun 6, 2015 at 7:51 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> @@ -150,13 +159,15 @@ static int __cpuinit rockchip_boot_secondary(unsigned
> int cpu,
>                  * sram_base_addr + 4: 0xdeadbeaf
>                  * sram_base_addr + 8: start address for pc
>                  * */
> -               udelay(10);
> +               udelay(20);
>
> I increased the 'udelay(20)' or 'udelay(50)' in rockchip_boot_secondary().
> Set#2 also can repro this issue over 22600 cycles with testing scripts.
> (about 1 hours)
>
> log:
> ================= 226 ============
> [ 4069.134419] CPU1: shutdown
> [ 4069.164431] CPU2: shutdown
> [ 4069.204475] CPU3: shutdown
> ......
> [ 4072.454453] CPU1: shutdown
> [ 4072.504436] CPU2: shutdown
> [ 4072.554426] CPU3: shutdown
> [ 4072.577827] CPU1: Booted secondary processor
> [ 4072.582611] CPU2: Booted secondary processor
> [ 4072.587426] CPU3: Booted secondary processor
> <hang>
>
> The set #4 will be better work.

OK, I'm OK with this, but I'd like to get Heiko's opinion.

Also:
* Just for kicks, does mdelay(1) work?  I know that's 100x more than
udelay(10), but previously we were actually looping waiting for the
power domain, right?  ...so maybe the old code used to introduce a
pretty big delay.

* Does anyone from the chip design team have any idea why patch set #4
works but patch set #2 doesn't?  I know it's Sunday morning in China
right now, but maybe you could ask Monday?


Thanks!

-Doug
