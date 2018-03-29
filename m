From: ada@thorsis.com (Alexander Dahl)
Date: Thu, 29 Mar 2018 17:11:08 +0200
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <3478710.yJBBt3uoRT@ada>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <20180328155033.GH13942@piout.net> <3478710.yJBBt3uoRT@ada>
Message-ID: <2097113.JiHb7Y1Uf1@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hei hei,

Am Donnerstag, 29. M?rz 2018, 10:01:26 CEST schrieb Alexander Dahl:
> This is the result:
> 
> INT                NAME          RATE             MAX
>  17 [vel     timer at fffa]  1837 Ints/s     (max:  1912)
>  26 [      vel     eth0]     3 Ints/s     (max:    11)

Above was with v4.16-rc7+, and CONFIG_ATMEL_CLOCKSOURCE_TCB=y, 
CONFIG_ATMEL_TCLIB=n (as one might see in the name column).

Now, v4.16-rc7+, with CONFIG_ATMEL_CLOCKSOURCE_PIT=y, CONFIG_ATMEL_TCLIB=y, 
CONFIG_ATMEL_TCB_CLKSRC=y (old driver I guess):

INT                NAME          RATE             MAX
 19 [ vel     tc_clkevt]  1898 Ints/s     (max:  1945)
 26 [      vel     eth0]     3 Ints/s     (max:    11)

So the rates here are roughly the same with old and new driver and the same 
kernel source. As Alexandre stated in IRC, the rates should be the same with 
old and new driver on the otherwise same kernel source.

I just double checked it, and with the other clocksource on v4.16-rc7+ I get:

INT                NAME          RATE             MAX
 17 [vel     timer at fffa]  1904 Ints/s     (max:  1922)
 26 [      vel     eth0]     6 Ints/s     (max:     7)

The lower rates I reported yesterday were from older kernels v4.14.29-rt25 and 
v4.15.13, so there might be the question why v4.16-rc7+ has a much higher rate 
with tc_clkevt? But there's no real difference between tc_clkevt and 
timer at fffa? when both measured with v4.16-rc7+ on this target. I know 
Alexandre has lower rates though, may depend on other parameters.

So for completeness, I just tested the clean v4.16-rc7 without this patch 
series: 

INT                NAME          RATE             MAX
 19 [ vel     tc_clkevt]  1903 Ints/s     (max:  1930)
 26 [      vel     eth0]     7 Ints/s     (max:     7)

Basically the same for this one, too.

HTH & Greets
Alex
