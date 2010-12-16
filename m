From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 11:34:07 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
Message-ID: <20101216113407.GO9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 05:45:13PM -0600, Andrei Warkentin wrote:
> This is my first time on linux-arm-kernel, and while I've read the
> FAQ, hopefully I don't screw up too badly :).
> 
> Anyway, we're on a dual-core ARMv7 running 2.6.36, and during
> stability stress testing saw the following:
> 1) After a number hotplug iterations, CPU1 fails to set its online bit
> quickly enough and __cpu_up() times-out.
> 2) CPU1 eventually completes its startup and sets the bit, however,
> since _cpu_up() failed, CPU1's active bit is never set.

Why is your CPU taking soo long to come up?  We wait one second in the
generic code, which is the time taken from the platform code being happy
that it has successfully started the CPU.  Normally, platforms wait an
additional second to detect the CPU entering the kernel.

> 2) Additionally I ensure that if the CPU comes up later than it were
> supposed to (shouldn't, but...), then it will not start initializing
> behind cpu_up's back (which is not really undoable). This solves the
> problem with both cpu_up+secondary_start_kernel races and with
> platform_cpu_kill+secondary_start_kernel races.

Why would you have platform_cpu_kill() running at the same time - firstly,
hotplug events are serialized, and secondly the platform_cpu_kill() path
should wait up to five seconds for the CPU to go offline.  If it doesn't
go offline within five seconds it's dead (and maybe we should mark it
not present.)
