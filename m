From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 27 Aug 2015 16:22:29 +1000
Subject: linux-next: manual merge of the rtc tree with the arm-soc tree
Message-ID: <20150827162229.10fe7255@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Today's linux-next merge of the rtc tree got a conflict in:

  arch/arm/boot/dts/am437x-gp-evm.dts

between commits:

  d3d92af19e99 ("ARM: dts: am437x-gp-evm: McASP1 node for audio support")
  cf9a4850e995 ("ARM: dts: am437x-gp-evm: Enable analog audio via simple-card")

from the arm-soc tree and commit:

  f7331bad0fa4 ("ARM: dts: AM437x: Add the internal and external clock nodes for rtc")

from the rtc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/am437x-gp-evm.dts
index 215775dc6948,1d5733751fd4..000000000000
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@@ -112,32 -124,12 +112,39 @@@
  		clock-frequency = <12000000>;
  	};
  
 +	sound0: sound at 0 {
 +		compatible = "simple-audio-card";
 +		simple-audio-card,name = "AM437x-GP-EVM";
 +		simple-audio-card,widgets =
 +			"Headphone", "Headphone Jack",
 +			"Line", "Line In";
 +		simple-audio-card,routing =
 +			"Headphone Jack",	"HPLOUT",
 +			"Headphone Jack",	"HPROUT",
 +			"LINE1L",		"Line In",
 +			"LINE1R",		"Line In";
 +		simple-audio-card,format = "dsp_b";
 +		simple-audio-card,bitclock-master = <&sound0_master>;
 +		simple-audio-card,frame-master = <&sound0_master>;
 +		simple-audio-card,bitclock-inversion;
 +
 +		simple-audio-card,cpu {
 +			sound-dai = <&mcasp1>;
 +			system-clock-frequency = <12000000>;
 +		};
 +
 +		sound0_master: simple-audio-card,codec {
 +			sound-dai = <&tlv320aic3106>;
 +			system-clock-frequency = <12000000>;
 +		};
 +	};
++
+ 	/* fixed 32k external oscillator clock */
+ 	clk_32k_rtc: clk_32k_rtc {
+ 		#clock-cells = <0>;
+ 		compatible = "fixed-clock";
+ 		clock-frequency = <32768>;
+ 	};
  };
  
  &am43xx_pinmux {
@@@ -924,20 -797,8 +931,26 @@@
  	};
  };
  
 +&mcasp1 {
 +	#sound-dai-cells = <0>;
 +	pinctrl-names = "default", "sleep";
 +	pinctrl-0 = <&mcasp1_pins>;
 +	pinctrl-1 = <&mcasp1_sleep_pins>;
 +
 +	status = "okay";
 +
 +	op-mode = <0>; /* MCASP_IIS_MODE */
 +	tdm-slots = <2>;
 +	/* 4 serializers */
 +	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
 +		0 0 1 2
 +	>;
 +	tx-num-evt = <32>;
 +	rx-num-evt = <32>;
 +};
++
+ &rtc {
+ 	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
+ 	clock-names = "ext-clk", "int-clk";
+ 	status = "okay";
+ };
