From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 18 Mar 2014 13:02:55 -0700
Subject: [PATCH] ARM: dts: ventana: fix eth1 pci dev node
In-Reply-To: <20140314132805.GD813@S2101-09.ap.freescale.net>
References: <1394747064-4106-1-git-send-email-tharvey@gateworks.com>
 <20140314132805.GD813@S2101-09.ap.freescale.net>
Message-ID: <CAJ+vNU2Av-n1-efbFbXNvO4SmoobL_WpQKApFRS1Zjy0egLLzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 6:28 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Mar 13, 2014 at 02:44:24PM -0700, Tim Harvey wrote:
>> Properly add the PCI device node for the 2nd GigE port so that the device
>> driver can get its MAC from DT.  Note that the Ventana bootloader uses
>> the ethernet1 alias to populate the MAC address by adding the local-mac-address
>> property.  Also remove the unnecesssary 'sky2' alias.
>>
>> This is based on Shawn's for-next branch
>
> This line shouldn't be necessarily in the commit log.

ok

>
>>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  arch/arm/boot/dts/imx6q-gw5400-a.dts  | 40 +++++++++++++++++++++++++++++++----
>>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 39 ++++++++++++++++++++++++++++++----
>>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 39 ++++++++++++++++++++++++++++++----
>>  3 files changed, 106 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
>> index 902f983..5d2b912 100644
>> --- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
>> +++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
>> @@ -16,7 +16,7 @@
>>       model = "Gateworks Ventana GW5400-A";
>>       compatible = "gw,imx6q-gw5400-a", "gw,ventana", "fsl,imx6q";
>>
>> -     /* these are used by bootloader for disabling nodes */
>> +     /* these are used by bootloader for configuring nodes */
>>       aliases {
>>               ethernet0 = &fec;
>>               ethernet1 = &eth1;
>> @@ -26,7 +26,7 @@
>>               led0 = &led0;
>>               led1 = &led1;
>>               led2 = &led2;
>> -             sky2 = &eth1;
>> +
>
> No need to add a new line.

oops - will remove

>
>>               ssi0 = &ssi1;
>>               spi0 = &ecspi1;
>>               usb0 = &usbh1;
>> @@ -496,8 +496,40 @@
>>       reset-gpio = <&gpio1 29 0>;
>>       status = "okay";
>>
>> -     eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
>> -             compatible = "marvell,sky2";
>
> So this was just a placeholder and did not actually work in any way,
> right?

Kind of - it worked with a non-upstream patch against the sky2 driver
which used the dt alias of 'sky2' to get to its mac address.  I've
since learned how to reference PCI dt nodes properly and have patched
the sky2 driver the proper way (see
http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/drivers/net/ethernet/marvell/sky2.c?id=3ee2f8ce1ab8f235bda164295fa0cf39ec1c2400).
 So now, I'm 'fixing' the improper way I did it before.

>
>> +     pcie at 0,0 {
>
> Is this whole bridge/switch hierarchy binding documented somewhere or is
> this just something that work for you?

I'm not sure where its 'best' documented, but it is the way the kernel works.

>
>> +             /* 00:00.0 host-bridge */
>> +             #address-cells = <3>;
>> +             #size-cells = <2>;
>> +             device_type = "pci";
>> +             reg = <0x0 0 0 0 0>;
>> +
>> +             /*
>> +              * GigE PCI dev node needs to be defined so that enet driver
>> +              * can use it to obtain its boot-loader specified MAC
>> +              */
>> +             pcie at 0,0 {
>> +                     /* 01:00.0 PCIe switch */
>> +                     #address-cells = <3>;
>> +                     #size-cells = <2>;
>> +                     device_type = "pci";
>> +                     reg = <0x0 0 0 0 0>;
>> +
>> +                     pcie at 8,0 {
>
> What's the naming schema for all these pcie nodes?  Generally, we should
> have the numbers encoded in the node name coming from the address cells
> in 'reg' property.
>
> Shawn

I'm cc'ing Jason as some of his comments to another thread helped me
understand how to define a PCI device node off a bus in dt properly -
perhaps he knows where its best documented.

I was hoping there was a way to reference PCI nodes by BDF values as
I'm simply trying to define a marvell,sky2 device at 08:00.0.  I found
that the kernel's OF parsing code for PCI requires you to nest the
nodes to match the bus hierarchy.  In order to map a dt node to a PCI
device, the bus the device is on must have a dt node itself, which is
what creates the need for the nesting.  Note that the bus topology
here rc -> P2P bridge -> GigE.

Tim

>
>> +                             /* 02:08.0 PCIe switch port */
>> +                             #address-cells = <3>;
>> +                             #size-cells = <2>;
>> +                             device_type = "pci";
>> +                             reg = <0x4000 0 0 0 0>;
>> +                             eth1: pcie at 0,0 {
>> +                                     /* 08:00.0 GigE */
>> +                                     #address-cells = <3>;
>> +                                     #size-cells = <2>;
>> +                                     device_type = "pci";
>> +                                     reg = <0x0 0 0 0 0>;
>> +                                     compatible = "marvell,sky2";
>> +                             };
>> +                     };
>> +             };
>>       };
>>  };
>>
