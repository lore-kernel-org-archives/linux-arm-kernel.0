From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 Dec 2015 12:03:29 +0100
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <alpine.DEB.2.11.1511131509180.3987@nanos>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <alpine.DEB.2.11.1510202121590.8159@nanos>
 <20151111092638.587a53a4@free-electrons.com>
 <alpine.DEB.2.11.1511131509180.3987@nanos>
Message-ID: <20151204120329.30a52cf4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Fri, 13 Nov 2015 15:11:16 -0500 (EST), Thomas Gleixner wrote:

> On Wed, 11 Nov 2015, Thomas Petazzoni wrote:
> > Have you had the time to consider the proposed solution? For 4.3 we
> > implemented the quick work-around that consisted in clearing
> > IRQ_NOAUTOEN, but it's probably not a very good long-term solution.
> > 
> > Don't hesitate to let me know if you'd like to see some modifications
> > to the proposed approach, or if you have a totally different approach
> > in mind.
> 
> I'm not sure if we really need all that muck if we can just rely on
> that flag. I don't see the extra value, but you might have something
> in mind which does not jump into my face right now.

Well, the problem is that IRQ_NOAUTOEN is a global flag, which is OK
for global interrupts, but not good for per-CPU interrupts, since you
don't have the information on a per-CPU basis of which interrupt was
enabled before suspend, and therefore should be re-enabled after resume.

Until now, we don't have the problem since the only per-CPU interrupt
we were using was the local timer interrupt, and the local timers on
secondary CPUs are switched off during suspend and re-enabled during
resume. So re-enabling the interrupt on the boot CPU on resume is
sufficient.

However, our network driver recently switched to using per-CPU
interrupts as well, and in this case, it is really important to be able
to re-enable the per-CPU interrupts and the appropriate CPUs at resume
time. Since our HW registers are made so that it is not possible to
read out at suspend time which interrupts are enabled, we have to ask
the Linux kernel at resume time which interrupts should be re-enabled
at the HW level. Which is what my more complicated series was doing.

Do you have other suggestions to allow us to know which per-CPU
interrupts should be re-enabled on the different CPUs at resume time ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
