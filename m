From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Mar 2014 19:27:43 -0300
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <201403200501.16881.marex@denx.de>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de>
 <201403200501.16881.marex@denx.de>
Message-ID: <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Mar 20, 2014 at 1:01 AM, Marek Vasut <marex@denx.de> wrote:
> On Thursday, March 20, 2014 at 12:05:56 AM, Marek Vasut wrote:
>> On Wednesday, March 19, 2014 at 11:51:38 PM, Russell King - ARM Linux wrote:
>
> [...]
>
>> > As far as the 600Mbps receive - you need the right conditions for that.
>> > I select the performance cpufreq governor after boot, and let the boot
>> > quiesce.  It doesn't take much for it to drop back to 460Mbps - another
>> > running process other than iperf -s is sufficient to do that.
>> >
>> > Let me know how you get on with this.
>>
>> Roger that, will do, thank you very much !
>
> I did some test and I observe no dips in the speed, nice work. Thanks !
>
> I will try to get feedback from more boards and get back to you with the
> results.

Thanks for the patch.

Robert Daniels on Cc tried it on mx53 and sent the feedback below.

Thanks

"I tried the patch and it seems a little better but still has problems.
When I first started the test I saw dropped packets.  After about 2 minutes
I got the pause again with the accompanying kernel backtrace.  It looks
like I got some more debug information from the backtrace however (I think
that was part of the patch.)

This is what it looks like now:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0
at /home/robertd/Development/IC/
Dev/BoardSupport/ic-ii/linux-mainline/net/sched/sch_generic.c:264
 dev_watchdo
g+0x288/0x2ac()
NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.14.0-rc6+ #5
Backtrace:
[<800121bc>] (dump_backtrace) from [<800124a0>] (show_stack+0x18/0x1c)
 r6:8051f29c r5:00000000 r4:808edb9c r3:00000000
[<80012488>] (show_stack) from [<80652098>] (dump_stack+0x84/0x9c)
[<80652014>] (dump_stack) from [<80027d1c>] (warn_slowpath_common
+0x70/0x94)
 r5:00000009 r4:808c9d60
[<80027cac>] (warn_slowpath_common) from [<80027d78>] (warn_slowpath_fmt
+0x38/0x40)
 r8:ded37b40 r7:808c8000 r6:ded37b00 r5:dec34000 r4:00000000
[<80027d44>] (warn_slowpath_fmt) from [<8051f29c>] (dev_watchdog
+0x288/0x2ac)
 r3:dec34000 r2:808335f0
[<8051f014>] (dev_watchdog) from [<80031e68>] (call_timer_fn+0x74/0xf4)
 r10:80031df4 r9:dec34000 r8:8051f014 r7:808c8000 r6:00000100 r5:808c8000
 r4:808c9dd0
[<80031df4>] (call_timer_fn) from [<80032598>] (run_timer_softirq
+0x19c/0x234)
 r10:8051f014 r9:dec34000 r8:00200200 r7:00000000 r6:808c9e20 r5:80929fc0
 r4:dec34284
[<800323fc>] (run_timer_softirq) from [<8002c2f4>] (__do_softirq
+0x110/0x2b4)
 r10:00000100 r9:00000001 r8:40000001 r7:808c8000 r6:808ca080 r5:808ca084
 r4:00000000
[<8002c1e4>] (__do_softirq) from [<8002c7ac>] (irq_exit+0xb8/0x10c)
 r10:8065c4cc r9:00000001 r8:00000000 r7:00000037 r6:808c8000 r5:808c5fe8
 r4:808c8028
[<8002c6f4>] (irq_exit) from [<8000f2a0>] (handle_IRQ+0x5c/0xbc)
 r5:808c5fe8 r4:808d0d24
[<8000f244>] (handle_IRQ) from [<80008590>] (tzic_handle_irq+0x78/0xa8)
 r8:808c9f10 r7:00000001 r6:00000020 r5:80928fd8 r4:00000000 r3:00000080
[<80008518>] (tzic_handle_irq) from [<800130a4>] (__irq_svc+0x44/0x5c)
Exception stack(0x808c9f10 to 0x808c9f58)
9f00:                                     00000001 00000001 00000000
808d3e70
9f20: 808c8000 808d099c 808d0938 8092837d 00000000 808c8000 8065c4cc
808c9f64
9f40: 808c9f28 808c9f58 800638e0 8000f674 20000013 ffffffff
 r9:808c8000 r8:00000000 r7:808c9f44 r6:ffffffff r5:20000013 r4:8000f674
[<8000f64c>] (arch_cpu_idle) from [<8006e874>] (cpu_startup_entry
+0x108/0x160)
[<8006e76c>] (cpu_startup_entry) from [<8064ce8c>] (rest_init+0xb4/0xdc)
 r7:808b8360
[<8064cdd8>] (rest_init) from [<80879b58>] (start_kernel+0x328/0x38c)
 r6:ffffffff r5:808d0880 r4:808d0a30
[<80879830>] (start_kernel) from [<70008074>] (0x70008074)
---[ end trace 18ea3643c6be04df ]---
fec 63fec000.ethernet eth0: TX ring dump
Nr    SC     addr       len  SKB
 0    0x1c00 0xce485000  106 de5db480
 1    0x1c00 0xce485800  106 de5b7540
 2    0x1c00 0xce486000  106 de5b7300
 3    0x1c00 0xce486800  106 de5b73c0
 4    0x1c00 0xce487000  106 de5b7e40
 5    0x1c00 0xce487800  106 de5b7840
 6    0x1c00 0xce500000  106 de5b7b40
 7    0x1c00 0xce500800  106 de5b7600
 8    0x1c00 0xce501000  106 de5b7d80
 9    0x1c00 0xce501800  106 de5b7180
10    0x1c00 0xce502000  106 de5b7a80
11    0x1c00 0xce502800  106 de5b7240
12    0x1c00 0xce503000  106 de5b7000
13 SH 0x1c00 0x00000000   66   (null)
14    0x9c00 0xce504000   66 de5b90c0
15    0x1c00 0xce504800   66 de5b9a80
16    0x1c00 0xce505000   66 de5b9840
17    0x1c00 0xce505800   66 de5b9000
18    0x1c00 0xce506000   66 de5b9480
19    0x1c00 0xce506800   66 de5b9b40
20    0x1c00 0xce507000   66 de5b9600
21    0x1c00 0xce507800   66 de5b9900
22    0x1c00 0xce508000   66 de5b9180
23    0x1c00 0xce508800   66 de5b9240
24    0x1c00 0xce509000   66 de5b93c0
25    0x1c00 0xce509800   66 de5b9540
26    0x1c00 0xce50a000  106 de5b9780
27    0x1c00 0xce50a800   66 de5b9d80
28    0x1c00 0xce50b000  106 de5b9cc0
29    0x1c00 0xce50b800   66 de5b99c0
30    0x1c00 0xce50c000  106 de5b9300
31    0x1c00 0xce50c800  106 de7e9900
32    0x1c00 0xce50d000   66 de7e9e40
33    0x1c00 0xce50d800  106 de7e96c0
34    0x1c00 0xce50e000   66 de7e9c00
35    0x1c00 0xce50e800  106 de7e9d80
36    0x1c00 0xce50f000  106 de7e9cc0
37    0x1c00 0xce50f800   66 de7e9f00
38    0x1c00 0xce510000  106 de7e9a80
39    0x1c00 0xce510800  106 de7e90c0
40    0x1c00 0xce511000   66 de7e9240
41    0x1c00 0xce511800  106 de7e9000
42    0x1c00 0xce512000  106 de7e9780
43    0x1c00 0xce512800   66 de7e9300
44    0x1c00 0xce513000  106 de7e9840
45    0x1c00 0xce513800  106 de5dbd80
46    0x1c00 0xce514000   66 de5dbb40
47    0x1c00 0xce514800  106 de5db780
48    0x1c00 0xce515000  106 de5db9c0
49    0x1c00 0xce515800   66 de5db600
50    0x1c00 0xce516000  106 de5db540
51    0x1c00 0xce516800  106 de5db000
52    0x1c00 0xce517000   66 de5dbc00
53    0x1c00 0xce517800  106 de5db6c0
54    0x1c00 0xce518000   66 de5db3c0
55    0x1c00 0xce518800  106 de5db300
56    0x1c00 0xce519000  106 de5dbf00
57    0x1c00 0xce519800   66 de5db0c0
58    0x1c00 0xce51a000  106 de5db900
59    0x1c00 0xce51a800  106 de5db240
60    0x1c00 0xce51b000   66 de5dbe40
61    0x1c00 0xce51b800  106 de5db840
62    0x1c00 0xce51c000  106 de5dbcc0
63    0x3c00 0xce51c800  106 de5db180
"
