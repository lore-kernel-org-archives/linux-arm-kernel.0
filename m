From: robert.daniels@vantagecontrols.com (robert.daniels at vantagecontrols.com)
Date: Mon, 24 Mar 2014 11:57:18 -0600
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140321173252.GL7528@n2100.arm.linux.org.uk>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de> <201403200501.16881.marex@denx.de>
 <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
 <20140320230559.GF7528@n2100.arm.linux.org.uk>
 <532B86A7.5010200@boundarydevices.com>
 <20140321011843.GG7528@n2100.arm.linux.org.uk>
 <CAOMZO5A+e+mHw1EG9t983ZG_KVL_O1r5UVwUU3JBsU5yPxOBsA@mail.gmail.com>
 <CAOMZO5CxjCHLrY0KTe4j=NiSU3CQVNZWhEAs33Le8ji3NAFETQ@mail.gmail.com>
 <CANBf9eNZB+BVBDkgWNxxGs-ndQ-mYCc6+bfVdS-8T-QLpSZ3GA@mail.gmail.com>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
Message-ID: <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Russell King - ARM Linux <linux@arm.linux.org.uk> wrote on 03/21/2014
11:32:53 AM:

> Hmm, rt kernels.  Does this happen without the rt patches applied?

I am not using the rt patches and I still see the problem.  I'm using
3.14.0-rc6+ with
fec patches on the i.MX53 Quick Start Board with the latest U-Boot.

When I run my test I will immediately see packet loss with the eventual tx
timeout issue.

These are the steps I use to reproduce the problem:

Setup: Desktop (Ubuntu 12.04: webfs, iperf3, /srv/ftp/test.bmp ~27 MB)
       i.MX53 Quick Start Board (linux 3.14.0-rc6+ with fec patches:
iperf3, wget)

Test:

  Desktop:
    iperf3 -s -V

  i.MX53 QSB:
    ssh 1> iperf3 -c 192.168.1.101 -u -l 64 -b 55M -V -t 1000
    ssh 2> cd /tmp; while true; do date; wget
http://192.168.1.101:8000/test.bmp; rm -fv /tmp/test.bmp; done

Now for the verbose explanation, I installed webfs on my Ubuntu desktop
machine and put
a ~27 MB bmp file in the web_root directory for the i.MX53 QSB to access.
I built iperf3
and ran the server on my Ubuntu desktop machine in verbose mode.

On the i.MX53 QSB I connect with ssh and run iperf3 with the above options.
I then open
another ssh session and run the wget command from above which continuously
transfers the
test.bmp from my desktop.  As soon as I start the wget I start seeing
packet loss
from iperf3.  After a while I will also see the tx timeout.

The following is what I see from iperf3 on the desktop:

-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Time: Mon, 24 Mar 2014 16:42:13 GMT
Accepted connection from 192.168.1.169, port 48609
      Cookie: ic-ii-0.4872.965116.71cd138c70e6e36e
[  5] local 192.168.1.101 port 5201 connected to 192.168.1.169 port 56375
Starting Test: protocol: UDP, 1 streams, 64 byte blocks, omitting 0
seconds, 1000 second test
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total
Datagrams
[  5]   0.00-1.00   sec   879 KBytes  7.20 Mbits/sec  0.087 ms  0/14064
(0%)
[  5]   1.00-2.00   sec   910 KBytes  7.46 Mbits/sec  0.088 ms  0/14568
(0%)
[  5]   2.00-3.00   sec   910 KBytes  7.46 Mbits/sec  0.086 ms  0/14562
(0%)
[  5]   3.00-4.00   sec   891 KBytes  7.30 Mbits/sec  0.086 ms  0/14259
(0%)
[  5]   4.00-5.00   sec   891 KBytes  7.30 Mbits/sec  0.084 ms  0/14250
(0%)
[  5]   5.00-6.00   sec   913 KBytes  7.48 Mbits/sec  0.084 ms  0/14612
(0%)
[  5]   6.00-7.00   sec   913 KBytes  7.48 Mbits/sec  0.085 ms  0/14615
(0%)
[  5]   7.00-8.00   sec   806 KBytes  6.60 Mbits/sec  0.246 ms  0/12893
(0%)
[  5]   8.00-9.00   sec   327 KBytes  2.68 Mbits/sec  2.748 ms  1/5230
(0.019%)   <----- Start of wget transfers
[  5]   9.00-10.00  sec   294 KBytes  2.41 Mbits/sec  0.191 ms  13/4715
(0.28%)
[  5]  10.00-11.00  sec   301 KBytes  2.46 Mbits/sec  0.184 ms  11/4820
(0.23%)
[  5]  11.00-12.00  sec   351 KBytes  2.88 Mbits/sec  0.373 ms  0/5616 (0%)
[  5]  12.00-13.00  sec   289 KBytes  2.36 Mbits/sec  0.086 ms  4/4622
(0.087%)
[  5]  13.00-14.00  sec   303 KBytes  2.48 Mbits/sec  0.084 ms  18/4859
(0.37%)
[  5]  14.00-15.00  sec   369 KBytes  3.03 Mbits/sec  0.094 ms  0/5911 (0%)
[  5]  15.00-16.00  sec   283 KBytes  2.32 Mbits/sec  0.193 ms  6/4537
(0.13%)
[  5]  16.00-17.00  sec   277 KBytes  2.27 Mbits/sec  0.146 ms  12/4441
(0.27%)
[  5]  17.00-18.00  sec   366 KBytes  3.00 Mbits/sec  0.054 ms  0/5850 (0%)
[  5]  18.00-19.00  sec   287 KBytes  2.35 Mbits/sec  0.085 ms  5/4604
(0.11%)
[  5]  19.00-20.00  sec   276 KBytes  2.26 Mbits/sec  0.081 ms  10/4429
(0.23%)
[  5]  20.00-21.00  sec   362 KBytes  2.97 Mbits/sec  0.417 ms  1/5798
(0.017%)
[  5]  21.00-22.00  sec   301 KBytes  2.47 Mbits/sec  0.089 ms  6/4826
(0.12%)
[  5]  22.00-23.00  sec   278 KBytes  2.28 Mbits/sec  0.228 ms  15/4471
(0.34%)
[  5]  23.00-24.00  sec   379 KBytes  3.10 Mbits/sec  0.130 ms  7/6068
(0.12%)
[  5]  24.00-25.00  sec   318 KBytes  2.60 Mbits/sec  0.083 ms  2/5087
(0.039%)
[  5]  25.00-26.00  sec   279 KBytes  2.29 Mbits/sec  0.301 ms  11/4476
(0.25%)
[  5]  26.00-27.00  sec   350 KBytes  2.86 Mbits/sec  0.059 ms  11/5605
(0.2%)
[  5]  27.00-28.00  sec   324 KBytes  2.65 Mbits/sec  0.597 ms  1/5179
(0.019%)
[  5]  28.00-29.00  sec   284 KBytes  2.32 Mbits/sec  0.088 ms  13/4549
(0.29%)
[  5]  29.00-30.00  sec   339 KBytes  2.77 Mbits/sec  0.442 ms  12/5431
(0.22%)
[  5]  30.00-31.00  sec   317 KBytes  2.60 Mbits/sec  0.122 ms  1/5074
(0.02%)
[  5]  31.00-32.00  sec   278 KBytes  2.28 Mbits/sec  0.099 ms  10/4458
(0.22%)
[  5]  32.00-33.00  sec   328 KBytes  2.68 Mbits/sec  0.043 ms  12/5252
(0.23%)
[  5]  33.00-34.00  sec   316 KBytes  2.59 Mbits/sec  0.445 ms  1/5060
(0.02%)
[  5]  34.00-35.00  sec   277 KBytes  2.27 Mbits/sec  1.432 ms  13/4445
(0.29%)
[  5]  35.00-36.00  sec   345 KBytes  2.83 Mbits/sec  0.089 ms  12/5535
(0.22%)
[  5]  36.00-37.00  sec   360 KBytes  2.95 Mbits/sec  0.143 ms  0/5768 (0%)
[  5]  37.00-38.00  sec   292 KBytes  2.39 Mbits/sec  0.460 ms  3/4671
(0.064%)
[  5]  38.00-39.00  sec   290 KBytes  2.37 Mbits/sec  0.095 ms  14/4649
(0.3%)
[  5]  39.00-40.00  sec   353 KBytes  2.89 Mbits/sec  0.318 ms  1/5643
(0.018%)
[  5]  40.00-41.00  sec   297 KBytes  2.44 Mbits/sec  0.707 ms  3/4761
(0.063%)
[  5]  41.00-42.00  sec   270 KBytes  2.21 Mbits/sec  0.173 ms  18/4335
(0.42%)
[  5]  42.00-43.00  sec   359 KBytes  2.94 Mbits/sec  0.452 ms  1/5750
(0.017%)
[  5]  43.00-44.00  sec   294 KBytes  2.41 Mbits/sec  0.112 ms  4/4703
(0.085%)
[  5]  44.00-45.00  sec   272 KBytes  2.23 Mbits/sec  0.134 ms  18/4371
(0.41%)
[  5]  45.00-46.00  sec   385 KBytes  3.16 Mbits/sec  0.090 ms  3/6170
(0.049%)
[  5]  46.00-47.00  sec   309 KBytes  2.53 Mbits/sec  0.735 ms  2/4949
(0.04%)
[  5]  47.00-48.00  sec   288 KBytes  2.36 Mbits/sec  0.206 ms  13/4622
(0.28%)
[  5]  48.00-49.00  sec   356 KBytes  2.92 Mbits/sec  0.107 ms  4/5707
(0.07%)
[  5]  49.00-50.00  sec   292 KBytes  2.39 Mbits/sec  1.680 ms  4/4670
(0.086%)
[  5]  50.00-51.00  sec   262 KBytes  2.15 Mbits/sec  0.646 ms  12/4202
(0.29%)
[  5]  51.00-52.00  sec   349 KBytes  2.86 Mbits/sec  0.151 ms  11/5597
(0.2%)
[  5]  52.00-53.00  sec   313 KBytes  2.56 Mbits/sec  0.076 ms  3/5011
(0.06%)
[  5]  53.00-54.00  sec   278 KBytes  2.27 Mbits/sec  0.436 ms  16/4456
(0.36%)
[  5]  54.00-55.00  sec   361 KBytes  2.95 Mbits/sec  0.086 ms  3/5772
(0.052%)
[  5]  55.00-56.00  sec   312 KBytes  2.56 Mbits/sec  0.422 ms  1/4992
(0.02%)
[  5]  56.00-57.00  sec   292 KBytes  2.39 Mbits/sec  0.134 ms  14/4683
(0.3%)
[  5]  57.00-58.00  sec   344 KBytes  2.82 Mbits/sec  0.090 ms  6/5513
(0.11%)
[  5]  58.00-59.00  sec   200 KBytes  1.64 Mbits/sec  0.811 ms  1/3199
(0.031%)
[  5]  59.00-60.00  sec  0.00 Bytes  0.00 bits/sec  0.811 ms  0/0 (-nan%)
<----- Coincides with the tx timeout
[  5]  60.00-61.00  sec  0.00 Bytes  0.00 bits/sec  0.811 ms  0/0 (-nan%)
[  5]  61.00-62.00  sec  84.2 KBytes   690 Kbits/sec  0.032 ms  0/1347 (0%)
[  5]  62.00-63.00  sec   307 KBytes  2.52 Mbits/sec  0.243 ms  0/4915 (0%)
[  5]  63.00-64.00  sec   301 KBytes  2.47 Mbits/sec  0.044 ms  0/4820 (0%)
[  5]  64.00-65.00  sec   391 KBytes  3.21 Mbits/sec  0.053 ms  1/6263
(0.016%)
[  5]  65.00-66.00  sec   364 KBytes  2.98 Mbits/sec  0.431 ms  0/5828 (0%)

Here is another tx timeout dump:

Jan  1fec 63fec000.ethernet eth0: TX ring dump
Nr    SC     addr       len  SKB
 0    0x1c00 0xce485000  106 dec7bf00
 1    0x1c00 0xce485800  106 dec7bcc0
 2    0x1c00 0xce486000  106 dec7b480
 3    0x1c00 0xce486800  106 dec7b840
 4    0x1c00 0xce487000  106 dec7b3c0
 5    0x1c00 0xce487800  106 dec7b600
 6    0x1c00 0xce500000  106 dec7b780
 7    0x1c00 0xce500800  106 dec7be40
 8    0x1c00 0xce501000  106 dec7b9c0
 9    0x1c00 0xce501800  106 dec7bb40
10    0x1c00 0xce502000  106 dec7b180
11    0x1c00 0xce502800  106 de7b2540
12    0x1c00 0xce503000  106 de7b2480
13    0x1c00 0xce503800  106 de7b2900
14    0x1c00 0xce504000  106 de7b2d80
15    0x1c00 0xce504800  106 de7b23c0
16    0x1c00 0xce505000  106 de7b2cc0
17    0x1c00 0xce505800  106 de7b2000
18    0x1c00 0xce506000  106 de7b2b40
19    0x1c00 0xce506800  106 de7b2840
20    0x1c00 0xce507000  106 de7b2780
21    0x1c00 0xce507800  106 de7b2300
22    0x1c00 0xce508000  106 de7b2e40
23    0x1c00 0xce508800  106 de7b2180
24    0x1c00 0xce509000  106 de7b2c00
25    0x1c00 0xce509800  106 de7b29c0
26    0x1c00 0xce50a000  106 de7b2240
27    0x1c00 0xce50a800  106 de7b2a80
28    0x1c00 0xce50b000  106 de7b2600
29    0x1c00 0xce50b800  106 de7b20c0
30    0x1c00 0xce50c000  106 de7ea780
31    0x1c00 0xce50c800  106 de7ea480
32    0x1c00 0xce50d000  106 de7ea900
33 SH 0x1c00 0x00000000  106   (null)
34    0x9c00 0xce50e000  106 de120e40
35    0x1c00 0xce50e800  106 de120f00
36    0x1c00 0xce50f000  106 de120840
37    0x1c00 0xce50f800  106 de120600
38    0x1c00 0xce510000   66 de1209c0
39    0x1c00 0xce510800  106 de120a80
40    0x1c00 0xce511000  106 de120cc0
41    0x1c00 0xce511800   66 de120000
42    0x1c00 0xce512000  106 de1200c0
43    0x1c00 0xce512800  106 de120780
44    0x1c00 0xce513000  106 de120c00
45    0x1c00 0xce513800   66 de120b40
46    0x1c00 0xce514000  106 de120540
47    0x1c00 0xce514800  106 de120900
48    0x1c00 0xce515000   66 de120240
49    0x1c00 0xce515800  106 de120d80
50    0x1c00 0xce516000  106 de1203c0
51    0x1c00 0xce516800   66 de120480
52    0x1c00 0xce517000  106 de120300
53    0x1c00 0xce517800  106 de120180
54    0x1c00 0xce518000   66 dec7b000
55    0x1c00 0xce518800  106 dec7b300
56    0x1c00 0xce519000  106 dec7b0c0
57    0x1c00 0xce519800   66 dec7b540
58    0x1c00 0xce51a000  106 dec7bc00
59    0x1c00 0xce51a800  106 dec7ba80
60    0x1c00 0xce51b000   66 dec7b900
61    0x1c00 0xce51b800  106 dec7bd80
62    0x1c00 0xce51c000  106 dec7b240
63    0x3c00 0xce51c800  106 dec7b6c0


As the test continues to run, the tx timeout will continue to happen.  I
monitored the sequence of tx timeouts to see
if there was anything interesting about which buffer descriptors were
having problems - here is the sequence:

15, 60, 57, 54, 53, 6, 18, 47, 24, 54, 23, 9, 39, 14


This email, and any document attached hereto, may contain
confidential and/or privileged information.  If you are not the
intended recipient (or have received this email in error) please
notify the sender immediately and destroy this email.  Any
unauthorized, direct or indirect, copying, disclosure, distribution
or other use of the material or parts thereof is strictly
forbidden.
