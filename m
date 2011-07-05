From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 12:25:33 +0100
Subject: [PATCH 3/4] mmci: sync DATAEND irq with dma|pio transfer done
In-Reply-To: <1309247860-17181-1-git-send-email-linus.walleij@stericsson.com>
References: <1309247860-17181-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110705112533.GY8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 09:57:40AM +0200, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> The end of a dma|pio data transfer is synced with the
> DATAEND irq. This will prevent the mmci driver from ending
> the request before the dma|pio job is completely done.
> 
> For dma we use DMA_PREP_INTERRUPT to register a callback
> function which is called when dma driver is done with job.
> 
> To also make sure we prevent hanging forever, waiting for
> DATAEND irq or a dma|pio transfer to be done, we setup a timer
> when either a DATAEND or dma|pio job is done. Once both
> conditions have occured, the timer is cancelled and the data
> transfer is completed.
> 
> If a timeout occurs, the data transfer is terminated in a
> controlled manner and EAGAIN is returned to the framework.
> A timeout value of 50 ms has been found to work well for
> our usecases.

What is the framework supposed to do with that error code?  Magic the
driver into disabling DMA by some non-existant callback?

Please, stop introducing magic new error codes which have no meaning to
the upper levels unless you're also going to add some handling of those
error conditions as well.
