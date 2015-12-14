From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Dec 2015 17:01:00 +0000
Subject: [PATCH] ARM64: ZynqMP: DT: Fix GIC's 'reg' property
In-Reply-To: <20151214164613.GH21356@leverpostej>
References: <1450110700-14152-1-git-send-email-soren.brinkmann@xilinx.com>
 <20151214164613.GH21356@leverpostej>
Message-ID: <566EF5CC.4070000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 14/12/15 16:46, Mark Rutland wrote:
> On Mon, Dec 14, 2015 at 08:31:40AM -0800, Soren Brinkmann wrote:
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 857eda5c7217..b5d1facadf16 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -80,10 +80,10 @@
>>  		gic: interrupt-controller at f9010000 {
>>  			compatible = "arm,gic-400", "arm,cortex-a15-gic";
>>  			#interrupt-cells = <3>;
>> -			reg = <0x0 0xf9010000 0x10000>,
>> -			      <0x0 0xf902f000 0x2000>,
>> +			reg = <0x0 0xf9010000 0x1000>,
>> +			      <0x0 0xf9020000 0x20000>,
>>  			      <0x0 0xf9040000 0x20000>,
>> -			      <0x0 0xf906f000 0x2000>;
>> +			      <0x0 0xf9060000 0x20000>;
> 
> I'm confused. These sizes don't look right for GIC-400. Is this a custom
> GIC?

Probably an implementation that obey the SBSA requirement of aliasing
the first 4kB of the CPU interface on a 64kB page, and the second one on
the following 64kB page. See the APM system for an example of such a
thing. I'm more concerned about the GICH region (3rd one), which has no
reason to be bigger than 4kB.

> Did this ever work wit hteh old offsets and sizes?

It probably dies when trying to use EOImode==1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
