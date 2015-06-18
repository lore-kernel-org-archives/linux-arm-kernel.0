From: stefan@agner.ch (Stefan Agner)
Date: Fri, 19 Jun 2015 00:58:33 +0200
Subject: [PATCH v6 0/6] mtd: nand: vf610_nfc: Freescale NFC for VF610
Message-ID: <1434668319-6651-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sixth revision has some minor changes, removing some worthless
optimization and a compatible string.

In the fifth revision some more changes, which have been made in the
U-Boot driver, have been applied to this driver too. The driver now
uses dedicated vf610_nfc_read_page/vf610_nfc_write_page functions
which feel more appropriate for the device. This changes enable raw
page writes, which in turn enables to use the the mtd_nandbiterrs.ko
test.

Beside that, the changes from the reviews have been implemented.

If one is interested in the individual changes, the U-Boot patchset,
which has been applied/adopted and squashed into this driver, is
available in the U-Boot mailing list archive:
http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/220416

The patchset is based on the patchset by Bill Pringlemeir, see:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/295419

The driver passes the MTD tests, the logs are attched inline, below
the change log.

Performance key points on Colibri VF61:
mtd_speedtest: testing eraseblock write speed
mtd_speedtest: eraseblock write speed is 5417 KiB/s
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 13012 KiB/s
mtd_speedtest: testing page write speed

Changes since v5:
- Removed fsl,mpc5125-nfc compatible string
- Removed readl/writel_relaxed
- Change interface of vf610_nfc_transfer_size to match other accessors

Changes since v4:
- Rebased ontop of l2-mtd/master (v4.1-rc4 based)
- Eliminate unnecessary page read (NAND_CMD_SEQIN) since the driver does
  not support sub-page writes anyway (improves write performance)
- Support ONFI by enabling READID command with offset and parameter page
  reads (CMD_PARAM)
- Change to dedicated read_page/write_page function, enables raw writes
- Use __LITTLE_ENDIAN to distingush between LE/BE relevant statements
- Eliminated vf610_nfc_probe_dt in favor of common DT init code
- Use wait_for_completion_timeout
- Some style fixes (spaces, etc.)

Changes since v3:
- Make the driver selectable when COMPILE_TEST is set
- Fix compile error due to superfluous ECC_STATUS configuration in initial
  patch (without ECC correction ECC_STATUS does not need to be configured)
- Remove custom BBT pattern and switch to in-band BBT in the initial patch
- Include two bug fixes, for details see the corresponding U-Boot patches:
  http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/215802

Changes since v2:
- Updated binding documentation

Changes since v1:
- Nest nfc_config struct within the main nfc struct
- Use assigned clock binding to specify NFC clock
- Rebased ontop of MSCM IR patchset (driver parts have been merged)
- Split out arch Kconfig in a separate config
- Fix module license
- Updated MAINTAINERS

Changes since RFC (Bill Pringlemeir):
- Renamed driver from fsl_nfc to vf610_nfc
- Use readl/writel for all register in accessor functions
- Optimized field accessor functions
- Implemented PM (suspend/resume) functions
- Implemented basic support for ECC strength/ECC step size from dt
- Improved performance of count_written_bits by using hweight32
- Support ECC with 60-bytes to correct up to 32 bit errors
- Changed to in-band BBT (NAND_BBT_NO_OOB) which also allows ECC modes
  which uses up to 60 bytes on 64 byte OOB
- Removed custom (downstream) BBT pattern since BBT table won't be
  compatible anyway (due to the change above)


MTD tests:

[  197.039235] ==================================================
[  197.045208] mtd_nandbiterrs: MTD device: 3
[  197.066559] mtd_nandbiterrs: MTD device size 134217728, eraseblock=131072, page=2048, oob=64
[  197.075314] mtd_nandbiterrs: Device uses 1 subpages of 2048 bytes
[  197.081506] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[  197.099422] mtd_nandbiterrs: incremental biterrors test
[  197.105002] mtd_nandbiterrs: write_page
[  197.109515] mtd_nandbiterrs: rewrite page
[  197.124398] mtd_nandbiterrs: read_page
[  197.128747] mtd_nandbiterrs: verify_page
[  197.132964] mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
[  197.140201] mtd_nandbiterrs: Inserted biterror @ 0/5
[  197.145212] mtd_nandbiterrs: rewrite page
[  197.149796] mtd_nandbiterrs: read_page
[  197.162519] mtd_nandbiterrs: verify_page
[  197.166953] mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
[  197.174109] mtd_nandbiterrs: Inserted biterror @ 0/2
[  197.179117] mtd_nandbiterrs: rewrite page
[  197.183743] mtd_nandbiterrs: read_page
[  197.187931] mtd_nandbiterrs: verify_page
[  197.192239] mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
[  197.199339] mtd_nandbiterrs: Inserted biterror @ 0/0
[  197.204377] mtd_nandbiterrs: rewrite page
[  197.218883] mtd_nandbiterrs: read_page
[  197.222929] mtd_nandbiterrs: verify_page
[  197.227091] mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
[  197.234218] mtd_nandbiterrs: Inserted biterror @ 1/7
[  197.239336] mtd_nandbiterrs: rewrite page
[  197.243912] mtd_nandbiterrs: read_page
[  197.257324] mtd_nandbiterrs: verify_page
[  197.261871] mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
[  197.268975] mtd_nandbiterrs: Inserted biterror @ 1/5
[  197.274024] mtd_nandbiterrs: rewrite page
[  197.278626] mtd_nandbiterrs: read_page
[  197.282638] mtd_nandbiterrs: verify_page
[  197.286909] mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
[  197.294046] mtd_nandbiterrs: Inserted biterror @ 1/2
[  197.299051] mtd_nandbiterrs: rewrite page
[  197.303646] mtd_nandbiterrs: read_page
[  197.307628] mtd_nandbiterrs: verify_page
[  197.311814] mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
[  197.319044] mtd_nandbiterrs: Inserted biterror @ 1/0
[  197.324092] mtd_nandbiterrs: rewrite page
[  197.338545] mtd_nandbiterrs: read_page
[  197.342583] mtd_nandbiterrs: verify_page
[  197.346852] mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
[  197.353989] mtd_nandbiterrs: Inserted biterror @ 2/6
[  197.358993] mtd_nandbiterrs: rewrite page
[  197.363596] mtd_nandbiterrs: read_page
[  197.376554] mtd_nandbiterrs: verify_page
[  197.381268] mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
[  197.388373] mtd_nandbiterrs: Inserted biterror @ 2/5
[  197.393422] mtd_nandbiterrs: rewrite page
[  197.398104] mtd_nandbiterrs: read_page
[  197.402330] mtd_nandbiterrs: verify_page
[  197.406597] mtd_nandbiterrs: Successfully corrected 9 bit errors per subpage
[  197.413738] mtd_nandbiterrs: Inserted biterror @ 2/2
[  197.418743] mtd_nandbiterrs: rewrite page
[  197.435214] mtd_nandbiterrs: read_page
[  197.439226] mtd_nandbiterrs: verify_page
[  197.443536] mtd_nandbiterrs: Successfully corrected 10 bit errors per subpage
[  197.450760] mtd_nandbiterrs: Inserted biterror @ 2/0
[  197.455764] mtd_nandbiterrs: rewrite page
[  197.460388] mtd_nandbiterrs: read_page
[  197.475201] mtd_nandbiterrs: verify_page
[  197.479639] mtd_nandbiterrs: Successfully corrected 11 bit errors per subpage
[  197.486827] mtd_nandbiterrs: Inserted biterror @ 3/7
[  197.491861] mtd_nandbiterrs: rewrite page
[  197.496462] mtd_nandbiterrs: read_page
[  197.500703] mtd_nandbiterrs: verify_page
[  197.504977] mtd_nandbiterrs: Successfully corrected 12 bit errors per subpage
[  197.512205] mtd_nandbiterrs: Inserted biterror @ 3/6
[  197.517207] mtd_nandbiterrs: rewrite page
[  197.531491] mtd_nandbiterrs: read_page
[  197.535503] mtd_nandbiterrs: verify_page
[  197.539810] mtd_nandbiterrs: Successfully corrected 13 bit errors per subpage
[  197.547003] mtd_nandbiterrs: Inserted biterror @ 3/5
[  197.552042] mtd_nandbiterrs: rewrite page
[  197.556627] mtd_nandbiterrs: read_page
[  197.569904] mtd_nandbiterrs: verify_page
[  197.574460] mtd_nandbiterrs: Successfully corrected 14 bit errors per subpage
[  197.581688] mtd_nandbiterrs: Inserted biterror @ 3/2
[  197.586696] mtd_nandbiterrs: rewrite page
[  197.591390] mtd_nandbiterrs: read_page
[  197.595378] mtd_nandbiterrs: verify_page
[  197.599679] mtd_nandbiterrs: Successfully corrected 15 bit errors per subpage
[  197.606865] mtd_nandbiterrs: Inserted biterror @ 3/0
[  197.611898] mtd_nandbiterrs: rewrite page
[  197.616474] mtd_nandbiterrs: read_page
[  197.629809] mtd_nandbiterrs: verify_page
[  197.633987] mtd_nandbiterrs: Successfully corrected 16 bit errors per subpage
[  197.641212] mtd_nandbiterrs: Inserted biterror @ 4/2
[  197.646221] mtd_nandbiterrs: rewrite page
[  197.650866] mtd_nandbiterrs: read_page
[  197.654851] mtd_nandbiterrs: verify_page
[  197.659010] mtd_nandbiterrs: Successfully corrected 17 bit errors per subpage
[  197.666349] mtd_nandbiterrs: Inserted biterror @ 4/0
[  197.671392] mtd_nandbiterrs: rewrite page
[  197.676019] mtd_nandbiterrs: read_page
[  197.690248] mtd_nandbiterrs: verify_page
[  197.694705] mtd_nandbiterrs: Successfully corrected 18 bit errors per subpage
[  197.701943] mtd_nandbiterrs: Inserted biterror @ 5/7
[  197.706952] mtd_nandbiterrs: rewrite page
[  197.711588] mtd_nandbiterrs: read_page
[  197.715575] mtd_nandbiterrs: verify_page
[  197.719881] mtd_nandbiterrs: Successfully corrected 19 bit errors per subpage
[  197.727070] mtd_nandbiterrs: Inserted biterror @ 5/2
[  197.732108] mtd_nandbiterrs: rewrite page
[  197.736650] mtd_nandbiterrs: read_page
[  197.750836] mtd_nandbiterrs: verify_page
[  197.755261] mtd_nandbiterrs: Successfully corrected 20 bit errors per subpage
[  197.762491] mtd_nandbiterrs: Inserted biterror @ 5/0
[  197.767500] mtd_nandbiterrs: rewrite page
[  197.772081] mtd_nandbiterrs: read_page
[  197.776070] mtd_nandbiterrs: verify_page
[  197.780374] mtd_nandbiterrs: Successfully corrected 21 bit errors per subpage
[  197.787566] mtd_nandbiterrs: Inserted biterror @ 6/6
[  197.792605] mtd_nandbiterrs: rewrite page
[  197.797182] mtd_nandbiterrs: read_page
[  197.811376] mtd_nandbiterrs: verify_page
[  197.815653] mtd_nandbiterrs: Successfully corrected 22 bit errors per subpage
[  197.823023] mtd_nandbiterrs: Inserted biterror @ 6/2
[  197.828034] mtd_nandbiterrs: rewrite page
[  197.832662] mtd_nandbiterrs: read_page
[  197.836647] mtd_nandbiterrs: verify_page
[  197.840949] mtd_nandbiterrs: Successfully corrected 23 bit errors per subpage
[  197.848140] mtd_nandbiterrs: Inserted biterror @ 6/0
[  197.853178] mtd_nandbiterrs: rewrite page
[  197.857762] mtd_nandbiterrs: read_page
[  197.871308] mtd_nandbiterrs: verify_page
[  197.875690] mtd_nandbiterrs: Successfully corrected 24 bit errors per subpage
[  197.882923] mtd_nandbiterrs: Inserted biterror @ 7/7
[  197.887929] mtd_nandbiterrs: rewrite page
[  197.892515] mtd_nandbiterrs: read_page
[  197.896503] mtd_nandbiterrs: verify_page
[  197.900694] mtd_nandbiterrs: Successfully corrected 25 bit errors per subpage
[  197.907994] mtd_nandbiterrs: Inserted biterror @ 7/6
[  197.913038] mtd_nandbiterrs: rewrite page
[  197.917568] mtd_nandbiterrs: read_page
[  197.930384] mtd_nandbiterrs: verify_page
[  197.934712] mtd_nandbiterrs: Successfully corrected 26 bit errors per subpage
[  197.941941] mtd_nandbiterrs: Inserted biterror @ 7/2
[  197.946950] mtd_nandbiterrs: rewrite page
[  197.951529] mtd_nandbiterrs: read_page
[  197.955515] mtd_nandbiterrs: verify_page
[  197.959817] mtd_nandbiterrs: Successfully corrected 27 bit errors per subpage
[  197.967008] mtd_nandbiterrs: Inserted biterror @ 7/0
[  197.972057] mtd_nandbiterrs: rewrite page
[  197.977849] mtd_nandbiterrs: read_page
[  197.992304] mtd_nandbiterrs: verify_page
[  197.996624] mtd_nandbiterrs: Successfully corrected 28 bit errors per subpage
[  198.003858] mtd_nandbiterrs: Inserted biterror @ 8/7
[  198.008862] mtd_nandbiterrs: rewrite page
[  198.013441] mtd_nandbiterrs: read_page
[  198.017424] mtd_nandbiterrs: verify_page
[  198.021644] mtd_nandbiterrs: Successfully corrected 29 bit errors per subpage
[  198.028829] mtd_nandbiterrs: Inserted biterror @ 8/5
[  198.033979] mtd_nandbiterrs: rewrite page
[  198.038616] mtd_nandbiterrs: read_page
[  198.052747] mtd_nandbiterrs: verify_page
[  198.057239] mtd_nandbiterrs: Successfully corrected 30 bit errors per subpage
[  198.064477] mtd_nandbiterrs: Inserted biterror @ 8/4
[  198.069490] mtd_nandbiterrs: rewrite page
[  198.074074] mtd_nandbiterrs: read_page
[  198.078062] mtd_nandbiterrs: verify_page
[  198.082368] mtd_nandbiterrs: Successfully corrected 31 bit errors per subpage
[  198.089597] mtd_nandbiterrs: Inserted biterror @ 8/2
[  198.094603] mtd_nandbiterrs: rewrite page
[  198.099202] mtd_nandbiterrs: read_page
[  198.113451] mtd_nandbiterrs: verify_page
[  198.117846] mtd_nandbiterrs: Successfully corrected 32 bit errors per subpage
[  198.125076] mtd_nandbiterrs: Inserted biterror @ 8/0
[  198.130105] mtd_nandbiterrs: rewrite page
[  198.134705] mtd_nandbiterrs: read_page
[  198.138905] mtd_nandbiterrs: error: read failed at 0x0
[  198.144239] mtd_nandbiterrs: After 33 biterrors per subpage, read reported error -74
[  198.163281] mtd_nandbiterrs: finished successfully.
[  198.168332] ==================================================
[  228.550809] 
[  228.552545] =================================================
[  228.558346] mtd_oobtest: MTD device: 3
[  228.581278] mtd_oobtest: MTD device size 134217728, eraseblock size 131072, page size 2048, count of eraseblocks 1024, pages per eraseblock 64, OOB size 64
[  228.595985] mtd_test: scanning for bad eraseblocks
[  228.611269] mtd_test: block 316 is bad
[  228.615909] mtd_test: block 917 is bad
[  228.619790] mtd_test: scanned 1024 eraseblocks, 2 are bad
[  228.625347] mtd_oobtest: test 1 of 5
[  228.900362] mtd_oobtest: writing OOBs of whole device
[  228.932108] mtd_oobtest: written up to eraseblock 0
[  233.052533] mtd_oobtest: written up to eraseblock 256
[  237.155804] mtd_oobtest: written up to eraseblock 512
[  241.274283] mtd_oobtest: written up to eraseblock 768
[  245.361809] mtd_oobtest: written 1024 eraseblocks
[  245.366613] mtd_oobtest: verifying all eraseblocks
[  245.374180] mtd_oobtest: verified up to eraseblock 0
[  246.223481] mtd_oobtest: verified up to eraseblock 256
[  247.045983] mtd_oobtest: verified up to eraseblock 512
[  247.870732] mtd_oobtest: verified up to eraseblock 768
[  248.683053] mtd_oobtest: verified 1024 eraseblocks
[  248.687936] mtd_oobtest: test 2 of 5
[  249.636996] mtd_oobtest: writing OOBs of whole device
[  249.668742] mtd_oobtest: written up to eraseblock 0
[  253.782380] mtd_oobtest: written up to eraseblock 256
[  257.882626] mtd_oobtest: written up to eraseblock 512
[  261.996761] mtd_oobtest: written up to eraseblock 768
[  266.082061] mtd_oobtest: written 1024 eraseblocks
[  266.086841] mtd_oobtest: verifying all eraseblocks
[  266.105270] mtd_oobtest: verified up to eraseblock 0
[  266.893608] mtd_oobtest: verified up to eraseblock 256
[  267.662111] mtd_oobtest: verified up to eraseblock 512
[  268.437666] mtd_oobtest: verified up to eraseblock 768
[  269.199091] mtd_oobtest: verified 1024 eraseblocks
[  269.203950] mtd_oobtest: test 3 of 5
[  270.153944] mtd_oobtest: writing OOBs of whole device
[  270.184817] mtd_oobtest: written up to eraseblock 0
[  274.253906] mtd_oobtest: written up to eraseblock 256
[  278.304987] mtd_oobtest: written up to eraseblock 512
[  282.377734] mtd_oobtest: written up to eraseblock 768
[  286.420526] mtd_oobtest: written 1024 eraseblocks
[  286.425326] mtd_oobtest: verifying all eraseblocks
[  286.445855] mtd_oobtest: verified up to eraseblock 0
[  287.822691] mtd_oobtest: verified up to eraseblock 256
[  289.182885] mtd_oobtest: verified up to eraseblock 512
[  290.549325] mtd_oobtest: verified up to eraseblock 768
[  291.910018] mtd_oobtest: verified 1024 eraseblocks
[  291.914908] mtd_oobtest: test 4 of 5
[  292.866482] mtd_oobtest: attempting to start write past end of OOB
[  292.872769] mtd_oobtest: an error is expected...
[  292.877437] mtd_oobtest: error occurred as expected
[  292.882388] mtd_oobtest: attempting to start read past end of OOB
[  292.888524] mtd_oobtest: an error is expected...
[  292.893213] mtd_oobtest: error occurred as expected
[  292.898130] mtd_oobtest: attempting to write past end of device
[  292.904117] mtd_oobtest: an error is expected...
[  292.908778] mtd_oobtest: error occurred as expected
[  292.913719] mtd_oobtest: attempting to read past end of device
[  292.919591] mtd_oobtest: an error is expected...
[  292.924275] mtd_oobtest: error occurred as expected
[  292.939108] mtd_oobtest: attempting to write past end of device
[  292.945314] mtd_oobtest: an error is expected...
[  292.949991] mtd_oobtest: error occurred as expected
[  292.954958] mtd_oobtest: attempting to read past end of device
[  292.960832] mtd_oobtest: an error is expected...
[  292.965519] mtd_oobtest: error occurred as expected
[  292.970436] mtd_oobtest: test 5 of 5
[  293.353327] mtd_oobtest: writing OOBs of whole device
[  293.358748] mtd_oobtest: written up to eraseblock 0
[  293.376318] mtd_oobtest: written up to eraseblock 0
[  293.520054] mtd_oobtest: written up to eraseblock 256
[  293.525416] mtd_oobtest: written up to eraseblock 256
[  293.670380] mtd_oobtest: written up to eraseblock 512
[  293.675740] mtd_oobtest: written up to eraseblock 512
[  293.821610] mtd_oobtest: written up to eraseblock 768
[  293.826949] mtd_oobtest: written up to eraseblock 768
[  293.970588] mtd_oobtest: written 1023 eraseblocks
[  293.975401] mtd_oobtest: verifying all eraseblocks
[  293.990560] mtd_oobtest: verified up to eraseblock 0
[  294.044032] mtd_oobtest: verified up to eraseblock 256
[  294.084619] mtd_oobtest: verified up to eraseblock 512
[  294.126433] mtd_oobtest: verified up to eraseblock 768
[  294.165784] mtd_oobtest: verified 1023 eraseblocks
[  294.170639] mtd_oobtest: finished with 0 errors
[  294.183643] =================================================
[  680.940230] 
[  680.941955] =================================================
[  680.947837] mtd_pagetest: MTD device: 3
[  680.963656] mtd_pagetest: MTD device size 134217728, eraseblock size 131072, page size 2048, count of eraseblocks 1024, pages per eraseblock 64, OOB size 64
[  680.979125] mtd_test: scanning for bad eraseblocks
[  680.985544] mtd_test: block 316 is bad
[  681.003039] mtd_test: block 917 is bad
[  681.013254] mtd_test: scanned 1024 eraseblocks, 2 are bad
[  681.018816] mtd_pagetest: erasing whole device
[  681.996061] mtd_pagetest: erased 1024 eraseblocks
[  682.000848] mtd_pagetest: writing whole device
[  682.047637] mtd_pagetest: written up to eraseblock 0
[  688.833017] mtd_pagetest: written up to eraseblock 256
[  695.627467] mtd_pagetest: written up to eraseblock 512
[  702.445828] mtd_pagetest: written up to eraseblock 768
[  709.194956] mtd_pagetest: written 1024 eraseblocks
[  709.199851] mtd_pagetest: verifying all eraseblocks
[  709.293300] mtd_pagetest: verified up to eraseblock 0
[  726.138810] mtd_pagetest: verified up to eraseblock 256
[  742.916639] mtd_pagetest: verified up to eraseblock 512
[  759.762748] mtd_pagetest: verified up to eraseblock 768
[  776.475675] mtd_pagetest: verified 1024 eraseblocks
[  776.480664] mtd_pagetest: crosstest
[  776.484539] mtd_pagetest: reading page at 0x0
[  776.500772] mtd_pagetest: reading page at 0x7fff800
[  776.506272] mtd_pagetest: reading page at 0x0
[  776.510894] mtd_pagetest: verifying pages read at 0x0 match
[  776.516546] mtd_pagetest: crosstest ok
[  776.520480] mtd_pagetest: erasecrosstest
[  776.524452] mtd_pagetest: erasing block 0
[  776.529717] mtd_pagetest: writing 1st page of block 0
[  776.546505] mtd_pagetest: reading 1st page of block 0
[  776.551842] mtd_pagetest: verifying 1st page of block 0
[  776.557266] mtd_pagetest: erasing block 0
[  776.562543] mtd_pagetest: writing 1st page of block 0
[  776.568051] mtd_pagetest: erasing block 1023
[  776.585315] mtd_pagetest: reading 1st page of block 0
[  776.590643] mtd_pagetest: verifying 1st page of block 0
[  776.596064] mtd_pagetest: erasecrosstest ok
[  776.600328] mtd_pagetest: erasetest
[  776.603855] mtd_pagetest: erasing block 0
[  776.609124] mtd_pagetest: writing 1st page of block 0
[  776.624166] mtd_pagetest: erasing block 0
[  776.629215] mtd_pagetest: reading 1st page of block 0
[  776.634752] mtd_pagetest: verifying 1st page of block 0 is all 0xff
[  776.641247] mtd_pagetest: erasetest ok
[  776.645047] mtd_pagetest: finished with 0 errors
[  776.659316] =================================================
[  813.279152] 
[  813.280872] =================================================
[  813.286736] mtd_readtest: MTD device: 3
[  813.304677] mtd_readtest: MTD device size 134217728, eraseblock size 131072, page size 2048, count of eraseblocks 1024, pages per eraseblock 64, OOB size 64
[  813.320133] mtd_test: scanning for bad eraseblocks
[  813.340247] mtd_test: block 316 is bad
[  813.361102] mtd_test: block 917 is bad
[  813.365642] mtd_test: scanned 1024 eraseblocks, 2 are bad
[  813.371236] mtd_readtest: testing page read
[  827.307978] mtd_readtest: finished
[  827.311495] =================================================
[  872.104334] 
[  872.105977] =================================================
[  872.111773] mtd_speedtest: MTD device: 3
[  872.115791] mtd_speedtest: MTD device size 134217728, eraseblock size 131072, page size 2048, count of eraseblocks 1024, pages per eraseblock 64, OOB size 64
[  872.144566] mtd_test: scanning for bad eraseblocks
[  872.150139] mtd_test: block 316 is bad
[  872.154142] mtd_test: block 917 is bad
[  872.158012] mtd_test: scanned 1024 eraseblocks, 2 are bad
[  873.129035] mtd_speedtest: testing eraseblock write speed
[  896.786975] mtd_speedtest: eraseblock write speed is 5531 KiB/s
[  896.793012] mtd_speedtest: testing eraseblock read speed
[  906.852427] mtd_speedtest: eraseblock read speed is 13012 KiB/s
[  907.806007] mtd_speedtest: testing page write speed
[  932.631540] mtd_speedtest: page write speed is 5270 KiB/s
[  932.637025] mtd_speedtest: testing page read speed
[  942.883652] mtd_speedtest: page read speed is 12775 KiB/s
[  943.837307] mtd_speedtest: testing 2 page write speed
[  967.757883] mtd_speedtest: 2 page write speed is 5470 KiB/s
[  967.763571] mtd_speedtest: testing 2 page read speed
[  977.914108] mtd_speedtest: 2 page read speed is 12895 KiB/s
[  977.919763] mtd_speedtest: Testing erase speed
[  978.880217] mtd_speedtest: erase speed is 136836 KiB/s
[  978.885463] mtd_speedtest: Testing 2x multi-block erase speed
[  979.103001] mtd_speedtest: 2x multi-block erase speed is 619981 KiB/s
[  979.109559] mtd_speedtest: Testing 4x multi-block erase speed
[  979.323339] mtd_speedtest: 4x multi-block erase speed is 631961 KiB/s
[  979.329882] mtd_speedtest: Testing 8x multi-block erase speed
[  979.541457] mtd_speedtest: 8x multi-block erase speed is 638126 KiB/s
[  979.547993] mtd_speedtest: Testing 16x multi-block erase speed
[  979.756687] mtd_speedtest: 16x multi-block erase speed is 644413 KiB/s
[  979.763295] mtd_speedtest: Testing 32x multi-block erase speed
[  979.972792] mtd_speedtest: 32x multi-block erase speed is 644413 KiB/s
[  979.979423] mtd_speedtest: Testing 64x multi-block erase speed
[  980.189510] mtd_speedtest: 64x multi-block erase speed is 641254 KiB/s
[  980.196136] mtd_speedtest: finished
[  980.199691] =================================================
[  990.768858] 
[  990.770572] =================================================
[  990.776448] mtd_stresstest: MTD device: 3
[  990.794553] mtd_stresstest: MTD device size 134217728, eraseblock size 131072, page size 2048, count of eraseblocks 1024, pages per eraseblock 64, OOB size 64
[  990.831237] mtd_test: scanning for bad eraseblocks
[  990.837349] mtd_test: block 316 is bad
[  990.842945] mtd_test: block 917 is bad
[  990.858831] mtd_test: scanned 1024 eraseblocks, 2 are bad
[  990.864702] mtd_stresstest: doing operations
[  990.869078] mtd_stresstest: 0 operations done
[ 1006.064161] mtd_stresstest: 1024 operations done
[ 1019.995691] mtd_stresstest: 2048 operations done
[ 1033.373661] mtd_stresstest: 3072 operations done
[ 1047.380562] mtd_stresstest: 4096 operations done
[ 1060.903347] mtd_stresstest: 5120 operations done
[ 1074.271605] mtd_stresstest: 6144 operations done
[ 1088.084848] mtd_stresstest: 7168 operations done
[ 1101.145225] mtd_stresstest: 8192 operations done
[ 1114.460050] mtd_stresstest: 9216 operations done
[ 1124.579963] mtd_stresstest: finished, 10000 operations done
[ 1124.585839] =================================================
[ 1191.017762] 
[ 1191.019488] =================================================
[ 1191.025350] mtd_subpagetest: MTD device: 3
[ 1191.042604] mtd_subpagetest: MTD device size 134217728, eraseblock size 131072, page size 2048, subpage size 2048, count of eraseblocks 1024, pages per eraseblock 64, OOB size 64
[ 1191.060156] mtd_test: scanning for bad eraseblocks
[ 1191.081143] mtd_test: block 316 is bad
[ 1191.090832] mtd_test: block 917 is bad
[ 1191.107359] mtd_test: scanned 1024 eraseblocks, 2 are bad
[ 1192.082790] mtd_subpagetest: writing whole device
[ 1192.088410] mtd_subpagetest: written up to eraseblock 0
[ 1192.316990] mtd_subpagetest: written up to eraseblock 256
[ 1192.534023] mtd_subpagetest: written up to eraseblock 512
[ 1192.749818] mtd_subpagetest: written up to eraseblock 768
[ 1192.966055] mtd_subpagetest: written 1024 eraseblocks
[ 1192.971178] mtd_subpagetest: verifying all eraseblocks
[ 1192.986433] mtd_subpagetest: verified up to eraseblock 0
[ 1193.130746] mtd_subpagetest: verified up to eraseblock 256
[ 1193.264266] mtd_subpagetest: verified up to eraseblock 512
[ 1193.398699] mtd_subpagetest: verified up to eraseblock 768
[ 1193.531363] mtd_subpagetest: verified 1024 eraseblocks
[ 1194.487203] mtd_subpagetest: verifying all eraseblocks for 0xff
[ 1194.520323] mtd_subpagetest: verified up to eraseblock 0
[ 1198.586458] mtd_subpagetest: verified up to eraseblock 256
[ 1202.915264] mtd_subpagetest: verified up to eraseblock 512
[ 1206.980799] mtd_subpagetest: verified up to eraseblock 768
[ 1211.017044] mtd_subpagetest: verified 1024 eraseblocks
[ 1211.022254] mtd_subpagetest: writing whole device
[ 1211.069251] mtd_subpagetest: written up to eraseblock 0
[ 1216.795927] mtd_subpagetest: written up to eraseblock 256
[ 1222.539298] mtd_subpagetest: written up to eraseblock 512
[ 1228.311730] mtd_subpagetest: written up to eraseblock 768
[ 1234.023293] mtd_subpagetest: written 1024 eraseblocks
[ 1234.028418] mtd_subpagetest: verifying all eraseblocks
[ 1234.068746] mtd_subpagetest: verified up to eraseblock 0
[ 1237.300199] mtd_subpagetest: verified up to eraseblock 256
[ 1240.518463] mtd_subpagetest: verified up to eraseblock 512
[ 1243.748402] mtd_subpagetest: verified up to eraseblock 768
[ 1246.954212] mtd_subpagetest: verified 1024 eraseblocks
[ 1247.906580] mtd_subpagetest: verifying all eraseblocks for 0xff
[ 1247.938841] mtd_subpagetest: verified up to eraseblock 0
[ 1252.006415] mtd_subpagetest: verified up to eraseblock 256
[ 1256.056679] mtd_subpagetest: verified up to eraseblock 512
[ 1260.126068] mtd_subpagetest: verified up to eraseblock 768
[ 1264.161988] mtd_subpagetest: verified 1024 eraseblocks
[ 1264.167204] mtd_subpagetest: finished with 0 errors
[ 1264.182901] =================================================



 *** SUBJECT HERE ***

*** BLURB HERE ***

Stefan Agner (6):
  mtd: nand: vf610_nfc: Freescale NFC for VF610, MPC5125 and others
  mtd: nand: vf610_nfc: add hardware BCH-ECC support
  mtd: nand: vf610_nfc: add device tree bindings
  ARM: vf610: enable NAND Flash Controller
  ARM: dts: vf610twr: add NAND flash controller peripherial
  ARM: dts: vf-colibri: enable NAND flash controller

 .../devicetree/bindings/mtd/vf610-nfc.txt          |  45 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/vf-colibri.dtsi                  |  32 +
 arch/arm/boot/dts/vf610-twr.dts                    |  44 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |   8 +
 arch/arm/mach-imx/Kconfig                          |   1 +
 drivers/mtd/nand/Kconfig                           |  14 +
 drivers/mtd/nand/Makefile                          |   1 +
 drivers/mtd/nand/vf610_nfc.c                       | 839 +++++++++++++++++++++
 9 files changed, 990 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/vf610-nfc.txt
 create mode 100644 drivers/mtd/nand/vf610_nfc.c

-- 
2.4.2
