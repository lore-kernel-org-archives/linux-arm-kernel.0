From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 17:00:51 +0100
Subject: [PATCH for 3.9-rc] arm: mvebu: Use local interrupt only for the
 timer 0
In-Reply-To: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
References: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130326170051.4882c730@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew,

On Wed, 20 Mar 2013 16:09:35 +0100, Gregory CLEMENT wrote:
> The commit 3a6f08a37 "arm: mvebu: Add support for local interrupt",
> managed the 28th first interrupts as local interrupt to match the
> hardware specification. Among these interrupts there are the Gigabits
> Ethernet ones used by the mvneta driver. Unfortunately the state of
> the percpu_irq API prevents the driver to use it.
> 
> Indeed the interrupts have to be freed when the .stop() function is
> called. As the free_percpu_irq() function don't disable the interrupt
> line, we have to do it on each CPU before calling this. The function
> disable_percpu_irq() only disable the percpu on the current CPU and
> there is no function which allows to disable a percpu irq on a given
> CPU. Waiting for the extension of the percpu_irq API, this fix allows
> to use again the mvneta driver.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Would it be possible to get this commit pushed for 3.9-rc? Without it,
the Marvell Armada 370/XP network interfaces are completely broken. The
patch has been sent almost a week ago, and has received Tested-by from
Ryan Press, Masami Hiramatsu and myself.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
