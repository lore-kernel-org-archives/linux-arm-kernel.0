From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 5 Jul 2013 12:21:07 +0200 (CEST)
Subject: [PATCH v5] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <CACmBeS03Xfo7DyyYUbpBaO8TeR3g8BTPzcoOzQayk40k1soFzA@mail.gmail.com>
References: <1372687359-18235-1-git-send-email-jonas.jensen@gmail.com>
 <1372940383-5957-1-git-send-email-jonas.jensen@gmail.com>
 <alpine.DEB.2.02.1307042211420.11637@ionos.tec.linutronix.de>
 <CACmBeS03Xfo7DyyYUbpBaO8TeR3g8BTPzcoOzQayk40k1soFzA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1307051213080.11637@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Jul 2013, Jonas Jensen wrote:

> On 4 July 2013 23:42, Thomas Gleixner <tglx@linutronix.de> wrote:
> > You just modify bits on the "cache" variable. though you are not
> > caching it. As it seems to work it looks like this register simply can
> > be written with constants.
> 
> I agree, the global "cache" variable wasn't very good. The only good thing, that
> it eliminated all TIMER_CR reads in moxart_clkevt_next_event.

Well, you can use a global cache variable. But that wants to be
implemented as a real cache, i.e. it always contains the current state
of the register.

   cache = 0;

   cache |= T2_ENABLE;
   write(cache, CR);
   ....
 
> Yes it could be written with constants, and it wouldn't be so bad, because in
> this case so few need to be set. If more constants were set from init
> the benefit
> would be more clear.
>
> >> +     timereg_cache = readl(base + TIMER_CR) | TIMEREG_CR_2_ENABLE;
> >
> > Why are you reading that back? You know excactly which of the timers
> > you are using and none of those should be enabled before you reach
> > that code. If it one of them is enabled by the boot loader you better
> > disable it in this init function.
> 
> Removed. All timers except TIMER2 should be disabled in init.
> 
> > Now if you disable all of those timers and just use a known set, then
> > you can do without a pseudo cache variable and just write constants
> > into the control register, right ?
> 
> Yes, please take a look at v6.

You are still reading from the control register.

What's wrong with:

#define T1_ENABLE	(TIMEREG_CR_2_ENABLE | TIMEREG_CR_1_ENABLE)
#define T1_DISABLE	(TIMEREG_CR_2_ENABLE)

Because you need to preserve the CR2 enable bit so your clocksource
does not get switched off.

Then the set_mode/next_event functions simply do:

     write(T1_DISABLE)
     write(data)
     write(T1_ENABLE)

Hmm?

Thanks,

	tglx
