From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Nov 2018 16:37:04 +0800
Subject: [PATCH] arm64: dts: nxp: add more thermal zone support
In-Reply-To: <20181102031115.3818-1-andy.tang@nxp.com>
References: <20181102031115.3818-1-andy.tang@nxp.com>
Message-ID: <201811021632.pSXentBV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuantian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.19 next-20181102]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yuantian-Tang/arm64-dts-nxp-add-more-thermal-zone-support/20181102-115718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts:10:0:
>> arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi:103:11: fatal error: fsl-tmu.dtsi: No such file or directory
     #include "fsl-tmu.dtsi"
              ^~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts:12:0:
>> arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi:150:11: fatal error: fsl-tmu.dtsi: No such file or directory
     #include "fsl-tmu.dtsi"
              ^~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts:13:0:
>> arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi:119:11: fatal error: fsl-tmu.dtsi: No such file or directory
     #include "fsl-tmu.dtsi"
              ^~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts:13:0:
>> arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi:131:11: fatal error: fsl-tmu.dtsi: No such file or directory
     #include "fsl-tmu.dtsi"
              ^~~~~~~~~~~~~~
   compilation terminated.

vim +103 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi

    11	
    12	/ {
    13		compatible = "fsl,ls1012a";
    14		interrupt-parent = <&gic>;
    15		#address-cells = <2>;
    16		#size-cells = <2>;
    17	
    18		aliases {
    19			crypto = &crypto;
    20			rtic-a = &rtic_a;
    21			rtic-b = &rtic_b;
    22			rtic-c = &rtic_c;
    23			rtic-d = &rtic_d;
    24			sec-mon = &sec_mon;
    25		};
    26	
    27		cpus {
    28			#address-cells = <1>;
    29			#size-cells = <0>;
    30	
    31			cooling_map0: cpu0: cpu at 0 {
    32				device_type = "cpu";
    33				compatible = "arm,cortex-a53";
    34				reg = <0x0>;
    35				clocks = <&clockgen 1 0>;
    36				#cooling-cells = <2>;
    37				cpu-idle-states = <&CPU_PH20>;
    38			};
    39		};
    40	
    41		idle-states {
    42			/*
    43			 * PSCI node is not added default, U-boot will add missing
    44			 * parts if it determines to use PSCI.
    45			 */
    46			entry-method = "psci";
    47	
    48			CPU_PH20: cpu-ph20 {
    49				compatible = "arm,idle-state";
    50				idle-state-name = "PH20";
    51				arm,psci-suspend-param = <0x0>;
    52				entry-latency-us = <1000>;
    53				exit-latency-us = <1000>;
    54				min-residency-us = <3000>;
    55			};
    56		};
    57	
    58		sysclk: sysclk {
    59			compatible = "fixed-clock";
    60			#clock-cells = <0>;
    61			clock-frequency = <125000000>;
    62			clock-output-names = "sysclk";
    63		};
    64	
    65		coreclk: coreclk {
    66			compatible = "fixed-clock";
    67			#clock-cells = <0>;
    68			clock-frequency = <100000000>;
    69			clock-output-names = "coreclk";
    70		};
    71	
    72		timer {
    73			compatible = "arm,armv8-timer";
    74			interrupts = <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure PPI */
    75				     <1 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-Secure PPI */
    76				     <1 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
    77				     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
    78		};
    79	
    80		pmu {
    81			compatible = "arm,armv8-pmuv3";
    82			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
    83		};
    84	
    85		gic: interrupt-controller at 1400000 {
    86			compatible = "arm,gic-400";
    87			#interrupt-cells = <3>;
    88			interrupt-controller;
    89			reg = <0x0 0x1401000 0 0x1000>, /* GICD */
    90			      <0x0 0x1402000 0 0x2000>, /* GICC */
    91			      <0x0 0x1404000 0 0x2000>, /* GICH */
    92			      <0x0 0x1406000 0 0x2000>; /* GICV */
    93			interrupts = <1 9 IRQ_TYPE_LEVEL_LOW>;
    94		};
    95	
    96		reboot {
    97			compatible = "syscon-reboot";
    98			regmap = <&dcfg>;
    99			offset = <0xb0>;
   100			mask = <0x02>;
   101		};
   102	
 > 103		#include "fsl-tmu.dtsi"
   104	
   105		soc {
   106			compatible = "simple-bus";
   107			#address-cells = <2>;
   108			#size-cells = <2>;
   109			ranges;
   110	
   111			esdhc0: esdhc at 1560000 {
   112				compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
   113				reg = <0x0 0x1560000 0x0 0x10000>;
   114				interrupts = <0 62 0x4>;
   115				clocks = <&clockgen 4 0>;
   116				voltage-ranges = <1800 1800 3300 3300>;
   117				sdhci,auto-cmd12;
   118				big-endian;
   119				bus-width = <4>;
   120				status = "disabled";
   121			};
   122	
   123			scfg: scfg at 1570000 {
   124				compatible = "fsl,ls1012a-scfg", "syscon";
   125				reg = <0x0 0x1570000 0x0 0x10000>;
   126				big-endian;
   127			};
   128	
   129			esdhc1: esdhc at 1580000 {
   130				compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
   131				reg = <0x0 0x1580000 0x0 0x10000>;
   132				interrupts = <0 65 0x4>;
   133				clocks = <&clockgen 4 0>;
   134				voltage-ranges = <1800 1800 3300 3300>;
   135				sdhci,auto-cmd12;
   136				big-endian;
   137				broken-cd;
   138				bus-width = <4>;
   139				status = "disabled";
   140			};
   141	
   142			crypto: crypto at 1700000 {
   143				compatible = "fsl,sec-v5.4", "fsl,sec-v5.0",
   144					     "fsl,sec-v4.0";
   145				fsl,sec-era = <8>;
   146				#address-cells = <1>;
   147				#size-cells = <1>;
   148				ranges = <0x0 0x00 0x1700000 0x100000>;
   149				reg = <0x00 0x1700000 0x0 0x100000>;
   150				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
   151	
   152				sec_jr0: jr at 10000 {
   153					compatible = "fsl,sec-v5.4-job-ring",
   154						     "fsl,sec-v5.0-job-ring",
   155						     "fsl,sec-v4.0-job-ring";
   156					reg	   = <0x10000 0x10000>;
   157					interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
   158				};
   159	
   160				sec_jr1: jr at 20000 {
   161					compatible = "fsl,sec-v5.4-job-ring",
   162						     "fsl,sec-v5.0-job-ring",
   163						     "fsl,sec-v4.0-job-ring";
   164					reg	   = <0x20000 0x10000>;
   165					interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
   166				};
   167	
   168				sec_jr2: jr at 30000 {
   169					compatible = "fsl,sec-v5.4-job-ring",
   170						     "fsl,sec-v5.0-job-ring",
   171						     "fsl,sec-v4.0-job-ring";
   172					reg	   = <0x30000 0x10000>;
   173					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
   174				};
   175	
   176				sec_jr3: jr at 40000 {
   177					compatible = "fsl,sec-v5.4-job-ring",
   178						     "fsl,sec-v5.0-job-ring",
   179						     "fsl,sec-v4.0-job-ring";
   180					reg	   = <0x40000 0x10000>;
   181					interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
   182				};
   183	
   184				rtic at 60000 {
   185					compatible = "fsl,sec-v5.4-rtic",
   186						     "fsl,sec-v5.0-rtic",
   187						     "fsl,sec-v4.0-rtic";
   188					#address-cells = <1>;
   189					#size-cells = <1>;
   190					reg = <0x60000 0x100 0x60e00 0x18>;
   191					ranges = <0x0 0x60100 0x500>;
   192	
   193					rtic_a: rtic-a at 0 {
   194						compatible = "fsl,sec-v5.4-rtic-memory",
   195							     "fsl,sec-v5.0-rtic-memory",
   196							     "fsl,sec-v4.0-rtic-memory";
   197						reg = <0x00 0x20 0x100 0x100>;
   198					};
   199	
   200					rtic_b: rtic-b at 20 {
   201						compatible = "fsl,sec-v5.4-rtic-memory",
   202							     "fsl,sec-v5.0-rtic-memory",
   203							     "fsl,sec-v4.0-rtic-memory";
   204						reg = <0x20 0x20 0x200 0x100>;
   205					};
   206	
   207					rtic_c: rtic-c at 40 {
   208						compatible = "fsl,sec-v5.4-rtic-memory",
   209							     "fsl,sec-v5.0-rtic-memory",
   210							     "fsl,sec-v4.0-rtic-memory";
   211						reg = <0x40 0x20 0x300 0x100>;
   212					};
   213	
   214					rtic_d: rtic-d at 60 {
   215						compatible = "fsl,sec-v5.4-rtic-memory",
   216							     "fsl,sec-v5.0-rtic-memory",
   217							     "fsl,sec-v4.0-rtic-memory";
   218						reg = <0x60 0x20 0x400 0x100>;
   219					};
   220				};
   221			};
   222	
   223			sec_mon: sec_mon at 1e90000 {
   224				compatible = "fsl,sec-v5.4-mon", "fsl,sec-v5.0-mon",
   225					     "fsl,sec-v4.0-mon";
   226				reg = <0x0 0x1e90000 0x0 0x10000>;
   227				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
   228					     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
   229			};
   230	
   231			dcfg: dcfg at 1ee0000 {
   232				compatible = "fsl,ls1012a-dcfg",
   233					     "syscon";
   234				reg = <0x0 0x1ee0000 0x0 0x10000>;
   235				big-endian;
   236			};
   237	
   238			clockgen: clocking at 1ee1000 {
   239				compatible = "fsl,ls1012a-clockgen";
   240				reg = <0x0 0x1ee1000 0x0 0x1000>;
   241				#clock-cells = <2>;
   242				clocks = <&sysclk &coreclk>;
   243				clock-names = "sysclk", "coreclk";
   244			};
   245	
   246			tmu: tmu at 1f00000 {
   247				compatible = "fsl,qoriq-tmu";
   248				reg = <0x0 0x1f00000 0x0 0x10000>;
   249				interrupts = <0 33 0x4>;
   250				fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
   251				fsl,tmu-calibration = <0x00000000 0x00000026
   252						       0x00000001 0x0000002d
   253						       0x00000002 0x00000032
   254						       0x00000003 0x00000039
   255						       0x00000004 0x0000003f
   256						       0x00000005 0x00000046
   257						       0x00000006 0x0000004d
   258						       0x00000007 0x00000054
   259						       0x00000008 0x0000005a
   260						       0x00000009 0x00000061
   261						       0x0000000a 0x0000006a
   262						       0x0000000b 0x00000071
   263	
   264						       0x00010000 0x00000025
   265						       0x00010001 0x0000002c
   266						       0x00010002 0x00000035
   267						       0x00010003 0x0000003d
   268						       0x00010004 0x00000045
   269						       0x00010005 0x0000004e
   270						       0x00010006 0x00000057
   271						       0x00010007 0x00000061
   272						       0x00010008 0x0000006b
   273						       0x00010009 0x00000076
   274	
   275						       0x00020000 0x00000029
   276						       0x00020001 0x00000033
   277						       0x00020002 0x0000003d
   278						       0x00020003 0x00000049
   279						       0x00020004 0x00000056
   280						       0x00020005 0x00000061
   281						       0x00020006 0x0000006d
   282	
   283						       0x00030000 0x00000021
   284						       0x00030001 0x0000002a
   285						       0x00030002 0x0000003c
   286						       0x00030003 0x0000004e>;
   287				big-endian;
   288				#thermal-sensor-cells = <1>;
   289			};
   290	
   291			i2c0: i2c at 2180000 {
   292				compatible = "fsl,vf610-i2c";
   293				#address-cells = <1>;
   294				#size-cells = <0>;
   295				reg = <0x0 0x2180000 0x0 0x10000>;
   296				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
   297				clocks = <&clockgen 4 0>;
   298				status = "disabled";
   299			};
   300	
   301			i2c1: i2c at 2190000 {
   302				compatible = "fsl,vf610-i2c";
   303				#address-cells = <1>;
   304				#size-cells = <0>;
   305				reg = <0x0 0x2190000 0x0 0x10000>;
   306				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
   307				clocks = <&clockgen 4 0>;
   308				status = "disabled";
   309			};
   310	
   311			dspi: spi at 2100000 {
   312				compatible = "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";
   313				#address-cells = <1>;
   314				#size-cells = <0>;
   315				reg = <0x0 0x2100000 0x0 0x10000>;
   316				interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
   317				clock-names = "dspi";
   318				clocks = <&clockgen 4 0>;
   319				spi-num-chipselects = <5>;
   320				big-endian;
   321				status = "disabled";
   322			};
   323	
   324			duart0: serial at 21c0500 {
   325				compatible = "fsl,ns16550", "ns16550a";
   326				reg = <0x00 0x21c0500 0x0 0x100>;
   327				interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
   328				clocks = <&clockgen 4 0>;
   329				status = "disabled";
   330			};
   331	
   332			duart1: serial at 21c0600 {
   333				compatible = "fsl,ns16550", "ns16550a";
   334				reg = <0x00 0x21c0600 0x0 0x100>;
   335				interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
   336				clocks = <&clockgen 4 0>;
   337				status = "disabled";
   338			};
   339	
   340			gpio0: gpio at 2300000 {
   341				compatible = "fsl,qoriq-gpio";
   342				reg = <0x0 0x2300000 0x0 0x10000>;
   343				interrupts = <0 66 IRQ_TYPE_LEVEL_HIGH>;
   344				gpio-controller;
   345				#gpio-cells = <2>;
   346				interrupt-controller;
   347				#interrupt-cells = <2>;
   348			};
   349	
   350			gpio1: gpio at 2310000 {
   351				compatible = "fsl,qoriq-gpio";
   352				reg = <0x0 0x2310000 0x0 0x10000>;
   353				interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
   354				gpio-controller;
   355				#gpio-cells = <2>;
   356				interrupt-controller;
   357				#interrupt-cells = <2>;
   358			};
   359	
   360			wdog0: wdog at 2ad0000 {
   361				compatible = "fsl,ls1012a-wdt",
   362					     "fsl,imx21-wdt";
   363				reg = <0x0 0x2ad0000 0x0 0x10000>;
   364				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
   365				clocks = <&clockgen 4 0>;
   366				big-endian;
   367			};
   368	
   369			sai1: sai at 2b50000 {
   370				#sound-dai-cells = <0>;
   371				compatible = "fsl,vf610-sai";
   372				reg = <0x0 0x2b50000 0x0 0x10000>;
   373				interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
   374				clocks = <&clockgen 4 3>, <&clockgen 4 3>,
   375					 <&clockgen 4 3>, <&clockgen 4 3>;
   376				clock-names = "bus", "mclk1", "mclk2", "mclk3";
   377				dma-names = "tx", "rx";
   378				dmas = <&edma0 1 47>,
   379				       <&edma0 1 46>;
   380				status = "disabled";
   381			};
   382	
   383			sai2: sai at 2b60000 {
   384				#sound-dai-cells = <0>;
   385				compatible = "fsl,vf610-sai";
   386				reg = <0x0 0x2b60000 0x0 0x10000>;
   387				interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
   388				clocks = <&clockgen 4 3>, <&clockgen 4 3>,
   389					 <&clockgen 4 3>, <&clockgen 4 3>;
   390				clock-names = "bus", "mclk1", "mclk2", "mclk3";
   391				dma-names = "tx", "rx";
   392				dmas = <&edma0 1 45>,
   393				       <&edma0 1 44>;
   394				status = "disabled";
   395			};
   396	
   397			edma0: edma at 2c00000 {
   398				#dma-cells = <2>;
   399				compatible = "fsl,vf610-edma";
   400				reg = <0x0 0x2c00000 0x0 0x10000>,
   401				      <0x0 0x2c10000 0x0 0x10000>,
   402				      <0x0 0x2c20000 0x0 0x10000>;
   403				interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>,
   404					     <0 103 IRQ_TYPE_LEVEL_HIGH>;
   405				interrupt-names = "edma-tx", "edma-err";
   406				dma-channels = <32>;
   407				big-endian;
   408				clock-names = "dmamux0", "dmamux1";
   409				clocks = <&clockgen 4 3>,
   410					 <&clockgen 4 3>;
   411			};
   412	
   413			usb0: usb3 at 2f00000 {
   414				compatible = "snps,dwc3";
   415				reg = <0x0 0x2f00000 0x0 0x10000>;
   416				interrupts = <0 60 0x4>;
   417				dr_mode = "host";
   418				snps,quirk-frame-length-adjustment = <0x20>;
   419				snps,dis_rxdet_inp3_quirk;
   420			};
   421	
   422			sata: sata at 3200000 {
   423				compatible = "fsl,ls1012a-ahci", "fsl,ls1043a-ahci";
   424				reg = <0x0 0x3200000 0x0 0x10000>,
   425					<0x0 0x20140520 0x0 0x4>;
   426				reg-names = "ahci", "sata-ecc";
   427				interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
   428				clocks = <&clockgen 4 0>;
   429				dma-coherent;
   430				status = "disabled";
   431			};
   432	
   433			usb1: usb2 at 8600000 {
   434				compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
   435				reg = <0x0 0x8600000 0x0 0x1000>;
   436				interrupts = <0 139 0x4>;
   437				dr_mode = "host";
   438				phy_type = "ulpi";
   439			};
   440	
   441			msi: msi-controller1 at 1572000 {
   442				compatible = "fsl,ls1012a-msi";
   443				reg = <0x0 0x1572000 0x0 0x8>;
   444				msi-controller;
   445				interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
   446			};
   447	
   448			pcie at 3400000 {
   449				compatible = "fsl,ls1012a-pcie", "snps,dw-pcie";
   450				reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
   451				       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
   452				reg-names = "regs", "config";
   453				interrupts = <0 118 0x4>, /* controller interrupt */
   454					     <0 117 0x4>; /* PME interrupt */
   455				interrupt-names = "aer", "pme";
   456				#address-cells = <3>;
   457				#size-cells = <2>;
   458				device_type = "pci";
   459				num-lanes = <4>;
   460				bus-range = <0x0 0xff>;
   461				ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
   462					  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
   463				msi-parent = <&msi>;
   464				#interrupt-cells = <1>;
   465				interrupt-map-mask = <0 0 0 7>;
   466				interrupt-map = <0000 0 0 1 &gic 0 110 IRQ_TYPE_LEVEL_HIGH>,
   467						<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
   468						<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
   469						<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
   470			};
   471		};
   472	
   473		firmware {
   474			optee {
   475				compatible = "linaro,optee-tz";
   476				method = "smc";
   477			};
   478		};
   479	};
   480	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40351 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181102/974b2aae/attachment-0001.gz>
