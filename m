From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 10:22:16 +0000
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <4F0FF98D.9050308@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
 <20120111165508.GC1068@n2100.arm.linux.org.uk>
 <201201111827.18890.arnd.bergmann@linaro.org>
 <20120111194334.GF1068@n2100.arm.linux.org.uk> <4F0EF119.3000605@atmel.com>
 <20120112193639.GL1068@n2100.arm.linux.org.uk>
 <CAMXH7KEX+pMZvSnb5HHuMFaPbupSx+qCJkGtoDLTDkaboHCoMQ@mail.gmail.com>
 <4F0FF98D.9050308@linaro.org>
Message-ID: <20120113102216.GQ1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 10:29:49AM +0100, Daniel Lezcano wrote:
> I was asking me the same question. I am wondering if that makes sense to
> create an arch/arm/include/asm/pm.h file where we move from the system.h
> file these two functions:
> 
> extern void (*arm_pm_restart)(char str, const char *cmd);

Ideally, I want this one to go away - which it can do once its usage in
the AT91 code has been fixed up.  I don't know how to do that because
I don't know which machines/platforms end up with which SoCs.

The idea of exporting arm_pm_standby() is one I thought about, but I'm
not sure if it makes sense for all SoCs to call their standby function
from the CPU idle code.

I'm coming to the conclusion that moving the AT91 CPU idle driver out
of arch/arm/mach-at91 is the wrong thing to do - it seems that the CPU
idle driver is intimately linked to core AT91 code, and moving it out
just makes those linkages a lot more complicated to handle.  And for
what benefit - just to have this located under the drivers/ subtree
because it's now seen to be a driver ?

I think this is one of the times where the 'solution' is worse than the
problem.
