From: dev@lynxeye.de (Lucas Stach)
Date: Wed,  8 Apr 2015 21:46:05 +0200
Subject: [PATCH v2 0/5] Tegra 2 NAND Flash Support
Message-ID: <1428522370-18035-1-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've spent some idle cycles to get the Tegra NAND flash controller
driver into shape. I reworked the driver to incorporate any review
I got from the first round of this series.

Performance is up a bit, and now seems to be in the range that
one could expect from the device. According to some simple
benchmarks (thanks Stefan) this driver is faster than the L4T
downstream driver.

Also the driver got a significant amount of testing, which revealed
some problems with ECC handling which should now be all fixed. MTD
test results attached.

Regards,
Lucas

[root at localhost ~]# insmod /root/mtd-tests/mtd_speedtest.ko dev=1
[  108.607611] 
[  108.612143] =================================================
[  108.617913] mtd_speedtest: MTD device: 1
[  108.622930] mtd_speedtest: MTD device size 67108864, eraseblock size 524288, page size 4096, count of eraseblocks 128, pages per eraseblock 128, OOB size 224
[  108.677678] mtd_test: scanning for bad eraseblocks
[  108.682616] mtd_test: scanned 128 eraseblocks, 0 are bad
[  108.786282] mtd_speedtest: testing eraseblock write speed
[  116.735746] mtd_speedtest: eraseblock write speed is 8403 KiB/s
[  116.741699] mtd_speedtest: testing eraseblock read speed
[  121.365402] mtd_speedtest: eraseblock read speed is 14256 KiB/s
[  121.509170] mtd_speedtest: testing page write speed
[  129.700082] mtd_speedtest: page write speed is 8012 KiB/s
[  129.705515] mtd_speedtest: testing page read speed
[  134.377940] mtd_speedtest: page read speed is 14039 KiB/s
[  134.521148] mtd_speedtest: testing 2 page write speed
[  142.564004] mtd_speedtest: 2 page write speed is 8154 KiB/s
[  142.569610] mtd_speedtest: testing 2 page read speed
[  147.221758] mtd_speedtest: 2 page read speed is 14099 KiB/s
[  147.227360] mtd_speedtest: Testing erase speed
[  147.369935] mtd_speedtest: erase speed is 474898 KiB/s
[  147.375105] mtd_speedtest: Testing 2x multi-block erase speed
[  147.456717] mtd_speedtest: 2x multi-block erase speed is 873813 KiB/s
[  147.463163] mtd_speedtest: Testing 4x multi-block erase speed
[  147.546198] mtd_speedtest: 4x multi-block erase speed is 862315 KiB/s
[  147.552643] mtd_speedtest: Testing 8x multi-block erase speed
[  147.635005] mtd_speedtest: 8x multi-block erase speed is 873813 KiB/s
[  147.641449] mtd_speedtest: Testing 16x multi-block erase speed
[  147.723454] mtd_speedtest: 16x multi-block erase speed is 873813 KiB/s
[  147.730037] mtd_speedtest: Testing 32x multi-block erase speed
[  147.810388] mtd_speedtest: 32x multi-block erase speed is 897753 KiB/s
[  147.816953] mtd_speedtest: Testing 64x multi-block erase speed
[  147.897626] mtd_speedtest: 64x multi-block erase speed is 885621 KiB/s
[  147.904147] mtd_speedtest: finished
[  147.908506] =================================================


[root at localhost ~]# insmod /root/mtd-tests/mtd_nandbiterrs.ko dev=1 mode=0
[  174.629593] 
[  174.631117] ==================================================
[  174.638285] mtd_nandbiterrs: MTD device: 1
[  174.642420] mtd_nandbiterrs: MTD device size 67108864, eraseblock=524288, page=4096, oob=224
[  174.651956] mtd_nandbiterrs: Device uses 4 subpages of 1024 bytes
[  174.658947] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[  174.666945] mtd_nandbiterrs: incremental biterrors test
[  174.673084] mtd_nandbiterrs: write_page
[  174.677507] mtd_nandbiterrs: rewrite page
[  174.699128] mtd_nandbiterrs: read_page
[  174.703391] mtd_nandbiterrs: verify_page
[  174.707929] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
[  174.715160] mtd_nandbiterrs: Inserted biterror @ 0/5
[  174.720140] mtd_nandbiterrs: Inserted biterror @ 1025/7
[  174.725527] mtd_nandbiterrs: Inserted biterror @ 2048/5
[  174.730765] mtd_nandbiterrs: Inserted biterror @ 3072/4
[  174.736142] mtd_nandbiterrs: rewrite page
[  174.751375] mtd_nandbiterrs: read_page
[  174.755414] mtd_nandbiterrs: Read reported 4 corrected bit errors
[  174.761490] mtd_nandbiterrs: verify_page
[  174.765547] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
[  174.772577] mtd_nandbiterrs: Inserted biterror @ 0/2
[  174.777541] mtd_nandbiterrs: Inserted biterror @ 1026/6
[  174.782786] mtd_nandbiterrs: Inserted biterror @ 2048/4
[  174.788013] mtd_nandbiterrs: Inserted biterror @ 3072/1
[  174.793221] mtd_nandbiterrs: rewrite page
[  174.806444] mtd_nandbiterrs: read_page
[  174.810464] mtd_nandbiterrs: Read reported 5 corrected bit errors
[  174.816560] mtd_nandbiterrs: verify_page
[  174.820604] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
[  174.827649] mtd_nandbiterrs: Inserted biterror @ 0/0
[  174.832598] mtd_nandbiterrs: Inserted biterror @ 1027/7
[  174.837821] mtd_nandbiterrs: Inserted biterror @ 2048/2
[  174.843030] mtd_nandbiterrs: Inserted biterror @ 3073/7
[  174.848251] mtd_nandbiterrs: rewrite page
[  174.861385] mtd_nandbiterrs: read_page
[  174.865420] mtd_nandbiterrs: Read reported 8 corrected bit errors
[  174.871495] mtd_nandbiterrs: verify_page
[  174.875551] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
[  174.882580] mtd_nandbiterrs: Inserted biterror @ 1/7
[  174.887550] mtd_nandbiterrs: Inserted biterror @ 1027/6
[  174.892759] mtd_nandbiterrs: Inserted biterror @ 2048/1
[  174.897983] mtd_nandbiterrs: Inserted biterror @ 3073/4
[  174.903197] mtd_nandbiterrs: rewrite page
[  174.916415] mtd_nandbiterrs: read_page
[  174.920435] mtd_nandbiterrs: Read reported 9 corrected bit errors
[  174.926530] mtd_nandbiterrs: verify_page
[  174.930567] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
[  174.937611] mtd_nandbiterrs: Inserted biterror @ 1/5
[  174.942560] mtd_nandbiterrs: Inserted biterror @ 1028/5
[  174.947782] mtd_nandbiterrs: Inserted biterror @ 2048/0
[  174.952991] mtd_nandbiterrs: Inserted biterror @ 3073/1
[  174.958212] mtd_nandbiterrs: rewrite page
[  174.971437] mtd_nandbiterrs: read_page
[  174.975472] mtd_nandbiterrs: Read reported 11 corrected bit errors
[  174.981634] mtd_nandbiterrs: verify_page
[  174.985690] mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
[  174.992724] mtd_nandbiterrs: Inserted biterror @ 1/2
[  174.997688] mtd_nandbiterrs: Inserted biterror @ 1029/7
[  175.002897] mtd_nandbiterrs: Inserted biterror @ 2049/7
[  175.008124] mtd_nandbiterrs: Inserted biterror @ 3074/6
[  175.013332] mtd_nandbiterrs: rewrite page
[  175.026567] mtd_nandbiterrs: read_page
[  175.030591] mtd_nandbiterrs: Read reported 14 corrected bit errors
[  175.036771] mtd_nandbiterrs: verify_page
[  175.040841] mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
[  175.047889] mtd_nandbiterrs: Inserted biterror @ 1/0
[  175.052839] mtd_nandbiterrs: Inserted biterror @ 1029/5
[  175.058063] mtd_nandbiterrs: Inserted biterror @ 2049/5
[  175.063271] mtd_nandbiterrs: Inserted biterror @ 3074/4
[  175.068492] mtd_nandbiterrs: rewrite page
[  175.081688] mtd_nandbiterrs: read_page
[  175.085710] mtd_nandbiterrs: Read reported 14 corrected bit errors
[  175.091890] mtd_nandbiterrs: verify_page
[  175.095927] mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
[  175.102971] mtd_nandbiterrs: Inserted biterror @ 2/6
[  175.107935] mtd_nandbiterrs: Inserted biterror @ 1030/6
[  175.113150] mtd_nandbiterrs: Inserted biterror @ 2049/4
[  175.118374] mtd_nandbiterrs: Inserted biterror @ 3074/1
[  175.123582] mtd_nandbiterrs: rewrite page
[  175.136799] mtd_nandbiterrs: read_page
[  175.140821] mtd_nandbiterrs: Read reported 17 corrected bit errors
[  175.147001] mtd_nandbiterrs: verify_page
[  175.151039] mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
[  175.158083] mtd_nandbiterrs: Inserted biterror @ 2/5
[  175.163032] mtd_nandbiterrs: Inserted biterror @ 1030/5
[  175.168284] mtd_nandbiterrs: Inserted biterror @ 2049/2
[  175.173493] mtd_nandbiterrs: Inserted biterror @ 3075/7
[  175.178718] mtd_nandbiterrs: rewrite page
[  175.191926] mtd_nandbiterrs: read_page
[  175.195949] mtd_nandbiterrs: Read reported 18 corrected bit errors
[  175.202129] mtd_nandbiterrs: verify_page
[  175.206168] mtd_nandbiterrs: Successfully corrected 9 bit errors per subpage
[  175.213215] mtd_nandbiterrs: Inserted biterror @ 2/2
[  175.218183] mtd_nandbiterrs: Inserted biterror @ 1031/7
[  175.223392] mtd_nandbiterrs: Inserted biterror @ 2049/1
[  175.228614] mtd_nandbiterrs: Inserted biterror @ 3075/6
[  175.233822] mtd_nandbiterrs: rewrite page
[  175.246926] mtd_nandbiterrs: read_page
[  175.250997] mtd_nandbiterrs: Read reported 20 corrected bit errors
[  175.257160] mtd_nandbiterrs: verify_page
[  175.261217] mtd_nandbiterrs: Successfully corrected 10 bit errors per subpage
[  175.268354] mtd_nandbiterrs: Inserted biterror @ 2/0
[  175.273303] mtd_nandbiterrs: Inserted biterror @ 1031/6
[  175.278527] mtd_nandbiterrs: Inserted biterror @ 2049/0
[  175.283736] mtd_nandbiterrs: Inserted biterror @ 3075/4
[  175.288957] mtd_nandbiterrs: rewrite page
[  175.302207] mtd_nandbiterrs: read_page
[  175.306233] mtd_nandbiterrs: Read reported 20 corrected bit errors
[  175.312415] mtd_nandbiterrs: verify_page
[  175.316453] mtd_nandbiterrs: Successfully corrected 11 bit errors per subpage
[  175.323589] mtd_nandbiterrs: Inserted biterror @ 3/7
[  175.328555] mtd_nandbiterrs: Inserted biterror @ 1031/5
[  175.333765] mtd_nandbiterrs: Inserted biterror @ 2050/6
[  175.338988] mtd_nandbiterrs: Inserted biterror @ 3075/1
[  175.344196] mtd_nandbiterrs: rewrite page
[  175.357415] mtd_nandbiterrs: read_page
[  175.361457] mtd_nandbiterrs: Read reported 22 corrected bit errors
[  175.367620] mtd_nandbiterrs: verify_page
[  175.371676] mtd_nandbiterrs: Successfully corrected 12 bit errors per subpage
[  175.378807] mtd_nandbiterrs: Inserted biterror @ 3/6
[  175.383757] mtd_nandbiterrs: Inserted biterror @ 1032/7
[  175.388979] mtd_nandbiterrs: Inserted biterror @ 2050/5
[  175.394188] mtd_nandbiterrs: Inserted biterror @ 3076/5
[  175.399408] mtd_nandbiterrs: rewrite page
[  175.412576] mtd_nandbiterrs: read_page
[  175.416602] mtd_nandbiterrs: Read reported 24 corrected bit errors
[  175.422817] mtd_nandbiterrs: verify_page
[  175.426856] mtd_nandbiterrs: Successfully corrected 13 bit errors per subpage
[  175.433992] mtd_nandbiterrs: Inserted biterror @ 3/5
[  175.438956] mtd_nandbiterrs: Inserted biterror @ 1032/4
[  175.444165] mtd_nandbiterrs: Inserted biterror @ 2050/4
[  175.449387] mtd_nandbiterrs: Inserted biterror @ 3076/4
[  175.454596] mtd_nandbiterrs: rewrite page
[  175.467725] mtd_nandbiterrs: read_page
[  175.471762] mtd_nandbiterrs: Read reported 25 corrected bit errors
[  175.477925] mtd_nandbiterrs: verify_page
[  175.481981] mtd_nandbiterrs: Successfully corrected 14 bit errors per subpage
[  175.489097] mtd_nandbiterrs: Inserted biterror @ 3/2
[  175.494061] mtd_nandbiterrs: Inserted biterror @ 1033/4
[  175.499282] mtd_nandbiterrs: Inserted biterror @ 2050/2
[  175.504492] mtd_nandbiterrs: Inserted biterror @ 3076/1
[  175.509712] mtd_nandbiterrs: rewrite page
[  175.522924] mtd_nandbiterrs: read_page
[  175.526948] mtd_nandbiterrs: Read reported 27 corrected bit errors
[  175.533129] mtd_nandbiterrs: verify_page
[  175.537180] mtd_nandbiterrs: Successfully corrected 15 bit errors per subpage
[  175.544311] mtd_nandbiterrs: Inserted biterror @ 3/0
[  175.549290] mtd_nandbiterrs: Inserted biterror @ 1034/7
[  175.554516] mtd_nandbiterrs: Inserted biterror @ 2050/1
[  175.559728] mtd_nandbiterrs: Inserted biterror @ 3077/7
[  175.564949] mtd_nandbiterrs: rewrite page
[  175.578130] mtd_nandbiterrs: read_page
[  175.582166] mtd_nandbiterrs: error: read failed at 0x0
[  175.587289] mtd_nandbiterrs: After 16 biterrors per subpage, read reported error -74
[  175.595596] mtd_nandbiterrs: finished successfully.
[  175.600478] ==================================================
insmod: ERROR: could not insert module /root/mtd-tests/mtd_nandbiterrs.ko: Input/output error

[root at localhost ~]# insmod /root/mtd-tests/mtd_nandbiterrs.ko dev=1 mode=1
[  189.039493] 
[  189.041014] ==================================================
[  189.046968] mtd_nandbiterrs: MTD device: 1
[  189.051096] mtd_nandbiterrs: MTD device size 67108864, eraseblock=524288, page=4096, oob=224
[  189.060056] mtd_nandbiterrs: Device uses 4 subpages of 1024 bytes
[  189.066396] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[  189.074382] mtd_nandbiterrs: overwrite biterrors test
[  189.079952] mtd_nandbiterrs: write_page
[  202.616531] mtd_nandbiterrs: Read reported 1 corrected bit errors
[  207.467579] mtd_nandbiterrs: Read reported 2 corrected bit errors
[  209.060301] mtd_nandbiterrs: Read reported 3 corrected bit errors
[  211.872583] mtd_nandbiterrs: Read reported 4 corrected bit errors
[  213.115939] mtd_nandbiterrs: Read reported 5 corrected bit errors
[  218.396860] mtd_nandbiterrs: Read reported 6 corrected bit errors
[  218.554635] mtd_nandbiterrs: Read reported 7 corrected bit errors
[  219.949190] mtd_nandbiterrs: Read reported 8 corrected bit errors
[  221.741819] mtd_nandbiterrs: Read reported 9 corrected bit errors
[  225.065108] mtd_nandbiterrs: Read reported 10 corrected bit errors
[  225.449503] mtd_nandbiterrs: Read reported 11 corrected bit errors
[  227.442651] mtd_nandbiterrs: Read reported 12 corrected bit errors
[  232.432393] mtd_nandbiterrs: Read reported 13 corrected bit errors
[  234.794003] mtd_nandbiterrs: Read reported 14 corrected bit errors
[  235.065069] mtd_nandbiterrs: Read reported 15 corrected bit errors
[  235.686246] mtd_nandbiterrs: Read reported 16 corrected bit errors
[  238.296935] mtd_nandbiterrs: Read reported 17 corrected bit errors
[  239.316587] mtd_nandbiterrs: Read reported 18 corrected bit errors
[  239.957394] mtd_nandbiterrs: Read reported 19 corrected bit errors
[  241.752129] mtd_nandbiterrs: Read reported 20 corrected bit errors
[  242.430117] mtd_nandbiterrs: Read reported 21 corrected bit errors
[  243.817587] mtd_nandbiterrs: Read reported 22 corrected bit errors
[  243.861707] mtd_nandbiterrs: Read reported 23 corrected bit errors
[  244.047620] mtd_nandbiterrs: Read reported 24 corrected bit errors
[  244.989938] mtd_nandbiterrs: Read reported 25 corrected bit errors
[  246.840869] mtd_nandbiterrs: Read reported 26 corrected bit errors
[  246.998449] mtd_nandbiterrs: Read reported 27 corrected bit errors
[  247.299432] mtd_nandbiterrs: Read reported 28 corrected bit errors
[  247.769255] mtd_nandbiterrs: Read reported 29 corrected bit errors
[  248.115931] mtd_nandbiterrs: Read reported 30 corrected bit errors
[  250.174867] mtd_nandbiterrs: Read reported 31 corrected bit errors
[  250.805717] mtd_nandbiterrs: Read reported 32 corrected bit errors
[  253.500340] mtd_nandbiterrs: Read reported 33 corrected bit errors
[  255.854560] mtd_nandbiterrs: Read reported 34 corrected bit errors
[  258.862542] mtd_nandbiterrs: Read reported 35 corrected bit errors
[  260.061025] mtd_nandbiterrs: Read reported 36 corrected bit errors
[  260.398326] mtd_nandbiterrs: Read reported 37 corrected bit errors
[  261.209347] mtd_nandbiterrs: Read reported 38 corrected bit errors
[  262.133054] mtd_nandbiterrs: Read reported 39 corrected bit errors
[  262.782686] mtd_nandbiterrs: Read reported 40 corrected bit errors
[  262.836213] mtd_nandbiterrs: Read reported 41 corrected bit errors
[  263.590229] mtd_nandbiterrs: Read reported 42 corrected bit errors
[  264.505231] mtd_nandbiterrs: Read reported 43 corrected bit errors
[  268.433205] mtd_nandbiterrs: Read reported 44 corrected bit errors
[  273.150540] mtd_nandbiterrs: Read reported 45 corrected bit errors
[  275.095989] mtd_nandbiterrs: Read reported 46 corrected bit errors
[  276.530180] mtd_nandbiterrs: Read reported 47 corrected bit errors
[  277.654199] mtd_nandbiterrs: Read reported 48 corrected bit errors
[  278.598045] mtd_nandbiterrs: Read reported 49 corrected bit errors
[  279.115607] mtd_nandbiterrs: Read reported 50 corrected bit errors
[  280.578877] mtd_nandbiterrs: Read reported 51 corrected bit errors
[  281.407856] mtd_nandbiterrs: error: read failed at 0x0
[  281.412997] mtd_nandbiterrs: Read reported error -74
[  281.417947] mtd_nandbiterrs: Bit error histogram (9698 operations total):
[  281.424732] mtd_nandbiterrs: Page reads with   0 corrected bit errors: 1408
[  281.431693] mtd_nandbiterrs: Page reads with   1 corrected bit errors: 512
[  281.438549] mtd_nandbiterrs: Page reads with   2 corrected bit errors: 166
[  281.445422] mtd_nandbiterrs: Page reads with   3 corrected bit errors: 297
[  281.452298] mtd_nandbiterrs: Page reads with   4 corrected bit errors: 128
[  281.459155] mtd_nandbiterrs: Page reads with   5 corrected bit errors: 565
[  281.466027] mtd_nandbiterrs: Page reads with   6 corrected bit errors: 12
[  281.472812] mtd_nandbiterrs: Page reads with   7 corrected bit errors: 170
[  281.479668] mtd_nandbiterrs: Page reads with   8 corrected bit errors: 199
[  281.486539] mtd_nandbiterrs: Page reads with   9 corrected bit errors: 319
[  281.493439] mtd_nandbiterrs: Page reads with  10 corrected bit errors: 50
[  281.500210] mtd_nandbiterrs: Page reads with  11 corrected bit errors: 206
[  281.507084] mtd_nandbiterrs: Page reads with  12 corrected bit errors: 628
[  281.513957] mtd_nandbiterrs: Page reads with  13 corrected bit errors: 166
[  281.520813] mtd_nandbiterrs: Page reads with  14 corrected bit errors: 31
[  281.527598] mtd_nandbiterrs: Page reads with  15 corrected bit errors: 259
[  281.534508] mtd_nandbiterrs: Page reads with  16 corrected bit errors: 63
[  281.541283] mtd_nandbiterrs: Page reads with  17 corrected bit errors: 95
[  281.548070] mtd_nandbiterrs: Page reads with  18 corrected bit errors: 105
[  281.554946] mtd_nandbiterrs: Page reads with  19 corrected bit errors: 188
[  281.561819] mtd_nandbiterrs: Page reads with  20 corrected bit errors: 122
[  281.568674] mtd_nandbiterrs: Page reads with  21 corrected bit errors: 61
[  281.575458] mtd_nandbiterrs: Page reads with  22 corrected bit errors: 20
[  281.582243] mtd_nandbiterrs: Page reads with  23 corrected bit errors: 37
[  281.589012] mtd_nandbiterrs: Page reads with  24 corrected bit errors: 88
[  281.595796] mtd_nandbiterrs: Page reads with  25 corrected bit errors: 168
[  281.602668] mtd_nandbiterrs: Page reads with  26 corrected bit errors: 24
[  281.609438] mtd_nandbiterrs: Page reads with  27 corrected bit errors: 40
[  281.616222] mtd_nandbiterrs: Page reads with  28 corrected bit errors: 63
[  281.623006] mtd_nandbiterrs: Page reads with  29 corrected bit errors: 149
[  281.629861] mtd_nandbiterrs: Page reads with  30 corrected bit errors: 125
[  281.636732] mtd_nandbiterrs: Page reads with  31 corrected bit errors: 234
[  281.643603] mtd_nandbiterrs: Page reads with  32 corrected bit errors: 114
[  281.650459] mtd_nandbiterrs: Page reads with  33 corrected bit errors: 205
[  281.657334] mtd_nandbiterrs: Page reads with  34 corrected bit errors: 438
[  281.664239] mtd_nandbiterrs: Page reads with  35 corrected bit errors: 69
[  281.671014] mtd_nandbiterrs: Page reads with  36 corrected bit errors: 49
[  281.677799] mtd_nandbiterrs: Page reads with  37 corrected bit errors: 65
[  281.684585] mtd_nandbiterrs: Page reads with  38 corrected bit errors: 84
[  281.691354] mtd_nandbiterrs: Page reads with  39 corrected bit errors: 41
[  281.698138] mtd_nandbiterrs: Page reads with  40 corrected bit errors: 34
[  281.704923] mtd_nandbiterrs: Page reads with  41 corrected bit errors: 30
[  281.711707] mtd_nandbiterrs: Page reads with  42 corrected bit errors: 128
[  281.718562] mtd_nandbiterrs: Page reads with  43 corrected bit errors: 455
[  281.725434] mtd_nandbiterrs: Page reads with  44 corrected bit errors: 490
[  281.732305] mtd_nandbiterrs: Page reads with  45 corrected bit errors: 152
[  281.739161] mtd_nandbiterrs: Page reads with  46 corrected bit errors: 244
[  281.746032] mtd_nandbiterrs: Page reads with  47 corrected bit errors: 101
[  281.752904] mtd_nandbiterrs: Page reads with  48 corrected bit errors: 63
[  281.759680] mtd_nandbiterrs: Page reads with  49 corrected bit errors: 106
[  281.766551] mtd_nandbiterrs: Page reads with  50 corrected bit errors: 88
[  281.773915] mtd_nandbiterrs: finished successfully.
[  281.778779] ==================================================
insmod: ERROR: could not insert module /root/mtd-tests/mtd_nandbiterrs.ko: Input/output error


[root at localhost ~]# insmod /root/mtd-tests/mtd_oobtest.ko dev=1
[   81.671222] 
[   81.672889] =================================================
[   81.678647] mtd_oobtest: MTD device: 1
[   81.684113] mtd_oobtest: MTD device size 67108864, eraseblock size 524288, page size 4096, count of eraseblocks 128, pages per eraseblock 128, OOB size 224
[   81.735121] mtd_test: scanning for bad eraseblocks
[   81.739934] mtd_test: scanned 128 eraseblocks, 0 are bad
[   81.745294] mtd_oobtest: test 1 of 5
[   81.826984] mtd_oobtest: writing OOBs of whole device
[   82.012080] mtd_oobtest: written up to eraseblock 0
[   95.693233] mtd_oobtest: written 128 eraseblocks
[   95.697860] mtd_oobtest: verifying all eraseblocks
[   95.784329] mtd_oobtest: verified up to eraseblock 0
[  104.453700] mtd_oobtest: verified 128 eraseblocks
[  104.458408] mtd_oobtest: test 2 of 5
[  104.535594] mtd_oobtest: writing OOBs of whole device
[  104.640800] mtd_oobtest: written up to eraseblock 0
[  118.332306] mtd_oobtest: written 128 eraseblocks
[  118.336935] mtd_oobtest: verifying all eraseblocks
[  118.423385] mtd_oobtest: verified up to eraseblock 0
[  127.075131] mtd_oobtest: verified 128 eraseblocks
[  127.079825] mtd_oobtest: test 3 of 5
[  127.158388] mtd_oobtest: writing OOBs of whole device
[  127.269185] mtd_oobtest: written up to eraseblock 0
[  140.822559] mtd_oobtest: written 128 eraseblocks
[  140.827186] mtd_oobtest: verifying all eraseblocks
[  140.994636] mtd_oobtest: verified up to eraseblock 0
[  158.287402] mtd_oobtest: verified 128 eraseblocks
[  158.292096] mtd_oobtest: test 4 of 5
[  158.369704] mtd_oobtest: attempting to start write past end of OOB
[  158.375884] mtd_oobtest: an error is expected...
[  158.380488] mtd_oobtest: error occurred as expected
[  158.385927] mtd_oobtest: attempting to start read past end of OOB
[  158.392046] mtd_oobtest: an error is expected...
[  158.396679] mtd_oobtest: error occurred as expected
[  158.401552] mtd_oobtest: attempting to write past end of device
[  158.407477] mtd_oobtest: an error is expected...
[  158.412082] mtd_oobtest: error occurred as expected
[  158.416991] mtd_oobtest: attempting to read past end of device
[  158.422809] mtd_oobtest: an error is expected...
[  158.427434] mtd_oobtest: error occurred as expected
[  158.432869] mtd_oobtest: attempting to write past end of device
[  158.438805] mtd_oobtest: an error is expected...
[  158.443411] mtd_oobtest: error occurred as expected
[  158.448295] mtd_oobtest: attempting to read past end of device
[  158.454132] mtd_oobtest: an error is expected...
[  158.458736] mtd_oobtest: error occurred as expected
[  158.463598] mtd_oobtest: test 5 of 5
[  158.540451] mtd_oobtest: writing OOBs of whole device
[  158.546342] mtd_oobtest: written up to eraseblock 0
[  158.552043] mtd_oobtest: written up to eraseblock 0
[  158.767554] mtd_oobtest: written 127 eraseblocks
[  158.772159] mtd_oobtest: verifying all eraseblocks
[  158.778355] mtd_oobtest: verified up to eraseblock 0
[  158.955044] mtd_oobtest: verified 127 eraseblocks
[  158.959737] mtd_oobtest: finished with 0 errors
[  158.964975] =================================================


Lucas Stach (5):
  mtd: nand: tegra: add devicetree binding
  mtd: nand: add NVIDIA Tegra NAND Flash controller driver
  clk: tegra20: init NDFLASH clock to sensible rate
  ARM: tegra: add Tegra20 NAND flash controller node
  ARM: tegra: enable NAND flash on Colibri T20

 .../bindings/mtd/nvidia,tegra20-nand.txt           |  29 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi         |   6 +
 arch/arm/boot/dts/tegra20.dtsi                     |  13 +
 drivers/clk/tegra/clk-tegra20.c                    |   1 +
 drivers/mtd/nand/Kconfig                           |   6 +
 drivers/mtd/nand/Makefile                          |   1 +
 drivers/mtd/nand/tegra_nand.c                      | 786 +++++++++++++++++++++
 8 files changed, 848 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
 create mode 100644 drivers/mtd/nand/tegra_nand.c

-- 
2.1.0
