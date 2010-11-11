From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 11 Nov 2010 11:31:43 +0100
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <alpine.LFD.2.00.1011111054010.2900@localhost6.localdomain6>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.00.1011111054010.2900@localhost6.localdomain6>
Message-ID: <4CDBC60F.8070905@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:

> There is only one caveat. When nohz is on and you sleep longer than 16
> seconds then the limitation we have in place does not work anymore, as
> it would say that the long sleep time is less than the 63bit
> wraparound time. With 32bit clocksource it limits the sleep correclty
> to avoid the clocksource wrap issue.

Hm! So the .mask has that side effect (as I suspected), and with
this the sleep will be limited to what time you can get into 63 bits
(2200 years). And we sure want NOHZ...

But if I complement the solution with the keepwarm() timer from
Orion doing just a dummy read() on the clocksource every say 15 secs
it will work even if the system sleeps for so long.

> Aside of that you are trading a bit less source code with extra code
> in the clock read() function, which is called pretty frequently.

Hm, yeah. I would have to go to metrics but it's O(n)
is it not? Shouldn't hurt a high-frequency SMP system
I believe.

Yours,
Linus Walleij
