From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2018 14:06:11 +0100
Subject: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
In-Reply-To: <20181105125644.GA7937@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
Message-ID: <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 05. 11. 18 13:56, Borislav Petkov wrote:
> On Thu, Oct 25, 2018 at 11:37:00AM +0530, Manish Narani wrote:
>> Add ddrc memory controller node in dts. The size mentioned in dts is
>> 0x30000, because we need to access DDR_QOS INTR registers located at
>> 0xFD090208 from this driver.
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> ---
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 29ce234..a81d3b16 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -355,6 +355,13 @@
>>  			xlnx,bus-width = <64>;
>>  		};
>>  
>> +		mc: memory-controller at fd070000 {
>> +			compatible = "xlnx,zynqmp-ddrc-2.40a";
>> +			reg = <0x0 0xfd070000 0x0 0x30000>;
>> +			interrupt-parent = <&gic>;
>> +			interrupts = <0 112 4>;
>> +		};
>> +
>>  		gem0: ethernet at ff0b0000 {
>>  			compatible = "cdns,zynqmp-gem", "cdns,gem";
>>  			status = "disabled";
>> -- 
> 
> Ok, talking to Mark on IRC, he says those DT changes normally go through
> the arm-soc tree.
> 
> And I'm fine with that except if we do that, then the EDAC changes
> go through my tree and those drivers could end up temporarily broken
> depending on the merge order and timing.

I don't think that driver will be broken. You can build them, use them
on out of tree HW. And when this patch is merged to mainline it will be
enabled for xilinx soc.

> 
> So should we perhaps make an arm-soc shared, immutable branch which you
> guys export for me with those DT changes applied, which I can merge into
> my tree and apply the EDAC changes ontop.
> 
> This is what we've been doing with the tip tree until now and it has
> proven successful.
> 
> Thoughts?

Normally driver is merged via appropriate subsystem with DT binding doc
and enabled for the soc/platform later.
Also in connection to process which you have described above.
DT node should match binding which is in your tree and should go first
and then enabling for certain SoC on the top.

TBH I can't see any reason to do merges but if you want to do that way
we can also do it.

Thanks,
Michal
