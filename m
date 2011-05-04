From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed, 04 May 2011 11:45:23 -0700
Subject: [RFC PATCH 08/12] ARM: msm: use remapped PPI interrupts for	local
	timer
In-Reply-To: <4DC0E886.3010709@codeaurora.org>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>	<1303326501-15664-9-git-send-email-marc.zyngier@arm.com>	<4DB6FD50.9070907@codeaurora.org>	<20110503190422.GA14176@n2100.arm.linux.org.uk>
	<4DC0E886.3010709@codeaurora.org>
Message-ID: <4DC19EC3.2070702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd wrote:
> 
> I took a peek at the APB timer on x86 and I see that apbt_setup_irq()
> does an
> 
>         if (system_state == SYSTEM_BOOTING) {
>                 if (request_irq(adev->irq, apbt_interrupt_handler,
> 
> which is probably exactly what we want to do to handle the crash I'm
> talking about.
> 

This won't work right with the maxcpus commandline option set to
something lower than the number of cpus present on the system. This
option controls how many cpus the system tries to bring up during boot,
while still allowing one to hotplug the rest of them later. If you do
hotplug them later, system_state will no longer be SYSTEM_BOOTING, and
this code won't do what it needs to do.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
