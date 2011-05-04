From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 May 2011 22:47:50 -0700
Subject: [RFC PATCH 08/12] ARM: msm: use remapped PPI interrupts for	local
	timer
In-Reply-To: <20110503190422.GA14176@n2100.arm.linux.org.uk>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-9-git-send-email-marc.zyngier@arm.com>
	<4DB6FD50.9070907@codeaurora.org>
	<20110503190422.GA14176@n2100.arm.linux.org.uk>
Message-ID: <4DC0E886.3010709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/3/2011 12:04 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 26, 2011 at 10:13:52AM -0700, Stephen Boyd wrote:
>> Why do we need to call local_timer_setup() on each CPU up though? It
>> would be nice to be able to just add local timers for all possible CPUs
>> at boot time and then have the clockevents core take care of enabling
>> and disabling the events as appropriate without ARM code forcing the
>> events to be UNUSED and then re-adding the events back on CPU up. I'm
>> probably missing something really obvious here.
> Firstly, because you can't access the local timer registers from non-
> local CPUs.  Secondly, when you offline a CPU, generic code unregisters
> the local timer, so whenever you online a CPU you have to add its local
> timer clockevent back again.
>
> Thirdly, you may have a system where the local timer gets powered down
> when a CPU is offlined, and so it would need reinitialization when you
> online it again.

Ok that all sounds fine and good. Thanks.

I took a peek at the APB timer on x86 and I see that apbt_setup_irq()
does an

        if (system_state == SYSTEM_BOOTING) {
                if (request_irq(adev->irq, apbt_interrupt_handler,

which is probably exactly what we want to do to handle the crash I'm
talking about. They also do a memcpy() of the clockevent and what looks
like a disable_irq() on CPU_DEAD which might all be good ideas.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
