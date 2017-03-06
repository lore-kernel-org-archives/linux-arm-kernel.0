From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 6 Mar 2017 08:35:52 +0100
Subject: [PATCH 1/2] ARM: dts: aspeed: add SPI controller bindings
In-Reply-To: <CACPK8XeaSh8MVTfPjwt=+NBPWCkMK7QqpAXF7+BYYQBViVSNKg@mail.gmail.com>
References: <1488378403-24640-1-git-send-email-clg@kaod.org>
 <1488378403-24640-2-git-send-email-clg@kaod.org>
 <CACPK8XeaSh8MVTfPjwt=+NBPWCkMK7QqpAXF7+BYYQBViVSNKg@mail.gmail.com>
Message-ID: <1506a763-5038-f630-e70c-f877a332659f@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2017 12:13 AM, Joel Stanley wrote:
> Hi Cedric,
> 
> On Thu, Mar 2, 2017 at 12:56 AM, C?dric Le Goater <clg@kaod.org> wrote:
>> Let's define the SPI controllers in the Aspeed SoCs AST2500 and
>> AST2400 and also enable these, as well as the chips, on the associated
>> platforms.
> 
> Thanks for this. Was there a reason you didn't modify the romulus dts as well?

Mostly because this is a pre-romulus patch that I refreshed. 
I will send a extra patch for the romulus platform. 

Thanks,

C. 


> Cheers,
> 
> Joel
> 
>>
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>> ---
>>  arch/arm/boot/dts/aspeed-ast2500-evb.dts      | 20 +++++++++
>>  arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 16 +++++++
>>  arch/arm/boot/dts/aspeed-g4.dtsi              | 29 ++++++++++++
>>  arch/arm/boot/dts/aspeed-g5.dtsi              | 63 +++++++++++++++++++++++++++
>>  4 files changed, 128 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
>> index d967603dade8..8f82e8ab1875 100644
>> --- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
>> +++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
>> @@ -20,6 +20,26 @@
>>         };
>>  };
>>
>> +&fmc {
>> +       status = "okay";
>> +       flash at 0 {
>> +               status = "okay";
>> +               label = "bmc";
>> +       };
>> +};
>> +
>> +&spi1 {
>> +       status = "okay";
>> +       flash at 0 {
>> +               status = "okay";
>> +               label = "pnor";
>> +       };
>> +};
>> +
>> +&spi2 {
>> +       status = "okay";
>> +};
>> +
>>  &uart5 {
>>         status = "okay";
>>  };
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
>> index 1d2fc1e1dc29..aab1889f702f 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
>> @@ -31,6 +31,22 @@
>>         };
>>  };
>>
>> +&fmc {
>> +       status = "okay";
>> +       flash at 0 {
>> +               status = "okay";
>> +               label = "bmc";
>> +       };
>> +};
>> +
>> +&spi {
>> +       status = "okay";
>> +       flash at 0 {
>> +               status = "okay";
>> +               label = "pnor";
>> +       };
>> +};
>> +
>>  &uart5 {
>>         status = "okay";
>>  };
>> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
>> index 0b4932cc02a8..7ef6442d0ade 100644
>> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
>> @@ -33,6 +33,35 @@
>>                 #size-cells = <1>;
>>                 ranges;
>>
>> +               fmc: flash-controller at 1e620000 {
>> +                       reg = < 0x1e620000 0x94
>> +                               0x20000000 0x02000000 >;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       compatible = "aspeed,ast2400-fmc";
>> +                       status = "disabled";
>> +                       interrupts = <19>;
>> +                       flash at 0 {
>> +                               reg = < 0 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +               };
>> +
>> +               spi: flash-controller at 1e630000 {
>> +                       reg = < 0x1e630000 0x18
>> +                               0x30000000 0x02000000 >;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       compatible = "aspeed,ast2400-spi";
>> +                       status = "disabled";
>> +                       flash at 0 {
>> +                               reg = < 0 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +               };
>> +
>>                 vic: interrupt-controller at 1e6c0080 {
>>                         compatible = "aspeed,ast2400-vic";
>>                         interrupt-controller;
>> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
>> index b664fe380936..8970f3cb8e2b 100644
>> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
>> @@ -24,6 +24,69 @@
>>                 #size-cells = <1>;
>>                 ranges;
>>
>> +               fmc: flash-controller at 1e620000 {
>> +                       reg = < 0x1e620000 0xc4
>> +                               0x20000000 0x10000000 >;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       compatible = "aspeed,ast2500-fmc";
>> +                       status = "disabled";
>> +                       interrupts = <19>;
>> +                       flash at 0 {
>> +                               reg = < 0 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +                       flash at 1 {
>> +                               reg = < 1 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +                       flash at 2 {
>> +                               reg = < 2 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +               };
>> +
>> +               spi1: flash-controller at 1e630000 {
>> +                       reg = < 0x1e630000 0xc4
>> +                               0x30000000 0x08000000 >;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       compatible = "aspeed,ast2500-spi";
>> +                       status = "disabled";
>> +                       flash at 0 {
>> +                               reg = < 0 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +                       flash at 1 {
>> +                               reg = < 1 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +               };
>> +
>> +               spi2: flash-controller at 1e631000 {
>> +                       reg = < 0x1e631000 0xc4
>> +                               0x38000000 0x08000000 >;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       compatible = "aspeed,ast2500-spi";
>> +                       status = "disabled";
>> +                       flash at 0 {
>> +                               reg = < 0 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +                       flash at 1 {
>> +                               reg = < 1 >;
>> +                               compatible = "jedec,spi-nor";
>> +                               status = "disabled";
>> +                       };
>> +               };
>> +
>>                 vic: interrupt-controller at 1e6c0080 {
>>                         compatible = "aspeed,ast2400-vic";
>>                         interrupt-controller;
>> --
>> 2.7.4
>>
