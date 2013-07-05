From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 5 Jul 2013 12:05:59 +0200
Subject: [PATCH v5] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <alpine.DEB.2.02.1307042211420.11637@ionos.tec.linutronix.de>
References: <1372687359-18235-1-git-send-email-jonas.jensen@gmail.com>
 <1372940383-5957-1-git-send-email-jonas.jensen@gmail.com>
 <alpine.DEB.2.02.1307042211420.11637@ionos.tec.linutronix.de>
Message-ID: <CACmBeS03Xfo7DyyYUbpBaO8TeR3g8BTPzcoOzQayk40k1soFzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2013 23:42, Thomas Gleixner <tglx@linutronix.de> wrote:
> You just modify bits on the "cache" variable. though you are not
> caching it. As it seems to work it looks like this register simply can
> be written with constants.

I agree, the global "cache" variable wasn't very good. The only good thing, that
it eliminated all TIMER_CR reads in moxart_clkevt_next_event.

Yes it could be written with constants, and it wouldn't be so bad, because in
this case so few need to be set. If more constants were set from init
the benefit
would be more clear.

>> +     timereg_cache = readl(base + TIMER_CR) | TIMEREG_CR_2_ENABLE;
>
> Why are you reading that back? You know excactly which of the timers
> you are using and none of those should be enabled before you reach
> that code. If it one of them is enabled by the boot loader you better
> disable it in this init function.

Removed. All timers except TIMER2 should be disabled in init.

> Now if you disable all of those timers and just use a known set, then
> you can do without a pseudo cache variable and just write constants
> into the control register, right ?

Yes, please take a look at v6.


Best regards,
Jonas
