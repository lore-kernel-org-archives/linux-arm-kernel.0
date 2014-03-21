From: berndfaust@gmail.com (Bernd Faust)
Date: Fri, 21 Mar 2014 17:37:28 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <CAOMZO5CxjCHLrY0KTe4j=NiSU3CQVNZWhEAs33Le8ji3NAFETQ@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de>
 <201403200501.16881.marex@denx.de>
 <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
 <20140320230559.GF7528@n2100.arm.linux.org.uk>
 <532B86A7.5010200@boundarydevices.com>
 <20140321011843.GG7528@n2100.arm.linux.org.uk>
 <CAOMZO5A+e+mHw1EG9t983ZG_KVL_O1r5UVwUU3JBsU5yPxOBsA@mail.gmail.com>
 <CAOMZO5CxjCHLrY0KTe4j=NiSU3CQVNZWhEAs33Le8ji3NAFETQ@mail.gmail.com>
Message-ID: <CANBf9eNOTvfgKCQm032CPjDrEA2ZDsu7BWXUC6Ut_H9PTHC8+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I also tried the patch, but unfortunately it doesn't work for me either.
I get the same error as Robert Daniels. My target is a i.MX6 (Cortex
A9, single core) running Linux Kernel version 3.10.9-rt5+

Test done:
  Start iperf server on target
    $ iperf -s -u &

   Let iperf client run for 10 minutes on the host
    $ iperf -c <ip_target> -u -b 100m -t 600 -l 256

  Also start a ping from host to target, to easily detect when the error occurs
    $ ping <ip_target>


Without the patch applied I see the following behavior:
After some time the ping from host to target stopped.
As soon as iperf was ready I started a ping from target to host.
By doing that the network came back to life: the ping from host to
target resumed.

With the patch applied the following happens:
After some amount of time the ping stops, but I've seen large ping
times (up to 9000ms) before it does that.
After iperf is done, the connection was dead. (just like without the patch)
The difference now is that the ping from host to target started
reporting "Destination Host Unreachable" after iperf has finished
and the ping from target to host didn't bring the connection back to
life: it reported 100% packet loss.

dmesg output on target shows the following:

------------[ cut here ]------------
WARNING: at /home/bfa/linux/net/sched/sch_generic.c:255
dev_watchdog+0x380/0x390()
NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
Modules linked in:
CPU: 0 PID: 3 Comm: ksoftirqd/0 Tainted: G           O 3.10.9-rt5+ #3
Backtrace:
[<80012cf0>] (dump_backtrace+0x0/0x118) from [<800130f0>] (show_stack+0x20/0x24)
 r6:000000ff r5:8046caf8 r4:9f8d1d80 r3:00000000
[<800130d0>] (show_stack+0x0/0x24) from [<8054c9f0>] (dump_stack+0x24/0x28)
[<8054c9cc>] (dump_stack+0x0/0x28) from [<80020d84>]
(warn_slowpath_common+0x64/0x78)
[<80020d20>] (warn_slowpath_common+0x0/0x78) from [<80020e54>]
(warn_slowpath_fmt+0x40/0x48)
 r8:8076ea10 r7:8072c2c0 r6:00000000 r5:9f837214 r4:9f837000
r3:00000009
[<80020e14>] (warn_slowpath_fmt+0x0/0x48) from [<8046caf8>]
(dev_watchdog+0x380/0x390)
 r3:9f837000 r2:8069ab98
[<8046c778>] (dev_watchdog+0x0/0x390) from [<800326c8>]
(call_timer_fn+0x54/0x1ac)
[<80032674>] (call_timer_fn+0x0/0x1ac) from [<80032a58>]
(run_timer_softirq+0x238/0x2ec)
[<80032820>] (run_timer_softirq+0x0/0x2ec) from [<8002a180>]
(handle_softirq+0x84/0x1e8)
[<8002a0fc>] (handle_softirq+0x0/0x1e8) from [<8002a344>]
(do_single_softirq+0x60/0x90)
[<8002a2e4>] (do_single_softirq+0x0/0x90) from [<8002a4e4>]
(do_current_softirqs+0x170/0x1a8)
 r7:80735620 r6:807b2440 r5:9f8d0000 r4:00000001
[<8002a374>] (do_current_softirqs+0x0/0x1a8) from [<8002a55c>]
(run_ksoftirqd+0x40/0x60)
[<8002a51c>] (run_ksoftirqd+0x0/0x60) from [<800516a8>]
(smpboot_thread_fn+0x23c/0x2b0)
 r5:9f8d0000 r4:9f827540
[<8005146c>] (smpboot_thread_fn+0x0/0x2b0) from [<80047684>] (kthread+0xb4/0xb8)
[<800475d0>] (kthread+0x0/0xb8) from [<8000edd8>] (ret_from_fork+0x14/0x20)
 r7:00000000 r6:00000000 r5:800475d0 r4:9f8c3e5c
---[ end trace 0000000000000002 ]---
fec 2188000.ethernet eth0: TX ring dump
Nr    SC     addr       len  SKB
 0    0x1c00 0x2e853000   98 9e8b6000
 1    0x1c00 0x2e853800   98 9e9bb6c0
 2    0x1c00 0x2e9c4000   98 9e841a80
 3    0x1c00 0x2e9c4800   98 9e841000
 4    0x1c00 0x2e9c5000   98 9e8c3480
 5    0x1c00 0x2e9c5800   98 9e9bb540
 6    0x1c00 0x2e9c6000   98 9e8b4f00
 7    0x1c00 0x2e9c6800   98 9e941e40
 8    0x1c00 0x2e9c7000   98 9e941300
 9    0x1c00 0x2e9c7800   98 9e941780
10    0x1c00 0x2e9cc000   98 9e8b4d80
11    0x1c00 0x2e9cc800   98 9e8b4b40
12    0x1c00 0x2e9cd000   98 9e8b4a80
13    0x1c00 0x2e9cd800   98 9e8b4600
14    0x1c00 0x2e9ce000   98 9e941600
15    0x1c00 0x2e9ce800   98 9e8b4540
16    0x1c00 0x2e9cf000   98 9e8b4180
17    0x1c00 0x2e9cf800   98 9e9419c0
18    0x1c00 0x2e9f8000   98 9e8b4300
19    0x1c00 0x2e9f8800   98 9e941840
20    0x1c00 0x2e9f9000   98 9e8b4cc0
21    0x1c00 0x2e9f9800   98 9e8b49c0
22    0x1c00 0x2e9fa000   98 9e8416c0
23    0x1c00 0x2e9fa800   98 9e8c1b40
24    0x1c00 0x2e9fb000   98 9e9ad900
25    0x1c00 0x2e9fb800   98 9e9ad300
26    0x1c00 0x2e9fc000   98 9e9ad840
27    0x1c00 0x2e9fc800   98 9e9ad000
28    0x1c00 0x2e9fd000   98 9e941b40
29    0x1c00 0x2e9fd800   98 9e8b6240
30    0x1c00 0x2e9fe000   98 9e941f00
31    0x1c00 0x2e9fe800   98 9e941000
32    0x1c00 0x2e9ff000   98 9e941a80
33    0x1c00 0x2e9ff800   98 9e8b4e40
34    0x1c00 0x2ea00000   98 9e9ad600
35    0x1c00 0x2ea00800   98 9e8413c0
36    0x1c00 0x2ea01000   98 9e841c00
37    0x1c00 0x2ea01800   98 9e8b6300
38    0x1c00 0x2ea02000   98 9e8b6c00
39    0x1c00 0x2ea02800   98 9e8b40c0
40    0x1c00 0x2ea03000   98 9e841e40
41    0x1c00 0x2ea03800   98 9e8c1600
42    0x1c00 0x2ea04000   98 9e8c1c00
43    0x1c00 0x2ea04800   98 9e9ad6c0
44    0x1c00 0x2ea05000   98 9e9bb0c0
45    0x1c00 0x2ea05800   98 9e9ad480
46    0x1c00 0x2ea06000   98 9e841900
47    0x1c00 0x2ea06800   98 9e8b4240
48    0x1c00 0x2ea07000   98 9e8b4000
49    0x1c00 0x2ea07800   98 9e8b4840
50    0x1c00 0x2ea08000   98 9e9ad240
51    0x1c00 0x2ea08800   98 9e9b19c0
52    0x1c00 0x2ea09000   98 9e941240
53    0x1c00 0x2ea09800   98 9e841600
54    0x1c00 0x2ea0a000   98 9e9bb780
55    0x1c00 0x2ea0a800   98 9e9b1480
56    0x1c00 0x2ea0b000   98 9e9bb600
57    0x1c00 0x2ea0b800   98 9e9b13c0
58    0x1c00 0x2ea0c000   98 9e9ada80
59    0x1c00 0x2ea0c800   98 9e9ad0c0
60 SH 0x1c00 0x00000000   98   (null)
61    0x9c00 0x2ea0d800   98 9e841b40
62    0x1c00 0x2ea0e000   98 9e9bb240
63    0x3c00 0x2ea0e800   98 9e8c3f00


both situations are very reproducible.
I've you have suggestions on what I can do or test, please let me know.

regards,
Bernd Faust

On 21 March 2014 02:43, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Mar 20, 2014 at 10:36 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Robert's tests were made on a mx53 (single CortexA9), and its cache
>> controller is not the L310.
>
> Ops, I meant CortexA8.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
