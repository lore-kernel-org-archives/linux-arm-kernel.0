From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Feb 2012 09:59:55 +0000
Subject: [PATCH] hotplug: eliminate warning "Unknown IPI message 0x1"
In-Reply-To: <1328866073-14769-2-git-send-email-bill4carson@gmail.com>
References: <1328866073-14769-1-git-send-email-bill4carson@gmail.com>
 <1328866073-14769-2-git-send-email-bill4carson@gmail.com>
Message-ID: <20120210095955.GT889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 05:27:53PM +0800, Bill Carson wrote:
> When playing hotplug on vexpress board, a tiny warning pops out.
> 
> /sys/devices/system/cpu # echo 0 > cpu3/online
> CPU3: shutdown
> /sys/devices/system/cpu # echo 1 > cpu3/online
> CPU3: Booted secondary processor
> Calibrating delay loop (skipped) already calibrated this CPU
> CPU3: Unknown IPI message 0x1
>       ^^^^^^^
> It's a phony warning caused by handle_IPI as a result of calling
> gic_raise_softirq(cpumask_of(cpu), 1). Introducing a new ipi_msg_type
> IPI_WAKEUP_CPU to make this warning go away.

NAK.  I want people to move to SGI0 for this, so that we can have SGI1-N
as the proper IPIs.  The reason _I_ haven't done this is because it's
totally unclear whether anyone relies on the current IPI number.
