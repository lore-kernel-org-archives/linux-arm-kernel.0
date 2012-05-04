From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 4 May 2012 07:15:45 +0000
Subject: [RFC / PATCH] arm/davinci: optimize the DMA ISR
In-Reply-To: <1328790506-18507-1-git-send-email-bigeasy@linutronix.de>
References: <1328790506-18507-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B63E9FED37@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Thu, Feb 09, 2012 at 17:58:26, Sebastian Andrzej Siewior wrote:
> The ISR does quiete a lot of hw access which could be avoided. First it
> checks for a pending interrupt by reading alteast one register. Then it
> checks for the "activated" slots by reading another register. This is
> more or a less a must.
> Now, once it found an active slot it does the same two reads again.
> After that it "knows" that there must be a pending transfer however it
> cross checks with the other register. There are 32 bit in an interger
> which are polled instead of considering only the set bits and ignoring
> those which are zero. This performs atleast 32 reads which could be
> avoided. In case of a first match it does another read.
> This patch reorganizes the access by re-using the register which have
> been read and then uses ffs() to find the matching slot instead looping
> over it. By doing this we get rid of the last (32 + 2 + hits) reads.

> It is possible however that by really busy bank0 we never get to handle
> bank1. If this is a problem, we could try to handle bank1 after we are
> done with bank0 to check if there are any outstanding transfers.

AFAICT, even the current code does not take care of this so
I guess this is never really hit in practice.

> To put some numbers on this, this is from spi transfer via spidev. The
> first column is the number of total transfers, the time stamp is taken
> before and after the ioctl():
> 
> |10000, min: 542us      avg: 591us
> |20000, min: 542us      avg: 592us
> |30000, min: 542us      avg: 592us
> |40000, min: 542us      avg: 585us
> |50000, min: 542us      avg: 593us
> 
> The same test case with the patch applied
> |10000, min: 444us      avg: 493us
> |20000, min: 444us      avg: 491us
> |30000, min: 444us      avg: 489us
> |40000, min: 444us      avg: 491us
> |50000, min: 444us      avg: 492us
> 
> that is almost 100us that just went away.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for the patch. I also sanity tested it using audio
on DA850 EVM.

Applying it for v3.5

Thanks,
Sekhar
