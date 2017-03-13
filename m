From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 13 Mar 2017 06:20:59 -0700
Subject: [PATCH] ARM: dts: imx: add Gateworks Ventana GW5904 support
In-Reply-To: <b105d1ea-7975-bd21-0aa0-762060ceb62a@gmail.com>
References: <1489178411-6559-1-git-send-email-tharvey@gateworks.com>
 <04584d61-f1e2-3722-1f13-ff133edc0c22@gmail.com>
 <CAJ+vNU1NcW=y_c-jJBnAaOozrzYJAekd9BEiMdd2=Bpx=Ng79Q@mail.gmail.com>
 <b105d1ea-7975-bd21-0aa0-762060ceb62a@gmail.com>
Message-ID: <CAJ+vNU1JAp3=bxrKY9cNac8=aEG4MMh01Cb6iwb-dV+gyNPn_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 5:20 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 03/10/2017 05:07 PM, Tim Harvey wrote:
>> On Fri, Mar 10, 2017 at 12:43 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>
>>>> +     dsa {
>>>> +             compatible = "marvell,dsa";
>>>> +             #address-cells = <2>;
>>>> +             #size-cells = <0>;
>>>> +
>>>> +             dsa,ethernet = <&fec>;
>>>> +             dsa,mii-bus = <&mdio>;
>>>> +
>>>
>>> Please consider using the new binding for DSA switches, see:
>>>
>>> https://patchwork.kernel.org/patch/9493037/
>>>
>>
>> Hi Florian,
>>
>> I tried the new binding first, but haven't gotten it to work yet. Let
>> me make sure I understand what I should be doing.
>>
>> This is a MV88E6176 so I first need to add dt support for that to the
>> mv88e6xxx driver (which supports the device, just not via dt):
>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
>> index 03dc886..fd5c716 100644
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -4602,6 +4602,10 @@ static const struct of_device_id mv88e6xxx_of_match[] = {
>>                 .data = &mv88e6xxx_table[MV88E6085],
>>         },
>>         {
>> +               .compatible = "marvell,mv88e6176",
>> +               .data = &mv88e6xxx_table[MV88E6176],
>> +       },
>> +       {
>>                 .compatible = "marvell,mv88e6190",
>>                 .data = &mv88e6xxx_table[MV88E6190],
>>         },
>>
>> Then I remove the old binding and add the new binding as such:
>>
>> &fec {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&pinctrl_enet>;
>>         phy-mode = "rgmii-id";
>>         status = "okay";
>
> You most likely need to declare a fixed PHY for the FEC to be setting up
> the link, speed and duplex?

Florian,

Thanks - this appears to be the issue. I declared the fixed-phy down
in the cpu port but I guess it needs to be done in the net device.

Tim
