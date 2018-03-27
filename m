From: ada@thorsis.com (Alexander Dahl)
Date: Tue, 27 Mar 2018 12:41:08 +0200
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
Message-ID: <9761072.pX2B0LJlSJ@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexandre,

Am Freitag, 23. Februar 2018, 18:15:52 CEST schrieb Alexandre Belloni:
>  - using the PIT doesn't work well with preempt-rt because its interrupt is
>    shared (in particular with the UART and their interrupt flags are
>    incompatible)

This is actually quite annoying when using the UART as a serial console, 
producing garbage when you type too fast. That's why I tested this patch 
series (on top of v4.16-rc7). Target is a at91sam9g20 based board, quite close 
to, but not actually an at91sam9g20-ek.

First test was with the previous kernel config updated by oldconfig, so 
basically still using the PIT:

  +CONFIG_ATMEL_CLOCKSOURCE_PIT=y

On the serial console with v4.16 and the patch set without switching to the 
new options, I see this on boot (no surprise, this is what it also prints with 
v4.9):

  clocksource: pit: mask: 0xfffffff max_cycles: 0xfffffff, max_idle_ns: 
14468723050 ns
  ?
  clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 
19112604462750000 ns
  ?
  clocksource: tcb_clksrc: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 115749784805 ns
  ?
  clocksource: Switched to clocksource tcb_clksrc

Interrupts here:

  $ cat /proc/interrupts 
             CPU0       
   16:       4802  atmel-aic   1 Level     at91_tick, rtc0, ttyS0
   19:      24041  atmel-aic  19 Level     tc_clkevt
   26:        124  atmel-aic  21 Level     eth0
   28:          1      GPIO  11 Edge      reset
  Err:          0

Second test with tcb block added to dts like in 
32ce250b0af3b6971fc746445fce87861a9f5628 and with changed kernel config 
according to defconfig changes in patch 5 and 6:

  +# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
  +CONFIG_ATMEL_CLOCKSOURCE_TCB=y
  -CONFIG_ATMEL_TCLIB=y
  -CONFIG_ATMEL_TCB_CLKSRC=y
  -CONFIG_ATMEL_TCB_CLKSRC_BLOCK=0
  +# CONFIG_ATMEL_TCLIB is not set
  -CONFIG_ATMEL_PIT=y
  +CONFIG_ATMEL_ARM_TCB_CLKSRC=y
  -CONFIG_PWM_ATMEL_TCB=m

The output on the serial console contains this:

  clocksource: timer at fffa0000:0,1: mask: 0xffffffff max_cycles: 0xffffffff, 
max_idle_ns: 115749784805 ns
  ?
  clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 
19112604462750000 ns
  ?
  clocksource: Switched to clocksource timer at fffa0000:0,1

Interrupts here:

  $ cat /proc/interrupts 
             CPU0       
   17:    5727291  atmel-aic  19 Level     timer at fffa0000:2
   18:       5523  atmel-aic   1 Level     rtc0, ttyS0
   26:       5031  atmel-aic  21 Level     eth0
   28:          1      GPIO  11 Edge      reset
  Err:          0

So, the board boots and runs like usual. I don't know if that qualifies for a 
Tested-by? Hope that helps.

Greets
Alex
