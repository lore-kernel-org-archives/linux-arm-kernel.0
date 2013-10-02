From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 20:12:39 -0600
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <5243EE06.1020200@yahoo.com.au>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <5e0b6222e8648fb0c63aa649ee70b29d11f4924f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5243EE06.1020200@yahoo.com.au>
Message-ID: <524B8117.9070309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 02:19 AM, Craig McGeachie wrote:
> On 09/24/2013 03:38 PM, Stephen Warren wrote:
>> I'm not actually sure that's a good change. If we read e.g. PEND1 and
>> saw 4 bits asserted, why wouldn't we optimize by handling each of those
>> 4 bits. Re-reading the PEND1 register for each bit, and presumably
>> seeing the exact same set of remaining bits still set (or even more),
>> just seems like a waste. We know we're going to have to process all the
>> interrupts, so why not just process them?
> 
> 
> On 09/25/2013 11:33 PM, Simon Arlott wrote:
>> On Sat, September 21, 2013 09:14, Craig McGeachie wrote:
>>>   * Restore the flow of control that re-reads the base pending register
>>>     after handling any interrupt. The current version handles all
>>>     interrupts found in a GPU pending register before re-reading the
>>>     base pending register. In the original Broadcom assembly code, there
>>>     appear to be defect tracking numbers next to code inserted to create
>>>     this behaviour.
>>
>> This was by design so that continuous interrupts in a bank did not impact
>> progress of interrupts in other bank. If there are defects with this
>> strategy, then check that they do not exist in your interrupt handlers
>> instead of the interrupt controller itself. Unless there is a real bug
>> in the interrupt controller, you're decreasing the performance by
>> re-reading the base pending register every time.
> 
> I don't understand the concern with re-reading two volatile registers
> between each dispatch.  Given the amount of processing that occurs
> between the call to handle_IRQ and the calls to the possibly multiple
> registered interrupt handlers, plus the processing that the handlers
> perform (even if they are implemented as top/bottom halves), I think the
> performance overhead of the two extra reads is vanishingly small.  In
> fact, I think that focusing on eliminating them is premature
> optimisation.  Developers are notoriously bad at identifying performance
> hotspots through visual inspection.
> 
> The point about the registers being volatile is important.  It's a C
> keyword for a very good reason.

Volatile as a keyword isn't especially useful for registers though,
since register IO tends to need various barriers as well, but anyway...

I do agree that it's likely best if the driver processes interrupts in
the priority order that the HW designers came up with. So, I'm open to
that change. This might make a difference to some time-critical
shortcuts like the PCM (audio) interrupt.
