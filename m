From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 10 Jul 2018 08:35:10 -0500
Subject: [PATCH 1/2] ARM: dts: arria10: update NAND clocking
In-Reply-To: <CAK7LNARAVSK5VY=_RfO2PXJCAnXJN3sXoAY=ijSwVojeo=c66w@mail.gmail.com>
References: <1531176063-30140-1-git-send-email-dinguyen@kernel.org>
 <CAK7LNARAVSK5VY=_RfO2PXJCAnXJN3sXoAY=ijSwVojeo=c66w@mail.gmail.com>
Message-ID: <b33d18b2-1956-50a4-9a3f-6d2a0abd4b81@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/09/2018 08:31 PM, Masahiro Yamada wrote:
> 2018-07-10 7:41 GMT+09:00 Dinh Nguyen <dinguyen@kernel.org>:
>> The NAND IP needs 2 clocks(nand_x_clk and nand_clk). This patch adds a
>> nand_x_clk, which is derived from the nand_clk, but has a fixed divider
>> of 4.
>>
>> Update the NAND node to use the additional clock.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>  arch/arm/boot/dts/socfpga_arria10.dtsi | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
>> index a4dcb68..558b5ea 100644
>> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
>> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
>> @@ -377,13 +377,21 @@
>>                                                 clk-gate = <0xC8 11>;
>>                                         };
>>
>> -                                       nand_clk: nand_clk {
>> +                                       nand_x_clk: nand_x_clk {
>>                                                 #clock-cells = <0>;
>>                                                 compatible = "altr,socfpga-a10-gate-clk";
>>                                                 clocks = <&l4_mp_clk>;
>>                                                 clk-gate = <0xC8 10>;
>>                                         };
>>
>> +                                       nand_clk: nand_clk {
>> +                                               #clock-cells = <0>;
>> +                                               compatible = "altr,socfpga-a10-gate-clk";
>> +                                               clocks = <&nand_x_clk>;
>> +                                               fixed-divider = <4>;
>> +                                               clk-gate = <0xC8 10>;
>> +                                       };
>> +
>>                                         spi_m_clk: spi_m_clk {
>>                                                 #clock-cells = <0>;
>>                                                 compatible = "altr,socfpga-a10-gate-clk";
>> @@ -650,7 +658,8 @@
>>                         reg-names = "nand_data", "denali_reg";
>>                         interrupts = <0 99 4>;
>>                         dma-mask = <0xffffffff>;
>> -                       clocks = <&nand_clk>;
>> +                       clocks = <&nand_clk>, <&nand_x_clk>;
>> +                       clock-names = "nand", "nand_x";
> 
> 
> Doesn't SOCFPGA really need the ECC clock?
> 

I don't see any mentions of an ECC clock in any of the SoCFPGA
documentation for the NAND IP.

Dinh
