From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 28 Jan 2016 03:22:47 +0900
Subject: [PATCH] ARM: dts: orion5x: add mtd flash support to linkstation
 lswtgl
In-Reply-To: <20160127173231.GI20194@lunn.ch>
References: <1453907405-30434-1-git-send-email-rogershimizu@gmail.com>
 <20160127173231.GI20194@lunn.ch>
Message-ID: <CAEQ9gEmcss4sb6hE6-w0jVoYfHqnWNf23EVNMefvZ24TYfEk2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

On Thu, Jan 28, 2016 at 2:32 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Thu, Jan 28, 2016 at 12:10:05AM +0900, Roger Shimizu wrote:
>> MTD flash stores u-boot and u-boot environment on linkstation lswtgl.
>> The latter one can be easily read/write by u-boot-tools package in Debian.
>>
>> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
>> ---
>>  arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 30 ++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
>> index 420788229e6f..16eabc524b27 100644
>> --- a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
>> +++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
>> @@ -228,6 +228,36 @@
>>       };
>>  };
>>
>> +&devbus_bootcs {
>> +     status = "okay";
>> +     devbus,keep-config;
>> +
>> +     flash at 0 {
>> +             compatible = "jedec-flash";
>> +             reg = <0 0x40000>;
>> +             bank-width = <1>;
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +
>
> Hi Roger
>
> Same comment i just sent to Thomas:
>
> The partition table should be a subnode of the mtd node and should be named
> 'partitions'. This node should have the following property:
> - compatible : (required) must be "fixed-partitions"
> Partitions are then defined in subnodes of the partitions node.
>
> For backwards compatibility partitions as direct subnodes of the mtd device are
> supported. This use is discouraged.
>
>            Andrew
>
>
>> +             partition at 0 {
>> +                     label = "header";
>> +                     reg = <0 0x30000>;
>> +                     read-only;
>> +             };
>> +
>> +             partition at 30000 {
>> +                     label = "uboot";
>> +                     reg = <0x30000 0xF000>;
>> +                     read-only;
>> +             };
>> +
>> +             partition at 3F000 {
>> +                     label = "uboot_env";
>> +                     reg = <0x3F000 0x1000>;
>> +             };
>> +     };
>> +};
>> +
>>  &mdio {
>>       status = "okay";
>>
>> --
>> 2.1.4
>>

Thanks for your comments!

Using the patch I submitted result in:

[    1.667440] Found: SST 39LF020
[    1.670613] f4000000.flash: Found 1 x8 devices at 0x0 in 8-bit bank
[    1.676948] number of JEDEC chips: 1
[    1.698943] 3 ofpart partitions found on MTD device f4000000.flash
[    1.705222] Creating 3 MTD partitions on "f4000000.flash":
[    1.710803] 0x000000000000-0x000000030000 : "header"
[    1.719051] 0x000000030000-0x00000003f000 : "uboot"
[    1.727182] 0x00000003f000-0x000000040000 : "uboot_env"

Applying the partition DT proposed in
Documentation/devicetree/bindings/mtd/partition.txt, result in:

[    1.667879] Found: SST 39LF020
[    1.671053] f4000000.flash: Found 1 x8 devices at 0x0 in 8-bit bank
[    1.677389] number of JEDEC chips: 1

So the partitions are gone.

My modified DT is like:

&devbus_bootcs {
    status = "okay";
    devbus,keep-config;

    flash at 0 {
        compatible = "jedec-flash";
        reg = <0 0x40000>;
        bank-width = <1>;
        #address-cells = <1>;
        #size-cells = <1>;

        partitions {
            compatible = "fixed-partitions";
            #address-cells = <1>;
            #size-cells = <1>;

            partition at 0 {
                label = "header";
                reg = <0 0x30000>;
                read-only;
            };

            partition at 30000 {
                label = "uboot";
                reg = <0x30000 0xF000>;
                read-only;
            };

            partition at 3F000 {
                label = "uboot_env";
                reg = <0x3F000 0x1000>;
            };
        };
    };
};

Any comment would be appreciated!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 17B3ACB1
