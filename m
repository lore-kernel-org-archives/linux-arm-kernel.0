From: carlo@caione.org (Carlo Caione)
Date: Fri, 26 Feb 2016 17:43:54 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <2692251.6GoexVJEYt@wuerfel>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <3072897.5MMsyiojns@wuerfel>
 <CAOQ7t2Za5t_3nAm0wyf0rmFa+RTRSGUDAg5b64VvXp-okLMoNQ@mail.gmail.com>
 <2692251.6GoexVJEYt@wuerfel>
Message-ID: <CAOQ7t2Y2B8hfGim9UegUZsurQM0+Df0K0_DjsQ0r8+qMjUSBEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 5:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 26 February 2016 16:34:59 Carlo Caione wrote:
>> On Fri, Feb 19, 2016 at 1:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> <cut>
>>
>> > This still really sounds like a mixed bag to me, which should better get represented
>> > as a syscon node, except that there are also some more structured areas in
>> > CBUS.
>> >
>> > Having just the registers between METAL_REVISION and HW_REV in a syscon
>> > is clearly wrong, as that would include the pinctrl area that already has
>> > a driver, but would not include some other parts that want the syscon.
>> >
>> > Maybe the best way is to make it compatible with both syscon and
>> > simple-bus and put the other nodes underneath. That is still rather
>> > ugly, but at least it works and can be extended.
>>
>> More on this topic.
>>
>> On the meson platforms (at least on the meson8 / meson8b) we have two
>> buses: cbus and aobus. Since in cbus we have a bunch of scattered
>> registers, Arnd suggested to make it compatible with both syscon and
>> simple-bus. So my idea was actually to update the meson8b DTSI file
>> adding the two buses to make it closer to the actual hardware.
>>
>> In the most simple cases moving the devices under the correct bus is a
>> trivial operation since (of course) the same driver can be used when
>> the device is attached to a different bus, like in the uart_AO case
>> (http://lxr.free-electrons.com/source/arch/arm/boot/dts/meson8b.dtsi#L114).
>>
>> Unfortunately pinctrl is a different beast since it requires
>> (http://lxr.free-electrons.com/source/drivers/pinctrl/meson/pinctrl-meson.c#L659)
>> at least two subnodes: one accessing registers from aobus, and the
>> other one from cbus.
>>
>> I know this is quite a peculiar case but I'm wondering what is the
>> best way to approach this issue.
>>
>> 1) We could move only the pinctrl device outside both aobus and cbus
>> but IMO this is ugly (at this point is probably better not having the
>> two buses at all described in the DTS).
>> 2) The second option is just to fix the driver so that the two
>> subnodes are not strictly required. The problem with this second
>> solution is that in the driver we still need to access some data
>> (http://lxr.free-electrons.com/source/drivers/pinctrl/meson/pinctrl-meson8b.c#L873)
>> that is specific to each bus. So we will end up having two different
>> compatibles for the two buses (meson8b-pinctrl-aobus using data from
>> 'ao-bank', and meson8b-pinctrl-cbus using data from 'banks').
>> 3) Another option is just to have the driver with a unique compatible
>> poking the parent node (or just to another property) to determine on
>> which bus it is so that it can use the correct bus-specific data.
>>
>> Any idea / feedback?
>
> Would it be possible to split the pin controller driver into two drivers
> that each only access registers on one of the buses? Is that a split
> that makes sense from the point of view of that driver?

AFAICT (I'm not the driver author) there is no a really strict reason
to have one single driver accessing registers on both buses. Of course
the driver has to be changed a bit.
Are you suggesting to have two different drivers with two different compatibles?

-- 
Carlo Caione
