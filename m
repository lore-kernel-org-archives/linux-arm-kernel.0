From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Oct 2013 15:51:31 -0400 (EDT)
Subject: [PATCH 3/6] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <20131002125458.GA3407@localhost.localdomain>
References: <1380644227-12244-1-git-send-email-v.tyrtov@samsung.com>
 <1380644227-12244-4-git-send-email-v.tyrtov@samsung.com>
 <20131002125458.GA3407@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1310041543090.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Oct 2013, Dave Martin wrote:

> On Tue, Oct 01, 2013 at 08:17:04PM +0400, Vyacheslav Tyrtov wrote:
> > +static int exynos_power_up(unsigned int cpu, unsigned int cluster)
> > +{
> > +     int ret;
> > +     local_irq_disable();
> 
> Should there be a local_fiq_disable() here also?

No.  In fact this is paired with

> > +     arch_spin_lock(&exynos_lock);

to create the equivalent of a arch_spin_lock_irq().  And the reason is:

/*
 * We can't use regular spinlocks. In the switcher case, it is possible
 * for an outbound CPU to call power_down() after its inbound counterpart
 * is already live using the same logical CPU number which trips lockdep
 * debugging.
 */

Otherwise we simply would have used spin_lock_irq().

No FIQs are supposed to ever race with this code.


Nicolas
