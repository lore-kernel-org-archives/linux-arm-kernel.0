From: tnowicki@caviumnetworks.com (Tomasz Nowicki)
Date: Wed, 9 May 2018 15:20:42 +0200
Subject: [PATCH v8 00/13] Support PPTT for ARM64
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
Message-ID: <588884ff-d6ad-e111-6fe7-b30356c00945@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.04.2018 01:31, Jeremy Linton wrote:
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to describe the processor and cache topology. Ideally it is
> used to extend/override information provided by the hardware, but
> right now ARM64 is entirely dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> When we enable ACPI/PPTT for arm64 we map the package_id to the
> PPTT node flagged as the physical package by the firmware.
> This results in topologies that match what the remainder of the
> system expects. Finally, we update the scheduler MC domain so that
> it generally reflects the LLC unless the LLC is too large for the
> NUMA domain (or package).

Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>

Tested on ThunderX2:

Machine (511GB total)
   NUMANode L#0 (P#0 256GB)
     Package L#0 + L3 L#0 (32MB)
       L2 L#0 (256KB) + L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0
         PU L#0 (P#0)
         PU L#1 (P#32)
         PU L#2 (P#64)
         PU L#3 (P#96)
       L2 L#1 (256KB) + L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1
         PU L#4 (P#1)
         PU L#5 (P#33)
         PU L#6 (P#65)
         PU L#7 (P#97)
       L2 L#2 (256KB) + L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2
         PU L#8 (P#2)
         PU L#9 (P#34)
         PU L#10 (P#66)
         PU L#11 (P#98)
       L2 L#3 (256KB) + L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3
         PU L#12 (P#3)
         PU L#13 (P#35)
         PU L#14 (P#67)
         PU L#15 (P#99)
       L2 L#4 (256KB) + L1d L#4 (32KB) + L1i L#4 (32KB) + Core L#4
         PU L#16 (P#4)
         PU L#17 (P#36)
         PU L#18 (P#68)
         PU L#19 (P#100)
       L2 L#5 (256KB) + L1d L#5 (32KB) + L1i L#5 (32KB) + Core L#5
         PU L#20 (P#5)
         PU L#21 (P#37)
         PU L#22 (P#69)
         PU L#23 (P#101)
       L2 L#6 (256KB) + L1d L#6 (32KB) + L1i L#6 (32KB) + Core L#6
         PU L#24 (P#6)
         PU L#25 (P#38)
         PU L#26 (P#70)
         PU L#27 (P#102)
       L2 L#7 (256KB) + L1d L#7 (32KB) + L1i L#7 (32KB) + Core L#7
         PU L#28 (P#7)
         PU L#29 (P#39)
         PU L#30 (P#71)
         PU L#31 (P#103)
       L2 L#8 (256KB) + L1d L#8 (32KB) + L1i L#8 (32KB) + Core L#8
         PU L#32 (P#8)
         PU L#33 (P#40)
         PU L#34 (P#72)
         PU L#35 (P#104)
       L2 L#9 (256KB) + L1d L#9 (32KB) + L1i L#9 (32KB) + Core L#9
         PU L#36 (P#9)
         PU L#37 (P#41)
         PU L#38 (P#73)
         PU L#39 (P#105)
       L2 L#10 (256KB) + L1d L#10 (32KB) + L1i L#10 (32KB) + Core L#10
         PU L#40 (P#10)
         PU L#41 (P#42)
         PU L#42 (P#74)
         PU L#43 (P#106)
       L2 L#11 (256KB) + L1d L#11 (32KB) + L1i L#11 (32KB) + Core L#11
         PU L#44 (P#11)
         PU L#45 (P#43)
         PU L#46 (P#75)
         PU L#47 (P#107)
       L2 L#12 (256KB) + L1d L#12 (32KB) + L1i L#12 (32KB) + Core L#12
         PU L#48 (P#12)
         PU L#49 (P#44)
         PU L#50 (P#76)
         PU L#51 (P#108)
       L2 L#13 (256KB) + L1d L#13 (32KB) + L1i L#13 (32KB) + Core L#13
         PU L#52 (P#13)
         PU L#53 (P#45)
         PU L#54 (P#77)
         PU L#55 (P#109)
       L2 L#14 (256KB) + L1d L#14 (32KB) + L1i L#14 (32KB) + Core L#14
         PU L#56 (P#14)
         PU L#57 (P#46)
         PU L#58 (P#78)
         PU L#59 (P#110)
       L2 L#15 (256KB) + L1d L#15 (32KB) + L1i L#15 (32KB) + Core L#15
         PU L#60 (P#15)
         PU L#61 (P#47)
         PU L#62 (P#79)
         PU L#63 (P#111)
       L2 L#16 (256KB) + L1d L#16 (32KB) + L1i L#16 (32KB) + Core L#16
         PU L#64 (P#16)
         PU L#65 (P#48)
         PU L#66 (P#80)
         PU L#67 (P#112)
       L2 L#17 (256KB) + L1d L#17 (32KB) + L1i L#17 (32KB) + Core L#17
         PU L#68 (P#17)
         PU L#69 (P#49)
         PU L#70 (P#81)
         PU L#71 (P#113)
       L2 L#18 (256KB) + L1d L#18 (32KB) + L1i L#18 (32KB) + Core L#18
         PU L#72 (P#18)
         PU L#73 (P#50)
         PU L#74 (P#82)
         PU L#75 (P#114)
       L2 L#19 (256KB) + L1d L#19 (32KB) + L1i L#19 (32KB) + Core L#19
         PU L#76 (P#19)
         PU L#77 (P#51)
         PU L#78 (P#83)
         PU L#79 (P#115)
       L2 L#20 (256KB) + L1d L#20 (32KB) + L1i L#20 (32KB) + Core L#20
         PU L#80 (P#20)
         PU L#81 (P#52)
         PU L#82 (P#84)
         PU L#83 (P#116)
       L2 L#21 (256KB) + L1d L#21 (32KB) + L1i L#21 (32KB) + Core L#21
         PU L#84 (P#21)
         PU L#85 (P#53)
         PU L#86 (P#85)
         PU L#87 (P#117)
       L2 L#22 (256KB) + L1d L#22 (32KB) + L1i L#22 (32KB) + Core L#22
         PU L#88 (P#22)
         PU L#89 (P#54)
         PU L#90 (P#86)
         PU L#91 (P#118)
       L2 L#23 (256KB) + L1d L#23 (32KB) + L1i L#23 (32KB) + Core L#23
         PU L#92 (P#23)
         PU L#93 (P#55)
         PU L#94 (P#87)
         PU L#95 (P#119)
       L2 L#24 (256KB) + L1d L#24 (32KB) + L1i L#24 (32KB) + Core L#24
         PU L#96 (P#24)
         PU L#97 (P#56)
         PU L#98 (P#88)
         PU L#99 (P#120)
       L2 L#25 (256KB) + L1d L#25 (32KB) + L1i L#25 (32KB) + Core L#25
         PU L#100 (P#25)
         PU L#101 (P#57)
         PU L#102 (P#89)
         PU L#103 (P#121)
       L2 L#26 (256KB) + L1d L#26 (32KB) + L1i L#26 (32KB) + Core L#26
         PU L#104 (P#26)
         PU L#105 (P#58)
         PU L#106 (P#90)
         PU L#107 (P#122)
       L2 L#27 (256KB) + L1d L#27 (32KB) + L1i L#27 (32KB) + Core L#27
         PU L#108 (P#27)
         PU L#109 (P#59)
         PU L#110 (P#91)
         PU L#111 (P#123)
       L2 L#28 (256KB) + L1d L#28 (32KB) + L1i L#28 (32KB) + Core L#28
         PU L#112 (P#28)
         PU L#113 (P#60)
         PU L#114 (P#92)
         PU L#115 (P#124)
       L2 L#29 (256KB) + L1d L#29 (32KB) + L1i L#29 (32KB) + Core L#29
         PU L#116 (P#29)
         PU L#117 (P#61)
         PU L#118 (P#93)
         PU L#119 (P#125)
       L2 L#30 (256KB) + L1d L#30 (32KB) + L1i L#30 (32KB) + Core L#30
         PU L#120 (P#30)
         PU L#121 (P#62)
         PU L#122 (P#94)
         PU L#123 (P#126)
       L2 L#31 (256KB) + L1d L#31 (32KB) + L1i L#31 (32KB) + Core L#31
         PU L#124 (P#31)
         PU L#125 (P#63)
         PU L#126 (P#95)
         PU L#127 (P#127)
     HostBridge L#0
       PCIBridge
         PCI 8086:1584
           Net L#0 "enp2s0"
       PCIBridge
         PCI 8086:0953
       PCIBridge
         2 x { PCI 14e4:16a1 }
       PCIBridge
         PCI 8086:1583
           Net L#1 "enp19s0f0"
         PCI 8086:1583
           Net L#2 "enp19s0f1"
       PCIBridge
         PCIBridge
           PCI 1a03:2000
       PCI 14e4:9027
         Block(Disk) L#3 "sda"
       PCI 14e4:9027
   NUMANode L#1 (P#1 256GB)
     Package L#1 + L3 L#1 (32MB)
       L2 L#32 (256KB) + L1d L#32 (32KB) + L1i L#32 (32KB) + Core L#32
         PU L#128 (P#128)
         PU L#129 (P#160)
         PU L#130 (P#192)
         PU L#131 (P#224)
       L2 L#33 (256KB) + L1d L#33 (32KB) + L1i L#33 (32KB) + Core L#33
         PU L#132 (P#129)
         PU L#133 (P#161)
         PU L#134 (P#193)
         PU L#135 (P#225)
       L2 L#34 (256KB) + L1d L#34 (32KB) + L1i L#34 (32KB) + Core L#34
         PU L#136 (P#130)
         PU L#137 (P#162)
         PU L#138 (P#194)
         PU L#139 (P#226)
       L2 L#35 (256KB) + L1d L#35 (32KB) + L1i L#35 (32KB) + Core L#35
         PU L#140 (P#131)
         PU L#141 (P#163)
         PU L#142 (P#195)
         PU L#143 (P#227)
       L2 L#36 (256KB) + L1d L#36 (32KB) + L1i L#36 (32KB) + Core L#36
         PU L#144 (P#132)
         PU L#145 (P#164)
         PU L#146 (P#196)
         PU L#147 (P#228)
       L2 L#37 (256KB) + L1d L#37 (32KB) + L1i L#37 (32KB) + Core L#37
         PU L#148 (P#133)
         PU L#149 (P#165)
         PU L#150 (P#197)
         PU L#151 (P#229)
       L2 L#38 (256KB) + L1d L#38 (32KB) + L1i L#38 (32KB) + Core L#38
         PU L#152 (P#134)
         PU L#153 (P#166)
         PU L#154 (P#198)
         PU L#155 (P#230)
       L2 L#39 (256KB) + L1d L#39 (32KB) + L1i L#39 (32KB) + Core L#39
         PU L#156 (P#135)
         PU L#157 (P#167)
         PU L#158 (P#199)
         PU L#159 (P#231)
       L2 L#40 (256KB) + L1d L#40 (32KB) + L1i L#40 (32KB) + Core L#40
         PU L#160 (P#136)
         PU L#161 (P#168)
         PU L#162 (P#200)
         PU L#163 (P#232)
       L2 L#41 (256KB) + L1d L#41 (32KB) + L1i L#41 (32KB) + Core L#41
         PU L#164 (P#137)
         PU L#165 (P#169)
         PU L#166 (P#201)
         PU L#167 (P#233)
       L2 L#42 (256KB) + L1d L#42 (32KB) + L1i L#42 (32KB) + Core L#42
         PU L#168 (P#138)
         PU L#169 (P#170)
         PU L#170 (P#202)
         PU L#171 (P#234)
       L2 L#43 (256KB) + L1d L#43 (32KB) + L1i L#43 (32KB) + Core L#43
         PU L#172 (P#139)
         PU L#173 (P#171)
         PU L#174 (P#203)
         PU L#175 (P#235)
       L2 L#44 (256KB) + L1d L#44 (32KB) + L1i L#44 (32KB) + Core L#44
         PU L#176 (P#140)
         PU L#177 (P#172)
         PU L#178 (P#204)
         PU L#179 (P#236)
       L2 L#45 (256KB) + L1d L#45 (32KB) + L1i L#45 (32KB) + Core L#45
         PU L#180 (P#141)
         PU L#181 (P#173)
         PU L#182 (P#205)
         PU L#183 (P#237)
       L2 L#46 (256KB) + L1d L#46 (32KB) + L1i L#46 (32KB) + Core L#46
         PU L#184 (P#142)
         PU L#185 (P#174)
         PU L#186 (P#206)
         PU L#187 (P#238)
       L2 L#47 (256KB) + L1d L#47 (32KB) + L1i L#47 (32KB) + Core L#47
         PU L#188 (P#143)
         PU L#189 (P#175)
         PU L#190 (P#207)
         PU L#191 (P#239)
       L2 L#48 (256KB) + L1d L#48 (32KB) + L1i L#48 (32KB) + Core L#48
         PU L#192 (P#144)
         PU L#193 (P#176)
         PU L#194 (P#208)
         PU L#195 (P#240)
       L2 L#49 (256KB) + L1d L#49 (32KB) + L1i L#49 (32KB) + Core L#49
         PU L#196 (P#145)
         PU L#197 (P#177)
         PU L#198 (P#209)
         PU L#199 (P#241)
       L2 L#50 (256KB) + L1d L#50 (32KB) + L1i L#50 (32KB) + Core L#50
         PU L#200 (P#146)
         PU L#201 (P#178)
         PU L#202 (P#210)
         PU L#203 (P#242)
       L2 L#51 (256KB) + L1d L#51 (32KB) + L1i L#51 (32KB) + Core L#51
         PU L#204 (P#147)
         PU L#205 (P#179)
         PU L#206 (P#211)
         PU L#207 (P#243)
       L2 L#52 (256KB) + L1d L#52 (32KB) + L1i L#52 (32KB) + Core L#52
         PU L#208 (P#148)
         PU L#209 (P#180)
         PU L#210 (P#212)
         PU L#211 (P#244)
       L2 L#53 (256KB) + L1d L#53 (32KB) + L1i L#53 (32KB) + Core L#53
         PU L#212 (P#149)
         PU L#213 (P#181)
         PU L#214 (P#213)
         PU L#215 (P#245)
       L2 L#54 (256KB) + L1d L#54 (32KB) + L1i L#54 (32KB) + Core L#54
         PU L#216 (P#150)
         PU L#217 (P#182)
         PU L#218 (P#214)
         PU L#219 (P#246)
       L2 L#55 (256KB) + L1d L#55 (32KB) + L1i L#55 (32KB) + Core L#55
         PU L#220 (P#151)
         PU L#221 (P#183)
         PU L#222 (P#215)
         PU L#223 (P#247)
       L2 L#56 (256KB) + L1d L#56 (32KB) + L1i L#56 (32KB) + Core L#56
         PU L#224 (P#152)
         PU L#225 (P#184)
         PU L#226 (P#216)
         PU L#227 (P#248)
       L2 L#57 (256KB) + L1d L#57 (32KB) + L1i L#57 (32KB) + Core L#57
         PU L#228 (P#153)
         PU L#229 (P#185)
         PU L#230 (P#217)
         PU L#231 (P#249)
       L2 L#58 (256KB) + L1d L#58 (32KB) + L1i L#58 (32KB) + Core L#58
         PU L#232 (P#154)
         PU L#233 (P#186)
         PU L#234 (P#218)
         PU L#235 (P#250)
       L2 L#59 (256KB) + L1d L#59 (32KB) + L1i L#59 (32KB) + Core L#59
         PU L#236 (P#155)
         PU L#237 (P#187)
         PU L#238 (P#219)
         PU L#239 (P#251)
       L2 L#60 (256KB) + L1d L#60 (32KB) + L1i L#60 (32KB) + Core L#60
         PU L#240 (P#156)
         PU L#241 (P#188)
         PU L#242 (P#220)
         PU L#243 (P#252)
       L2 L#61 (256KB) + L1d L#61 (32KB) + L1i L#61 (32KB) + Core L#61
         PU L#244 (P#157)
         PU L#245 (P#189)
         PU L#246 (P#221)
         PU L#247 (P#253)
       L2 L#62 (256KB) + L1d L#62 (32KB) + L1i L#62 (32KB) + Core L#62
         PU L#248 (P#158)
         PU L#249 (P#190)
         PU L#250 (P#222)
         PU L#251 (P#254)
       L2 L#63 (256KB) + L1d L#63 (32KB) + L1i L#63 (32KB) + Core L#63
         PU L#252 (P#159)
         PU L#253 (P#191)
         PU L#254 (P#223)
         PU L#255 (P#255)
     HostBridge L#7
       PCIBridge
         PCI 8086:0953
       PCIBridge
         PCI 8086:10d3
           Net L#4 "enp146s0"
       PCIBridge
         PCI 1000:00c4

$ lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                256
On-line CPU(s) list:   0-255
Thread(s) per core:    4
Core(s) per socket:    32
Socket(s):             2
NUMA node(s):          2
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              32768K
NUMA node0 CPU(s):     0-127
NUMA node1 CPU(s):     128-255

$ lscpu -ap
# The following is the parsable format, which can be fed to other
# programs. Each different item in every column has an unique ID
# starting from zero.
# CPU,Core,Socket,Node,,L1d,L1i,L2,L3
0,0,0,0,,0,0,0,0
1,1,0,0,,1,1,1,0
2,2,0,0,,2,2,2,0
3,3,0,0,,3,3,3,0
4,4,0,0,,4,4,4,0
5,5,0,0,,5,5,5,0
6,6,0,0,,6,6,6,0
7,7,0,0,,7,7,7,0
8,8,0,0,,8,8,8,0
9,9,0,0,,9,9,9,0
10,10,0,0,,10,10,10,0
11,11,0,0,,11,11,11,0
12,12,0,0,,12,12,12,0
13,13,0,0,,13,13,13,0
14,14,0,0,,14,14,14,0
15,15,0,0,,15,15,15,0
16,16,0,0,,16,16,16,0
17,17,0,0,,17,17,17,0
18,18,0,0,,18,18,18,0
19,19,0,0,,19,19,19,0
20,20,0,0,,20,20,20,0
21,21,0,0,,21,21,21,0
22,22,0,0,,22,22,22,0
23,23,0,0,,23,23,23,0
24,24,0,0,,24,24,24,0
25,25,0,0,,25,25,25,0
26,26,0,0,,26,26,26,0
27,27,0,0,,27,27,27,0
28,28,0,0,,28,28,28,0
29,29,0,0,,29,29,29,0
30,30,0,0,,30,30,30,0
31,31,0,0,,31,31,31,0
32,0,0,0,,0,0,0,0
33,1,0,0,,1,1,1,0
34,2,0,0,,2,2,2,0
35,3,0,0,,3,3,3,0
36,4,0,0,,4,4,4,0
37,5,0,0,,5,5,5,0
38,6,0,0,,6,6,6,0
39,7,0,0,,7,7,7,0
40,8,0,0,,8,8,8,0
41,9,0,0,,9,9,9,0
42,10,0,0,,10,10,10,0
43,11,0,0,,11,11,11,0
44,12,0,0,,12,12,12,0
45,13,0,0,,13,13,13,0
46,14,0,0,,14,14,14,0
47,15,0,0,,15,15,15,0
48,16,0,0,,16,16,16,0
49,17,0,0,,17,17,17,0
50,18,0,0,,18,18,18,0
51,19,0,0,,19,19,19,0
52,20,0,0,,20,20,20,0
53,21,0,0,,21,21,21,0
54,22,0,0,,22,22,22,0
55,23,0,0,,23,23,23,0
56,24,0,0,,24,24,24,0
57,25,0,0,,25,25,25,0
58,26,0,0,,26,26,26,0
59,27,0,0,,27,27,27,0
60,28,0,0,,28,28,28,0
61,29,0,0,,29,29,29,0
62,30,0,0,,30,30,30,0
63,31,0,0,,31,31,31,0
64,0,0,0,,0,0,0,0
65,1,0,0,,1,1,1,0
66,2,0,0,,2,2,2,0
67,3,0,0,,3,3,3,0
68,4,0,0,,4,4,4,0
69,5,0,0,,5,5,5,0
70,6,0,0,,6,6,6,0
71,7,0,0,,7,7,7,0
72,8,0,0,,8,8,8,0
73,9,0,0,,9,9,9,0
74,10,0,0,,10,10,10,0
75,11,0,0,,11,11,11,0
76,12,0,0,,12,12,12,0
77,13,0,0,,13,13,13,0
78,14,0,0,,14,14,14,0
79,15,0,0,,15,15,15,0
80,16,0,0,,16,16,16,0
81,17,0,0,,17,17,17,0
82,18,0,0,,18,18,18,0
83,19,0,0,,19,19,19,0
84,20,0,0,,20,20,20,0
85,21,0,0,,21,21,21,0
86,22,0,0,,22,22,22,0
87,23,0,0,,23,23,23,0
88,24,0,0,,24,24,24,0
89,25,0,0,,25,25,25,0
90,26,0,0,,26,26,26,0
91,27,0,0,,27,27,27,0
92,28,0,0,,28,28,28,0
93,29,0,0,,29,29,29,0
94,30,0,0,,30,30,30,0
95,31,0,0,,31,31,31,0
96,0,0,0,,0,0,0,0
97,1,0,0,,1,1,1,0
98,2,0,0,,2,2,2,0
99,3,0,0,,3,3,3,0
100,4,0,0,,4,4,4,0
101,5,0,0,,5,5,5,0
102,6,0,0,,6,6,6,0
103,7,0,0,,7,7,7,0
104,8,0,0,,8,8,8,0
105,9,0,0,,9,9,9,0
106,10,0,0,,10,10,10,0
107,11,0,0,,11,11,11,0
108,12,0,0,,12,12,12,0
109,13,0,0,,13,13,13,0
110,14,0,0,,14,14,14,0
111,15,0,0,,15,15,15,0
112,16,0,0,,16,16,16,0
113,17,0,0,,17,17,17,0
114,18,0,0,,18,18,18,0
115,19,0,0,,19,19,19,0
116,20,0,0,,20,20,20,0
117,21,0,0,,21,21,21,0
118,22,0,0,,22,22,22,0
119,23,0,0,,23,23,23,0
120,24,0,0,,24,24,24,0
121,25,0,0,,25,25,25,0
122,26,0,0,,26,26,26,0
123,27,0,0,,27,27,27,0
124,28,0,0,,28,28,28,0
125,29,0,0,,29,29,29,0
126,30,0,0,,30,30,30,0
127,31,0,0,,31,31,31,0
128,32,1,1,,32,32,32,1
129,33,1,1,,33,33,33,1
130,34,1,1,,34,34,34,1
131,35,1,1,,35,35,35,1
132,36,1,1,,36,36,36,1
133,37,1,1,,37,37,37,1
134,38,1,1,,38,38,38,1
135,39,1,1,,39,39,39,1
136,40,1,1,,40,40,40,1
137,41,1,1,,41,41,41,1
138,42,1,1,,42,42,42,1
139,43,1,1,,43,43,43,1
140,44,1,1,,44,44,44,1
141,45,1,1,,45,45,45,1
142,46,1,1,,46,46,46,1
143,47,1,1,,47,47,47,1
144,48,1,1,,48,48,48,1
145,49,1,1,,49,49,49,1
146,50,1,1,,50,50,50,1
147,51,1,1,,51,51,51,1
148,52,1,1,,52,52,52,1
149,53,1,1,,53,53,53,1
150,54,1,1,,54,54,54,1
151,55,1,1,,55,55,55,1
152,56,1,1,,56,56,56,1
153,57,1,1,,57,57,57,1
154,58,1,1,,58,58,58,1
155,59,1,1,,59,59,59,1
156,60,1,1,,60,60,60,1
157,61,1,1,,61,61,61,1
158,62,1,1,,62,62,62,1
159,63,1,1,,63,63,63,1
160,32,1,1,,32,32,32,1
161,33,1,1,,33,33,33,1
162,34,1,1,,34,34,34,1
163,35,1,1,,35,35,35,1
164,36,1,1,,36,36,36,1
165,37,1,1,,37,37,37,1
166,38,1,1,,38,38,38,1
167,39,1,1,,39,39,39,1
168,40,1,1,,40,40,40,1
169,41,1,1,,41,41,41,1
170,42,1,1,,42,42,42,1
171,43,1,1,,43,43,43,1
172,44,1,1,,44,44,44,1
173,45,1,1,,45,45,45,1
174,46,1,1,,46,46,46,1
175,47,1,1,,47,47,47,1
176,48,1,1,,48,48,48,1
177,49,1,1,,49,49,49,1
178,50,1,1,,50,50,50,1
179,51,1,1,,51,51,51,1
180,52,1,1,,52,52,52,1
181,53,1,1,,53,53,53,1
182,54,1,1,,54,54,54,1
183,55,1,1,,55,55,55,1
184,56,1,1,,56,56,56,1
185,57,1,1,,57,57,57,1
186,58,1,1,,58,58,58,1
187,59,1,1,,59,59,59,1
188,60,1,1,,60,60,60,1
189,61,1,1,,61,61,61,1
190,62,1,1,,62,62,62,1
191,63,1,1,,63,63,63,1
192,32,1,1,,32,32,32,1
193,33,1,1,,33,33,33,1
194,34,1,1,,34,34,34,1
195,35,1,1,,35,35,35,1
196,36,1,1,,36,36,36,1
197,37,1,1,,37,37,37,1
198,38,1,1,,38,38,38,1
199,39,1,1,,39,39,39,1
200,40,1,1,,40,40,40,1
201,41,1,1,,41,41,41,1
202,42,1,1,,42,42,42,1
203,43,1,1,,43,43,43,1
204,44,1,1,,44,44,44,1
205,45,1,1,,45,45,45,1
206,46,1,1,,46,46,46,1
207,47,1,1,,47,47,47,1
208,48,1,1,,48,48,48,1
209,49,1,1,,49,49,49,1
210,50,1,1,,50,50,50,1
211,51,1,1,,51,51,51,1
212,52,1,1,,52,52,52,1
213,53,1,1,,53,53,53,1
214,54,1,1,,54,54,54,1
215,55,1,1,,55,55,55,1
216,56,1,1,,56,56,56,1
217,57,1,1,,57,57,57,1
218,58,1,1,,58,58,58,1
219,59,1,1,,59,59,59,1
220,60,1,1,,60,60,60,1
221,61,1,1,,61,61,61,1
222,62,1,1,,62,62,62,1
223,63,1,1,,63,63,63,1
224,32,1,1,,32,32,32,1
225,33,1,1,,33,33,33,1
226,34,1,1,,34,34,34,1
227,35,1,1,,35,35,35,1
228,36,1,1,,36,36,36,1
229,37,1,1,,37,37,37,1
230,38,1,1,,38,38,38,1
231,39,1,1,,39,39,39,1
232,40,1,1,,40,40,40,1
233,41,1,1,,41,41,41,1
234,42,1,1,,42,42,42,1
235,43,1,1,,43,43,43,1
236,44,1,1,,44,44,44,1
237,45,1,1,,45,45,45,1
238,46,1,1,,46,46,46,1
239,47,1,1,,47,47,47,1
240,48,1,1,,48,48,48,1
241,49,1,1,,49,49,49,1
242,50,1,1,,50,50,50,1
243,51,1,1,,51,51,51,1
244,52,1,1,,52,52,52,1
245,53,1,1,,53,53,53,1
246,54,1,1,,54,54,54,1
247,55,1,1,,55,55,55,1
248,56,1,1,,56,56,56,1
249,57,1,1,,57,57,57,1
250,58,1,1,,58,58,58,1
251,59,1,1,,59,59,59,1
252,60,1,1,,60,60,60,1
253,61,1,1,,61,61,61,1
254,62,1,1,,62,62,62,1
255,63,1,1,,63,63,63,1

> 
> For example on juno:
> [root at mammon-juno-rh topology]# lstopo-no-graphics
>    Package L#0
>      L2 L#0 (1024KB)
>        L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
>        L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
>        L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
>        L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
>      L2 L#1 (2048KB)
>        L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
>        L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
>    HostBridge L#0
>      PCIBridge
>        PCIBridge
>          PCIBridge
>            PCI 1095:3132
>              Block(Disk) L#0 "sda"
>          PCIBridge
>            PCI 1002:68f9
>              GPU L#1 "renderD128"
>              GPU L#2 "card0"
>              GPU L#3 "controlD64"
>          PCIBridge
>            PCI 11ab:4380
>              Net L#4 "enp8s0"
> 
> Git tree at:
> http://linux-arm.org/git?p=linux-jlinton.git
> branch: pptt_v8
> 
> v7->v8:
> Modify the logic used to select the MC domain (the change
>    shouldn't modify the sched domains on any existing machines
>    compared to v7, only how they are built)
> Reduce the severity of some parsing messages.
> Fix s390 link problem.
> Further checks to deal with broken PPTT tables.
> Various style tweaks, SPDX license addition, etc.
> 
> v6->v7:
> Add additional patch to use the last cache level within the NUMA
>    or socket as the MC domain. This assures the MC domain is
>    equal or smaller than the DIE.
>    
> Various formatting/etc review comments.
> 
> Rebase to 4.16rc2
> 
> v5->v6:
> Add additional patches which re-factor how the initial DT code sets
>    up the cacheinfo structure so that its not as dependent on the
>    of_node stored in that tree. Once that is done we rename it
>    for use with the ACPI code.
> 
> Additionally there were a fair number of minor name/location/etc
>    tweaks scattered about made in response to review comments.
> 
> v4->v5:
> Update the cache type from NOCACHE to UNIFIED when all the cache
>    attributes we update are valid. This fixes a problem where caches
>    which are entirely created by the PPTT don't show up in lstopo.
> 
> Give the PPTT its own firmware_node in the cache structure instead of
>    sharing it with the of_node.
> 
> Move some pieces around between patches.
> 
> (see previous cover letters for futher changes)
> 
> Jeremy Linton (13):
>    drivers: base: cacheinfo: move cache_setup_of_node()
>    drivers: base: cacheinfo: setup DT cache properties early
>    cacheinfo: rename of_node to fw_token
>    arm64/acpi: Create arch specific cpu to acpi id helper
>    ACPI/PPTT: Add Processor Properties Topology Table parsing
>    ACPI: Enable PPTT support on ARM64
>    drivers: base cacheinfo: Add support for ACPI based firmware tables
>    arm64: Add support for ACPI based firmware tables
>    ACPI/PPTT: Add topology parsing code
>    arm64: topology: rename cluster_id
>    arm64: topology: enable ACPI/PPTT based CPU topology
>    ACPI: Add PPTT to injectable table list
>    arm64: topology: divorce MC scheduling domain from core_siblings
> 
>   arch/arm64/Kconfig                |   1 +
>   arch/arm64/include/asm/acpi.h     |   4 +
>   arch/arm64/include/asm/topology.h |   6 +-
>   arch/arm64/kernel/cacheinfo.c     |  15 +-
>   arch/arm64/kernel/topology.c      | 103 +++++-
>   arch/riscv/kernel/cacheinfo.c     |   1 -
>   drivers/acpi/Kconfig              |   3 +
>   drivers/acpi/Makefile             |   1 +
>   drivers/acpi/pptt.c               | 678 ++++++++++++++++++++++++++++++++++++++
>   drivers/acpi/tables.c             |   2 +-
>   drivers/base/cacheinfo.c          | 157 ++++-----
>   include/linux/acpi.h              |   4 +
>   include/linux/cacheinfo.h         |  18 +-
>   13 files changed, 886 insertions(+), 107 deletions(-)
>   create mode 100644 drivers/acpi/pptt.c
> 
