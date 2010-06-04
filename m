From: fachkar.datawind@gmail.com (f. achkar)
Date: Fri, 04 Jun 2010 12:50:05 -0400
Subject: KERN_ERR error adding pwm scaler?
Message-ID: <4C092EBD.1010903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
newbie, testing linux-arm-2.6.32-9 on s3c2450. I'm stuck with the
s3c2450_init_clocks/s3c_pwmclk_init !
getting 'KERN_ERR error adding pwm scaler' in
"arch/arm/plat-s3c/pwm-clock.c:444" .

I'm not sure why I get the following:
442            if (ret < 0) {
(gdb)
444                return;
(gdb) bt
#0  s3c_pwmclk_init ()@arch/arm/plat-s3c/pwm-clock.c:444
#1  0xc000e27c in s3c2450_init_clocks (xtal=<value optimized out>) at
arch/arm/mach-s3c2450/clock.c:1161
#2  0xc000f248 in s3c24xx_init_clocks (xtal=0) at
arch/arm/plat-s3c/init.c:86
#3  0xc000e3a0 in smdk2450_map_io () at
arch/arm/mach-s3c2450/mach-smdk2450.c:357
#4  0xc000d6ac in paging_init (mdesc=0xc0023088) at arch/arm/mm/mmu.c:993
#5  0xc000bc1c in setup_arch (cmdline_p=0xc04edfe4) at
arch/arm/kernel/setup.c:745
#6  0xc00088f4 in start_kernel () at init/main.c:551
#7  0x3000804c in ?? ()
#8  0x3000804c in ?? ()
(gdb) s
310        unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
(gdb) s
316        divclk->divisor = tcfg_to_divisor(tcfg1);
(gdb) s
310        unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
(gdb) s
(and never returns from that!!!)

anyone can give me a hint on why/how to address this issue?
the current code can be found at
http://github.com/ferarachkar/dw-ubi2-2.6.32-9/tree/chromiumos-s3c2450
thanks,
-------------------------------------------------------------
detailed gdb session below:

(gdb) thbreak start_kernel
Hardware assisted breakpoint 1 at 0xc00088a0: file init/main.c, line 522.
(gdb) c
Continuing.

Temporary breakpoint 1, start_kernel () at init/main.c:522
522        smp_setup_processor_id();
(gdb) thbreak s3c2450_init_clocks
Hardware assisted breakpoint 2 at 0xc000dff4: file
arch/arm/mach-s3c2450/clock.c, line 1088.
(gdb) c
Continuing.

Temporary breakpoint 2, s3c2450_init_clocks (xtal=12000000) at
arch/arm/mach-s3c2450/clock.c:1088
1088            unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
(gdb) thbreak arch/arm/mach-s3c2450/clock.c:1161
Hardware assisted breakpoint 3 at 0xc000e278: file
arch/arm/mach-s3c2450/clock.c, line 1161.
(gdb) c
Continuing.

Temporary breakpoint 3, s3c2450_init_clocks (xtal=<value optimized out>)
at arch/arm/mach-s3c2450/clock.c:1161
1161            s3c_pwmclk_init();
(gdb) s
s3c_pwmclk_init () at arch/arm/plat-s3c/pwm-clock.c:425
425        clk_timers = clk_get(NULL, "timers");
(gdb) s
clk_get (dev=0x0, id=0xc047057c "timers") at arch/arm/plat-s3c/clock.c:76
76        if (dev == NULL || dev->bus != &platform_bus_type)
(gdb) print *dev
$1 = {parent = 0x0, p = 0x0, kobj = {name = 0x0, entry = {next = 0x0,
prev = 0x0}, parent = 0x0, kset = 0x0, ktype = 0x0, sd = 0x0, kref =
{refcount = {
        counter = 0}}, state_initialized = 0, state_in_sysfs = 0,
state_add_uevent_sent = 0, state_remove_uevent_sent = 0, uevent_suppress
= 0},
  init_name = 0x0, type = 0x0, sem = {lock = {raw_lock = {<No data
fields>}}, count = 0, wait_list = {next = 0x0, prev = 0x0}}, bus = 0x0,
driver = 0x0,
  platform_data = 0x0, power = {power_state = {event = 0}, can_wakeup =
0, should_wakeup = 0, status = DPM_INVALID, entry = {next = 0x0, prev =
0x0}},
  dma_mask = 0x0, coherent_dma_mask = 0, dma_parms = 0x0, dma_pools =
{next = 0x0, prev = 0x0}, dma_mem = 0x0, archdata = {<No data fields>},
devt = 0,
  devres_lock = {raw_lock = {<No data fields>}}, devres_head = {next =
0x0, prev = 0x0}, knode_class = {n_klist = 0x0, n_node = {next = 0x0,
prev = 0x0},
    n_ref = {refcount = {counter = 0}}}, class = 0x0, groups = 0x0,
release = 0}
(gdb) s
79            idno = to_platform_device(dev)->id;
(gdb) s
81        spin_lock(&clocks_lock);
(gdb) s
add_preempt_count (val=1) at kernel/sched.c:5286
5286        if (DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))
(gdb) s
97        return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
(gdb) s
5289        preempt_count() += val;
(gdb) s
5294        DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
(gdb) s
clk_get (dev=<value optimized out>, id=0xc047057c "timers") at
arch/arm/plat-s3c/clock.c:83
83        list_for_each_entry(p, &clocks, list) {
(gdb) n
115        __asm__ __volatile__(
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb) n
87        return test_bit(flag, (unsigned long *)&ti->flags);
(gdb) n
482            unsigned int cpu = get_cpu();
(gdb) s
483            if (likely(module_is_live(module))) {
(gdb) s
83        list_for_each_entry(p, &clocks, list) {
(gdb) n
84            if (p->id == idno &&
(gdb) print *p
$2 = {list = {next = 0xc04f18c0, prev = 0xc04f44b4}, owner = 0x0, parent
= 0xc04f45d4, name = 0xc0470900 "spi", id = 1, usage = 0, rate = 0,
  ctrlbit = 32768, enable = 0xc00999a4 <s3c2443_clkcon_enable_p>,
set_rate = 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb) n
115        __asm__ __volatile__(
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb) n
84            if (p->id == idno &&
(gdb) print *p
$3 = {list = {next = 0xc04f1888, prev = 0xc04f18f8}, owner = 0x0, parent
= 0xc04f45d4, name = 0xc0470900 "spi", id = 0, usage = 0, rate = 0,
  ctrlbit = 16384, enable = 0xc00999a4 <s3c2443_clkcon_enable_p>,
set_rate = 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$4 = {list = {next = 0xc04f1850, prev = 0xc04f18c0}, owner = 0x0, parent
= 0xc04f45d4, name = 0xc04708b8 "iis", id = -1, usage = 0, rate = 0,
ctrlbit = 512,
  enable = 0xc00999a4 <s3c2443_clkcon_enable_p>, set_rate = 0, get_rate
= 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb) 
84            if (p->id == idno &&
(gdb) print *p
$5 = {list = {next = 0xc04f1818, prev = 0xc04f1888}, owner = 0x0, parent
= 0xc04f45d4, name = 0xc04708ac "i2c", id = -1, usage = 0, rate = 0,
ctrlbit = 16,
  enable = 0xc00999a4 <s3c2443_clkcon_enable_p>, set_rate = 0, get_rate
= 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$6 = {list = {next = 0xc04f17a8, prev = 0xc04f1818}, owner = 0x0, parent
= 0xc04f45d4, name = 0xc04708f4 "sdi", id = -1, usage = 0, rate = 0,
ctrlbit = 32,
  enable = 0xc00999a4 <s3c2443_clkcon_enable_p>, set_rate = 0, get_rate
= 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$7 = {list = {next = 0xc04f1770, prev = 0xc04f17e0}, owner = 0x0, parent
= 0xc04f459c, name = 0xc0471890 "nand", id = -1, usage = 0, rate = 0,
ctrlbit = 0,
  enable = 0xc009cf24 <clk_null_enable>, set_rate = 0, get_rate = 0,
round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$8 = {list = {next = 0xc04f1738, prev = 0xc04f17a8}, owner = 0x0, parent
= 0xc04f45d4, name = 0xc04b30e0 "ac97", id = -1, usage = 0, rate = 0,
  ctrlbit = 256, enable = 0xc00999a4 <s3c2443_clkcon_enable_p>, set_rate
= 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$9 = {list = {next = 0xc04f1700, prev = 0xc04f1770}, owner = 0x0, parent
= 0xc04f459c, name = 0xc0470594 "cfata", id = -1, usage = 0, rate = 0,
  ctrlbit = 131072, enable = 0xc0099978 <s3c2443_clkcon_enable_h>,
set_rate = 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb)


83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)

83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb)



83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$10 = {list = {next = 0xc04f1620, prev = 0xc04f1690}, owner = 0x0,
parent = 0xc04f45d4, name = 0xc047028c "uart", id = 3, usage = 0, rate =
0, ctrlbit = 8,
  enable = 0xc00999a4 <s3c2443_clkcon_enable_p>, set_rate = 0, get_rate
= 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$11 = {list = {next = 0xc04f15e8, prev = 0xc04f1658}, owner = 0x0,
parent = 0xc04f45d4, name = 0xc047028c "uart", id = 2, usage = 0, rate =
0, ctrlbit = 4,
  enable = 0xc00999a4 <s3c2443_clkcon_enable_p>, set_rate = 0, get_rate
= 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$12 = {list = {next = 0xc04f15b0, prev = 0xc04f1620}, owner = 0x0,
parent = 0xc04f45d4, name = 0xc047028c "uart", id = 1, usage = 0, rate =
0, ctrlbit = 2,
  enable = 0xc00999a4 <s3c2443_clkcon_enable_p>, set_rate = 0, get_rate
= 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$13 = {list = {next = 0xc04f1578, prev = 0xc04f15e8}, owner = 0x0,
parent = 0xc04f45d4, name = 0xc047028c "uart", id = 0, usage = 0, rate =
0, ctrlbit = 1,
  enable = 0xc00999a4 <s3c2443_clkcon_enable_p>, set_rate = 0, get_rate
= 0, round_rate = 0, set_parent = 0}
(gdb) n
83        list_for_each_entry(p, &clocks, list) {
(gdb)
115        __asm__ __volatile__(
(gdb)
83        list_for_each_entry(p, &clocks, list) {
(gdb)
84            if (p->id == idno &&
(gdb) print *p
$14 = {list = {next = 0xc04f1540, prev = 0xc04f15b0}, owner = 0x0,
parent = 0xc04f45d4, name = 0xc047057c "timers", id = -1, usage = 0,
rate = 0,
  ctrlbit = 1024, enable = 0xc00999a4 <s3c2443_clkcon_enable_p>,
set_rate = 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) n
481        if (module) {
(gdb) bt
#0  clk_get (dev=<value optimized out>, id=0xc047057c "timers") at
include/linux/module.h:481
#1  0xc000f62c in s3c_pwmclk_init () at arch/arm/plat-s3c/pwm-clock.c:425
#2  0xc000e27c in s3c2450_init_clocks (xtal=<value optimized out>) at
arch/arm/mach-s3c2450/clock.c:1161
#3  0xc000f248 in s3c24xx_init_clocks (xtal=0) at
arch/arm/plat-s3c/init.c:86
#4  0xc000e3a0 in smdk2450_map_io () at
arch/arm/mach-s3c2450/mach-smdk2450.c:357
#5  0xc000d6ac in paging_init (mdesc=0xc0023088) at arch/arm/mm/mmu.c:993
#6  0xc000bc1c in setup_arch (cmdline_p=0xc04edfe4) at
arch/arm/kernel/setup.c:745
#7  0xc00088f4 in start_kernel () at init/main.c:551
#8  0x3000804c in ?? ()
#9  0x3000804c in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) n
95        if (IS_ERR(clk)) {
(gdb)
105        spin_unlock(&clocks_lock);
(gdb) print *clk
$15 = {list = {next = 0xc04f1540, prev = 0xc04f15b0}, owner = 0x0,
parent = 0xc04f45d4, name = 0xc047057c "timers", id = -1, usage = 0,
rate = 0,
  ctrlbit = 1024, enable = 0xc00999a4 <s3c2443_clkcon_enable_p>,
set_rate = 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) print *(clk->parent)
$16 = {list = {next = 0xc04f459c, prev = 0xc04f460c}, owner = 0x0,
parent = 0xc04f10a8, name = 0xc04706ec "pclk", id = -1, usage = 0, rate
= 66666666,
  ctrlbit = 0, enable = 0xc009cf24 <clk_null_enable>, set_rate =
0xc009cfac <clk_default_setrate>, get_rate = 0, round_rate = 0,
set_parent = 0}
(gdb) n
87        return test_bit(flag, (unsigned long *)&ti->flags);
(gdb) bt
#0  clk_get (dev=<value optimized out>, id=0xc047057c "timers") at
include/linux/thread_info.h:87
#1  0xc000f62c in s3c_pwmclk_init () at arch/arm/plat-s3c/pwm-clock.c:425
#2  0xc000e27c in s3c2450_init_clocks (xtal=<value optimized out>) at
arch/arm/mach-s3c2450/clock.c:1161
#3  0xc000f248 in s3c24xx_init_clocks (xtal=1) at
arch/arm/plat-s3c/init.c:86
#4  0xc000e3a0 in smdk2450_map_io () at
arch/arm/mach-s3c2450/mach-smdk2450.c:357
#5  0xc000d6ac in paging_init (mdesc=0xc0023088) at arch/arm/mm/mmu.c:993
#6  0xc000bc1c in setup_arch (cmdline_p=0xc04edfe4) at
arch/arm/kernel/setup.c:745
#7  0xc00088f4 in start_kernel () at init/main.c:551
#8  0x3000804c in ?? ()
#9  0x3000804c in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) n
105        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
(gdb) n
105        spin_unlock(&clocks_lock);
(gdb) n
107    }
(gdb) n
s3c_pwmclk_init () at arch/arm/plat-s3c/pwm-clock.c:426
426        if (IS_ERR(clk_timers)) {
(gdb) print *clk_timers
$17 = {list = {next = 0xc04f1540, prev = 0xc04f15b0}, owner = 0x0,
parent = 0xc04f45d4, name = 0xc047057c "timers", id = -1, usage = 0,
rate = 0,
  ctrlbit = 1024, enable = 0xc00999a4 <s3c2443_clkcon_enable_p>,
set_rate = 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) print *(clk_timers->parent)
$18 = {list = {next = 0xc04f459c, prev = 0xc04f460c}, owner = 0x0,
parent = 0xc04f10a8, name = 0xc04706ec "pclk", id = -1, usage = 0, rate
= 66666666,
  ctrlbit = 0, enable = 0xc009cf24 <clk_null_enable>, set_rate =
0xc009cfac <clk_default_setrate>, get_rate = 0, round_rate = 0,
set_parent = 0}
(gdb) n
432            clk_timer_scaler[clk].parent = clk_timers;
(gdb) print *(clk_timer_scaler[clk].parent)
$19 = {list = {next = 0x0, prev = 0x0}, owner = 0x0, parent = 0x0, name
= 0x0, id = 0, usage = 0, rate = 0, ctrlbit = 0, enable = 0, set_rate = 0,
  get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) n
433            ret = s3c24xx_register_clock(&clk_timer_scaler[clk]);
(gdb) print *(clk_timer_scaler[clk].parent)
$20 = {list = {next = 0xc04f1540, prev = 0xc04f15b0}, owner = 0x0,
parent = 0xc04f45d4, name = 0xc047057c "timers", id = -1, usage = 0,
rate = 0,
  ctrlbit = 1024, enable = 0xc00999a4 <s3c2443_clkcon_enable_p>,
set_rate = 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) s
s3c24xx_register_clock (clk=0xc04f46b4) at arch/arm/plat-s3c/clock.c:311
311        if (clk->enable == NULL)
(gdb) print *clk
$21 = {list = {next = 0x0, prev = 0x0}, owner = 0x0, parent =
0xc04f1578, name = 0xc0471590 "pwm-scaler0", id = -1, usage = 0, rate =
0, ctrlbit = 0,
  enable = 0, set_rate = 0xc009d5c0 <clk_pwm_scaler_set_rate>, get_rate
= 0xc009d584 <clk_pwm_scaler_get_rate>,
  round_rate = 0xc009d544 <clk_pwm_scaler_round_rate>, set_parent = 0}
(gdb) n
312            clk->enable = clk_null_enable;
(gdb) n
317        BUG_ON(clk->list.prev != clk->list.next);
(gdb) print *clk
$22 = {list = {next = 0x0, prev = 0x0}, owner = 0x0, parent =
0xc04f1578, name = 0xc0471590 "pwm-scaler0", id = -1, usage = 0, rate =
0, ctrlbit = 0,
  enable = 0xc009cf24 <clk_null_enable>, set_rate = 0xc009d5c0
<clk_pwm_scaler_set_rate>, get_rate = 0xc009d584 <clk_pwm_scaler_get_rate>,
  round_rate = 0xc009d544 <clk_pwm_scaler_round_rate>, set_parent = 0}
(gdb) n
319        spin_lock(&clocks_lock);
(gdb)
66        __list_add(new, head, head->next);
(gdb)
45        next->prev = new;
(gdb)
46        new->next = next;
(gdb)
48        prev->next = new;
(gdb)
321        spin_unlock(&clocks_lock);
(gdb)
87        return test_bit(flag, (unsigned long *)&ti->flags);
(gdb)
105        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
(gdb)
321        spin_unlock(&clocks_lock);
(gdb)
324    }
(gdb)
s3c_pwmclk_init () at arch/arm/plat-s3c/pwm-clock.c:434
434            if (ret < 0) {
(gdb) n
432            clk_timer_scaler[clk].parent = clk_timers;
(gdb) n
433            ret = s3c24xx_register_clock(&clk_timer_scaler[clk]);
(gdb) n
434            if (ret < 0) {
(gdb) n
441            ret = s3c24xx_register_clock(&clk_timer_tclk[clk]);
(gdb) s
s3c24xx_register_clock (clk=0xc04f4724)@arch/arm/plat-s3c/clock.c:311
311        if (clk->enable == NULL)
(gdb) print *clk
$23 = {list = {next = 0x0, prev = 0x0}, owner = 0x0, parent = 0x0, name
= 0xc04715a8 "pwm-tclk0", id = -1, usage = 0, rate = 0, ctrlbit = 0,
enable = 0,
  set_rate = 0, get_rate = 0, round_rate = 0, set_parent = 0}
(gdb) s
312            clk->enable = clk_null_enable;
(gdb) s
317        BUG_ON(clk->list.prev != clk->list.next);
(gdb) print *(clk->list.prev)
$24 = {next = 0x0, prev = 0x0}
(gdb) s                     
319        spin_lock(&clocks_lock);
(gdb) n
66        __list_add(new, head, head->next);
(gdb)
45        next->prev = new;
(gdb)
46        new->next = next;
(gdb)
48        prev->next = new;
(gdb)
321        spin_unlock(&clocks_lock);
(gdb)
87        return test_bit(flag, (unsigned long *)&ti->flags);
(gdb)
105        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
(gdb)
321        spin_unlock(&clocks_lock);
(gdb)
324    }
(gdb)
s3c_pwmclk_init () at arch/arm/plat-s3c/pwm-clock.c:442
442            if (ret < 0) {
(gdb)
441            ret = s3c24xx_register_clock(&clk_timer_tclk[clk]);
(gdb) s
s3c24xx_register_clock (clk=0xc04f475c)@arch/arm/plat-s3c/clock.c:311
311        if (clk->enable == NULL)
(gdb)
312            clk->enable = clk_null_enable;
(gdb)
317        BUG_ON(clk->list.prev != clk->list.next);
(gdb) print *clk
$25 = {list = {next = 0x0, prev = 0x0}, owner = 0x0, parent = 0x0, name
= 0xc04715b4 "pwm-tclk1", id = -1, usage = 0, rate = 0, ctrlbit = 0,
  enable = 0xc009cf24 <clk_null_enable>, set_rate = 0, get_rate = 0,
round_rate = 0, set_parent = 0}
(gdb) l
312            clk->enable = clk_null_enable;
313   
314        /* add to the list of available clocks */
315   
316        /* Quick check to see if this clock has already been
registered. */
317        BUG_ON(clk->list.prev != clk->list.next);
318   
319        spin_lock(&clocks_lock);
320        list_add(&clk->list, &clocks);
321        spin_unlock(&clocks_lock);
(gdb) s
319        spin_lock(&clocks_lock);
(gdb)
add_preempt_count (val=1) at kernel/sched.c:5286
5286        if (DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))
(gdb)
97        return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
(gdb)
5289        preempt_count() += val;
(gdb)
5294        DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
(gdb)
s3c24xx_register_clock (clk=0xc04f475c) at include/linux/list.h:66
66        __list_add(new, head, head->next);
(gdb)
45        next->prev = new;
(gdb)
46        new->next = next;
(gdb)
48        prev->next = new;
(gdb)
321        spin_unlock(&clocks_lock);
(gdb)
sub_preempt_count (val=1) at kernel/sched.c:5308
5308        if (DEBUG_LOCKS_WARN_ON(val > preempt_count()))
(gdb)
5313        if (DEBUG_LOCKS_WARN_ON((val < PREEMPT_MASK) &&
(gdb)
97        return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
(gdb)
5320        preempt_count() -= val;
(gdb)
s3c24xx_register_clock (clk=0xc04f475c)@include/linux/thread_info.h:87
87        return test_bit(flag, (unsigned long *)&ti->flags);
(gdb) 
105        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
(gdb)
321        spin_unlock(&clocks_lock);
(gdb)
324    }
(gdb)
s3c_pwmclk_init () at arch/arm/plat-s3c/pwm-clock.c:442
442            if (ret < 0) {
(gdb)
444                return;
(gdb) bt
#0  s3c_pwmclk_init ()@arch/arm/plat-s3c/pwm-clock.c:444
#1  0xc000e27c in s3c2450_init_clocks (xtal=<value optimized out>) at
arch/arm/mach-s3c2450/clock.c:1161
#2  0xc000f248 in s3c24xx_init_clocks (xtal=0) at
arch/arm/plat-s3c/init.c:86
#3  0xc000e3a0 in smdk2450_map_io () at
arch/arm/mach-s3c2450/mach-smdk2450.c:357
#4  0xc000d6ac in paging_init (mdesc=0xc0023088) at arch/arm/mm/mmu.c:993
#5  0xc000bc1c in setup_arch (cmdline_p=0xc04edfe4) at
arch/arm/kernel/setup.c:745
#6  0xc00088f4 in start_kernel () at init/main.c:551
#7  0x3000804c in ?? ()
#8  0x3000804c in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) s
310        unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
(gdb) s
316        divclk->divisor = tcfg_to_divisor(tcfg1);
(gdb) s
310        unsigned long tcfg1 = __raw_readl(S3C2410_TCFG1);
(gdb) s
