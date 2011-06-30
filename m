From: utx@penguin.cz (Stanislav Brabec)
Date: Thu, 30 Jun 2011 18:22:02 +0200
Subject: kernel panic in spi_complete() on spitz (PXA270)
In-Reply-To: <22208110.jIqhYvKY9h@bloomfield>
References: <1308845380.4533.54.camel@oct.suse.cz>
	<1309445118.4406.47.camel@oct.suse.cz>
	<201106301709.48818.marek.vasut@gmail.com>
	<22208110.jIqhYvKY9h@bloomfield>
Message-ID: <1309450922.4406.66.camel@oct.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Herrmann wrote:
> On Thursday, June 30, 2011 04:45:18 PM Stanislav Brabec wrote:
> > Then I tried to apply "[PATCH] MAX1111: Fix race condition causing NULL
>  
> > So I guess that MAX1111 AC voltage reading (via SPI) was involved in an
> > incorrect moment and race happened there and your MAX1111 race condition
> > fix fixes it.

> Are you using the first or second version of the patch? if the former, please 
> use v2 (sent a few days later), which has solved the same problem by using a 
> mutex instead of allocating message data on stack (which is not good for DMA)

I guess the second one with mutex.
This is my work-in-progress-mix patch:
http://www.penguin.cz/~utx/zaurus/feed/images/spitz/zImage-3.0.0-rc5+-spitz.diff

Several hours later, charging was turned on/off at least 1000 times
without any crash. So it seems that it was the correct race condition
fix.

> as for the backstory, this crash ocurrs when a short (measured in time spent) 
> message was enqueued after a long message, so that the short one finished first 
> (the actual bug was present even if the long one finished first, but in that 
> case there was double complete() on the one completion instead of a NULL 
> dereference)

I guess that inserting of power supply initiates reading of voltages on
MAX1111. The long one may be touchscreen or LCD control.

-- 
Stanislav Brabec
http://www.penguin.cz/~utx
