From: gores@marvell.com (Siddarth Gore)
Date: Mon, 23 Aug 2010 18:22:55 +0530
Subject: memspeed on Aspenite
Message-ID: <1282567975.2777.90.camel@pe-dt434>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The results for memspeed app on Aspenite DB for LSP 2.2.8.2.3 as well as
mainline 2.6.35 kernel, are given below.

* both kernels have L2 cache disabled and L1 cache enabled.
* uncached memory writes are noticeably slower on mainline kernel,
whereas the speeds are comparable when memory block is already present
in L1 (data) cache.
* the reason for this could be slow speed/contention while accessing
main memory, so i repeated the tests with no caching atall (L1 and L2
disabled). These numbers came out same for LSP and mainline kernel.
* further, bandwidth while accessing cached data is also much greater in
the LSP kernel.

I am looking into what might be happening, any ideas/suggestions
welcome.

-siddarth
PS: code used to compile memspeed also attached.

***************Mainline (2.6.35) kernel without L2  (BUFFER = 64k)

~ # ./memspeed -c
*** Memory Write Throughput (in MB/s) ***
method           uncached  write alloc       cached  cached + wa
STRB               188.46       331.38       577.25       899.28
STR                786.38       382.35      2642.50      2652.90
STM4              1624.31       385.44      2909.16      3171.53
STM8              2034.44       386.43      4442.98      3939.27
STRD              1631.52       386.09      3236.05      3941.39

*** Uncached Memory Read/Copy Throughput (in MB/s) ***
method    PLD=0   PLD=1   PLD=2   PLD=4   PLD=8  PLD=16  PLD=32  PLD=64 
LDRB     370.42  370.18  456.03  507.48  541.11  442.01  400.24  380.38
LDR      510.22  505.19  562.18  578.19  599.29  605.76  574.74  535.86
LDM      548.45  532.68  588.53  594.42  602.35  610.00  603.39  559.04
LDRD     477.59  430.61  511.33  552.34  576.48  566.28  498.13  469.23
CPY_B    156.81  156.80  163.67  149.09  152.55  151.11  152.10  154.19
CPY_Bwa  151.67  164.81  162.03  144.64  141.02  147.12  146.84  144.61
CPY_R    305.83  302.81  313.71  283.41  283.56  295.05  311.54  320.04
CPY_Rwa  192.24  207.53  209.01  180.25  175.17  184.07  183.95  180.23
CPY_M    378.40  322.67  417.79  403.85  398.06  396.56  409.38  416.31
CPY_Mwa  198.26  210.24  209.62  182.47  178.10  186.53  187.39  182.89
CPY_D    336.05  315.36  361.08  377.71  356.48  358.65  397.45  399.02
CPY_Dwa  192.46  204.63  203.66  177.79  172.57  181.01  182.23  178.57

*** Cached Memory Read/Copy Throughput (in MB/s) ***
method    PLD=0   PLD=1   PLD=2   PLD=4   PLD=8  PLD=16  PLD=32  PLD=64
LDRB     922.34  871.74  862.09  858.70  846.03  845.91  849.66  846.75
LDR     2900.89 2464.00 2369.34 2328.55 2245.00 2235.03 2255.32 2277.83
LDM     4497.51 3942.53 3027.01 2952.48 2819.55 2821.08 2847.01 2876.93
LDRD    1616.92 1469.47 1458.91 1467.13 1444.78 1447.80 1461.38 1461.31
CPY_B    491.15  486.40  466.49  467.21  463.10  461.04  461.72  465.06
CPY_Bwa  477.82  477.00  462.64  458.03  457.13  454.09  454.84  456.76
CPY_R   1781.87 1685.79 1501.97 1475.36 1451.06 1443.40 1451.77 1459.49
CPY_Rwa 1605.59 1603.00 1429.02 1414.78 1385.34 1379.93 1394.19 1393.15
CPY_M   2666.13 2462.52 2073.39 2037.13 1966.12 1971.33 1991.05 1995.38
CPY_Mwa 2465.72 2275.77 1944.52 1919.53 1861.64 1857.50 1879.41 1873.19
CPY_D   1405.17 1348.93 1267.71 1257.24 1224.85 1225.88 1232.08 1239.05
CPY_Dwa 1342.51 1241.43 1213.40 1207.56 1180.84 1180.08 1189.68 1190.25


***************LSP (2.2.8.2.3) kernel without L2 (BUFFER = 64k)

~ # ./memspeed -c
*** Memory Write Throughput (in MB/s) ***
method           uncached  write alloc       cached  cached + wa
STRB               922.09       335.67       920.63       893.59
STR               1917.30       388.38      2883.57      2648.31
STM4              1630.89       391.49      3501.35      3160.13
STM8              2031.07       392.65      4463.82      3924.40
STRD              2029.12       390.60      4470.54      3931.82

*** Uncached Memory Read/Copy Throughput (in MB/s) ***
method    PLD=0   PLD=1   PLD=2   PLD=4   PLD=8  PLD=16  PLD=32  PLD=64
LDRB     369.06  369.25  452.36  504.15  539.96  437.91  399.73  380.75
LDR      509.63  505.75  559.96  572.86  594.95  601.14  570.57  533.24
LDM      544.69  528.20  585.61  590.51  601.14  606.34  601.24  559.95
LDRD     477.41  429.09  509.10  547.05  571.84  562.20  498.04  469.70
CPY_B    220.17  220.59  276.18  309.26  320.63  290.12  273.31  263.76
CPY_Bwa  145.52  153.85  156.61  139.90  135.80  142.68  142.82  141.49
CPY_R    341.04  338.97  383.76  374.03  373.13  390.59  416.70  412.97
CPY_Rwa  183.95  192.84  199.53  173.22  167.64  177.95  178.17  175.70
CPY_M    347.05  294.75  399.88  378.63  372.31  371.14  397.91  411.09
CPY_Mwa  188.47  195.73  202.40  175.96  171.07  180.76  181.11  178.87
CPY_D    336.53  331.34  357.69  365.06  369.98  379.19  406.97  398.67
CPY_Dwa  184.39  189.68  196.50  171.02  165.10  175.72  175.80  173.78

*** Cached Memory Read/Copy Throughput (in MB/s) ***
method    PLD=0   PLD=1   PLD=2   PLD=4   PLD=8  PLD=16  PLD=32  PLD=64
LDRB     920.36  871.56  859.23  853.41  842.45  842.32  845.01  846.46
LDR     2884.00 2451.59 2356.95 2313.08 2234.44 2233.52 2252.71 2262.72
LDM     4464.70 3924.43 3013.70 2941.92 2816.51 2814.44 2845.41 2860.78
LDRD    1603.57 1460.50 1458.29 1457.61 1441.90 1439.00 1448.91 1454.05
CPY_B    489.71  482.38  465.19  463.44  460.18  460.17  460.94  461.37
CPY_Bwa  475.51  475.38  458.62  456.87  453.79  453.70  454.53  454.88
CPY_R   1776.31 1684.34 1490.75 1473.20 1440.56 1440.44 1448.34 1452.47
CPY_Rwa 1602.42 1601.08 1425.43 1409.13 1379.68 1379.20 1386.52 1390.25
CPY_M   2645.24 2445.68 2058.14 2024.33 1964.26 1963.14 1978.23 1985.58
CPY_Mwa 2445.75 2274.42 1935.22 1905.66 1852.03 1851.33 1864.35 1871.35
CPY_D   1395.71 1338.04 1259.41 1246.73 1224.40 1222.21 1229.33 1232.92
CPY_Dwa 1338.12 1236.86 1212.41 1200.58 1179.88 1177.74 1184.57 1187.82

-------------- next part --------------
A non-text attachment was scrubbed...
Name: memspeed.c
Type: text/x-csrc
Size: 8405 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100823/2c6f0137/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: asm.S
Type: text/x-csrc
Size: 3188 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100823/2c6f0137/attachment-0001.bin>
