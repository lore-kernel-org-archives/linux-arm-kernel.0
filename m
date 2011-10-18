From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Oct 2011 18:37:44 +0100
Subject: Warning at kernel/mutex.c
In-Reply-To: <CAOMZO5AR4iiktjmjzUU3AbQmYVk4wE28+KrZckt=VXLBJzXdBA@mail.gmail.com>
References: <CAOMZO5AR4iiktjmjzUU3AbQmYVk4wE28+KrZckt=VXLBJzXdBA@mail.gmail.com>
Message-ID: <20111018173744.GQ21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 02:43:27PM -0200, Fabio Estevam wrote:
> Hi,
> 
> I am running 3.1-rc10 kernel built with mxs_defconfig on a MX28EVK
> board and I am getting the following:
> 
> [    0.200000] Switching to clocksource mxs_timer
> [    0.220000] Switched to NOHz mode on CPU #0
> [    0.220000] ------------[ cut here ]------------
> [    0.220000] WARNING: at kernel/mutex.c:198 mutex_lock_nested+0x260/0x29c()
> [    0.220000] Modules linked in:
> [    0.220000] [<c0014478>] (unwind_backtrace+0x0/0xf4) from
> [<c002630c>] (warn_slowpath_common+0x4c/0x64)
> [    0.220000] [<c002630c>] (warn_slowpath_common+0x4c/0x64) from
> [<c0026340>] (warn_slowpath_null+0x1c/0x24)
> [    0.220000] [<c0026340>] (warn_slowpath_null+0x1c/0x24) from
> [<c02957cc>] (mutex_lock_nested+0x260/0x29c)
> [    0.220000] [<c02957cc>] (mutex_lock_nested+0x260/0x29c) from
> [<c0018580>] (clk_enable+0x2c/0x4c)
> [    0.220000] [<c0018580>] (clk_enable+0x2c/0x4c) from [<c01cd9e0>]
> (pl011_console_write+0x20/0x78)

clk_enable() shouldn't be taking a mutex because drivers can _and_ do
call it from non-schedulable contexts.  Unfortunately, some clk_enable
implementations do use a mutex.

We have a transition path for this, discussed quite a while ago -
introducing clk_prepare() to do the slow bits of enabling a clock,
leaving clk_enable() for the fast stuff.
