From: andreiw@motorola.com (Andrei Warkentin)
Date: Sat, 18 Dec 2010 01:17:34 -0600
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <20101218000828.GG9937@n2100.arm.linux.org.uk>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101216232849.GY9937@n2100.arm.linux.org.uk>
	<AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
	<20101217231449.GF9937@n2100.arm.linux.org.uk>
	<AANLkTi=-foyb9c5F4tFpGK6KzQnP9htJW8GwYoUHVK0r@mail.gmail.com>
	<20101218000828.GG9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinSg+iCGM64iQqLn32Wjpta_87=HWuG==KJ9-eW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 6:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 17, 2010 at 05:45:09PM -0600, Andrei Warkentin wrote:
>> On Fri, Dec 17, 2010 at 5:14 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Dec 17, 2010 at 02:52:29PM -0600, Andrei Warkentin wrote:
>> >> On Thu, Dec 16, 2010 at 5:28 PM, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >> > On Thu, Dec 16, 2010 at 05:09:48PM -0600, Andrei Warkentin wrote:
>> >> >> On Thu, Dec 16, 2010 at 5:34 AM, Russell King - ARM Linux
>> >> >> <linux@arm.linux.org.uk> wrote:
>> >> >> >
>> >> >> > On Wed, Dec 15, 2010 at 05:45:13PM -0600, Andrei Warkentin wrote:
>> >> >> > > This is my first time on linux-arm-kernel, and while I've read the
>> >> >> > > FAQ, hopefully I don't screw up too badly :).
>> >> >> > >
>> >> >> > > Anyway, we're on a dual-core ARMv7 running 2.6.36, and during
>> >> >> > > stability stress testing saw the following:
>> >> >> > > 1) After a number hotplug iterations, CPU1 fails to set its online bit
>> >> >> > > quickly enough and __cpu_up() times-out.
>> >> >> > > 2) CPU1 eventually completes its startup and sets the bit, however,
>> >> >> > > since _cpu_up() failed, CPU1's active bit is never set.
>> >> >> >
>> >> >> > Why is your CPU taking soo long to come up? ?We wait one second in the
>> >> >> > generic code, which is the time taken from the platform code being happy
>> >> >> > that it has successfully started the CPU. ?Normally, platforms wait an
>> >> >> > additional second to detect the CPU entering the kernel.
>> >> >>
>> >> >> It seems twd_calibrate_rate is the culprit (although in our case,
>> >> >> since the clock is the same to both CPUs, there is no point in
>> >> >> calibrating).
>> >> >
>> >> > twd_calibrate_rate() should only run once at boot. ?Once it's run,
>> >> > taking CPUs offline and back online should not cause the rate to be
>> >> > recalibrated.
>> >>
>> >> Let's me just see if I understand things correctly for the hotplug case.
>> >>
>> >> 1) cpu_down calls take_down_cpu
>> >> 2) Idle thread on secondary notices cpu_is_offline, and calls cpu_die()
>> >> 3) cpu_die calls platform_cpu_die, at which point the cpu is dead.
>> >
>> > Correct so far.
>> >
>> >> If it ever wakes up (because of a cpu_up), it will continue to run in
>> >> cpu_die.
>> >
>> > That depends what you have in your cpu_die(). ?If you return from
>> > cpu_die() then we assume that is because you have been woken up, and
>> > so we re-initialize the CPU.
>> >
>>
>> That's correct. Same applies to us. When we wake up a CPU, it is going
>> to return back to cpu_die, and then call secondary startup to join the
>> rest.
>
> However, your writel() is not guaranteed to take effect at the point in
> time that you issue it. ?You're programming a weakly ordered architecture,
> you need to be aware that things don't happen at the point in time that
> they appear in the program, or sometimes even in the order that you put
> them in the program. ?(See below.)
>
>> > That's because existing hotplug implementations don't have the necessary
>> > support hardware to reset just one CPU, and the only way to bring a CPU
>> > back online is to jump back to the secondary startup.
>> >
>> >> 4) cpu_die jump to secondary_start_kernel.
>> >
>> > This is for dumb implementations. ?If your code takes the CPU offline via
>> > hardware means, then you must _never_ return from cpu_die(), even if the
>> > hardware fails to take the CPU offline. ?I suspect this is where your
>> > problem lies.
>> >
>>
>> No, we don't have a problem shutting cores down. We gate the clock and
>> set the reset line, but when it comes back up all state will be
>> restored as it were prior to the getting turned off, so it can be
>> resumed back properly.
>>
>>
>> >> 5) secondary_start_kernel calls percpu_timer_setup
>> >> 6) ?percpu_timer_setup calls platform local_timer_setup
>> >> 7) local_timer_setup calls twd_timer_setup_scalable
>> >>
>> >> ...which calls __twd_timer_setup, which does twd_calibrate_rate among
>> >> other things.
>> >
>> > Again, correct, and this is where you claimed that excessive time was
>> > being spent. ?Looking at twd_calibrate_rate(), it has this:
>> >
>> > ? ? ? ?if (twd_timer_rate == 0) {
>> > ? ? ? ? ? ? ? ?printk(KERN_INFO "Calibrating local timer... ");
>> > ...
>> > ? ? ? ? ? ? ? ?twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
>> >
>> > ? ? ? ? ? ? ? ?printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
>> > ? ? ? ? ? ? ? ? ? ? ? ?(twd_timer_rate / 100000) % 100);
>> > ? ? ? ?}
>> >
>> > which, on the first and _only_ first pass through, initializes
>> > twd_timer_rate. ?Because on hotplug cpu-up the timer rate has already
>> > been calibrated, we won't re-run the calibration, and we won't spend
>> > lots of time here.
>> >
>>
>> Sorry, I feel like a moron. Didn't realize that in our codebase there
>> is a change explicitly always doing the calibration.
>> I'll see if this is necessary.
>>
>> This still doesn't explain why the ARM SMP code shouldn't be more
>> resilient (i.e. secondary startup doesn't do anything unless __cpu_up
>> wants it to)
>>
>> >> #ifdef CONFIG_HOTPLUG_CPU
>> >> static DEFINE_PER_CPU(struct completion, cpu_killed);
>> >> extern void tegra_hotplug_startup(void);
>> >> #endif
>> >
>> > You do not need cpu_killed to be a per-cpu thing. ?The locking in
>> > cpu_up() and cpu_down() ensures that you can not take more than one
>> > CPU up or down concurrently. ?See cpu_maps_update_begin() which
>> > acquires the lock, and cpu_maps_update_done() which drops the lock.
>> >
>> >> static DECLARE_BITMAP(cpu_init_bits, CONFIG_NR_CPUS) __read_mostly;
>> >> const struct cpumask *const cpu_init_mask = to_cpumask(cpu_init_bits);
>> >> #define cpu_init_map (*(cpumask_t *)cpu_init_mask)
>> >>
>> >> #define EVP_CPU_RESET_VECTOR \
>> >> ? ? ? (IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
>> >> #define CLK_RST_CONTROLLER_CLK_CPU_CMPLX \
>> >> ? ? ? (IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x4c)
>> >> #define CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET \
>> >> ? ? ? (IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x340)
>> >> #define CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR \
>> >> ? ? ? (IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x344)
>> >>
>> >> void __cpuinit platform_secondary_init(unsigned int cpu)
>> >> {
>> >> ? ? ? trace_hardirqs_off();
>> >> ? ? ? gic_cpu_init(0, IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x100);
>> >> ? ? ? /*
>> >> ? ? ? ?* Synchronise with the boot thread.
>> >> ? ? ? ?*/
>> >> ? ? ? spin_lock(&boot_lock);
>> >> #ifdef CONFIG_HOTPLUG_CPU
>> >> ? ? ? cpu_set(cpu, cpu_init_map);
>> >> ? ? ? INIT_COMPLETION(per_cpu(cpu_killed, cpu));
>> >
>> > This means you don't need to re-initialize the completion. ?Just define
>> > it once using DEFINE_COMPLETION(). ?Note that this is something that will
>> > be taken care of in core SMP hotplug code during the next merge window.
>> >
>>
>> Ah ok, thanks!
>>
>> >> #endif
>> >> ? ? ? spin_unlock(&boot_lock);
>> >> }
>> >>
>> >> int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>> >> {
>> >> ? ? ? unsigned long old_boot_vector;
>> >> ? ? ? unsigned long boot_vector;
>> >> ? ? ? unsigned long timeout;
>> >> ? ? ? u32 reg;
>> >>
>> >> ? ? ? /*
>> >> ? ? ? ?* set synchronisation state between this boot processor
>> >> ? ? ? ?* and the secondary one
>> >> ? ? ? ?*/
>> >> ? ? ? spin_lock(&boot_lock);
>> >>
>> >> ? ? ? /* set the reset vector to point to the secondary_startup routine */
>> >> #ifdef CONFIG_HOTPLUG_CPU
>> >> ? ? ? if (cpumask_test_cpu(cpu, cpu_init_mask))
>> >> ? ? ? ? ? ? ? boot_vector = virt_to_phys(tegra_hotplug_startup);
>> >> ? ? ? else
>> >> #endif
>> >> ? ? ? ? ? ? ? boot_vector = virt_to_phys(tegra_secondary_startup);
>> >
>> > I didn't see the code for these startup functions.
>> >
>>
>> ENTRY(tegra_secondary_startup)
>> ? ? ? ? msr ? ? cpsr_fsxc, #0xd3
>> ? ? ? ? bl ? ? ?__invalidate_cpu_state
>> ? ? ? ? cpu_id ?r0
>> ? ? ? ? enable_coresite r1
>> ? ? ? ? poke_ev r0, r1 ? ? ? ? ? ? ? ? ? ? ? ?<--------- updates reset
>> vector with up'ped CPU
>> ? ? ? ? b ? ? ? secondary_startup
>>
>> ENTRY(tegra_hotplug_startup)
>> ? ? ? ? setmode PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9
>> ? ? ? ? bl ? ? ?__invalidate_cpu_state
>> ? ? ? ? enable_coresite r1
>>
>> ? ? ? ? /* most of the below is a retread of what happens in __v7_setup and
>> ? ? ? ? ?* secondary_startup, to get the MMU re-enabled and to branch
>> ? ? ? ? ?* to secondary_kernel_startup */
>> ? ? ? ? mrc ? ? p15, 0, r0, c1, c0, 1
>> ? ? ? ? orr ? ? r0, r0, #(1 << 6) | (1 << 0) ? ?@ re-enable coherency
>> ? ? ? ? mcr ? ? p15, 0, r0, c1, c0, 1
>>
>> ? ? ? ? adr ? ? r4, __tegra_hotplug_data
>> ? ? ? ? ldmia ? r4, {r5, r7, r12}
>> ? ? ? ? mov ? ? r1, r12 ? ? ? ? ? ? ? ? @ ctx_restore = __cortex_a9_restore
>> ? ? ? ? sub ? ? r4, r4, r5
>> ? ? ? ? ldr ? ? r0, [r7, r4] ? ? ? ? ? ?@ pgdir = secondary_data.pgdir
>> ? ? ? ? b ? ? ? __return_to_virtual
>> ENDPROC(tegra_hotplug_startup)
>>
>> Effectively this restores what __cortex_a9_save did before it shut down the CPU.
>
> Err. ?You _really_ do not need all this complexity. ?My guess is that
> you've looked at what Realview is doing, and are trying to copy the
> way it does stuff. ?That's really over the top if you have the ability
> to place CPU cores back into reset, which it seems you do.
>
> All you need to do when killing a CPU is to put it back into reset.
> When you bring the CPU back up, just the same steps you'd run on the
> initial CPU bring-up. ?In other words, point the reset vector at
> tegra_secondary_startup and let it run through the same startup again.
>
> There's (should be) no need to preserve any state for the CPU across
> a hot-unplug. ?If there is state to be preserved, that's a bug which
> needs fixing (because something hasn't been properly re-initialized.)
> The first bug I've spotted in that area would be VFP - which is not
> hotplug aware. ?VFP needs to register into the hotplug notifier system
> so that vfp_enable() can be called. ?I'll have a patch for that before
> this weekend is out.

I fully agree with you. There should be no need for that. it looked
strange to me as well.
The worst part, is that tegra isn't the only cortex a9 based machine
arch, and all this code
is going to do is get duplicated all over the place, unnecessarily.
Thank you for the patch,
I think re-enabling debug monitor (if necessary) might be another
thing if it's not done already.

I do want to bring to your attention something I found while making
the patch I mailed here. It's that
secondary_startup (along with MMU-enabling friends) are located in the
.init.text section and get nuked after
startup. Which means that the secondary startup right now can't be
done without moving this code out of .init.text.
Moving that stuff is kind of iffy too, because it's used immediately
in head.S. I didn't try very hard :) (and it didn't work, but that's
my fault). Now I have a good reason to try again :).

>
>> >> void platform_cpu_die(unsigned int cpu)
>> >> {
>> >> #ifdef DEBUG
>> >> ? ? ? unsigned int this_cpu = hard_smp_processor_id();
>> >>
>> >> ? ? ? if (cpu != this_cpu) {
>> >> ? ? ? ? ? ? ? printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
>> >> ? ? ? ? ? ? ? ? ? ? ? ? ?this_cpu, cpu);
>> >> ? ? ? ? ? ? ? BUG();
>> >> ? ? ? }
>> >> #endif
>> >>
>> >> ? ? ? gic_cpu_exit(0);
>> >> ? ? ? barrier();
>> >> ? ? ? complete(&per_cpu(cpu_killed, cpu));
>> >> ? ? ? flush_cache_all();
>> >> ? ? ? barrier();
>> >> ? ? ? __cortex_a9_save(0);
>> >>
>> >> ? ? ? /* return happens from __cortex_a9_restore */
>> >> ? ? ? barrier();
>> >> ? ? ? writel(smp_processor_id(), EVP_CPU_RESET_VECTOR);
>> >
>> > And here, if the CPU is not _immediately_ stopped, it will return and
>> > restart the bring-up. ?If you are using hardware to reset the CPU (which
>> > it seems you are), you should ensure that this function never returns.
>> > You may also wish to add a pr_crit() here to indicate when this failure
>> > happens.
>> >
>>
>> It is immediately stopped. Turned off really. But this is where it
>> will resume on when it gets brought back up (__cortex_a9_restore takes
>> care of that)
>

But this is a writel to memory. And CONFIG_ARM_DMA_MEM_BUFFERABLE is defined, so
there is a __wmb() after the write, and in our case
#define wmb()           do { dsb(); outer_sync(); } while (0)

The dsb will flush the write buffer, unless I misunderstand.

> As I explained above, writel() is not guaranteed to take immediate effect.
> Writes to device memory can be buffered, which allows the CPU to continue
> execution having posted the write. ?At some point later, that write gets
> committed to hardware.
>
> For instance, this code is buggy:
>
> ? ? ? ?writel(0x00, base);
> ? ? ? ?udelay(10);
> ? ? ? ?writel(0xff, base);
>
> It may or may not write these two values 10us apart. ?As far as the
> external hardware can see, the writes could be:
>
> ? ? ? ?udelay(10);
> ? ? ? ?writel(0x00, base);
> ? ? ? ?writel(0xff, base);
>
> or:
>
> ? ? ? ?writel(0x00, base);
> ? ? ? ?writel(0xff, base);
> ? ? ? ?udelay(10);
>
> or even:
>
> ? ? ? ?writel(0x00, base);
> ? ? ? ?udelay(1000);
> ? ? ? ?writel(0xff, base);
>
> There are ways to ensure that writes take effect before the program
> continues, and one of the most reliable is to read back the register
> you've just written (which is the preferred method when writing PCI
> device drivers - because there could be many levels of bridges with
> write posting buffers between the CPU and the device.)
>
> As far as ordering:
>
> ? ? ? ?writel(0x00, base);
> ? ? ? ?*(int *)memory = value;
>
> there is no guarantee that the writel() will be seen by hardware before
> the memory location is written and that write is visible to hardware.
> The two operations could occur in the reverse order. ?This is because
> accesses to device memory can pass memory accesses. ?This iss why
> barriers are necessary - and there's a big document to describe barriers
> in the kernel Documentation subdirectory.
>

Keep in mind that this is not why we were seeing that failure. If it
failed here, secondary_boot spinning on this value wouldn't have
succeeded, and it wouldn't even try spinning with a timeout on the
cpu_online bit. And while I agree with you that the hotplug code code
be severely less byzantine (and help everybody all the other mach SMP
efforts in a generic fashion), it's not the problem either - it works
- boot_secondary returns success and cpu_up enters the timeout wait
for the online bit.

So what about the original issue at hand? Can we make the logic in
__cpu_up basically either bring the CPU up successfully or ensure it's
not going to come up behind the scenes? Because the current logic
allows for that.

Right now, in __cpu_up, if the online bit doesn't come up in some time
frame, there is nothing there that guarantees that the secondary
doesn't just come up late (and ruin things because it's an unexpected
guest at the party). This is why I sent the original patch.

I debugged through what was happening, and boot_secondary was
succeeding (this means that the secondary IS now about to jump to
secondary_start_kernel). But the wait to set the online bit timed out.
Not by much (judging from kernel messages), but timed out. Now, this
was on a IO/memory/compute overloaded system, this isn't supposed to
happen in real life, but it happened, and it's not helping our stress
tests ;-). Basically there is no safe guards to prevent something like
this from happening, hence the patch.

The patch waits to make sure secondary_start_kernel is entered, but
before all the non-easily revertable stuff starts happening. If that
wait succeeds nothing else should go wrong, and we do a non-timeout
wait for the online bit.

The second bit is paranoid, and extremely unlikely, but is there for
completeness sakes. I have never seen it in our mach. If it enters
too late (impossible really, barring terrible hw bugs) into
secondary_start_kernel, it won't continue with the init, because
__cpu_up timed out and didn't release the lock necessary to continue
secondary_start_kernel.

Thanks again,
A
