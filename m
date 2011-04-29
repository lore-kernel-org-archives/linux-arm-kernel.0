From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 14:49:36 +0100
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <4DBAB2CB.2030700@stericsson.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<20110428170342.GA17290@n2100.arm.linux.org.uk>
	<4DBAB2CB.2030700@stericsson.com>
Message-ID: <20110429134936.GQ5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 02:44:59PM +0200, Ulf Hansson wrote:
>>
>> That's rather unfortunate, because it means that trying it on ARM
>> hardware is going to hang indefinitely waiting for the nonexistent
>> DMA stuff to finish.
>
> I see the problem, we need a way of being able to switch between using  
> the dma callback and not using it. I think the variant data should be  
> used for this, what do you think?

How can we do that when it actually depends on how the primecell is wired
and the characteristics of the DMA controller to which it is connected?

> host->dataend and host->size==0 controls whether the data transfer has  
> finished successfully. I believe this should be handled correctly in my  
> patch. Maybe it is possible to make some minor restructuring to make it  
> more clear what the end condition really is, I can see if I can figure  
> something out.

host->size never goes to zero when DMA is in progress, as it doesn't
track the progress of the transfer.  That's only tracked with PIO,
and the remainder is calculated on error from the primecells counters.
