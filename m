From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 31 Oct 2017 12:22:02 -0400 (EDT)
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <PS1PR06MB1162212F37C8BA7EE367FE828A5E0@PS1PR06MB1162.apcprd06.prod.outlook.com>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
 <20171002020618.23924-4-nicolas.pitre@linaro.org>
 <PS1PR06MB1162212F37C8BA7EE367FE828A5E0@PS1PR06MB1162.apcprd06.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.76.1710311211540.21665@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Oct 2017, Chris Brandt wrote:

> On Sunday, October 01, 2017 1, Nicolas Pitre wrote:
> > With printch() the console messages are sent out one character at a time
> > which is agonizingly slow especially with semihosting as the whole trap
> > intercept, remote byte access, and system resume danse is performed for
> > every single character across a relatively slow remote debug connection.
> > Let's use printascii() to send a whole string at once. This is also going
> > to be more efficient, albeit to a quite lesser extent, with serial ports
> > as well.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  arch/arm/kernel/early_printk.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> Now that this patch has hit -next, I'm noticing an issue with it.
> 
> There are no carriage returns, just line feeds, which makes for a very 
> ugly display.

Hmmm....

If you look at printascii in arch/arm/kernel/debug.S you'll find the 
following code:

1:              waituart r2, r3
                senduart r1, r3
                busyuart r2, r3
                teq     r1, #'\n'
                moveq   r1, #'\r'
                beq     1b

Why is that not working for you?

Are you using semihosting?

Do you have another printascii implementation?


Nicolas
