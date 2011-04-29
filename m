From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 29 Apr 2011 14:44:59 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <20110428170342.GA17290@n2100.arm.linux.org.uk>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<20110428170342.GA17290@n2100.arm.linux.org.uk>
Message-ID: <4DBAB2CB.2030700@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> That's rather unfortunate, because it means that trying it on ARM
> hardware is going to hang indefinitely waiting for the nonexistent
> DMA stuff to finish.

I see the problem, we need a way of being able to switch between using 
the dma callback and not using it. I think the variant data should be 
used for this, what do you think?

> 
> I remain unconvinced whether this problem applies only to ARMs
> evaluation boards as I believe the whole primecell DMA stuff from
> the outset is fundamentally misdesigned.  I suspect there maybe SoCs
> out there which suffer from the same broken DMA issues which ARMs
> eval boards do.
> 
> Maybe an alternative solution is on data end to set a timer, which
> is cancelled when the DMA engine callback arrives.  If the timer
> expires, it means we have broken DMA and that needs to be shutdown
> for that instance.

This could be a very good alternative for error handling of the DMA job. 
I will try to add some code that handles this.

> 
> However, one thing worries me - what if the DMA callback comes before
> we get the data end interrupt.  Given the weirdnesses of your
> implementation found so far (which are well beyond what's visible
> on ARMs own implementation) I wouldn't put any guarantees on the
> relative ordering of that either.
> 

host->dataend and host->size==0 controls whether the data transfer has 
finished successfully. I believe this should be handled correctly in my 
patch. Maybe it is possible to make some minor restructuring to make it 
more clear what the end condition really is, I can see if I can figure 
something out.


BR
Ulf Hansson
