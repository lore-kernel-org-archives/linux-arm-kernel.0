From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Thu, 8 May 2014 11:23:15 +0200
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140502114133.GB3693@n2100.arm.linux.org.uk>
References: <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
 <20140401225149.GC7528@n2100.arm.linux.org.uk>
 <OF62048746.594D7A9E-ON87257CB0.006DF18B-87257CB0.006FDEED@grpleg.it>
 <CAGzjT4d8H6YE6P6A1E4aHiPAenJFvZH01LHXaNzVwhF2MRBvWQ@mail.gmail.com>
 <20140502114133.GB3693@n2100.arm.linux.org.uk>
Message-ID: <CAGzjT4ea8CGO7-rgqNt+1zwfyZfeyk9p=VfPbY6ubBJsHGPuKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

2014-05-02 13:41 GMT+02:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Apr 29, 2014 at 11:05:04AM +0200, Jaccon Bastiaansen wrote:
>> Hello all,
>>
>> I tried the FEC patches from Russel
>> (http://ftp.arm.linux.org.uk/cgit/linux-arm.git/log/?h=fec-testing),
>> but with the following test the FEC complety stops receiving frames:
>>
>>
>>  Linux PC <----->  Gigabit Ethernet switch  <------> SabreSD board
>>
>> Both ethernet links run at 1 Gigabit, full duplex.
>>
>> The SabreSD board runs the fec-testing kernel from Russel.
>>
>> On the SabreSD board we run "iperf -s -u"
>>
>> On the Linux PC we
>> - run the iperf client (command used: ?while [ 1 ]; do iperf ?c ?IP
>> address of SabreSD? -u -b 100m -t 300 -l 256;sleep 1;done?)
>> - ping the SabreSD board every second
>>
>> After a while (sometimes 10 seconds, sometimes a couple of minutes),
>> we see that the SabreSD board stops replying to the pings from the
>> Linux PC. Closer inspection shows that the FEC doesn't generate
>> receive frame interrupts anymore. The attached debugger screenshots
>> show the FEC registers when it is in this state. The RXF interrupt is
>> enabled and we know that the FEC is still receiving ethernet frames
>> (because the IEEE_R_FRAME_OK event counter is increasing), but no
>> receive frame interrupts are occurring. We only see MII interrupts
>> occurring.
>
> If the RXF interrupt is enabled, it means that we must have received
> less than NAPI_POLL_WEIGHT (64) frames from the ring during the previous
> NAPI poll - this is the only circumstance when we will re-enable
> interrupts.
>
> There are only two conditions where we stop receiving frames from the
> receive ring:
> 1. if we reach the NAPI poll weight number of frames received.
> 2. if we encounter a packet descriptor marked empty.
>
> It can't be (1) because we would have left the TXF/RXF interrupts
> disabled and waited for the next NAPI poll.  So, it can only be (2).
>
> (2) implies that there is a ring descriptor which is marked as being
> owned by the FEC, which means that there are descriptors free.  Whether
> it's the one which the FEC is expecting to be free or not is something
> that's impossible to tell (the FEC hardware doesn't tell us where it
> is in its ring, which is a big minus point against debugging.)
>
> It would be useful to see the state of the receive ring, as well as
> the rx_next index.  That may be difficult to get though.
>

I added some code to show the RX ring when the reception of frames has
stopped. See the patch below. Reading the fec_rx_ring file gives the
following output (I stripped the bit decoding here to reduce the
number of lines):

0: c0a0d000 0x0800 (== rx_bd_base)
1: c0a0d020 0x0800
2: c0a0d040 0x0800
3: c0a0d060 0x0800
4: c0a0d080 0x0800
5: c0a0d0a0 0x0800
6: c0a0d0c0 0x0800 (== rx_next)
7: c0a0d0e0 0x0800
8: c0a0d100 0x0800
9: c0a0d120 0x0800
10: c0a0d140 0x0800
11: c0a0d160 0x0800
12: c0a0d180 0x0800
13: c0a0d1a0 0x0800
14: c0a0d1c0 0x0800
15: c0a0d1e0 0x0800
16: c0a0d200 0x0800
17: c0a0d220 0x0800
18: c0a0d240 0x0800
19: c0a0d260 0x0800
20: c0a0d280 0x0800
21: c0a0d2a0 0x0800
22: c0a0d2c0 0x0800
23: c0a0d2e0 0x0800
24: c0a0d300 0x0800
25: c0a0d320 0x0800
26: c0a0d340 0x0800
27: c0a0d360 0x0800
28: c0a0d380 0x0800
29: c0a0d3a0 0x0800
30: c0a0d3c0 0x0800
31: c0a0d3e0 0x0800
32: c0a0d400 0x0800
33: c0a0d420 0x0800
34: c0a0d440 0x0800
35: c0a0d460 0x0800
36: c0a0d480 0x0800
37: c0a0d4a0 0x0800
38: c0a0d4c0 0x0800
39: c0a0d4e0 0x0800
40: c0a0d500 0x0800
41: c0a0d520 0x0800
42: c0a0d540 0x0800
43: c0a0d560 0x0800
44: c0a0d580 0x0800
45: c0a0d5a0 0x0800
46: c0a0d5c0 0x0800
47: c0a0d5e0 0x0800
48: c0a0d600 0x0800
49: c0a0d620 0x0800
50: c0a0d640 0x0800
51: c0a0d660 0x0800
52: c0a0d680 0x0800
53: c0a0d6a0 0x0800
54: c0a0d6c0 0x0800
55: c0a0d6e0 0x0800
56: c0a0d700 0x0800
57: c0a0d720 0x0800
58: c0a0d740 0x0800
59: c0a0d760 0x0800
60: c0a0d780 0x0800
61: c0a0d7a0 0x0800
62: c0a0d7c0 0x0800
63: c0a0d7e0 0x0800
64: c0a0d800 0x0800
65: c0a0d820 0x0800
66: c0a0d840 0x0800
67: c0a0d860 0x0800
68: c0a0d880 0x0800
69: c0a0d8a0 0x0800
70: c0a0d8c0 0x0800
71: c0a0d8e0 0x0800
72: c0a0d900 0x0800
73: c0a0d920 0x0800
74: c0a0d940 0x0800
75: c0a0d960 0x0800
76: c0a0d980 0x0800
77: c0a0d9a0 0x0800
78: c0a0d9c0 0x0800
79: c0a0d9e0 0x0800
80: c0a0da00 0x0800
81: c0a0da20 0x0800
82: c0a0da40 0x0800
83: c0a0da60 0x0800
84: c0a0da80 0x0800
85: c0a0daa0 0x0800
86: c0a0dac0 0x0800
87: c0a0dae0 0x0800
88: c0a0db00 0x0800
89: c0a0db20 0x0800
90: c0a0db40 0x0800
91: c0a0db60 0x0800
92: c0a0db80 0x0800
93: c0a0dba0 0x0800
94: c0a0dbc0 0x0800
95: c0a0dbe0 0x0800
96: c0a0dc00 0x0800
97: c0a0dc20 0x0800
98: c0a0dc40 0x0800
99: c0a0dc60 0x0800
100: c0a0dc80 0x0800
101: c0a0dca0 0x0800
102: c0a0dcc0 0x0800
103: c0a0dce0 0x0800
104: c0a0dd00 0x0800
105: c0a0dd20 0x0800
106: c0a0dd40 0x0800
107: c0a0dd60 0x0800
108: c0a0dd80 0x0800
109: c0a0dda0 0x0800
110: c0a0ddc0 0x0800
111: c0a0dde0 0x0800
112: c0a0de00 0x0800
113: c0a0de20 0x0800
114: c0a0de40 0x0800
115: c0a0de60 0x0800
116: c0a0de80 0x0800
117: c0a0dea0 0x0800
118: c0a0dec0 0x0800
119: c0a0dee0 0x0800
120: c0a0df00 0x0800
121: c0a0df20 0x0800
122: c0a0df40 0x0800
123: c0a0df60 0x0800
124: c0a0df80 0x0800
125: c0a0dfa0 0x0800
126: c0a0dfc0 0x0800
127: c0a0dfe0 0x2800

This shows that the complete receive ring is filled with received
frames, which matches with the value 0 in the RDAR register.

The patched FEC driver also logs "FEC receive ring full" when the
receive ring is full after the napi_complete() call and before the
enabling of the RXF interrupt. The kernel logging shows this message a
couple of times. So the RX ring has been filled completely between the
fec_enet_rx() call and the napi_complete() call. In this testcase
(100Megabit, 256 byte frames) it takes less than 3 milliseconds to
completely fill the RX ring. So a preemption between the fec_enet_rx()
call and the napi_complete() call or a long execution time of the
fec_enet_tx() function (which is called between fec_enet_rx() and
napi_complete() ) results in the enabling of the RXF interrupt when
the RX ring is completely full. It seems that in that case the RXF
interrupt will not be generated anymore.



@@ -23,17 +23,20 @@

 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/ptrace.h>
+#include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
@@ -1164,11 +1167,17 @@ static int fec_enet_rx_napi(struct napi_struct
*napi, int budget)

     fec_enet_tx(ndev);

     if (pkts < budget) {
         napi_complete(napi);
-        writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+        if (readl(fep->hwp + FEC_R_DES_ACTIVE) == 0) {
+            writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+            printk(KERN_ERR "%llu FEC: receive ring full!!!\n",
+                sched_clock());
+        } else {
+            writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+        }
     }
     return pkts;
 }

 /* ------------------------------------------------------------------------- */
@@ -2404,10 +2413,79 @@ static void fec_reset_phy(struct platform_device *pdev)
      * by machine code.
      */
 }
 #endif /* CONFIG_OF */

+#define BDRX_EMPTY    (1 << 15)
+#define BDRX_RO1    (1 << 14)
+#define BDRX_WRAP    (1 << 13)
+#define BDRX_RO2    (1 << 12)
+#define BDRX_LAST    (1 << 11)
+#define BDRX_UNDEF10    (1 << 10)
+#define BDRX_UNDEF9    (1 << 9)
+#define BDRX_MISS    (1 << 8)
+#define BDRX_BCAST    (1 << 7)
+#define BDRX_MCAST    (1 << 6)
+#define BDRX_LENERR    (1 << 5)
+#define BDRX_ALGNERR    (1 << 4)
+#define BDRX_UNDEF3    (1 << 3)
+#define BDRX_CRCERR    (1 << 2)
+#define BDRX_OVERRUN    (1 << 1)
+#define BDRX_TRUNC    (1 << 0)
+
+
+static int fec_rx_ring_show(struct seq_file *s, void *p)
+{
+    struct fec_enet_private *fep = s->private;
+    int nbds;
+    union bufdesc_u *bd;
+
+    bd = fep->rx_bd_base;
+    for (nbds = 0;nbds < fep->rx_ring_size;nbds++) {
+        seq_printf(s, "%d: %p 0x%.4x", nbds, bd, bd->ebd.desc.cbd_sc);
+        if (bd == fep->rx_bd_base)
+            seq_printf(s, " (== rx_bd_base)");
+        if (nbds == fep->rx_next)
+            seq_printf(s, " (== rx_next)");
+        seq_printf(s, "\n");
+        seq_printf(s,
+               "  [15]%s [14]%s [13]%s [12]%s [11]%s [10]%s [ 9]%s [ 8]%s"
+               "  [ 7]%s [ 6]%s [ 5]%s [ 4]%s [ 3]%s [ 2]%s [ 1]%s [ 0]%s\n",
+               bd->ebd.desc.cbd_sc & BDRX_EMPTY   ? "EMP" : "emp",
+               bd->ebd.desc.cbd_sc & BDRX_RO1     ? "RO1" : "ro1",
+               bd->ebd.desc.cbd_sc & BDRX_WRAP    ? "WRP" : "wrp",
+               bd->ebd.desc.cbd_sc & BDRX_RO2     ? "RO2" : "ro2",
+               bd->ebd.desc.cbd_sc & BDRX_LAST    ? "LST" : "lst",
+               bd->ebd.desc.cbd_sc & BDRX_UNDEF10 ? "UNA" : "una",
+               bd->ebd.desc.cbd_sc & BDRX_UNDEF9  ? "UN9" : "un9",
+               bd->ebd.desc.cbd_sc & BDRX_MISS    ? "MIS" : "mis",
+               bd->ebd.desc.cbd_sc & BDRX_BCAST   ? "BCS" : "bcs",
+               bd->ebd.desc.cbd_sc & BDRX_MCAST   ? "MCS" : "mcs",
+               bd->ebd.desc.cbd_sc & BDRX_LENERR  ? "LEN" : "len",
+               bd->ebd.desc.cbd_sc & BDRX_ALGNERR ? "ALN" : "aln",
+               bd->ebd.desc.cbd_sc & BDRX_UNDEF3  ? "UN3" : "un3",
+               bd->ebd.desc.cbd_sc & BDRX_CRCERR  ? "CRC" : "crc",
+               bd->ebd.desc.cbd_sc & BDRX_OVERRUN ? "OVR" : "ovr",
+               bd->ebd.desc.cbd_sc & BDRX_TRUNC   ? "TRC" : "trc");
+        bd += 1;
+    }
+    return 0;
+}
+
+static int fec_rx_ring_open(struct inode *inode, struct file *file)
+{
+    struct fec_enet_private *fep = inode->i_private;
+    return single_open(file, fec_rx_ring_show, fep);
+}
+
+static const struct file_operations fec_rx_ring_fops = {
+    .open        = fec_rx_ring_open,
+    .read        = seq_read,
+    .llseek        = seq_lseek,
+    .release    = single_release,
+};
+
 static int
 fec_probe(struct platform_device *pdev)
 {
     struct fec_enet_private *fep;
     struct fec_platform_data *pdata;
@@ -2558,10 +2636,18 @@ fec_probe(struct platform_device *pdev)

     if (fep->flags & FEC_FLAG_BUFDESC_EX && fep->ptp_clock)
         netdev_info(ndev, "registered PHC device %d\n", fep->dev_id);

     INIT_WORK(&fep->tx_timeout_work, fec_enet_timeout_work);
+
+    if (!debugfs_create_file("fec_rx_ring",
+                 S_IFREG | S_IRUGO,
+                 NULL,
+                 fep,
+                 &fec_rx_ring_fops))
+        goto failed_register;
+
     return 0;

 failed_register:
     fec_enet_mii_remove(fep);
 failed_mii_init:



Regards,
  Jaccon
