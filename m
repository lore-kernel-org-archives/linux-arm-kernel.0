From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jan 2010 13:47:23 +0000
Subject: ioctl() returns EFAULT / MMU domain problem?
In-Reply-To: <ac4446ac1001180535u299fa2f8rc2fdb3317a566066@mail.gmail.com>
References: <ac4446ac1001180535u299fa2f8rc2fdb3317a566066@mail.gmail.com>
Message-ID: <20100118134723.GA2695@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 10:35:26PM +0900, Koyo Takenoshita wrote:
> I think that the problem is that there is a possibility of schedule
> while doing set_fs(KERNEL_DS) and copy_to_user.

The domain register setting is stored in the per-thread cpu_domain
variable (current_thread_info()->cpu_domain).  set_fs() modifies
this according to KERNEL_DS vs USER_DS.

On context switches, the domain register is reloaded from cpu_domain,
so it will be preserved across context switches for the same thread;
if it wasn't, kernel boot wouldn't work (because the kernel boot uses
KERNEL_DS to be able to call execve(), open(), etc.)
