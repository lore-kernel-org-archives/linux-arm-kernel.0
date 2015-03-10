From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 21:19:55 +0100
Subject: [PATCH v2 05/18] reset: Add reset_controller_of_init() function
In-Reply-To: <CALszF6BkTOLR+VNkRKfvEBG5ZyaYL+9fZ4EAPVu5b_imCvEQoQ@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <8729383.kvUZDm4dQz@wuerfel>
 <CALszF6BkTOLR+VNkRKfvEBG5ZyaYL+9fZ4EAPVu5b_imCvEQoQ@mail.gmail.com>
Message-ID: <6773745.i9mx5zmPP4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 16:28:44 Maxime Coquelin wrote:
> 2015-03-10 16:00 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> > On Friday 20 February 2015 19:01:04 Maxime Coquelin wrote:
> >> Some platforms need to initialize the reset controller before the timers.
> >>
> >> This patch introduces a reset_controller_of_init() function that can be
> >> called before the timers intialization.
> >>
> >> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> >>
> >
> > Not sure about this. It seems like the cleanest approach if we get
> > a lot of these, but then again it is probably very rare, and I'd
> > like to avoid adding such infrastructure if it's just for one
> > SoC. Could we add a hack in the machine initialization instead?
> 
> Sun6i also need to initialize the reset controller early. Today, they
> hack the machine initialization.
> With two SoCs having the same need, what should we do?

Good question, I'd like to hear some other opinions on this first.

> > I think ideally this would be done in the boot loader before we
> > even start Linux, but I don't know if that's possible for you.
> 
> From what I understand, the only constraint is to perform it after the
> clock is enabled.
> So this should be possible to do it in the bootloader, but it means
> also adding timers clocks ungating in the bootloader.

Ungating the timer clock input seems like a reasonable thing to
do for the bootloader, I think a lot of platforms rely on this
elsewhere (but enough of them don't, which is why we have the
early clk init).

	Arnd
