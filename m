From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 05 Feb 2013 21:17:02 +0100
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <5111331F.7090900@free-electrons.com>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <5111331F.7090900@free-electrons.com>
Message-ID: <511168BE.1000803@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 05:28 PM, Gregory CLEMENT wrote:
> Hi Ezequiel,
> 
> On 02/05/2013 12:24 PM, Ezequiel Garcia wrote:
>> This patch adds an SPI master device node for Armada XP-GP board.
>> This master node is an SPI flash controller 'n25q128a13'.
>>
>> Since there is no 'partitions' node declared, one full sized
>> partition named as the device will be created.
>>
>> Cc: Gregory Clement <gregory.clement@free-electrons.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: Lior Amsalem <alior@marvell.com>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> ---
>> This patch depends on:
>>
>>  1. Gregory's patch for Armada XP GP board:
>>       arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)
>>
>>  2. My previous patch for SPI on Armada 370/XP:
>>       arm: mvebu: Add support for SPI controller in Armada 370/XP
>>
>> And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y
>>
>>  arch/arm/boot/dts/armada-xp-gp.dts |   12 ++++++++++++
>>  1 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
>> index 3eea531..1c8afe2 100644
>> --- a/arch/arm/boot/dts/armada-xp-gp.dts
>> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
>> @@ -97,5 +97,17 @@
>>  			phy = <&phy3>;
>>  			phy-mode = "rgmii-id";
>>  		};
>> +
>> +		spi0: spi at d0010600 {
>> +			status = "okay";
>> +
>> +			spi-flash at 0 {
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				compatible = "n25q128a13";
>> +				reg = <0>; /* Chip select 0 */
>> +				spi-max-frequency = <108000000>;

I had a remark about it, according to the datasheet, 108MHz is the
maximum frequency for the all the instructions but the READ
instruction. For the READ the maximum frequency is 54MHz. So I wonder
if we shouldn't use 54000000 here.



>> +			};
>> +		};
>>  	};
>>  };
>>
> 
> I applied, compiled and try this patch it worked well, at least
> for reading, I didn't try to write on the flash where my boolader
> is stored. So you can add my:
> 
> Tested-by: Gregory Clement <gregory.clement@free-electrons.com>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
