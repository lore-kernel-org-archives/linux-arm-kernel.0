From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Mar 2010 16:49:26 +0000
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
In-Reply-To: <000f01cabfa6$76951ac0$63bf5040$@deacon@arm.com>
References: <1268150768-6597-1-git-send-email-will.deacon@arm.com>
	<20100309162202.GB17251@n2100.arm.linux.org.uk>
	<000f01cabfa6$76951ac0$63bf5040$@deacon@arm.com>
Message-ID: <20100309164926.GC17251@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 04:35:00PM -0000, Will Deacon wrote:
> Hi Russell,
> 
> > On Tue, Mar 09, 2010 at 04:06:08PM +0000, Will Deacon wrote:
> > > The cpu_relax() macro is often used in the body of busy-wait loops to ensure
> > > that the variable being spun on is re-loaded for each iteration.
> > 
> > No, cpu_relax() exists to avoid x86 CPUs overheating - if you spin like
> > so:
> > 
> > 	for(;;);
> > 
> > the CPU will overheat, so it's conventional to write:
> > 
> > 	for(;;)
> > 		cpu_relax();
> > 
> > so that architectures can prevent those kinds of problems occuring.
> 
> Ok. I was going by the comments in Documentation/volatile-considered-harmful.txt
> where cpu_relax() is also used as a memory barrier.

I thought you might; I've just submitted a patch for that to akpm, lkml
and linux-arch.

> In the KGDB case [where this cropped up], if cpu_relax() is left as it is, then
> an smp_mb() is required in the architecture independent code. This also seems wrong
> because it's only needed for the ARM11MPCore. There may also potentially be other
> situations in the Kernel which are prone to deadlock because it is assumed that the
> write buffer will always drain.

Why is KGDB being special about this?  Ah yes, it's being brain dead:

static atomic_t                 passive_cpu_wait[NR_CPUS];
static atomic_t                 cpu_in_kgdb[NR_CPUS];

        while (atomic_read(&passive_cpu_wait[cpu]))
                cpu_relax();

                for (i = 0; i < NR_CPUS; i++)
                        atomic_set(&passive_cpu_wait[i], 1);

                for (i = NR_CPUS-1; i >= 0; i--)
                        atomic_set(&passive_cpu_wait[i], 0);

        atomic_set(&cpu_in_kgdb[cpu], 1);

        atomic_set(&cpu_in_kgdb[cpu], 0);

        atomic_set(&cpu_in_kgdb[ks->cpu], 1);

        for_each_online_cpu(i) {
                while (!atomic_read(&cpu_in_kgdb[i]))
                        cpu_relax();
        }

        atomic_set(&cpu_in_kgdb[ks->cpu], 0);

                for_each_online_cpu(i) {
                        while (atomic_read(&cpu_in_kgdb[i]))
                                cpu_relax();
                }

        if (!atomic_read(&cpu_in_kgdb[cpu]) &&
                        atomic_read(&kgdb_active) != cpu &&
                        atomic_read(&cpu_in_kgdb[atomic_read(&kgdb_active)])) {

None of the above is atomic in any way, and I suspect that all these
places in kernel/kgdb.c are buggy.  As I've said in the past, just
because something is called 'atomic' does not make it so:

On atomic_set():
  The setting is atomic in that the return values of the atomic operations by
  all threads are guaranteed to be correct reflecting either the value that has
  been set with this operation or set with another operation.  A proper implicit
  or explicit memory barrier is needed before the value set with the operation
  is guaranteed to be readable with atomic_read from another thread.

On atomic_read():
  The read is atomic in that the return value is guaranteed to be one of the
  values initialized or modified with the interface operations if a proper
  implicit or explicit memory barrier is used after possible runtime
  initialization by any other thread and the value is modified only with the
  interface operations.  atomic_read does not guarantee that the runtime
  initialization by any other thread is visible yet, so the user of the
  interface must take care of that with a proper implicit or explicit memory
  barrier.

Clearly, kgdb is using atomic_set()/atomic_read() in a way which does not
match this documentation - it's certainly missing the barriers as required
by the above quoted paragraphs.

Let me repeat: atomic_set() and atomic_read() are NOT atomic.  There's
nothing atomic about them.  All they do is provide a pair of accessors
to the underlying value in the atomic type.  They are no different to
declaring a volatile int and reading/writing it directly.
