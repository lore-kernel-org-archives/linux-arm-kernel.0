From: keescook@chromium.org (Kees Cook)
Date: Mon, 22 May 2017 13:05:38 -0700
Subject: arch: arm: bpf: Converting cBPF to eBPF for arm 32 bit
In-Reply-To: <CAHgaXd+dTEKyPbkB6oFpLa3z0ygkxK1dMT8R55iYjvsU=GO3Wg@mail.gmail.com>
References: <CAHgaXdKsO2xoKYp7g91g+n+d_1KHSSByLjzBB-WjVXSjhB7qxw@mail.gmail.com>
 <20170510.212952.1440495072777358778.davem@davemloft.net>
 <CAHgaXdK8LEEUPm4jTRRzCnjwdWAauHmmB=caZsSFY8MmStH89Q@mail.gmail.com>
 <20170510.215218.2185526627014393313.davem@davemloft.net>
 <CAHgaXdKZ_v+iO7uqEDx7PA7D+xcp1FngGvJ1SRSsGXNQ-iWWDQ@mail.gmail.com>
 <CAHgaXdLJoVUXXGTYs7FYXay5wx=sA-O+=dYhX+r7AQT7vSNfGQ@mail.gmail.com>
 <CAGXu5j+2q4Wwfhuk_DnDaV894A9ZOD=A_AvAU_OZG6KQv0_KMg@mail.gmail.com>
 <CAHgaXdL7GcVzs+ANPke_NywhcgHbe_fzi1sTDEy+Ni1-o82GYQ@mail.gmail.com>
 <591A07A1.1030006@iogearbox.net>
 <CAHgaXdKKbRVSpX-036TXpV5z=1=QCnPoku0+CeHxHco8-aasPQ@mail.gmail.com>
 <5922E11C.4070307@iogearbox.net>
 <CAHgaXd+dTEKyPbkB6oFpLa3z0ygkxK1dMT8R55iYjvsU=GO3Wg@mail.gmail.com>
Message-ID: <CAGXu5jLYunVCJGCfHPebKDaoQ71hdMGq4HhdDxTYpBQw_HXUYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 10:04 AM, Shubham Bansal
<illusionist.neo@gmail.com> wrote:
> These all benchmarks are for ARMv7.

Thanks! In the future, try to avoid the white-space damage
(line-wrapping). And it looks like you've still got debugging turned
on in your jit code:

[   56.176033] test_bpf: #21 LD_CPU
[   56.176329] bpf_jit: *** NOT YET: opcode 85 ***
[   56.176565] jited:0 2639 702 PASS

That breaks the test report line. After I cleaned these up and parsed
the results, they look great. Most things are half the speed of the
interpreter, if not better. Only the LD_ABS suffered, and that's
mainly the const blinding, I assume.

Please post your current patch. Thanks for this!

-Kees

-- 
Kees Cook
Pixel Security
-------------- next part --------------
#0 TAX
	interp: 757	645	650
	jitted: 234	171	195
	        30.9%	26.5%	30.0%
	harden: 239	218	229
	        31.6%	33.8%	35.2%
#1 TXA
	interp: 366	334	336
	jitted: 81	79	77
	        22.1%	23.7%	22.9%
	harden: 89	119	85
	        24.3%	35.6%	25.3%
#2 ADD_SUB_MUL_K
	interp: 543
	jitted: 89
	        16.4%
	harden: 213
	        39.2%
#3 DIV_MOD_KX
	interp: 1509
	jitted: 939
	        62.2%
	harden: 1190
	        78.9%
#4 AND_OR_LSH_K
	interp: 539	559
	jitted: 116	114
	        21.5%	20.4%
	harden: 200	149
	        37.1%	26.7%
#5 LD_IMM_0
	interp: 412
	jitted: 93
	        22.6%
	harden: 101
	        24.5%
#6 LD_IND
	interp: 428	376	389
	jitted: 371	279	274
	        86.7%	74.2%	70.4%
	harden: 314	310	283
	        73.4%	82.4%	72.8%
#7 LD_ABS
	interp: 509	405	358
	jitted: 408	402	272
	        80.2%	99.3%	76.0%
	harden: 376	460	397
	        73.9%	113.6%	110.9%
#8 LD_ABS_LL
	interp: 542	783
	jitted: 387	346
	        71.4%	44.2%
	harden: 608	415
	        112.2%	53.0%
#9 LD_IND_LL
	interp: 524	496	723
	jitted: 239	248	217
	        45.6%	50.0%	30.0%
	harden: 248	256	268
	        47.3%	51.6%	37.1%
#10 LD_ABS_NET
	interp: 527	545
	jitted: 356	332
	        67.6%	60.9%
	harden: 435	420
	        82.5%	77.1%
#11 LD_IND_NET
	interp: 650	495	647
	jitted: 223	212	320
	        34.3%	42.8%	49.5%
	harden: 240	228	215
	        36.9%	46.1%	33.2%
#12 LD_PKTTYPE
	interp: 686	901
	jitted: 102	90
	        14.9%	10.0%
	harden: 211	274
	        30.8%	30.4%
#13 LD_MARK
	interp: 305	291
	jitted: 80	80
	        26.2%	27.5%
	harden: 119	76
	        39.0%	26.1%
#14 LD_RXHASH
	interp: 257	259
	jitted: 73	71
	        28.4%	27.4%
	harden: 78	70
	        30.4%	27.0%
#15 LD_QUEUE
	interp: 255	254
	jitted: 120	121
	        47.1%	47.6%
	harden: 77	73
	        30.2%	28.7%
#16 LD_PROTOCOL
	interp: 593	603
	jitted: 256	247
	        43.2%	41.0%
	harden: 326	320
	        55.0%	53.1%
#17 LD_VLAN_TAG
	interp: 288	292
	jitted: 82	84
	        28.5%	28.8%
	harden: 129	86
	        44.8%	29.5%
#18 LD_VLAN_TAG_PRESENT
	interp: 335	421
	jitted: 80	77
	        23.9%	18.3%
	harden: 87	88
	        26.0%	20.9%
#19 LD_IFINDEX
	interp: 8568	606
	jitted: 87	98
	        1.0%	16.2%
	harden: 97	95
	        1.1%	15.7%
#20 LD_HATYPE
	interp: 618	695
	jitted: 95	90
	        15.4%	12.9%
	harden: 94	118
	        15.2%	17.0%
#25 LD_ANC_XOR
	interp: 314	344
	jitted: 86	100
	        27.4%	29.1%
	harden: 168	156
	        53.5%	45.3%
#26 SPILL_FILL
	interp: 757	850	903
	jitted: 131	137	123
	        17.3%	16.1%	13.6%
	harden: 232	212	219
	        30.6%	24.9%	24.3%
#27 JEQ
	interp: 380	420	426
	jitted: 266	189	216
	        70.0%	45.0%	50.7%
	harden: 362	352	230
	        95.3%	83.8%	54.0%
#28 JGT
	interp: 376	467	448
	jitted: 301	211	192
	        80.1%	45.2%	42.9%
	harden: 334	236	197
	        88.8%	50.5%	44.0%
#29 JGE
	interp: 446	590	498
	jitted: 191	200	223
	        42.8%	33.9%	44.8%
	harden: 260	318	307
	        58.3%	53.9%	61.6%
#30 JSET
	interp: 571	787	1003
	jitted: 211	210	214
	        37.0%	26.7%	21.3%
	harden: 274	339	410
	        48.0%	43.1%	40.9%
#31 tcpdump port 22
	interp: 358	1079	1190
	jitted: 314	722	711
	        87.7%	66.9%	59.7%
	harden: 355	951	968
	        99.2%	88.1%	81.3%
#32 tcpdump complex
	interp: 319	1061	2324
	jitted: 291	707	1068
	        91.2%	66.6%	46.0%
	harden: 318	798	1308
	        99.7%	75.2%	56.3%
#33 RET_A
	interp: 253	249
	jitted: 83	88
	        32.8%	35.3%
	harden: 83	76
	        32.8%	30.5%
#34 INT: ADD trivial
	interp: 414
	jitted: 162
	        39.1%
	harden: 152
	        36.7%
#35 INT: MUL_X
	interp: 336
	jitted: 176
	        52.4%
	harden: 192
	        57.1%
#36 INT: MUL_X2
	interp: 431
	jitted: 84
	        19.5%
	harden: 165
	        38.3%
#37 INT: MUL32_X
	interp: 523
	jitted: 99
	        18.9%
	harden: 163
	        31.2%
#38 INT: ADD 64-bit
	interp: 5263
	jitted: 1066
	        20.3%
	harden: 1507
	        28.6%
#39 INT: ADD 32-bit
	interp: 4127
	jitted: 666
	        16.1%
	harden: 954
	        23.1%
#40 INT: SUB
	interp: 4218
	jitted: 3236
	        76.7%
	harden: 1159
	        27.5%
#41 INT: XOR
	interp: 2252
	jitted: 308
	        13.7%
	harden: 480
	        21.3%
#42 INT: MUL
	interp: 1986
	jitted: 376
	        18.9%
	harden: 486
	        24.5%
#43 MOV REG64
	interp: 1103
	jitted: 227
	        20.6%
	harden: 274
	        24.8%
#44 MOV REG32
	interp: 1140
	jitted: 171
	        15.0%
	harden: 253
	        22.2%
#45 LD IMM64
	interp: 1182
	jitted: 163
	        13.8%
	harden: 578
	        48.9%
#47 INT: shifts by register
	interp: 1125
	jitted: 208
	        18.5%
	harden: 381
	        33.9%
#48 INT: DIV + ABS
	interp: 570	850
	jitted: 659	601
	        115.6%	70.7%
	harden: 588	482
	        103.2%	56.7%
#49 INT: DIV by zero
	interp: 350	305
	jitted: 317	169
	        90.6%	55.4%
	harden: 276	199
	        78.9%	65.2%
#54 JUMPS + HOLES
	interp: 863
	jitted: 358
	        41.5%
	harden: 371
	        43.0%
#57 M[]: alt STX + LDX
	interp: 3990
	jitted: 456
	        11.4%
	harden: 621
	        15.6%
#58 M[]: full STX + full LDX
	interp: 2819
	jitted: 438
	        15.5%
	harden: 586
	        20.8%
#60 LD [SKF_AD_OFF-1]
	interp: 313
	jitted: 198
	        63.3%
	harden: 195
	        62.3%
#61 load 64-bit immediate
	interp: 579
	jitted: 125
	        21.6%
	harden: 220
	        38.0%
#62 nmap reduced
	interp: 1860
	jitted: 1054
	        56.7%
	harden: 816
	        43.9%
#63 ALU_MOV_X: dst = 2
	interp: 249
	jitted: 81
	        32.5%
	harden: 76
	        30.5%
#64 ALU_MOV_X: dst = 4294967295
	interp: 264
	jitted: 85
	        32.2%
	harden: 79
	        29.9%
#65 ALU64_MOV_X: dst = 2
	interp: 229
	jitted: 96
	        41.9%
	harden: 80
	        34.9%
#66 ALU64_MOV_X: dst = 4294967295
	interp: 213
	jitted: 71
	        33.3%
	harden: 79
	        37.1%
#67 ALU_MOV_K: dst = 2
	interp: 167
	jitted: 70
	        41.9%
	harden: 75
	        44.9%
#68 ALU_MOV_K: dst = 4294967295
	interp: 149
	jitted: 71
	        47.7%
	harden: 73
	        49.0%
#69 ALU_MOV_K: 0x0000ffffffff0000 = 0x00000000ffffffff
	interp: 358
	jitted: 97
	        27.1%
	harden: 195
	        54.5%
#70 ALU64_MOV_K: dst = 2
	interp: 158
	jitted: 75
	        47.5%
	harden: 77
	        48.7%
#71 ALU64_MOV_K: dst = 2147483647
	interp: 156
	jitted: 66
	        42.3%
	harden: 104
	        66.7%
#72 ALU64_OR_K: dst = 0x0
	interp: 306
	jitted: 92
	        30.1%
	harden: 215
	        70.3%
#73 ALU64_MOV_K: dst = -1
	interp: 327
	jitted: 94
	        28.7%
	harden: 173
	        52.9%
#74 ALU_ADD_X: 1 + 2 = 3
	interp: 212
	jitted: 66
	        31.1%
	harden: 114
	        53.8%
#75 ALU_ADD_X: 1 + 4294967294 = 4294967295
	interp: 231
	jitted: 66
	        28.6%
	harden: 112
	        48.5%
#76 ALU_ADD_X: 2 + 4294967294 = 0
	interp: 309
	jitted: 87
	        28.2%
	harden: 186
	        60.2%
#77 ALU64_ADD_X: 1 + 2 = 3
	interp: 280
	jitted: 77
	        27.5%
	harden: 159
	        56.8%
#78 ALU64_ADD_X: 1 + 4294967294 = 4294967295
	interp: 286
	jitted: 72
	        25.2%
	harden: 109
	        38.1%
#79 ALU64_ADD_X: 2 + 4294967294 = 4294967296
	interp: 460
	jitted: 79
	        17.2%
	harden: 218
	        47.4%
#80 ALU_ADD_K: 1 + 2 = 3
	interp: 210
	jitted: 75
	        35.7%
	harden: 120
	        57.1%
#81 ALU_ADD_K: 3 + 0 = 3
	interp: 208
	jitted: 71
	        34.1%
	harden: 118
	        56.7%
#82 ALU_ADD_K: 1 + 4294967294 = 4294967295
	interp: 205
	jitted: 67
	        32.7%
	harden: 121
	        59.0%
#83 ALU_ADD_K: 4294967294 + 2 = 0
	interp: 323
	jitted: 82
	        25.4%
	harden: 139
	        43.0%
#84 ALU_ADD_K: 0 + (-1) = 0x00000000ffffffff
	interp: 338
	jitted: 86
	        25.4%
	harden: 176
	        52.1%
#85 ALU_ADD_K: 0 + 0xffff = 0xffff
	interp: 347
	jitted: 99
	        28.5%
	harden: 190
	        54.8%
#86 ALU_ADD_K: 0 + 0x7fffffff = 0x7fffffff
	interp: 360
	jitted: 113
	        31.4%
	harden: 228
	        63.3%
#87 ALU_ADD_K: 0 + 0x80000000 = 0x80000000
	interp: 345
	jitted: 123
	        35.7%
	harden: 198
	        57.4%
#88 ALU_ADD_K: 0 + 0x80008000 = 0x80008000
	interp: 377
	jitted: 85
	        22.5%
	harden: 189
	        50.1%
#89 ALU64_ADD_K: 1 + 2 = 3
	interp: 184
	jitted: 66
	        35.9%
	harden: 112
	        60.9%
#90 ALU64_ADD_K: 3 + 0 = 3
	interp: 185
	jitted: 66
	        35.7%
	harden: 111
	        60.0%
#91 ALU64_ADD_K: 1 + 2147483646 = 2147483647
	interp: 186
	jitted: 69
	        37.1%
	harden: 138
	        74.2%
#92 ALU64_ADD_K: 4294967294 + 2 = 4294967296
	interp: 353
	jitted: 109
	        30.9%
	harden: 151
	        42.8%
#93 ALU64_ADD_K: 2147483646 + -2147483647 = -1
	interp: 182
	jitted: 72
	        39.6%
	harden: 115
	        63.2%
#94 ALU64_ADD_K: 1 + 0 = 1
	interp: 311
	jitted: 126
	        40.5%
	harden: 206
	        66.2%
#95 ALU64_ADD_K: 0 + (-1) = 0xffffffffffffffff
	interp: 339
	jitted: 107
	        31.6%
	harden: 211
	        62.2%
#96 ALU64_ADD_K: 0 + 0xffff = 0xffff
	interp: 310
	jitted: 98
	        31.6%
	harden: 250
	        80.6%
#97 ALU64_ADD_K: 0 + 0x7fffffff = 0x7fffffff
	interp: 313
	jitted: 87
	        27.8%
	harden: 199
	        63.6%
#98 ALU64_ADD_K: 0 + 0x80000000 = 0xffffffff80000000
	interp: 340
	jitted: 98
	        28.8%
	harden: 177
	        52.1%
#99 ALU_ADD_K: 0 + 0x80008000 = 0xffffffff80008000
	interp: 311
	jitted: 92
	        29.6%
	harden: 243
	        78.1%
#100 ALU_SUB_X: 3 - 1 = 2
	interp: 213
	jitted: 77
	        36.2%
	harden: 108
	        50.7%
#101 ALU_SUB_X: 4294967295 - 4294967294 = 1
	interp: 212
	jitted: 72
	        34.0%
	harden: 133
	        62.7%
#102 ALU64_SUB_X: 3 - 1 = 2
	interp: 237
	jitted: 72
	        30.4%
	harden: 110
	        46.4%
#103 ALU64_SUB_X: 4294967295 - 4294967294 = 1
	interp: 221
	jitted: 71
	        32.1%
	harden: 111
	        50.2%
#104 ALU_SUB_K: 3 - 1 = 2
	interp: 177
	jitted: 120
	        67.8%
	harden: 110
	        62.1%
#105 ALU_SUB_K: 3 - 0 = 3
	interp: 179
	jitted: 82
	        45.8%
	harden: 123
	        68.7%
#106 ALU_SUB_K: 4294967295 - 4294967294 = 1
	interp: 195
	jitted: 103
	        52.8%
	harden: 124
	        63.6%
#107 ALU64_SUB_K: 3 - 1 = 2
	interp: 183
	jitted: 140
	        76.5%
	harden: 116
	        63.4%
#108 ALU64_SUB_K: 3 - 0 = 3
	interp: 177
	jitted: 117
	        66.1%
	harden: 133
	        75.1%
#109 ALU64_SUB_K: 4294967294 - 4294967295 = -1
	interp: 181
	jitted: 83
	        45.9%
	harden: 148
	        81.8%
#110 ALU64_ADD_K: 2147483646 - 2147483647 = -1
	interp: 177
	jitted: 77
	        43.5%
	harden: 145
	        81.9%
#111 ALU_MUL_X: 2 * 3 = 6
	interp: 241
	jitted: 68
	        28.2%
	harden: 172
	        71.4%
#112 ALU_MUL_X: 2 * 0x7FFFFFF8 = 0xFFFFFFF0
	interp: 220
	jitted: 70
	        31.8%
	harden: 117
	        53.2%
#113 ALU_MUL_X: -1 * -1 = 1
	interp: 224
	jitted: 73
	        32.6%
	harden: 109
	        48.7%
#114 ALU64_MUL_X: 2 * 3 = 6
	interp: 213
	jitted: 70
	        32.9%
	harden: 115
	        54.0%
#115 ALU64_MUL_X: 1 * 2147483647 = 2147483647
	interp: 230
	jitted: 75
	        32.6%
	harden: 119
	        51.7%
#116 ALU_MUL_K: 2 * 3 = 6
	interp: 191
	jitted: 67
	        35.1%
	harden: 111
	        58.1%
#117 ALU_MUL_K: 3 * 1 = 3
	interp: 189
	jitted: 71
	        37.6%
	harden: 118
	        62.4%
#118 ALU_MUL_K: 2 * 0x7FFFFFF8 = 0xFFFFFFF0
	interp: 192
	jitted: 70
	        36.5%
	harden: 109
	        56.8%
#119 ALU_MUL_K: 1 * (-1) = 0x00000000ffffffff
	interp: 333
	jitted: 153
	        45.9%
	harden: 201
	        60.4%
#120 ALU64_MUL_K: 2 * 3 = 6
	interp: 185
	jitted: 101
	        54.6%
	harden: 116
	        62.7%
#121 ALU64_MUL_K: 3 * 1 = 3
	interp: 185
	jitted: 108
	        58.4%
	harden: 115
	        62.2%
#122 ALU64_MUL_K: 1 * 2147483647 = 2147483647
	interp: 184
	jitted: 106
	        57.6%
	harden: 278
	        151.1%
#123 ALU64_MUL_K: 1 * -2147483647 = -2147483647
	interp: 183
	jitted: 92
	        50.3%
	harden: 125
	        68.3%
#124 ALU64_MUL_K: 1 * (-1) = 0xffffffffffffffff
	interp: 336
	jitted: 122
	        36.3%
	harden: 208
	        61.9%
#125 ALU_DIV_X: 6 / 2 = 3
	interp: 316
	jitted: 220
	        69.6%
	harden: 246
	        77.8%
#126 ALU_DIV_X: 4294967295 / 4294967295 = 1
	interp: 315
	jitted: 208
	        66.0%
	harden: 291
	        92.4%
#130 ALU_DIV_K: 6 / 2 = 3
	interp: 249
	jitted: 246
	        98.8%
	harden: 234
	        94.0%
#131 ALU_DIV_K: 3 / 1 = 3
	interp: 240
	jitted: 199
	        82.9%
	harden: 240
	        100.0%
#132 ALU_DIV_K: 4294967295 / 4294967295 = 1
	interp: 254
	jitted: 192
	        75.6%
	harden: 276
	        108.7%
#133 ALU_DIV_K: 0xffffffffffffffff / (-1) = 0x1
	interp: 379
	jitted: 215
	        56.7%
	harden: 373
	        98.4%
#138 ALU_MOD_X: 3 % 2 = 1
	interp: 421
	jitted: 235
	        55.8%
	harden: 293
	        69.6%
#139 ALU_MOD_X: 4294967295 % 4294967293 = 2
	interp: 453
	jitted: 262
	        57.8%
	harden: 289
	        63.8%
#142 ALU_MOD_K: 3 % 2 = 1
	interp: 380
	jitted: 231
	        60.8%
	harden: 311
	        81.8%
#144 ALU_MOD_K: 4294967295 % 4294967293 = 2
	interp: 467
	jitted: 257
	        55.0%
	harden: 319
	        68.3%
#148 ALU_AND_X: 3 & 2 = 2
	interp: 225
	jitted: 100
	        44.4%
	harden: 109
	        48.4%
#149 ALU_AND_X: 0xffffffff & 0xffffffff = 0xffffffff
	interp: 261
	jitted: 106
	        40.6%
	harden: 130
	        49.8%
#150 ALU64_AND_X: 3 & 2 = 2
	interp: 273
	jitted: 86
	        31.5%
	harden: 106
	        38.8%
#151 ALU64_AND_X: 0xffffffff & 0xffffffff = 0xffffffff
	interp: 251
	jitted: 118
	        47.0%
	harden: 102
	        40.6%
#152 ALU_AND_K: 3 & 2 = 2
	interp: 201
	jitted: 117
	        58.2%
	harden: 114
	        56.7%
#153 ALU_AND_K: 0xffffffff & 0xffffffff = 0xffffffff
	interp: 240
	jitted: 72
	        30.0%
	harden: 138
	        57.5%
#154 ALU64_AND_K: 3 & 2 = 2
	interp: 209
	jitted: 72
	        34.4%
	harden: 110
	        52.6%
#155 ALU64_AND_K: 0xffffffff & 0xffffffff = 0xffffffff
	interp: 319
	jitted: 70
	        21.9%
	harden: 148
	        46.4%
#156 ALU64_AND_K: 0x0000ffffffff0000 & 0x0 = 0x0000ffff00000000
	interp: 384
	jitted: 99
	        25.8%
	harden: 206
	        53.6%
#157 ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffffffff
	interp: 367
	jitted: 97
	        26.4%
	harden: 176
	        48.0%
#158 ALU64_AND_K: 0xffffffffffffffff & -1 = 0xffffffffffffffff
	interp: 375
	jitted: 86
	        22.9%
	harden: 271
	        72.3%
#159 ALU_OR_X: 1 | 2 = 3
	interp: 271
	jitted: 73
	        26.9%
	harden: 108
	        39.9%
#160 ALU_OR_X: 0x0 | 0xffffffff = 0xffffffff
	interp: 280
	jitted: 72
	        25.7%
	harden: 118
	        42.1%
#161 ALU64_OR_X: 1 | 2 = 3
	interp: 253
	jitted: 89
	        35.2%
	harden: 103
	        40.7%
#162 ALU64_OR_X: 0 | 0xffffffff = 0xffffffff
	interp: 263
	jitted: 91
	        34.6%
	harden: 143
	        54.4%
#163 ALU_OR_K: 1 | 2 = 3
	interp: 216
	jitted: 71
	        32.9%
	harden: 123
	        56.9%
#164 ALU_OR_K: 0 & 0xffffffff = 0xffffffff
	interp: 187
	jitted: 116
	        62.0%
	harden: 110
	        58.8%
#165 ALU64_OR_K: 1 | 2 = 3
	interp: 183
	jitted: 77
	        42.1%
	harden: 120
	        65.6%
#166 ALU64_OR_K: 0 & 0xffffffff = 0xffffffff
	interp: 195
	jitted: 80
	        41.0%
	harden: 119
	        61.0%
#167 ALU64_OR_K: 0x0000ffffffff0000 | 0x0 = 0x0000ffff00000000
	interp: 338
	jitted: 86
	        25.4%
	harden: 212
	        62.7%
#168 ALU64_OR_K: 0x0000ffffffff0000 | -1 = 0xffffffffffffffff
	interp: 324
	jitted: 99
	        30.6%
	harden: 221
	        68.2%
#169 ALU64_OR_K: 0x000000000000000 | -1 = 0xffffffffffffffff
	interp: 309
	jitted: 147
	        47.6%
	harden: 198
	        64.1%
#170 ALU_XOR_X: 5 ^ 6 = 3
	interp: 216
	jitted: 80
	        37.0%
	harden: 138
	        63.9%
#171 ALU_XOR_X: 0x1 ^ 0xffffffff = 0xfffffffe
	interp: 414
	jitted: 73
	        17.6%
	harden: 130
	        31.4%
#172 ALU64_XOR_X: 5 ^ 6 = 3
	interp: 320
	jitted: 71
	        22.2%
	harden: 114
	        35.6%
#173 ALU64_XOR_X: 1 ^ 0xffffffff = 0xfffffffe
	interp: 223
	jitted: 72
	        32.3%
	harden: 106
	        47.5%
#174 ALU_XOR_K: 5 ^ 6 = 3
	interp: 203
	jitted: 71
	        35.0%
	harden: 112
	        55.2%
#175 ALU_XOR_K: 1 ^ 0xffffffff = 0xfffffffe
	interp: 205
	jitted: 67
	        32.7%
	harden: 116
	        56.6%
#176 ALU64_XOR_K: 5 ^ 6 = 3
	interp: 205
	jitted: 70
	        34.1%
	harden: 114
	        55.6%
#177 ALU64_XOR_K: 1 & 0xffffffff = 0xfffffffe
	interp: 186
	jitted: 104
	        55.9%
	harden: 112
	        60.2%
#178 ALU64_XOR_K: 0x0000ffffffff0000 ^ 0x0 = 0x0000ffffffff0000
	interp: 352
	jitted: 96
	        27.3%
	harden: 201
	        57.1%
#179 ALU64_XOR_K: 0x0000ffffffff0000 ^ -1 = 0xffff00000000ffff
	interp: 353
	jitted: 119
	        33.7%
	harden: 242
	        68.6%
#180 ALU64_XOR_K: 0x000000000000000 ^ -1 = 0xffffffffffffffff
	interp: 362
	jitted: 116
	        32.0%
	harden: 208
	        57.5%
#181 ALU_LSH_X: 1 << 1 = 2
	interp: 211
	jitted: 100
	        47.4%
	harden: 112
	        53.1%
#182 ALU_LSH_X: 1 << 31 = 0x80000000
	interp: 216
	jitted: 73
	        33.8%
	harden: 137
	        63.4%
#183 ALU64_LSH_X: 1 << 1 = 2
	interp: 224
	jitted: 119
	        53.1%
	harden: 163
	        72.8%
#184 ALU64_LSH_X: 1 << 31 = 0x80000000
	interp: 223
	jitted: 110
	        49.3%
	harden: 145
	        65.0%
#185 ALU_LSH_K: 1 << 1 = 2
	interp: 208
	jitted: 147
	        70.7%
	harden: 92
	        44.2%
#186 ALU_LSH_K: 1 << 31 = 0x80000000
	interp: 210
	jitted: 116
	        55.2%
	harden: 94
	        44.8%
#187 ALU64_LSH_K: 1 << 1 = 2
	interp: 211
	jitted: 154
	        73.0%
	harden: 94
	        44.5%
#188 ALU64_LSH_K: 1 << 31 = 0x80000000
	interp: 182
	jitted: 92
	        50.5%
	harden: 127
	        69.8%
#189 ALU_RSH_X: 2 >> 1 = 1
	interp: 226
	jitted: 86
	        38.1%
	harden: 135
	        59.7%
#190 ALU_RSH_X: 0x80000000 >> 31 = 1
	interp: 225
	jitted: 148
	        65.8%
	harden: 109
	        48.4%
#191 ALU64_RSH_X: 2 >> 1 = 1
	interp: 289
	jitted: 108
	        37.4%
	harden: 123
	        42.6%
#192 ALU64_RSH_X: 0x80000000 >> 31 = 1
	interp: 253
	jitted: 96
	        37.9%
	harden: 117
	        46.2%
#193 ALU_RSH_K: 2 >> 1 = 1
	interp: 207
	jitted: 68
	        32.9%
	harden: 95
	        45.9%
#194 ALU_RSH_K: 0x80000000 >> 31 = 1
	interp: 210
	jitted: 74
	        35.2%
	harden: 103
	        49.0%
#195 ALU64_RSH_K: 2 >> 1 = 1
	interp: 232
	jitted: 66
	        28.4%
	harden: 124
	        53.4%
#196 ALU64_RSH_K: 0x80000000 >> 31 = 1
	interp: 208
	jitted: 95
	        45.7%
	harden: 107
	        51.4%
#197 ALU_ARSH_X: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff
	interp: 252
	jitted: 74
	        29.4%
	harden: 125
	        49.6%
#198 ALU_ARSH_K: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff
	interp: 197
	jitted: 96
	        48.7%
	harden: 105
	        53.3%
#199 ALU_NEG: -(3) = -3
	interp: 189
	jitted: 84
	        44.4%
	harden: 76
	        40.2%
#200 ALU_NEG: -(-3) = 3
	interp: 171
	jitted: 72
	        42.1%
	harden: 106
	        62.0%
#201 ALU64_NEG: -(3) = -3
	interp: 179
	jitted: 74
	        41.3%
	harden: 104
	        58.1%
#202 ALU64_NEG: -(-3) = 3
	interp: 180
	jitted: 68
	        37.8%
	harden: 135
	        75.0%
#203 ALU_END_FROM_BE 16: 0x0123456789abcdef -> 0xcdef
	interp: 202
	jitted: 74
	        36.6%
	harden: 115
	        56.9%
#204 ALU_END_FROM_BE 32: 0x0123456789abcdef -> 0x89abcdef
	interp: 368
	jitted: 101
	        27.4%
	harden: 101
	        27.4%
#205 ALU_END_FROM_BE 64: 0x0123456789abcdef -> 0x89abcdef
	interp: 244
	jitted: 93
	        38.1%
	harden: 103
	        42.2%
#206 ALU_END_FROM_LE 16: 0x0123456789abcdef -> 0xefcd
	interp: 274
	jitted: 73
	        26.6%
	harden: 107
	        39.1%
#207 ALU_END_FROM_LE 32: 0x0123456789abcdef -> 0xefcdab89
	interp: 319
	jitted: 76
	        23.8%
	harden: 93
	        29.2%
#208 ALU_END_FROM_LE 64: 0x0123456789abcdef -> 0x67452301
	interp: 193
	jitted: 78
	        40.4%
	harden: 108
	        56.0%
#209 ST_MEM_B: Store/Load byte: max negative
	interp: 219
	jitted: 72
	        32.9%
	harden: 168
	        76.7%
#210 ST_MEM_B: Store/Load byte: max positive
	interp: 227
	jitted: 79
	        34.8%
	harden: 105
	        46.3%
#211 STX_MEM_B: Store/Load byte: max negative
	interp: 251
	jitted: 79
	        31.5%
	harden: 140
	        55.8%
#212 ST_MEM_H: Store/Load half word: max negative
	interp: 218
	jitted: 81
	        37.2%
	harden: 98
	        45.0%
#213 ST_MEM_H: Store/Load half word: max positive
	interp: 208
	jitted: 100
	        48.1%
	harden: 109
	        52.4%
#214 STX_MEM_H: Store/Load half word: max negative
	interp: 259
	jitted: 110
	        42.5%
	harden: 134
	        51.7%
#215 ST_MEM_W: Store/Load word: max negative
	interp: 253
	jitted: 75
	        29.6%
	harden: 148
	        58.5%
#216 ST_MEM_W: Store/Load word: max positive
	interp: 244
	jitted: 89
	        36.5%
	harden: 136
	        55.7%
#217 STX_MEM_W: Store/Load word: max negative
	interp: 297
	jitted: 122
	        41.1%
	harden: 205
	        69.0%
#218 ST_MEM_DW: Store/Load double word: max negative
	interp: 257
	jitted: 85
	        33.1%
	harden: 124
	        48.2%
#219 ST_MEM_DW: Store/Load double word: max negative 2
	interp: 392
	jitted: 123
	        31.4%
	harden: 222
	        56.6%
#220 ST_MEM_DW: Store/Load double word: max positive
	interp: 292
	jitted: 78
	        26.7%
	harden: 110
	        37.7%
#221 STX_MEM_DW: Store/Load double word: max negative
	interp: 259
	jitted: 85
	        32.8%
	harden: 194
	        74.9%
#230 JMP_EXIT
	interp: 127
	jitted: 82
	        64.6%
	harden: 77
	        60.6%
#231 JMP_JA: Unconditional jump: if (true) return 1
	interp: 194
	jitted: 86
	        44.3%
	harden: 84
	        43.3%
#232 JMP_JSGT_K: Signed jump: if (-1 > -2) return 1
	interp: 262
	jitted: 86
	        32.8%
	harden: 128
	        48.9%
#233 JMP_JSGT_K: Signed jump: if (-1 > -1) return 0
	interp: 249
	jitted: 82
	        32.9%
	harden: 126
	        50.6%
#234 JMP_JSGE_K: Signed jump: if (-1 >= -2) return 1
	interp: 262
	jitted: 72
	        27.5%
	harden: 179
	        68.3%
#235 JMP_JSGE_K: Signed jump: if (-1 >= -1) return 1
	interp: 260
	jitted: 73
	        28.1%
	harden: 125
	        48.1%
#236 JMP_JGT_K: if (3 > 2) return 1
	interp: 260
	jitted: 71
	        27.3%
	harden: 142
	        54.6%
#237 JMP_JGT_K: Unsigned jump: if (-1 > 1) return 1
	interp: 278
	jitted: 72
	        25.9%
	harden: 161
	        57.9%
#238 JMP_JGE_K: if (3 >= 2) return 1
	interp: 255
	jitted: 77
	        30.2%
	harden: 163
	        63.9%
#239 JMP_JGT_K: if (3 > 2) return 1 (jump backwards)
	interp: 321
	jitted: 76
	        23.7%
	harden: 143
	        44.5%
#240 JMP_JGE_K: if (3 >= 3) return 1
	interp: 340
	jitted: 74
	        21.8%
	harden: 179
	        52.6%
#241 JMP_JNE_K: if (3 != 2) return 1
	interp: 310
	jitted: 74
	        23.9%
	harden: 144
	        46.5%
#242 JMP_JEQ_K: if (3 == 3) return 1
	interp: 310
	jitted: 78
	        25.2%
	harden: 144
	        46.5%
#243 JMP_JSET_K: if (0x3 & 0x2) return 1
	interp: 276
	jitted: 109
	        39.5%
	harden: 149
	        54.0%
#244 JMP_JSET_K: if (0x3 & 0xffffffff) return 1
	interp: 312
	jitted: 71
	        22.8%
	harden: 153
	        49.0%
#245 JMP_JSGT_X: Signed jump: if (-1 > -2) return 1
	interp: 346
	jitted: 75
	        21.7%
	harden: 162
	        46.8%
#246 JMP_JSGT_X: Signed jump: if (-1 > -1) return 0
	interp: 292
	jitted: 78
	        26.7%
	harden: 162
	        55.5%
#247 JMP_JSGE_X: Signed jump: if (-1 >= -2) return 1
	interp: 318
	jitted: 134
	        42.1%
	harden: 178
	        56.0%
#248 JMP_JSGE_X: Signed jump: if (-1 >= -1) return 1
	interp: 287
	jitted: 102
	        35.5%
	harden: 192
	        66.9%
#249 JMP_JGT_X: if (3 > 2) return 1
	interp: 316
	jitted: 83
	        26.3%
	harden: 205
	        64.9%
#250 JMP_JGT_X: Unsigned jump: if (-1 > 1) return 1
	interp: 400
	jitted: 80
	        20.0%
	harden: 154
	        38.5%
#251 JMP_JGE_X: if (3 >= 2) return 1
	interp: 287
	jitted: 78
	        27.2%
	harden: 177
	        61.7%
#252 JMP_JGE_X: if (3 >= 3) return 1
	interp: 287
	jitted: 116
	        40.4%
	harden: 160
	        55.7%
#253 JMP_JGE_X: ldimm64 test 1
	interp: 323
	jitted: 81
	        25.1%
	harden: 204
	        63.2%
#254 JMP_JGE_X: ldimm64 test 2
	interp: 298
	jitted: 79
	        26.5%
	harden: 201
	        67.4%
#255 JMP_JGE_X: ldimm64 test 3
	interp: 263
	jitted: 78
	        29.7%
	harden: 184
	        70.0%
#256 JMP_JNE_X: if (3 != 2) return 1
	interp: 313
	jitted: 108
	        34.5%
	harden: 168
	        53.7%
#257 JMP_JEQ_X: if (3 == 3) return 1
	interp: 308
	jitted: 102
	        33.1%
	harden: 197
	        64.0%
#258 JMP_JSET_X: if (0x3 & 0x2) return 1
	interp: 359
	jitted: 133
	        37.0%
	harden: 192
	        53.5%
#259 JMP_JSET_X: if (0x3 & 0xffffffff) return 1
	interp: 421
	jitted: 128
	        30.4%
	harden: 181
	        43.0%
#260 JMP_JA: Jump, gap, jump, ...
	interp: 309
	jitted: 108
	        35.0%
	harden: 97
	        31.4%
#261 BPF_MAXINSNS: Maximum possible literals
	interp: 251
	jitted: 111
	        44.2%
	harden: 125
	        49.8%
#262 BPF_MAXINSNS: Single literal
	interp: 286
	jitted: 115
	        40.2%
	harden: 105
	        36.7%
#263 BPF_MAXINSNS: Run/add until end
	interp: 254969
	jitted: 8481
	        3.3%
	harden: 121315
	        47.6%
#265 BPF_MAXINSNS: Very long jump
	interp: 284
	jitted: 123
	        43.3%
	harden: 131
	        46.1%
#266 BPF_MAXINSNS: Ctx heavy transformations
	interp: 548311	560800
	jitted: 28166	29032
	        5.1%	5.2%
	harden: 217030	181848
	        39.6%	32.4%
#268 BPF_MAXINSNS: Jump heavy test
	interp: 480796
	jitted: 132663
	        27.6%
	harden: 440621
	        91.6%
#269 BPF_MAXINSNS: Very long jump backwards
	interp: 193
	jitted: 148
	        76.7%
	harden: 154
	        79.8%
#270 BPF_MAXINSNS: Edge hopping nuthouse
	interp: 114304
	jitted: 277097
	        242.4%
	harden: 302835
	        264.9%
#271 BPF_MAXINSNS: Jump, gap, jump, ...
	interp: 1884
	jitted: 1041
	        55.3%
	harden: 1008
	        53.5%
#274 LD_IND byte frag
	interp: 695
	jitted: 574
	        82.6%
	harden: 1453
	        209.1%
#275 LD_IND halfword frag
	interp: 818
	jitted: 641
	        78.4%
	harden: 600
	        73.3%
#276 LD_IND word frag
	interp: 837
	jitted: 731
	        87.3%
	harden: 719
	        85.9%
#277 LD_IND halfword mixed head/frag
	interp: 1170
	jitted: 741
	        63.3%
	harden: 705
	        60.3%
#278 LD_IND word mixed head/frag
	interp: 950
	jitted: 972
	        102.3%
	harden: 732
	        77.1%
#279 LD_ABS byte frag
	interp: 953
	jitted: 601
	        63.1%
	harden: 683
	        71.7%
#280 LD_ABS halfword frag
	interp: 754
	jitted: 603
	        80.0%
	harden: 595
	        78.9%
#281 LD_ABS word frag
	interp: 1133
	jitted: 688
	        60.7%
	harden: 672
	        59.3%
#282 LD_ABS halfword mixed head/frag
	interp: 1079
	jitted: 657
	        60.9%
	harden: 775
	        71.8%
#283 LD_ABS word mixed head/frag
	interp: 718
	jitted: 748
	        104.2%
	harden: 725
	        101.0%
#284 LD_IND byte default X
	interp: 297
	jitted: 178
	        59.9%
	harden: 274
	        92.3%
#285 LD_IND byte positive offset
	interp: 300
	jitted: 187
	        62.3%
	harden: 302
	        100.7%
#286 LD_IND byte negative offset
	interp: 296
	jitted: 178
	        60.1%
	harden: 311
	        105.1%
#287 LD_IND halfword positive offset
	interp: 333
	jitted: 161
	        48.3%
	harden: 218
	        65.5%
#288 LD_IND halfword negative offset
	interp: 306
	jitted: 195
	        63.7%
	harden: 193
	        63.1%
#289 LD_IND halfword unaligned
	interp: 307
	jitted: 183
	        59.6%
	harden: 190
	        61.9%
#290 LD_IND word positive offset
	interp: 337
	jitted: 170
	        50.4%
	harden: 200
	        59.3%
#291 LD_IND word negative offset
	interp: 312
	jitted: 198
	        63.5%
	harden: 216
	        69.2%
#292 LD_IND word unaligned (addr & 3 == 2)
	interp: 309
	jitted: 281
	        90.9%
	harden: 195
	        63.1%
#293 LD_IND word unaligned (addr & 3 == 1)
	interp: 335
	jitted: 172
	        51.3%
	harden: 196
	        58.5%
#294 LD_IND word unaligned (addr & 3 == 3)
	interp: 305
	jitted: 171
	        56.1%
	harden: 221
	        72.5%
#295 LD_ABS byte
	interp: 269
	jitted: 162
	        60.2%
	harden: 195
	        72.5%
#296 LD_ABS halfword
	interp: 294
	jitted: 160
	        54.4%
	harden: 170
	        57.8%
#297 LD_ABS halfword unaligned
	interp: 271
	jitted: 180
	        66.4%
	harden: 167
	        61.6%
#298 LD_ABS word
	interp: 265
	jitted: 166
	        62.6%
	harden: 182
	        68.7%
#299 LD_ABS word unaligned (addr & 3 == 2)
	interp: 267
	jitted: 157
	        58.8%
	harden: 185
	        69.3%
#300 LD_ABS word unaligned (addr & 3 == 1)
	interp: 269
	jitted: 170
	        63.2%
	harden: 162
	        60.2%
#301 LD_ABS word unaligned (addr & 3 == 3)
	interp: 281
	jitted: 163
	        58.0%
	harden: 231
	        82.2%
#302 ADD default X
	interp: 296
	jitted: 84
	        28.4%
	harden: 105
	        35.5%
#303 ADD default A
	interp: 309
	jitted: 79
	        25.6%
	harden: 101
	        32.7%
#304 SUB default X
	interp: 290
	jitted: 82
	        28.3%
	harden: 106
	        36.6%
#305 SUB default A
	interp: 252
	jitted: 85
	        33.7%
	harden: 119
	        47.2%
#306 MUL default X
	interp: 322
	jitted: 76
	        23.6%
	harden: 131
	        40.7%
#307 MUL default A
	interp: 267
	jitted: 83
	        31.1%
	harden: 116
	        43.4%
#308 DIV default X
	interp: 293
	jitted: 93
	        31.7%
	harden: 116
	        39.6%
#309 DIV default A
	interp: 336
	jitted: 203
	        60.4%
	harden: 227
	        67.6%
#310 MOD default X
	interp: 284
	jitted: 100
	        35.2%
	harden: 98
	        34.5%
#311 MOD default A
	interp: 435
	jitted: 249
	        57.2%
	harden: 265
	        60.9%
#312 JMP EQ default A
	interp: 352
	jitted: 83
	        23.6%
	harden: 134
	        38.1%
#313 JMP EQ default X
	interp: 357
	jitted: 95
	        26.6%
	harden: 108
	        30.3%
