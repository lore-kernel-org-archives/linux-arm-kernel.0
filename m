From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 19 Sep 2011 10:52:04 +0530
Subject: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip (Re: [PATCH
	v15 06/12] OMAP: dmtimer: switch-over to platform device driver)
In-Reply-To: <20110917013531.GB2937@atomide.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
	<CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
	<20110915165810.GA2284@atomide.com> <20110915170548.GB2284@atomide.com>
	<CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
	<CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
	<20110917013531.GB2937@atomide.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302575A0FBC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Sat, Sep 17, 2011 at 07:05:31, Tony Lindgren wrote:
> 
> Afzal, care to check if that works for AM335X/TI816X/TI814X?

With following patch over yours, AM335X (the only board with me) boots up fine.

Regards
Afzal

>From ff64a239e60f9b517860eb2fe9c4f88a188ca51d Mon Sep 17 00:00:00 2001
From: Afzal Mohammed <afzal@ti.com>
Date: Mon, 19 Sep 2011 10:06:59 +0530
Subject: [PATCH] ARM: OMAP: dmtimer register safe access

Access dmtimer registers after setting it's parent
clock. If default parent is not physically present,
accessing register causes abort, so access registers
after proper parent is set.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1746c69..ababc4d 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -172,7 +172,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
        }

        omap_hwmod_enable(oh);
-       __omap_dm_timer_init_regs(timer);

        sys_timer_reserved |= (1 << (gptimer_id - 1));

@@ -190,6 +189,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
                        clk_put(src);
                }
        }
+       __omap_dm_timer_init_regs(timer);
        __omap_dm_timer_reset(timer, 1, 1);
        timer->posted = 1;

--
1.6.2.4
