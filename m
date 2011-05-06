From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 6 May 2011 10:13:33 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <20110429134936.GQ5126@n2100.arm.linux.org.uk>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<20110428170342.GA17290@n2100.arm.linux.org.uk>
	<4DBAB2CB.2030700@stericsson.com>
	<20110429134936.GQ5126@n2100.arm.linux.org.uk>
Message-ID: <4DC3ADAD.70603@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2011 at 02:44:59PM +0200, Ulf Hansson wrote:
>>> That's rather unfortunate, because it means that trying it on ARM
>>> hardware is going to hang indefinitely waiting for the nonexistent
>>> DMA stuff to finish.
>> I see the problem, we need a way of being able to switch between using  
>> the dma callback and not using it. I think the variant data should be  
>> used for this, what do you think?
> 
> How can we do that when it actually depends on how the primecell is wired
> and the characteristics of the DMA controller to which it is connected?

OK, lets add a new member in the mmci amba platform struct then. That 
should do it!?

> 
>> host->dataend and host->size==0 controls whether the data transfer has  
>> finished successfully. I believe this should be handled correctly in my  
>> patch. Maybe it is possible to make some minor restructuring to make it  
>> more clear what the end condition really is, I can see if I can figure  
>> something out.
> 
> host->size never goes to zero when DMA is in progress, as it doesn't
> track the progress of the transfer.  That's only tracked with PIO,
> and the remainder is calculated on error from the primecells counters.
> 

The error handling is almost the same for PIO and DMA. If we get 
MCI_DATACRCFAIL | MCI_DATATIMEOUT | MCI_TXUNDERRUN | MCI_RXOVERRUN, then 
we use the DATACNT register to find out the remainder of data, done in 
mmci_data_irq function. There is no difference between DMA and PIO here.

But, if we are "hanging" for a dma_callback to be called to fully 
complete the data transfer there is no error handling. You proposed to 
use a timer, which should be set when DATAEND occurs and if we still are 
waiting for the dma callback. I think this is good approach!

If that timer runs out, we could potentially read the DATACNT register 
to find out the remainder of data as we do when we handle 
MCI_DATACRCFAIL | MCI_DATATIMEOUT | MCI_TXUNDERRUN | MCI_RXOVERRUN 
errors. We must also take actions to terminate the dma job.
