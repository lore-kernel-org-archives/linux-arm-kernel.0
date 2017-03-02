From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Mar 2017 09:45:33 +0100
Subject: [PATCHv2 net-next 10/16] net: mvpp2: handle register mapping
 and access for PPv2.2
In-Reply-To: <20170106144648.GE14217@n2100.armlinux.org.uk>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170106144648.GE14217@n2100.armlinux.org.uk>
Message-ID: <20170302094533.5e6dfe93@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 6 Jan 2017 14:46:48 +0000, Russell King - ARM Linux wrote:

> I'm not entirely sure this is the best solution - every register access
> will be wrapped with a preempt_disable() and preempt_enable().  At
> every site, when preempt is enabled, we will end up with code to:
> 
> - get the thread info
> - increment the preempt count
> - access the register
> - decrement the preempt count
> - test resulting preempt count and branch to __preempt_schedule()
> 
> If tracing is enabled, it gets much worse, because the increment and
> decrement happen out of line, and are even more expensive.
> 
> If a function is going to make several register accesses, it's going
> to be much more efficient to do:
> 
> 	void __iomem *base = priv->cpu_base[get_cpu()];
> 
> 	...
> 
> 	put_cpu();
> 
> which means we don't end up with multiple instances of the preempt code
> consecutive accesses.

In the next version, these accessors have been reworked. After getting
more details about the HW, it turned out that disabling preemption is
not at all necessary. We just have some global registers (can be
accessed through any per-CPU window) and some per-CPU registers (must
be accessed from a specific per-CPU window), with the trick that
certain sequences of register read/write must occur from the same
per-CPU window.

So we'll have mvpp2_{read,write} that read/write through the register
window of CPU0, used for all non-per CPU register accesses. And we'll
have mvpp2_percpu_{read,write}, taking an additional "cpu" argument,
used for per-CPU register accesses. Thanks to "cpu" being passed as
argument, the caller can ensure the same cpu window is used to do
several reads/writes in a row.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
