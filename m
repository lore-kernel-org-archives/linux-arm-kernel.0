From: fernando.endo@phiinnovations.com (Fernando Endo)
Date: Fri, 30 Sep 2011 19:33:43 -0300
Subject: Porting linux to Stellaris Cortex-M3
In-Reply-To: <20110927205043.GA23944@n2100.arm.linux.org.uk>
References: <CAH8SYHDRT7OpLr0sx75rMyy4OV59JZGoRv_cr2+-+2yy3tfU9g@mail.gmail.com>
	<CAAJ0-p7YwKR9B6BfoHcRqrNPVvpd49XrPsDCN7UF=-5jAf8XnQ@mail.gmail.com>
	<CAH8SYHBFgkp47vf97qC_pseBOKNMrqVMj9sddjzUg1xjWpg6xw@mail.gmail.com>
	<20110927205043.GA23944@n2100.arm.linux.org.uk>
Message-ID: <CAH8SYHD=+-Vh1bYcfTuMg=4ddHqRq2riv+0eMuaOB9viLjdNoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Sep 27, 2011 at 09:54:18AM -0300, Fernando Endo wrote:
>> This is the log that I got with printascii bypassing printk:
>>
>> <5>Linux version 2.6.33-arm1 (fernando at fernando-POS-MIG31AG) (gcc
>> version 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #127 Tue Sep 27
>> 09:14:21 BRT 2011
>> CPU: ARMv7-M Processor [412fc230] revision 0 (ARMv?(11)M)
>> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>> Machine: Stellaris LM3S9B96
>> <7>On node 0 totalpages: 2048
>> <7>free_area_init_node: node 0, pgdat 600de1e0, node_mem_map 600f6000
>> <7> ?DMA zone: 16 pages used for memmap
>> <7> ?DMA zone: 0 pages reserved
>> <7> ?DMA zone: 2032 pages, LIFO batch:0
>> Built 1 zonelists in Zone order, mobility grouping off. ?Total pages: 2032
>> <5>Kernel command line: init=/bin/busybox console=ttyS mem=8M
>> <6>PID hash table entries: 32 (order: -5, 128 bytes)
>> <6>Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)
>> <6>Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> <6>Memory: 8MB = 8MB total
>> <5>Memory: 7168k/7168k available, 1024k reserved, 0K highmem
>> <5>Virtual kernel memory layout:
>> ? ?vector ?: 0x00000000 - 0x00001000 ? ( ? 4 kB)
>> ? ?fixmap ?: 0xfff00000 - 0xfffe0000 ? ( 896 kB)
>> ? ?vmalloc : 0x00000000 - 0xffffffff ? (4095 MB)
>> ? ?lowmem ?: 0x60000000 - 0x60800000 ? ( ? 8 MB)
>> ? ?modules : 0x60000000 - 0x60800000 ? ( ? 8 MB)
>> ? ? ?.init : 0x60008000 - 0x6002f000 ? ( 156 kB)
>> ? ? ?.text : 0x6002f000 - 0x600cb000 ? ( 624 kB)
>> ? ? ?.data : 0x600d6000 - 0x600deb40 ? ( ?35 kB)
>> <6>Hierarchical RCU implementation.
>> <6>NR_IRQS:54
>> <6>console [ttyS0] enabled
>> <6>Calibrating delay loop... <c>3.82 BogoMIPS (lpj=19136)
>> Mount-cache hash table entries: 512
>> <6>Switching to clocksource timer3
>> <6>ttyS0 at MMIO 0x4000c000 (irq = 5) is a LM3S9B96 UARTx Port
>> <6>Freeing init memory: 156K
>> <3>BUG: scheduling while atomic: init/1/0xffff0003
>> [<60032b6d>] (unwind_backtrace+0x1/0x88) from [<600a1379>] (dump_stack+0xd/0x10)
>> [<600a1379>] (dump_stack+0xd/0x10) from [<60034ea5>] (__schedule_bug+0x35/0x40)
>> [<60034ea5>] (__schedule_bug+0x35/0x40) from [<600a17b1>] (schedule+0x2d1/0x2f4)
>> [<600a17b1>] (schedule+0x2d1/0x2f4) from [<6002f791>] (ret_slow_syscall+0x1/0xc)
>
> Hmm, this doesn't look good. ?What this is showing is that it's the
> call to schedule() in the code dealing with returning to userspace.
> The preempt count shouldn't be this wrong here - it suggests that
> something is returning with wrong preempt status.
>
> The problem is it's not possible at this point to work out from the
> information you've supplied whether it's a data abort, prefetch abort,
> or SWI (SVC) call (and actually we don't have any tracking of that.)
>
> If I had to guess I'd suggest that there was something fishy with
> the IRQ handling - but without knowing what mods you've made to the
> stock kernel, that's about as much speculation that I can give.
>

Hello again, now I have good news!

Our port is working fine, we got the linux prompt today.
I don't know exactly the influence of the changes I've done, but just
to help people facing the same situation:

(... after crazy attempts)
1) I was using "for" instructions inside a /init test program to make
a led blink
2) I've replaced them by sleep(1), then things seemed to be much
better, no more crashes
3) As sleep(1) didn't take 1s, I fixed that
4) I've started debugging printf, as suggests busybox.net/FAQ.html#init
5) Finally, after finding and fixing a bug on my uart_isr, I was able
to see printf messages
   (I didn't know that the kernel may use uart interruptions after
switching to the user space)
6) The prompt came after creating init scripts read by Busybox

I think the first one was somehow messing the user space...

Att,
Fernando Akira Endo
