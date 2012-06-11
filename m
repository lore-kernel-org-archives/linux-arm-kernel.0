From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jun 2012 19:26:40 +0100
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
Message-ID: <20120611182640.GC18267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 01:18:28PM -0400, Nicolas Pitre wrote:
> And that message certainly has to go as it may be triggered multiple 
> times per second in some use cases here.

That, I interpret, as an attempt to use CPU hotplugging for power
saving.

No.  Do not do that.  Under any circumstances.  Not only is the CPU
hotplugging code racy in places, it also totally destroys the ability
to have threads bound to CPUs, or even interrupts to CPUs.

It's also racy with userspace.  Think of an application which wants to
know how many CPUs are online to create a number of threads, then you
take a CPU offline.  There's no way for it to be notified about that.
Or, conversely you bring a CPU online.  Again, no way for userspace to
be properly notified.

Then there's issues with reading /proc/interrupts while CPUs come and
go, especially when you have large numbers of interrupts which have to
be read across multiple reads.

Then there's all the driver model events sent into userspace when the
sysfs nodes for CPUs come and go.

So no, I'd point out that the message you get is the _least_ of your
problems if you're playing this idiotic game.  Don't do it.  Use CPU
idle instead.  That's what it's there for.
