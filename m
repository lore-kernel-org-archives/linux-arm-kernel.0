From: scaudle@codeaurora.org (Stephen Caudle)
Date: Thu, 09 Dec 2010 11:24:19 -0500
Subject: [PATCH v2] [ARM] gic: Unmask private interrupts on all cores
	during IRQ enable
In-Reply-To: <20101201171425.GA29347@n2100.arm.linux.org.uk>
References: <1288820762-16077-1-git-send-email-scaudle@codeaurora.org>
	<20101130180718.GB8521@n2100.arm.linux.org.uk>
	<4CF6797A.2010807@codeaurora.org>
	<20101201171425.GA29347@n2100.arm.linux.org.uk>
Message-ID: <4D0102B3.8010302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2010 12:14 PM, Russell King - ARM Linux wrote:
> On Wed, Dec 01, 2010 at 11:36:10AM -0500, Stephen Caudle wrote:
>> On 11/30/2010 01:07 PM, Russell King - ARM Linux wrote:
>>> Sorry, missed this.
>>>
>>> If it's a private peripheral, it can only be accessed from its associated
>>> CPU.  What that means is you don't want to enable the interrupt on other
>>> CPUs as the peripheral may not be present or initialized on that CPU.
>>
>> Understood.  But the alternative is to require all code that requests a  
>> PPI to have to enable the IRQ on the other cores.  This seems  
>> unreasonable to me.
> 
> It is also unreasonable to have one core enabling the PPI on other
> cores where the hardware behind the interrupt may not have been
> initialized yet.  If it is a private interrupt for a private peripheral,
> then only the associated CPU should be enabling that interrupt.
> 
> I guess this is something which genirq can't cope with, in which case
> either genirq needs to be modified to cope with private CPU interrupts,
> which are controlled individually by their associated CPU, or we need a
> private interface to support this.

I see your point.  Our immediate need for this is to support a
performance monitor interrupt that happens to be a PPI.  It is used by
perf events (and subsequently, oprofile).

Since PPIs are so machine-specific, I started looking into patching
perf_events.c by adding a machine specific function to handle the PMU
IRQ request.  For mach-msm, we would call request_irq like normal, but
also unmask the performance monitor interrupt on the other cores.  The
downside to this is that a machine specific implementation would be
needed anytime a PPI is requested, not just in perf_events.c.

Then, I saw Thomas' email regarding our local timer PPI:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/033840.html.

Russell, before I submit another patch, I would like to know if you
prefer a more generic approach like Thomas suggests, or a
machine-specific approach like I have described?

Thanks,
Stephen

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
