From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 3 Nov 2015 22:28:34 +0800
Subject: [PATCH v2 0/3] let Marvell Berlin SoCs make use of the best delay
 timer
Message-ID: <1446560917-6318-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case there are several possible delay timers, we purely base the
selection on the frequency, which is suboptimal in some cases. Take
one Marvell Berlin platform for example: we have arch timer and dw-apb
timer. The arch timer freq is 25MHZ while the dw-apb timer freq is
100MHZ, current selection would choose the dw-apb timer. But the dw
apb timer is on the APB bus while arch timer sits in CPU, the cost
of accessing the apb timer is higher than the arch timer.
    
This series firstly modifies register_current_timer_delay() to choose
the highest rating delay timer: use the rating as a primary indication
and fall back to comparing the frequency if the rating is not set or
the same. Then we set the arch_delay_timer rating as 400, finally
Implement ARM delay timer for the dw_apb_timer and set its rating as 300.

Since v1:
 - add one patch to let register_current_timer_delay() to choose the the
   highest rating delay timer
 - add one patch to set arch_delay_timer rating as 400
 - remove CONFIG_DW_APB_TIMER_BASED_DELAY option, use CONFIG_ARM instead.
 - change the commit msg as "clocksource/drivers/abc: Foo...."


Jisheng Zhang (3):
  ARM: delay: choose the highest rating delay timer
  ARM: arch_timer: set the arch_delay_timer rating as 400
  clocksource/drivers/dw_apb_timer_of: Implement ARM delay timer

 arch/arm/include/asm/delay.h          |  1 +
 arch/arm/kernel/arch_timer.c          |  1 +
 arch/arm/lib/delay.c                  | 16 +++++++++++++++-
 drivers/clocksource/dw_apb_timer_of.c | 17 +++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.6.2
