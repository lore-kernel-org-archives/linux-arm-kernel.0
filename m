From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 May 2014 14:49:10 +0100
Subject: ARM: Disable preemption along with interrupts during shutdown
In-Reply-To: <1399555411-15330-1-git-send-email-arunks.linux@gmail.com>
References: <1399555411-15330-1-git-send-email-arunks.linux@gmail.com>
Message-ID: <20140508134910.GF3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 06:53:31PM +0530, arunks.linux at gmail.com wrote:
> From: Arun KS <arunks.linux@gmail.com>
> 
> 'irqs disabled' is funtamentally unsafe way of disabling preemption.
> Any spin_unlock() decreasing the preemption count to 0 might trigger
> a reschedule. A simple printk() might trigger a reschedule.
> 
> To be on safe side disable preemption as well using preempt_disable()

NAK.

asmlinkage void __sched notrace preempt_schedule(void)
{
        /*
         * If there is a non-zero preempt_count or interrupts are disabled,
         * we do not want to preempt the current task. Just return..
         */
        if (likely(!preemptible()))
                return;

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
