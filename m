From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Dec 2010 17:14:26 +0000
Subject: [PATCH v2] [ARM] gic: Unmask private interrupts on all cores
	during IRQ enable
In-Reply-To: <4CF6797A.2010807@codeaurora.org>
References: <1288820762-16077-1-git-send-email-scaudle@codeaurora.org>
	<20101130180718.GB8521@n2100.arm.linux.org.uk>
	<4CF6797A.2010807@codeaurora.org>
Message-ID: <20101201171425.GA29347@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 11:36:10AM -0500, Stephen Caudle wrote:
> On 11/30/2010 01:07 PM, Russell King - ARM Linux wrote:
>> Sorry, missed this.
>>
>> If it's a private peripheral, it can only be accessed from its associated
>> CPU.  What that means is you don't want to enable the interrupt on other
>> CPUs as the peripheral may not be present or initialized on that CPU.
>
> Understood.  But the alternative is to require all code that requests a  
> PPI to have to enable the IRQ on the other cores.  This seems  
> unreasonable to me.

It is also unreasonable to have one core enabling the PPI on other
cores where the hardware behind the interrupt may not have been
initialized yet.  If it is a private interrupt for a private peripheral,
then only the associated CPU should be enabling that interrupt.

I guess this is something which genirq can't cope with, in which case
either genirq needs to be modified to cope with private CPU interrupts,
which are controlled individually by their associated CPU, or we need a
private interface to support this.
