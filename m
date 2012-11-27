From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Nov 2012 15:31:06 +1100
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma tree
Message-ID: <20121127153106.6e2a6c4bc100bcd4a1306740@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/spear1340.dtsi between commit b47394911c26 ("ARM:
SPEAr13xx: Pass DW DMAC platform data from DT") from the slave-dma tree
and commit 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/spear1340.dtsi
index d487556,34da11a..0000000
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@@ -24,25 -38,28 +38,47 @@@
  			status = "disabled";
  		};
  
 +		dma at ea800000 {
 +			slave_info {
 +				uart1_tx {
 +					bus_id = "uart1_tx";
 +					cfg_hi = <0x6000>;	/* 0xC << 11 */
 +					cfg_lo = <0>;
 +					src_master = <0>;
 +					dst_master = <1>;
 +				};
 +				uart1_tx {
 +					bus_id = "uart1_tx";
 +					cfg_hi = <0x680>;	/* 0xD << 7 */
 +					cfg_lo = <0>;
 +					src_master = <1>;
 +					dst_master = <0>;
 +				};
 +			};
 +		};
 +
+ 		i2s-play at b2400000 {
+ 			compatible = "snps,designware-i2s";
+ 			reg = <0xb2400000 0x10000>;
+ 			interrupt-names = "play_irq";
+ 			interrupts = <0 98 0x4
+ 				      0 99 0x4>;
+ 			play;
+ 			channel = <8>;
+ 			status = "disabled";
+ 		};
+ 
+ 		i2s-rec at b2000000 {
+ 			compatible = "snps,designware-i2s";
+ 			reg = <0xb2000000 0x10000>;
+ 			interrupt-names = "record_irq";
+ 			interrupts = <0 100  0x4
+ 				      0 101 0x4>;
+ 			record;
+ 			channel = <8>;
+ 			status = "disabled";
+ 		};
+ 
  		pinmux: pinmux at e0700000 {
  			compatible = "st,spear1340-pinmux";
  			reg = <0xe0700000 0x1000>;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/b61ff815/attachment.sig>
