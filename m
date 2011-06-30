From: morpheus.ibis@gmail.com (Pavel Herrmann)
Date: Thu, 30 Jun 2011 17:36:57 +0200
Subject: kernel panic in spi_complete() on spitz (PXA270)
In-Reply-To: <201106301709.48818.marek.vasut@gmail.com>
References: <1308845380.4533.54.camel@oct.suse.cz>
	<1309445118.4406.47.camel@oct.suse.cz>
	<201106301709.48818.marek.vasut@gmail.com>
Message-ID: <22208110.jIqhYvKY9h@bloomfield>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 30, 2011 04:45:18 PM Stanislav Brabec wrote:
> Then I tried to apply "[PATCH] MAX1111: Fix race condition causing NULL
> pointer exception", connected charger that periodically disconnects and
> not seen the crash again. No OOPS was seen after ~100 reconnects.
> 
> So I guess that MAX1111 AC voltage reading (via SPI) was involved in an
> incorrect moment and race happened there and your MAX1111 race condition
> fix fixes it.

Hi,

Are you using the first or second version of the patch? if the former, please 
use v2 (sent a few days later), which has solved the same problem by using a 
mutex instead of allocating message data on stack (which is not good for DMA)

as for the backstory, this crash ocurrs when a short (measured in time spent) 
message was enqueued after a long message, so that the short one finished first 
(the actual bug was present even if the long one finished first, but in that 
case there was double complete() on the one completion instead of a NULL 
dereference)

Pavel
