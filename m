From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 14 Mar 2017 17:18:41 -0400
Subject: [PATCH 1/2] ARM: dts: BCM5301X: Specify serial console parameters
In-Reply-To: <9f5a0381-aae6-9ac2-56f3-9eb78ecfd819@broadcom.com>
References: <20170314075830.2247-1-zajec5@gmail.com>
 <20170314122650.GV15842@lunn.ch>
 <3345fb38-fbea-141e-6ad2-a3341e2c31fe@gmail.com>
 <CAC3K-4qQzX37BLD2N-N-vDwSk=H_rF5PzoMM+GM=Z935QFVnXw@mail.gmail.com>
 <9f5a0381-aae6-9ac2-56f3-9eb78ecfd819@broadcom.com>
Message-ID: <CAC3K-4pAzs5fXNB=ZpyzYZnTENa=c0v81GVn7WpW53K7GV9UOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 4:44 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
>
>
> On 17-03-14 07:53 AM, Jon Mason wrote:
>>
>> On Tue, Mar 14, 2017 at 8:32 AM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>>>
>>> On 03/14/2017 01:26 PM, Andrew Lunn wrote:
>>>>
>>>>
>>>> On Tue, Mar 14, 2017 at 08:58:29AM +0100, Rafa?? Mi??ecki wrote:
>>>>>
>>>>>
>>>>> From: Rafa?? Mi??ecki <rafal@milecki.pl>
>>>>>
>>>>> This adds baud rate, parity & number of data bits. It's required to get
>>>>> serial working correctly.
>>>>>
>>>>> Signed-off-by: Rafa?? Mi??ecki <rafal@milecki.pl>
>>>>> ---
>>>>>  arch/arm/boot/dts/bcm5301x.dtsi | 6 +++++-
>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi
>>>>> b/arch/arm/boot/dts/bcm5301x.dtsi
>>>>> index 8fd1ef9f0c2d..468107166a6f 100644
>>>>> --- a/arch/arm/boot/dts/bcm5301x.dtsi
>>>>> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
>>>>> @@ -18,8 +18,12 @@
>>>>>  / {
>>>>>         interrupt-parent = <&gic>;
>>>>>
>>>>> +       aliases {
>>>>> +               serial0 = &uart0;
>>>>> +       };
>>>>> +
>>>>>         chosen {
>>>>> -               stdout-path = &uart0;
>>>>> +               stdout-path = "serial0:115200n8";
>>>>>         };
>>>>
>>>>
>>>>
>>>> Hi Rafal
>>>>
>>>> The alias is fine. But putting the stdout-path here is unusual. Which
>>>> serial port is used for console is board specific, where as
>>>> bcm5301x.dtsi is very generic, it describes the SoC, not a board.  If
>>>> you look at other .dtsi files, those that specify stdout-path contain
>>>> properties which are common to a range of similar boards.
>>>
>>>
>>>
>>> So far I've never seen any board using other uart. Also uart0 is disabled
>>> by
>>> default and we enable it per board family (BCM4708 / BCM47081 / BCM4709 /
>>> BCM47094). I think it's just more practical to have simple DTS that
>>> covers
>>> 99,9% boards by default and handled that margin of devices separately.
>>>
>>> We already got a lot of duplicated code for enabling uart0, see:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b790d3b2943bf8e7e7bafe184008bd6451fe0bd
>>>
>>> Jon Mason from Broadcom who knows this hardware and designs very well
>>> confirmed
>>> it's a sane/safe assumption.
>>
>>
>>
>> It should work for all the boards.  The question is whether it should
>> be in the DTSI or DTS file.  This code replicates code I have in
>> arch/arm/boot/dts/bcm953012k.dts
>> So, either it should be removed or we should change all of the other
>> DTS files to have this entry.  My understanding is that the latter
>> approach is the acceptable one (which matches Andrew's comment), but I
>> can make the other changes if necessary.
>
> dtsi file is fine to handle 99% of the use cases and not duplicate the
> entry.  This is what we do for newer SoCs (such as Cygnus) where the console
> will always be a particular UART (as the BootROM already uses a certain UART
> the boards are designed to use that UART as the console always).  For
> bcm953012 a similar situation exists as a common bootloader is used across
> boards.  So, the uart used as the terminal will always be the same.

Unfortunately, there is not a common bootloader.  CFE is used for the
4708/9 boards, and u-boot is used for the 5301x boards.

Thanks,
Jon

> I don't see a good reason for duplicating the code in every dts file.
>
> Acked-by: Scott Branden <scott.branden@broadcom.com>
>>
>>
>> Thanks,
>> Jon
>>
>
