From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 20 Mar 2014 17:40:04 +0100
Subject: [PATCH] ARM: at91: panic when the mck rate is zero
In-Reply-To: <532B1881.2050409@gmail.com>
References: <1395332062-4967-1-git-send-email-alexandre.belloni@free-electrons.com>
 <532B1881.2050409@gmail.com>
Message-ID: <20140320164003.GV12021@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/2014 at 17:34:09 +0100, Boris BREZILLON wrote :
> Le 20/03/2014 17:14, Alexandre Belloni a ?crit :
> >If the mck rate is zero, we'll hit the following warning:
> >
> >WARNING: CPU: 0 PID: 0 at arch/arm/mach-at91/at91sam926x_time.c:257 at91sam926x_pit_init+0x13c/0x260()
> >
> >But the kernel will continue to try booting and face a lot of divisions by zero
> >when trying to handle the various clocks.
> >
> >Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >---
> >  arch/arm/mach-at91/at91sam926x_time.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> >diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
> >index 0f04ffe9c5a8..f060f6371392 100644
> >--- a/arch/arm/mach-at91/at91sam926x_time.c
> >+++ b/arch/arm/mach-at91/at91sam926x_time.c
> >@@ -250,6 +250,8 @@ void __init at91sam926x_pit_init(void)
> >  	if (IS_ERR(mck))
> >  		panic("AT91: PIT: Unable to get mck clk\n");
> >  	pit_rate = clk_get_rate(mck) / 16;
> >+	if (pit_rate == 0)
> >+		panic("AT91: PIT: can't continue, mck rate is zero\n");
> You're testing pit_rate why not printing:
> 
> "AT91: PIT: can't continue, *pit* rate is zero\n"
> 

pit_rate is zero because mck is zero I just didn't want to introduce a
new variable or another call to clk_get_rate(mck). I don't have any
strong opinion about that either so I can definitely make that change.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
