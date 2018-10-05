From: Nicolas.Cavallari@green-communications.fr (Nicolas Cavallari)
Date: Fri, 5 Oct 2018 10:27:48 +0200
Subject: [RFC 1/2] reboot: Make restart_handler_list a blocking notifier
 chain.
In-Reply-To: <20181004164911.GD30658@n2100.armlinux.org.uk>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
 <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
 <20181004164911.GD30658@n2100.armlinux.org.uk>
Message-ID: <211e71a4-57ce-2383-c74f-dfbfa053e4b7@green-communications.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2018 18:49, Russell King - ARM Linux wrote:
> This isn't going to work.
> 
> For example, sysrq processing (which can happen in IRQ context) calls
> emergency_restart() for the reboot sysrq.  That calls through to
> machine_restart(), which then calls do_kernel_restart().
>
> If do_kernel_restart() sleeps, then we're trying to sleep in IRQ
> context, and that's a no no.  I'm afraid you can't just add an irq
> enable and change the notifier list to be atomic - and, as you're
> making the change in generic code, this affects everyone, not just the
> architecture that happens to be in front of you (so if it were merged,
> you're likely to get a lot of bug reports!)

I don't get it.

Many implementations of machine_restart() sleeps or do an infinite loop.
Almost half of the restart_handler users sleeps or do an infinite loop.

I understand that sleeping in IRQ context is bad, but the kernel does it anyway.
And it seems nobody have noticed any problem with this.

The rn5t618 driver already does two I2C transfers in its restart handler.
Haven't anyone reported any problem about it ?

> It gets worse, because (eg) a panic() or IRQ can happen with any locks
> held - and if the I2C device's locks are held when one of those events
> happen, you have a deadlock situation (hence you won't reboot!)
> 
> I suppose a good first step would be for us to have our own
> machine_emergency_restart() on ARM, to separate the atomic paths
> from the non-atomic paths, so that those who need to talk to an I2C,
> that can happen from the non-atomic path (which means things like
> /sbin/reboot will work) but other stuff (eg, restart on panic, sysrq,
> soft-watchdog) will fail.

That would fix my use case, but not the existing code ?
