From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 Aug 2013 08:23:05 -0500
Subject: [PATCH 0/3] of: add update device node status via cmdline feature
In-Reply-To: <20130821124722.GB17748@b29396-Latitude-E6410>
References: <1376564133-11286-1-git-send-email-b29396@freescale.com>
 <520CCB70.8090908@gmail.com>
 <20130821124722.GB17748@b29396-Latitude-E6410>
Message-ID: <CAL_JsqLa1RkL0MaOCbjYbuQW7+8EKqX8RMfypN=i5UTKaF47=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 7:47 AM, Dong Aisheng <b29396@freescale.com> wrote:
> On Thu, Aug 15, 2013 at 07:37:04AM -0500, Rob Herring wrote:
>> On 08/15/2013 05:55 AM, Dong Aisheng wrote:
>> > We meet some boards having a lot of pin conflicts between different devices,
>> > only one of them can be enabled to run at one time.
>> >
>> > e.g. imx6q sabreauto board, i2c, spi, weim, flexcan, uart and etc involved
>> > with pin conflict.
>> >
>> > Instead of changing dts manually or adding a lot dts files according to
>> > different device availability, we provide feature to dynamically update the
>> > device node status via command line, then those devices involved with
>> > pin conflict can be enabled or disabled dynamically.
>> >
>> > It's conveniently to use and can save a lot dts board files, also can
>> > permenantly fix the pin conflicts issue.
>>
>> This doesn't scale either with updating of lots devices or when the next
>> person comes along and wants to edit another property.
>>
>
> I'm not sure about other property.
> But we update it did cause by the real requirement, not arbitrary.
> Or we can try to find another better way to avoid it.
>
>> This is something u-boot is perfectly capable of handling and updating
>> status is something lots of boards already do.
>>
>
> How does uboot handle this according to our needs?
> Also dynamically update the device node status with uboot command?
> Can you help point out an example for me to check?
>

Here's an example adding a status property with u-boot commands:

Highbank #fdt print /soc/ethernet
ethernet at fff50000 {
        compatible = "calxeda,hb-xgmac";
        reg = <0xfff50000 0x00001000>;
        interrupts = <0x00000000 0x0000004d 0x00000004 0x00000000
0x0000004e 0x00000004 0x00000000 0x0000004f 0x00000004>;
        dma-coherent;
};
Highbank #fdt set /soc/ethernet status okay
Highbank #fdt print /soc/ethernet
ethernet at fff50000 {
        status = "okay";
        compatible = "calxeda,hb-xgmac";
        reg = <0xfff50000 0x00001000>;
        interrupts = <0x00000000 0x0000004d 0x00000004 0x00000000
0x0000004e 0x00000004 0x00000000 0x0000004f 0x00000004>;
        dma-coherent;
};

Rob
