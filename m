From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 May 2014 11:44:02 +0200
Subject: [PATCH v6 00/12] CCF support for Renesas r7s72100
In-Reply-To: <20140514050801.GE3502@verge.net.au>
References: <1400029816-24028-1-git-send-email-wsa@the-dreams.de>
 <20140514050801.GE3502@verge.net.au>
Message-ID: <CAMuHMdUTQbTSU4GSuxZX22QTqyQuo-zsNg4+d+OqpqEbjOnCaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram, Simon,

On Wed, May 14, 2014 at 7:08 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, May 14, 2014 at 03:10:04AM +0200, Wolfram Sang wrote:
>> This series moves the r7s72100 platfrom from the legacy clock implementation to
>> the common clock framework.
>>
>> This series has been tested with the renesas-devel-v3.15-rc2-20140428 tag. If
>> you want to boot into a console, you have a runtime dependency [1] which is
>> expected to go away in 3.15-rc6.
>>
>> Changes since V5:
>>
>> * rebased and tested against latest renesas/devel-tag
>>   (with and without CCF)

That's genmai-legacy (ARCH_SHMOBILE_LEGACY=y, MACH_GENMAI=y),
and genmai-multiplatform (ARCH_SHMOBILE_MULTI=y, MACH_GENMAI=y,
right?

There's still a third variant: genmai-reference (ARCH_SHMOBILE_LEGACY=y,
MACH_GENMAI_REFERENCE=y), which uses board-genmai-reference.c,
but without CCF, i.e. with clock-r7s72100.c.
For that, you still need the legacy clocks (also for serial!), so I needed the
(gmail-whitespace-damaged) temporary workaround below in my local tree.

> Thanks, I have queued up this series.

Do we want to go for the quick fix below, or just fix the issue for good,
and merge genmai-reference and genmai-multiplatform now, just like we did
for koelsch/lager?

I can send a proper patch for the quick fix, depending on your decision.

>From 1b7b851a5d1b7d10f42f68a35b65278827b03cc4 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 12 May 2014 14:32:25 +0200
Subject: [PATCH] ARM: shmobile: genmai-reference: Re-add legacy clocks

genmai-reference still uses non-CCF, so it needs the legacy clocks

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/clock-r7s72100.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c
b/arch/arm/mach-shmobile/clock-r7s72100.c
index df187484de5d..1b677e0a69c6 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -194,6 +194,16 @@ static struct clk_lookup lookups[] = {
  CLKDEV_DEV_ID("rspi-rz.2", &mstp_clks[MSTP105]),
  CLKDEV_DEV_ID("rspi-rz.3", &mstp_clks[MSTP104]),
  CLKDEV_DEV_ID("rspi-rz.4", &mstp_clks[MSTP103]),
+ CLKDEV_DEV_ID("e800c800.spi", &mstp_clks[MSTP107]),
+ CLKDEV_DEV_ID("e800d000.spi", &mstp_clks[MSTP106]),
+ CLKDEV_DEV_ID("e800d800.spi", &mstp_clks[MSTP105]),
+ CLKDEV_DEV_ID("e800e000.spi", &mstp_clks[MSTP104]),
+ CLKDEV_DEV_ID("e800e800.spi", &mstp_clks[MSTP103]),
+ CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
+ CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
+ CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
+ CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
+ CLKDEV_DEV_ID("e8008000.serial", &mstp_clks[MSTP45]),
  CLKDEV_DEV_ID("r7s72100-ether", &mstp_clks[MSTP74]),

  /* ICK */
-- 
1.7.9.5

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
