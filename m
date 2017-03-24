From: horia.geanta@nxp.com (=?iso-8859-2?Q?Horia_Geant=E3?=)
Date: Fri, 24 Mar 2017 07:17:50 +0000
Subject: [PATCH] arm64: dts: ls1012a: add crypto node
References: <20170322122939.22117-1-horia.geanta@nxp.com>
 <20170324015606.GC30608@dragon>
Message-ID: <DB4PR04MB0847D837CB2762D5094720CB983E0@DB4PR04MB0847.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/24/2017 3:56 AM, Shawn Guo wrote:
> On Wed, Mar 22, 2017 at 02:29:39PM +0200, Horia Geant? wrote:
>> LS1012A has a SEC v5.4 security engine.
>>
>> Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts |  9 +++
>>  arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |  9 +++
>>  arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  |  9 +++
>>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 91 +++++++++++++++++++++-
>>  4 files changed, 117 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> index a619f6496a4c..bab9e68947e4 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> @@ -49,6 +49,15 @@
>>  	model = "LS1012A Freedom Board";
>>  	compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
>>  
>> +	aliases {
>> +		crypto = &crypto;
>> +		rtic_a = &rtic_a;
>> +		rtic_b = &rtic_b;
>> +		rtic_c = &rtic_c;
>> +		rtic_d = &rtic_d;
>> +		sec_mon = &sec_mon;
>> +	};
>> +
>>  	sys_mclk: clock-mclk {
>>  		compatible = "fixed-clock";
>>  		#clock-cells = <0>;
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
>> index 14a67f1709e7..5c4e84c7f20d 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
>> @@ -49,6 +49,15 @@
>>  	model = "LS1012A QDS Board";
>>  	compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
>>  
>> +	aliases {
>> +		crypto = &crypto;
>> +		rtic_a = &rtic_a;
>> +		rtic_b = &rtic_b;
>> +		rtic_c = &rtic_c;
>> +		rtic_d = &rtic_d;
>> +		sec_mon = &sec_mon;
>> +	};
>> +
>>  	sys_mclk: clock-mclk {
>>  		compatible = "fixed-clock";
>>  		#clock-cells = <0>;
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
>> index 62c5c7123a15..ff9dd16aa65a 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
>> @@ -48,6 +48,15 @@
>>  / {
>>  	model = "LS1012A RDB Board";
>>  	compatible = "fsl,ls1012a-rdb", "fsl,ls1012a";
>> +
>> +	aliases {
>> +		crypto = &crypto;
>> +		rtic_a = &rtic_a;
>> +		rtic_b = &rtic_b;
>> +		rtic_c = &rtic_c;
>> +		rtic_d = &rtic_d;
>> +		sec_mon = &sec_mon;
>> +	};
> 
> What are these aliases used for?  Are they board specific?  If not, we
> should probably have them in fsl-ls1012a.dtsi, since you are adding
> them for all three fsl-ls1012a based boards.
> 
Indeed, these can be shared and thus should be moved to
fsl-ls1012a.dtsi. Will be fixed in v2.

crypto alias is used in u-boot to fixup the crypto node with a
"fsl,sec-era" property.

rtic and sec_mon aliases have been added to be in line with the PPC
device trees, I am not aware how they are used.

>>  };
>>  
>>  &duart0 {
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
>> index cffebb4b3df1..68f3012ae07e 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
>> @@ -42,7 +42,7 @@
>>   *     OTHER DEALINGS IN THE SOFTWARE.
>>   */
>>  
>> -#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>  
>>  / {
>>  	compatible = "fsl,ls1012a";
>> @@ -113,6 +113,95 @@
>>  			big-endian;
>>  		};
>>  
>> +		crypto: crypto at 1700000 {
>> +			compatible = "fsl,sec-v5.4", "fsl,sec-v5.0",
>> +				     "fsl,sec-v4.0";
>> +			fsl,sec-era = <8>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0x0 0x00 0x1700000 0x100000>;
>> +			reg = <0x00 0x1700000 0x0 0x100000>;
>> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			sec_jr0: jr at 10000 {
>> +				compatible = "fsl,sec-v5.4-job-ring",
>> +					     "fsl,sec-v5.0-job-ring",
>> +					     "fsl,sec-v4.0-job-ring";
>> +				reg	   = <0x10000 0x10000>;
>> +				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			sec_jr1: jr at 20000 {
>> +				compatible = "fsl,sec-v5.4-job-ring",
>> +					     "fsl,sec-v5.0-job-ring",
>> +					     "fsl,sec-v4.0-job-ring";
>> +				reg	   = <0x20000 0x10000>;
>> +				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			sec_jr2: jr at 30000 {
>> +				compatible = "fsl,sec-v5.4-job-ring",
>> +					     "fsl,sec-v5.0-job-ring",
>> +					     "fsl,sec-v4.0-job-ring";
>> +				reg	   = <0x30000 0x10000>;
>> +				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			sec_jr3: jr at 40000 {
>> +				compatible = "fsl,sec-v5.4-job-ring",
>> +					     "fsl,sec-v5.0-job-ring",
>> +					     "fsl,sec-v4.0-job-ring";
>> +				reg	   = <0x40000 0x10000>;
>> +				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			rtic at 60000 {
>> +				compatible = "fsl,sec-v5.4-rtic",
>> +					     "fsl,sec-v5.0-rtic",
>> +					     "fsl,sec-v4.0-rtic";
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				reg = <0x60000 0x100 0x60e00 0x18>;
>> +				ranges = <0x0 0x60100 0x500>;
>> +
>> +				rtic_a: rtic-a at 0 {
>> +					compatible = "fsl,sec-v5.4-rtic-memory",
>> +						     "fsl,sec-v5.0-rtic-memory",
>> +						     "fsl,sec-v4.0-rtic-memory";
>> +					reg = <0x00 0x20 0x100 0x100>;
>> +				};
>> +
>> +				rtic_b: rtic-b at 20 {
>> +					compatible = "fsl,sec-v5.4-rtic-memory",
>> +						     "fsl,sec-v5.0-rtic-memory",
>> +						     "fsl,sec-v4.0-rtic-memory";
>> +					reg = <0x20 0x20 0x200 0x100>;
>> +				};
>> +
>> +				rtic_c: rtic-c at 40 {
>> +					compatible = "fsl,sec-v5.4-rtic-memory",
>> +						     "fsl,sec-v5.0-rtic-memory",
>> +						     "fsl,sec-v4.0-rtic-memory";
>> +					reg = <0x40 0x20 0x300 0x100>;
>> +				};
>> +
>> +				rtic_d: rtic-d at 60 {
>> +					compatible = "fsl,sec-v5.4-rtic-memory",
>> +						     "fsl,sec-v5.0-rtic-memory",
>> +						     "fsl,sec-v4.0-rtic-memory";
>> +					reg = <0x60 0x20 0x400 0x100>;
>> +				};
>> +			};
>> +		};
>> +
>> +		sec_mon: sec_mon at 1e90000 {
> 
> Hyphen is more preferred to be used in node name than underscore.
> 
This would imply changing the
Documentation/devicetree/bindings/crypto/fsl-sec4.txt binding and
dealing with all the consequences, which IIUC is probably not worth.

Thanks,
Horia
