From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Jan 2013 15:34:02 +0000
Subject: [PATCH] ARM: smp: return from ipi_cpu_stop()
In-Reply-To: <CAO3366w39Cm0qZ1vtH+f9AZjbzoa0ycMfFJuWP5L4+j=6mq1PQ@mail.gmail.com>
References: <1357391123-759-1-git-send-email-ulrich.hecht@gmail.com>
 <20130105140958.GW2631@n2100.arm.linux.org.uk>
 <CAO3366w39Cm0qZ1vtH+f9AZjbzoa0ycMfFJuWP5L4+j=6mq1PQ@mail.gmail.com>
Message-ID: <20130105153402.GX2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 05, 2013 at 03:49:33PM +0100, Ulrich Hecht wrote:
> On Sat, Jan 5, 2013 at 3:09 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Plus, there's no guarantee what so ever that anything will happen in the
> > idle loop; this is not the _normal_ CPU shutdown path, this is the "oh
> > fsck, we need to stop all other CPUs because we panic'd" handler.
> 
> So who's job is it then to call cpu_die()? Because that's what doesn't
> happen and leaves the second core spinning, wrecking the kexec'd
> kernel.

There's been discussions about how kexec should be handled, and it's
still up in the air - mainly because this area has been left totally
open architecturally about how it should be handled.  Many platforms
don't provide any support what so ever for dealing with the secondary
CPUs once they've been woken up, which makes the problem of what to
do with a running CPU across a kexec event extremely difficult to
deal with.

There's an idea to call disable_nonboot_cpus() from machine_shutdown(),
but this results in that function being called multiple times by some
paths, such as the restart path.

This suffers from the problem that machine_restart() is called from
non-process contexts, which means that sleeping in _cpu_down() (called
via disable_nonboot_cpus()) really isn't allowable.

It's really a bitch of a problem; if we had somewhere to put the CPUs
(eg, back into the boot loader) for every platform, then we wouldn't
have a problem - unfortunately we don't know if we still have a boot
loader around once the kernel is running.

But alas, such foresight is rather lacking.

All the time that we have random different platforms going off and doing
totally random different things, we're going to constantly hit these
kinds of problems.  I don't think it's going to be long before these
cause such a problem that we basically say "no, we're not going to make
it work on platform X because platform X is just being stupid.  Get
with the program, work with the community and design something sensible
instead."
