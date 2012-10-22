From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Oct 2012 12:14:03 +0200
Subject: [PATCH v2] ARM: SMP_TWD: make setup()/stop() reentrant
In-Reply-To: <20121022051319.GA19107@S2101-09.ap.freescale.net>
References: <1350640589-31821-1-git-send-email-linus.walleij@linaro.org>
 <20121022051319.GA19107@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdbpDQQKm2=3zued=Kf2ykiVpb9wQDrSZf7=k8h1ryLAgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 7:13 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> I have seen two problems with the patch.
>
> 1. twd_timer_setup() is called on per-cpu path, and initial_setup_called
>    should be a per-cpu variable.

OK folded this into my v3 patch. I was not properly multithreaded
in my head...

> 2. When secondary cores get off-line, the clockevent devices for
>    the cores will be released.  So when they become online, the
>    clockevent devices should be registered again.

So that is how it happens. Where is the code releasing all
clock events? I was thinking this would more properly be done
in the .stop() path of the SMP TWD driver?

Right now it's not looking good because it "just so happens"
that the clockevent silently goes away in the cycle where
.stop() is called. :-(

Yours,
Linus Walleij
