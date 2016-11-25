From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 25 Nov 2016 14:03:20 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <20161125135830.GL14217@n2100.armlinux.org.uk> (Russell King's
 message of "Fri, 25 Nov 2016 13:58:30 +0000")
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <20161125124528.GJ14217@n2100.armlinux.org.uk>
 <yw1xtwav9092.fsf@unicorn.mansr.com>
 <20161125133436.GK14217@n2100.armlinux.org.uk>
 <yw1xlgw78y8k.fsf@unicorn.mansr.com>
 <20161125135830.GL14217@n2100.armlinux.org.uk>
Message-ID: <yw1xh96v8xnb.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Fri, Nov 25, 2016 at 01:50:35PM +0000, M?ns Rullg?rd wrote:
>> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
>> > It would be unfair to augment the API and add the burden on everyone
>> > for the new API when 99.999% of the world doesn't require it.
>> 
>> I don't think making this particular dma driver wait for the descriptor
>> callback to return before reusing a channel quite amounts to a horrid
>> hack.  It certainly wouldn't burden anyone other than the poor drivers
>> for devices connected to it, all of which are specific to Sigma AFAIK.
>
> Except when you stop to think that delaying in a tasklet is exactly
> the same as randomly delaying in an interrupt handler - the tasklet
> runs on the return path back to the parent context of an interrupt
> handler.  Even if you sleep in the tasklet, you're sleeping on behalf
> of the currently executing thread - if it's a RT thread, you effectively
> destroy the RT-ness of the thread.  Let's hope no one cares about RT
> performance on that hardware...

That's why I suggested to do this only if the needed delay is known to
be no more than a few bus cycles.  The completion callback is currently
the only post-transfer interaction we have between the dma and device
drivers.  To handle an arbitrarily long delay, some new interface will
be required.

-- 
M?ns Rullg?rd
