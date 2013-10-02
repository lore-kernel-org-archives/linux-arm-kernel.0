From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Wed, 02 Oct 2013 20:35:38 +1300
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <524B8117.9070309@wwwdotorg.org>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <5e0b6222e8648fb0c63aa649ee70b29d11f4924f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5243EE06.1020200@yahoo.com.au> <524B8117.9070309@wwwdotorg.org>
Message-ID: <524BCCCA.4050105@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 03:12 PM, Stephen Warren wrote:
> On 09/26/2013 02:19 AM, Craig McGeachie wrote:
>> I don't understand the concern with re-reading two volatile registers
>> between each dispatch.  Given the amount of processing that occurs
>> between the call to handle_IRQ and the calls to the possibly multiple
>> registered interrupt handlers, plus the processing that the handlers
>> perform (even if they are implemented as top/bottom halves), I think the
>> performance overhead of the two extra reads is vanishingly small.  In
>> fact, I think that focusing on eliminating them is premature
>> optimisation.  Developers are notoriously bad at identifying performance
>> hotspots through visual inspection.
>>
>> The point about the registers being volatile is important.  It's a C
>> keyword for a very good reason.
>
> Volatile as a keyword isn't especially useful for registers though,
> since register IO tends to need various barriers as well, but anyway...

I agree.  I hadn't really meant that the volatile would make register 
reading correct.  I really only meant it as a concept of values that 
might be changed by something else unknown.

I'm still a little uncertain about the correct reading of registers, 
especially here.  I tried to get a good understanding of readl versus 
readl_relaxed and what ordering guarantees were, or were not given. 
About the only thing I am sure of is the requirements for wmb() and 
rmb() given by section 1.3 of BCM2835_ARM_Peripherals.pdf.  And I don't 
know whether or not it should be applied to interrupt registers, or 
whether the two different readl functions remove the need for explicit 
barriers.

I do know that the barriers are required when you switch which 
peripheral IO memory you are reading/writing, and I think the interrupt 
controller counts as different to the various devices that the handlers 
will be interacting with.

Cheers,
Craig.
