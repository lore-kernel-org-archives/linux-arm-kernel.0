From: robherring2@gmail.com (Rob Herring)
Date: Thu, 20 Nov 2014 09:16:31 -0600
Subject: [PATCH V3] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <8642876.4lpJWZTuhf@wuerfel>
References: <1414503414-3863-1-git-send-email-suravee.suthikulpanit@amd.com>
 <8642876.4lpJWZTuhf@wuerfel>
Message-ID: <CAL_Jsq+J3izFDepJ04Lb=caUOKJ4eNja0NrhqowyCOEPBVAPdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 5:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 28 October 2014 08:36:54 suravee.suthikulpanit at amd.com wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> Initial revision of device tree for AMD Seattle platform
>
> Sorry for not looking at this earlier in enough detail.
>
>> +     dma0: dma at 0500000 {
>> +             compatible = "arm,pl330", "arm,primecell";
>> +             reg = <0 0x0500000 0 0x1000>;
>> +             interrupts =
>> +                     <0 368 4>,
>> +                     <0 369 4>,
>> +                     <0 370 4>,
>> +                     <0 371 4>,
>> +                     <0 372 4>,
>> +                     <0 373 4>,
>> +                     <0 374 4>,
>> +                     <0 375 4>;
>> +             clocks = <&dmaclk_500mhz>;
>> +             clock-names = "apb_pclk";
>> +             #dma-cells = <1>;
>> +     };
>
> Is this device cache-coherent?
>
> Does it support larger than 32-bit DMA addresses?

No.

>
>> +     sata0: sata at 00300000 {
>> +             compatible = "snps,dwc-ahci";

This should have an AMD specific compatible string in addition in case
you have AMD specific configuration or bugs.

>> +             reg = <0 0x300000 0 0x800>;
>> +             interrupts = <0 355 4>;
>> +             clocks = <&sataclk_333mhz>;
>> +             clock-names = "apb_pclk";

This name is obviously wrong and copied from other (ARM Primecell)
bindings as this IP does not have an APB PCLK. You can drop the name
as it is optional.

>> +             dma-coherent;
>> +     };
>
> Same here: you list it as coherent, but not 64-bit DMA capable.
> Is that intentional?

AHCI controllers are probeable as to whether they support 64-bit DMA or not.

Rob
