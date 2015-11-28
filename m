From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 28 Nov 2015 18:38:26 +0100
Subject: [PATCH 2/4] ARM: dt: mvebu: ix4-300d: move partitions to
 partition sub-node
In-Reply-To: <20151128170036.GH32356@lunn.ch>
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1448709248-21177-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20151128170036.GH32356@lunn.ch>
Message-ID: <5659E692.9040007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.11.2015 18:00, Andrew Lunn wrote:
> On Sat, Nov 28, 2015 at 12:14:06PM +0100, Sebastian Hesselbarth wrote:
>> NAND flash partitions should be part of a partitions sub-node
>> not the flash node itself. Move the partitions which will also
>> allow different bootloaders get rid of the stock partitions
>> easily by removing the partitions node.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> Humm, did not know that. Quoting Documentation/devicetree/bindings/mtd/partition.txt:
> 
>       The partition table should be a subnode of the mtd node and
>       should be named 'partitions'. Partitions are defined in subnodes
>       of the partitions node.
> 
>       For backwards compatibility partitions as direct subnodes of the
>       mtd device are supported. This use is discouraged.
> 
> It also looks like none of the other MVEBU maintainers know that
> either, since a quick look at the .dts files shows very few have a
> partitions node.

Me neither, Linus Walleij's latest contribution to the pogoplug
series showed it to me. And while I am working on barebox support
for the ix4, I always wanted to remove the stock partitions easily.

Barebox always uses internal registers at 0xf1000000 so it will
never boot that stupid stock kernel that depends on 0xd0000000
registers.

> Acked-by: Andrew Lunn <andrew@lunn.ch>
> 
> Thanks
> 	Andrew

ditto ;)

Sebastian

>> ---
>> Cc: Jason Cooper <jason@lakedaemon.net> 
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Gregory Clement <gregory.clement@free-electrons.com> 
>> Cc: Rob Herring <robh+dt@kernel.org> 
>> Cc: Pawel Moll <pawel.moll@arm.com> 
>> Cc: Mark Rutland <mark.rutland@arm.com> 
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
>> Cc: Kumar Gala <galak@codeaurora.org> 
>> Cc: Russell King <linux@arm.linux.org.uk> 
>> Cc: Benoit Masson <yahoo@perenite.com>
>> Cc: linux-arm-kernel at lists.infradead.org 
>> Cc: devicetree at vger.kernel.org 
>> Cc: linux-kernel at vger.kernel.org 
>> ---
>>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 67 +++++++++++++------------
>>  1 file changed, 36 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
>> index 30a0a6eac645..76781fd18624 100644
>> --- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
>> +++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
>> @@ -151,37 +151,42 @@
>>  				marvell,nand-enable-arbiter;
>>  				nand-on-flash-bbt;
>>  
>> -				partition at 0 {
>> -					label = "u-boot";
>> -					reg = <0x0000000 0xe0000>;
>> -					read-only;
>> -				};
>> -
>> -				partition at e0000 {
>> -					label = "u-boot-env";
>> -					reg = <0xe0000 0x20000>;
>> -					read-only;
>> -				};
>> -
>> -				partition at 100000 {
>> -					label = "u-boot-env2";
>> -					reg = <0x100000 0x20000>;
>> -					read-only;
>> -				};
>> -
>> -				partition at 120000 {
>> -					label = "zImage";
>> -					reg = <0x120000 0x400000>;
>> -				};
>> -
>> -				partition at 520000 {
>> -					label = "initrd";
>> -					reg = <0x520000 0x400000>;
>> -				};
>> -
>> -				partition at xE00000 {
>> -					label = "boot";
>> -					reg = <0xE00000 0x3F200000>;
>> +				partitions {
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +
>> +					partition at 0 {
>> +						label = "u-boot";
>> +						reg = <0x0000000 0xe0000>;
>> +						read-only;
>> +					};
>> +
>> +					partition at e0000 {
>> +						label = "u-boot-env";
>> +						reg = <0xe0000 0x20000>;
>> +						read-only;
>> +					};
>> +
>> +					partition at 100000 {
>> +						label = "u-boot-env2";
>> +						reg = <0x100000 0x20000>;
>> +						read-only;
>> +					};
>> +
>> +					partition at 120000 {
>> +						label = "zImage";
>> +						reg = <0x120000 0x400000>;
>> +					};
>> +
>> +					partition at 520000 {
>> +						label = "initrd";
>> +						reg = <0x520000 0x400000>;
>> +					};
>> +
>> +					partition at xE00000 {
>> +						label = "boot";
>> +						reg = <0xE00000 0x3F200000>;
>> +					};
>>  				};
>>  			};
>>  		};
>> -- 
>> 2.1.4
>>
