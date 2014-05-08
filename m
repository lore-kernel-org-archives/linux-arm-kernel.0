From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 May 2014 16:22:20 +0100
Subject: ARM: Disable preemption along with interrupts during shutdown
In-Reply-To: <CAKZGPAMwqWP44Cv7V11Q+8Ykdt=3huFCRi-eKKSt5d9zPp8H+w@mail.gmail.com>
References: <1399555411-15330-1-git-send-email-arunks.linux@gmail.com>
 <20140508134910.GF3693@n2100.arm.linux.org.uk>
 <CAKZGPAMwqWP44Cv7V11Q+8Ykdt=3huFCRi-eKKSt5d9zPp8H+w@mail.gmail.com>
Message-ID: <20140508152220.GG3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 07:46:21PM +0530, Arun KS wrote:
> What if we fall in a path which calls spin_unlock_irq().
> Interrupts will get enabled and only preempt_count will help to bail
> out early from preempt_schedule().
> I recently hit a similar situation.

Use of spin_lock_irq()..spin_unlock_irq() in code which was entered with
interrupts already disabled is a bug in itself.

Papering over it with preempt_disable() is not an option.  /Always/ fix
the real problem, never paper over stuff like this.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
