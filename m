From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 24 Aug 2012 04:54:40 +0200
Subject: [PATCH V2] mxs/spi: Fix misuse of init_completion
In-Reply-To: <87393dt3em.fsf@octavius.laptop.org>
References: <1345775624-9696-1-git-send-email-marex@denx.de>
 <87393dt3em.fsf@octavius.laptop.org>
Message-ID: <201208240454.40561.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chris Ball,

> Hi Marek,
> 
> On Thu, Aug 23 2012, Marek Vasut wrote:
> > The init_completion() call does reinit not only the variable carrying
> > the flag that the completion finished, but also initialized the
> > waitqueue associated with the completion. On the contrary, the
> > INIT_WAITQUEUE() call only reinits the flag.

Darn, it's INIT_COMPLETION() of course.

> > In case there was anything still stuck in the waitqueue, subsequent call
> > to init_completion() would be able to create possible race condition.
> > This patch uses the proper function and moves init_completion() into
> > .probe() call of the driver, to be issued only once.
> > 
> > Note that such scenario is impossible, since two threads can never enter
> > the mxs_spi_txrx_dma(), since whole this section is protected by mutex
> > in SPI core. This by no means allows this issue to exit though.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Thanks for writing that up -- I appreciate seeing the explanation of the
> problems this could have caused.

You're very welcome, I was really lazy, sorry about that and thanks for pushing 
me ;-) I hope someone might eventually even find this explanation useful.

> - Chris.

Best regards,
Marek Vasut
