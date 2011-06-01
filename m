From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 17:01:44 +0100
Subject: [PATCH] arm: fix lockdep warning of "unannotated irqs-off"
In-Reply-To: <20110601235221.5aab9182@tom-ThinkPad-T410>
References: <20110601154259.12487694@tom-ThinkPad-T410>
	<20110601093436.GF3660@n2100.arm.linux.org.uk>
	<20110601211751.69b85eeb@tom-ThinkPad-T410>
	<20110601132233.GG3660@n2100.arm.linux.org.uk>
	<20110601222829.6eaad0e6@tom-ThinkPad-T410>
	<20110601144630.GL3660@n2100.arm.linux.org.uk>
	<20110601235221.5aab9182@tom-ThinkPad-T410>
Message-ID: <20110601160144.GN3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 11:52:21PM +0800, Ming Lei wrote:
> Except for tracing max time of irq disable, lock proving has to be
> supported if user needs it. So we should introduces the changes below
> into the patch:

No, you've completely missed the point: when we are not doing latency
analysis of IRQs-off regions, there is _no_ _point_ in telling the
kernel that IRQs are on while userspace is running - userspace will not
be taking any kernel locks itself.

So, the way things are setup at the moment on ARM, we "optimize" the
overhead of telling lockdep that IRQs are enabled while userspace is
running away _provided_ we are not doing IRQs-off latency tracing.
IOW, when CONFIG_IRQSOFF_TRACER is not set, we optimize away the
trace_hardirq_on call when entering userspace, and the trace_hardirq_off
call when leaving userspace.

I'm not sure why you're not grasping that, but I've explained it to you
several times in telling you that when CONFIG_IRQSOFF_TRACER is not set,
the kernel treats userspace as an IRQs-off region.
