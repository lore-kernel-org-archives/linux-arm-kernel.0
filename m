From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Mar 2015 23:12:12 +0000
Subject: i.MX6 : all interrupts are only on the first CPU
In-Reply-To: <CAL8zT=gniU_J-7gVHa3C+FJU_CCMkbiK77-+57vTUjCXQt+KHQ@mail.gmail.com>
References: <CAL8zT=gniU_J-7gVHa3C+FJU_CCMkbiK77-+57vTUjCXQt+KHQ@mail.gmail.com>
Message-ID: <20150324231212.GV8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 01:52:56PM +0100, Jean-Michel Hautbois wrote:
> I am currently running a 4.0-rc1 on a custom board, and I am observing
> something strange, don't know if it is a known fact : all interrupts
> are fired on the same CPU :
...
> /proc/irq/default_smp_affinity -> 3
> 
> So, it should balance a bit between both CPUs, or am I
> misunderstanding something ?
> Maybe a configuration issue ?

Only the first CPU in an affinity setting gets the interrupt.  This is
because I found adding code to the kernel to explicitly distribute the
interrupts is not as easy as it sounds; there's a fair amount of policy
involved there, and policy is best left to userspace.

There's an irqbalance daemon (which is derived from an older x86 version)
which the SolidRun guys are using extensively to distribute interrupts
over the other iMX6 CPUs, which is born out of updates I made to the
version in Ubuntu 12.04.

I've been telling people for years to use irqbalanced, but it seems I've
been ignored... well, we now have one which is suitable for iMX6, but
only because I did the tiny bit of work to add a few strings to the x86
version. :)

If you're wondering where policy comes into it - sometimes, it's better
to leave an interrupt on the same CPU rather than rotating it between
CPUs, because you get better performance due to cache locality.  Things
that fall into this are things like network interrupts - so it makes
sense to distribute a number of network interrupts across different CPU
cores, but not rotate the network interrupts amongst the cores (which
would cause cache lines to also rotate.)

Also note that only the primary GIC interrupts can be distributed to
separate CPUs - downstream interrupt controllers of the GIC (eg, the
IPU) depend on the routing of the GIC interrupt to which they are
attached.  Only the top level interrupt controller can select the CPU
target.  The downstream IRQ controller CPU affinity is meaningless.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
