From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 25 May 2015 22:53:59 +0200
Subject: [PATCH] clockevents: don't suspend/resume if unused
In-Reply-To: <alpine.DEB.2.11.1505252208140.5457@nanos>
References: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1505252046400.5457@nanos>
 <20150525190641.GA7542@gradator.net>
 <alpine.DEB.2.11.1505252208140.5457@nanos>
Message-ID: <20150525205359.GA9302@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Mon, May 25, 2015 at 10:11:15PM +0200, Thomas Gleixner wrote:
>  
> That's a reasonable explanation.
> 
> While timer IPs seem to be designed by janitors in general, this one
> has an extraordinary level of stupidity.

Yes, that's quite a stupid design, however I wasn't totally right from 
looking at the datasheet again, the timer does not restart when asked to 
stop while it is already stopped, my bad. But it doesn't change 
anything, the issue is still that this timer cannot be stopped right 
now, you have to ask for it to stop then wait the overflow.

1. suspend PIT[1] -> ask to stop

2. suspended, timer is still counting and will eventually reaches the 
overflow condition then stop, that's probably not going to happen if 
system switched to slow clock

3. resume PIT[2] -> wait for PIT to stop counting (up to 126ms) because 
we need it to be synched back if we want to use it at some point in the 
future, that's also the only way to clear pending interrupts.

Sylvain


[1] http://lxr.free-electrons.com/source/drivers/clocksource/timer-atmel-pit.c#L122
[2] http://lxr.free-electrons.com/source/drivers/clocksource/timer-atmel-pit.c#L130
