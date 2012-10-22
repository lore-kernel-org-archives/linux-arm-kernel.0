From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Oct 2012 22:14:51 +0800
Subject: [PATCH v2] ARM: SMP_TWD: make setup()/stop() reentrant
In-Reply-To: <CACRpkdbpDQQKm2=3zued=Kf2ykiVpb9wQDrSZf7=k8h1ryLAgA@mail.gmail.com>
References: <1350640589-31821-1-git-send-email-linus.walleij@linaro.org>
 <20121022051319.GA19107@S2101-09.ap.freescale.net>
 <CACRpkdbpDQQKm2=3zued=Kf2ykiVpb9wQDrSZf7=k8h1ryLAgA@mail.gmail.com>
Message-ID: <20121022141446.GB19107@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 12:14:03PM +0200, Linus Walleij wrote:
> > 2. When secondary cores get off-line, the clockevent devices for
> >    the cores will be released.  So when they become online, the
> >    clockevent devices should be registered again.
> 
> So that is how it happens. Where is the code releasing all
> clock events? I was thinking this would more properly be done
> in the .stop() path of the SMP TWD driver?
> 
tick_notify() will receive CLOCK_EVT_NOTIFY_CPU_DEAD when a cpu goes
away.  It results in tick_shutdown() invoking which will release the
clockevent device for the cpu.

Shawn
