From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Dec 2015 09:58:35 +0100
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <alpine.DEB.2.11.1512061018450.3595@nanos>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <alpine.DEB.2.11.1510202121590.8159@nanos>
 <20151111092638.587a53a4@free-electrons.com>
 <alpine.DEB.2.11.1511131509180.3987@nanos>
 <20151204120329.30a52cf4@free-electrons.com>
 <alpine.DEB.2.11.1512051823140.3595@nanos>
 <alpine.DEB.2.11.1512061018450.3595@nanos>
Message-ID: <20151208095835.582dc34b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Sun, 6 Dec 2015 10:28:15 +0100 (CET), Thomas Gleixner wrote:

> Second thoughts. That network driver example does not make sense.
> 
> You have a suspend/resume mechanism and a cpu hotplug machinery in
> that driver, right? So that should be responsible for
> disabling/enabling the per cpu interrupts. I don't think it's the
> proper way to do that in the irq chip driver at some random point
> during resume as you'd reenable interrupts on cpus which are not
> online yet.

The irqchip driver would re-enable the per-CPU interrupts in a CPU
notifier, so only when the secondary CPUs come online again after
resume.

When a device driver uses a normal (non per-CPU) interrupt, then it
doesn't have to take care of disabling the interrupt on suspend and
re-enabling the interrupt on resume at the interrupt controller level.
This is all transparently handled by the irqchip driver.

Why should the handling of per-CPU interrupts be different and require
explicit handling from each device driver rather than being
transparently handled by the irqchip driver ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
