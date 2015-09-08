From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 8 Sep 2015 21:14:31 +0800
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Add dts file for the
 pov protab2-ips9 tablet
In-Reply-To: <55EED95D.20004@redhat.com>
References: <1441441319-10658-1-git-send-email-hdegoede@redhat.com>
 <20150906163023.GR31584@lukather> <55ED3739.609@redhat.com>
 <20150907205603.GX31584@lukather> <55EE9230.70209@redhat.com>
 <CAGb2v64BGPP9Fs0gM0ghJZ0tO8QdGZD9GfpquGCGKiZCeTkyww@mail.gmail.com>
 <55EED95D.20004@redhat.com>
Message-ID: <CAGb2v66h4Gwidz4yU8h9wiSsU=XX2URWWK715rJsQRB8Sob0Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 8, 2015 at 8:49 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 09/08/2015 10:40 AM, Chen-Yu Tsai wrote:
>>
>> On Tue, Sep 8, 2015 at 3:45 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 07-09-15 22:56, Maxime Ripard wrote:
>>>>
>>>>
>>>> On Mon, Sep 07, 2015 at 09:05:29AM +0200, Hans de Goede wrote:
>>>>>>>
>>>>>>>
>>>>>>> +&reg_ldo3 {
>>>>>>> +       /*
>>>>>>> +        * We need to always power the camera sensor, otherwhise all
>>>>>>> access
>>>>>>> +        * to i2c1 is blocked.
>>>>>>> +        */
>>>>>>> +       regulator-always-on;
>>>>>>> +       regulator-min-microvolt = <2800000>;
>>>>>>> +       regulator-max-microvolt = <2800000>;
>>>>>>> +       regulator-name = "vdd-csi";
>>>>>>> +};
>>>>>>
>>>>>>
>>>>>>
>>>>>> What is connected on i2c1 ? Just the camera sensor? or it has some
>>>>>> other devices there?
>>>>>
>>>>>
>>>>>
>>>>> The bma250 accelerometer sits there, and the kernel already has a
>>>>> driver
>>>>> for it. That driver needs to have devicetree binding support added, and
>>>>> then we should be able to use the accelerometer.
>>>>
>>>>
>>>>
>>>> Ok, so if this regulator is disable, you can't access the other
>>>> devices as well, right?
>>>
>>>
>>>
>>> Right, the controller reports the bus as being stuck.
>>>
>>>> Do you know why? Is it the regulator providing
>>>> the pull-up voltage?
>>>
>>>
>>>
>>> I've tried enabling the pull ups on the SoC i2c pins, so I do not think
>>> that it is that, it seems that somehow when not powered the camera sensor
>>> is
>>> actively keeping the lines low. Either it has multiple power planes, or
>>> it is using normally-on fet-s between ground and its i2c lines.
>>
>>
>> FYI the reference designs use one regulator to power the pull-ups, VCC-PX
>> (X for X pin group), and VDDIO (IO power)on the camera sensors. AVDD, DVDD
>> (actual power) for the sensors are another (or more) regulators.
>
>
> But that is a A23 or some such generation thing, right? This is an A10 based
> tablet!

A13 reference design from

   https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/A13-PDFs/a13-sch.pdf

also has it, but instead of outputs from the AXP223, it's using
discrete regulator
ICs, such as the LP3992 shown in the design. These are likely GPIO enabled.

Looking at some A13 fex files, each camera sensor has a reset GPIO, but the two
share the same power GPIO, which likely enables the regulator.

A10 should be similar, considering they use the same PMIC, and are likely to
need external regulators for all the voltages required.

My point is that the camera sensors require like 2~3 supplies, and VDDIO seems
to be shared between the sensors (if there are 2), the external pull-ups, and
sometimes power to the SoC pin group (if there is a power pin for them).


ChenYu
