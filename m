From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Dec 2011 20:38:28 +0000
Subject: [PATCH v2 01/15] ARM: local timers: allow smp_twd to be used
 standalone
In-Reply-To: <1324574865-5367-2-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <1324574865-5367-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20111222203828.GP2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 05:27:31PM +0000, Marc Zyngier wrote:
> +	twd_clock_event	= alloc_percpu(struct clock_event_device);
> +	if (!twd_base || !twd_clock_event) {
> +		iounmap(twd_base);
> +		twd_base = NULL;
> +		free_percpu(twd_clock_event);
> +		return -ENOMEM;
> +	}
> +
> +	/* Immediately configure the timer on the boot CPU */
> +	clk = per_cpu_ptr(twd_clock_event, smp_processor_id());
> +	twd_setup(clk);

This is insufficient.  A proper local timer has this:

	evt->cpumask = cpumask_of(cpu);
	evt->broadcast = smp_timer_broadcast;

as well as all the rest of the normal clock event stuff.  The broadcast
callback is used when the timer core wants to broadcast the timer tick
to other CPUs - see tick_do_broadcast() in kernel/time/tick-broadcast.c.
The selection of which clock event device to use is rather 'optimized'
for current conditions, and registering local timers without this is
likely to oops the kernel at some point.

I don't think you can register separate clock event devices for use as
the broadcast device vs the local timer device.

So, either you _have_ to use the SMP supplied version, or we make the
broadcast function public and have everyone conditionally set that up,
or something else... either way this is getting exceedingly messy.

That's why I believe it's far simpler to just say no to using twd as a
global timer, and just keep it for SMP local timer purposes.
