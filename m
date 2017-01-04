From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 4 Jan 2017 12:27:58 +0100
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20170103093335.GA5605@leverpostej>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
 <CACRpkda2gdjM--LSoJTL0dvqyw796w1hMSAhUQwv9X0EPzJHig@mail.gmail.com>
 <20170102150015.GJ14217@n2100.armlinux.org.uk>
 <CACRpkdaxAPSU-XPQrgVRoBecAD1ZpVVP4qPe59af-yy11WqBQw@mail.gmail.com>
 <20170103093335.GA5605@leverpostej>
Message-ID: <20170104112758.cmehc4romofv3nbp@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-03 09:33:36 [+0000], Mark Rutland wrote:
> Hi,
Hi,

> It looked like DBGPRSR.SPD is set unexpectedly over the default idle
> path (i.e. WFI), causing the (otherwise valid) register accesses above
> to be handled as undefined.
> 
> I haven't looked at the patch in detail, but I guess that it allows idle
> to occur between reset_ctrl_regs() and arch_hw_breakpoint_init().

This could be possible. The callback is installed and the per-CPU thread
is woken up to handle it. It starts with the lowest CPU and loops for
all present CPUs. While waiting the thread to complete the callback, it
could go idle. See the for_each_present_cpu() loop in
__cpuhp_setup_state() and cpuhp_invoke_ap_callback() kicks the thread
(cpuhp_thread_fun()) and waits for its completion.
So the difference to on_each_cpu() is that the latter performs a busy
loop while waiting for function to complete on other CPUs.

> Reading DBGPRSR should clear SPD; but I'm not sure if other debug state
> is affected.
> 
> Thanks,
> Mark.

Sebastian
