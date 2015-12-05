From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 5 Dec 2015 18:24:31 +0100 (CET)
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <20151204120329.30a52cf4@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <alpine.DEB.2.11.1510202121590.8159@nanos>
 <20151111092638.587a53a4@free-electrons.com>
 <alpine.DEB.2.11.1511131509180.3987@nanos>
 <20151204120329.30a52cf4@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1512051823140.3595@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Fri, 4 Dec 2015, Thomas Petazzoni wrote:
> Well, the problem is that IRQ_NOAUTOEN is a global flag, which is OK
> for global interrupts, but not good for per-CPU interrupts, since you
> don't have the information on a per-CPU basis of which interrupt was
> enabled before suspend, and therefore should be re-enabled after resume.
> 
> Until now, we don't have the problem since the only per-CPU interrupt
> we were using was the local timer interrupt, and the local timers on
> secondary CPUs are switched off during suspend and re-enabled during
> resume. So re-enabling the interrupt on the boot CPU on resume is
> sufficient.
> 
> However, our network driver recently switched to using per-CPU
> interrupts as well, and in this case, it is really important to be able
> to re-enable the per-CPU interrupts and the appropriate CPUs at resume
> time. Since our HW registers are made so that it is not possible to
> read out at suspend time which interrupts are enabled, we have to ask
> the Linux kernel at resume time which interrupts should be re-enabled
> at the HW level. Which is what my more complicated series was doing.
> 
> Do you have other suggestions to allow us to know which per-CPU
> interrupts should be re-enabled on the different CPUs at resume time ?

Ok. That makes sense. So I'm going to pick up the core change.

Thanks,

	tglx
