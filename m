From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Wed, 02 Jul 2014 10:46:28 +0800
Subject: [PATCH 3/3] mtd: hisilicon: add device tree binding documentation
In-Reply-To: <20140630095234.GZ7262@leverpostej>
References: <1404115409-20200-1-git-send-email-wangzhou.bry@gmail.com>
 <1404115409-20200-4-git-send-email-wangzhou.bry@gmail.com>
 <20140630095234.GZ7262@leverpostej>
Message-ID: <53B37284.9060902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?06?30? 17:52, Mark Rutland wrote:
> On Mon, Jun 30, 2014 at 09:03:29AM +0100, Zhou Wang wrote:
>> Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
>> ---
>>   .../devicetree/bindings/mtd/hisi-nand.txt          |   38 ++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/hisi-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/hisi-nand.txt b/Documentation/devicetree/bindings/mtd/hisi-nand.txt
>> new file mode 100644
>> index 0000000..1cc6470
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/hisi-nand.txt
>> @@ -0,0 +1,38 @@
>> +Hisilicon Hip04 Soc NAND controller DT binding
>> +
>> +Required properties:
>> +- compatible:          Should be "hisilicon,nfc504".
>> +- reg:                 Contain registers location and length for reg and data.
>
> I'm not sure I follow. The example below has two reg entries. What does
> each entry represent, and what does the presence of multiple entries
> mean?
>

Maybe I could not express it clearly here. The first reg entry 
represents the basic address of registers of NAND controller, and the 
second represents the basic address of buffer of NAND controller.

>> +- interrupts:          Interrupt number for nfc.
>
> Just the one?
>

Yes, Just one interrupt number. And there is an interrupt relative 
register in the NAND controller, we can get information about interrupt 
from the register after an interrupt triggered.

>> +- nand-bus-width:      See nand.txt.
>> +- nand-ecc-mode:       See nand.txt.
>> +- hisi,nand-ecc-bits:  ECC bits type support.
>> +		<0>:   none ecc
>> +		<1>:   Can correct 1bit per 512byte.
>> +		<6>:   Can correct 16bits per 1K byte.
>
> Is this an enumeration, or a number of bits?
>

This is an enumeration which is just relative register configure, so we 
can directly use it to configure relative register bits in driver.

>> +- #address-cells:      partition address.
>> +- #size-cells:         partition size.
>
> Are these only allowed to be 1 cell, or can they be more?
>
> Thanks,
> Mark.
>

These are only allowed to be 1 cell. Address-cells represents basic 
address of a partition, and size-cells represents the size of a partition.

I will rewrite the unclear parts as your comments. Thanks for your comments.

-Zhou Wang

>> +
>> +Flash chip may optionally contain additional sub-nodes describing partitions of
>> +the address space. See partition.txt for more detail.
>> +
>> +Example:
>> +
>> +	nand: nand at 4020000 {
>> +		compatible = "hisilicon,nfc504";
>> +		reg = <0x4020000 0x10000>, <0x5000000 0x1000>;
>> +		interrupts = <0 379 4>;
>> +		nand-bus-width = <8>;
>> +		nand-ecc-mode = "hw";
>> +		hisi,nand-ecc-bits = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		partition at 0 {
>> +			label = "nand_text";
>> +			reg = <0x00000000 0x00400000>;
>> +		};
>> +
>> +		...
>> +
>> +	};
>> --
>> 1.7.9.5
>>
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
