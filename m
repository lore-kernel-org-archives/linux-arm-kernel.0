From: rob.herring@linaro.org (Rob Herring)
Date: Wed, 13 Jun 2018 16:06:51 -0600
Subject: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of
 sata ports
In-Reply-To: <0bf3c57c-dac8-8ece-6b8a-3b4d024140fc@broadcom.com>
References: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
 <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com>
 <395f1fe8-76f1-8310-d09e-63e25bca23d2@broadcom.com>
 <CAL_JsqJEFLXFf-Vq9c9XC41vBpisQwxkd06_v8Fmt6X=gp=2_g@mail.gmail.com>
 <f20222ea-47ac-ca05-a8d3-69f28932de94@gmail.com>
 <0bf3c57c-dac8-8ece-6b8a-3b4d024140fc@broadcom.com>
Message-ID: <CABGGiszcTNw23e_qA7EiGb_2hc6kHfVQJq02pQjbpTnv1CNksg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 2:18 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Hi Rob,
>
> Thanks for comment - reply inline.
>
>
>
> On 18-06-13 12:31 PM, Florian Fainelli wrote:
>>
>> On 06/12/2018 03:54 PM, Rob Herring wrote:
>>>
>>> On Thu, Jun 7, 2018 at 12:53 PM, Scott Branden
>>> <scott.branden@broadcom.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> Could you please kindly comment on change below.
>>>>
>>>> It allows board variants to be added easily via a simple define for
>>>> different number of SATA ports.
>>>>
>>>>
>>>>
>>>> On 18-06-04 09:22 AM, Florian Fainelli wrote:
>>>>>
>>>>> On 05/18/2018 11:34 AM, Scott Branden wrote:
>>>>>>
>>>>>> Move remaining sata configuration to stingray-sata.dtsi and enable
>>>>>> ports based on NUM_SATA defined.
>>>>>> Now, all that needs to be done is define NUM_SATA per board.
>>>>>
>>>>> Rob could you review this and let us know if this approach is okay or
>>>>> not? Thank you!
>>>>>
>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>>> ---
>>>>>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>> b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>> index 8c68e0c..7f6d176 100644
>>>>>> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>> @@ -43,7 +43,11 @@
>>>>>>                          interrupts = <GIC_SPI 321
>>>>>> IRQ_TYPE_LEVEL_HIGH>;
>>>>>>                          #address-cells = <1>;
>>>>>>                          #size-cells = <0>;
>>>>>> +#if (NUM_SATA > 0)
>>>>>> +                       status = "okay";
>>>>>> +#else
>>>>>>                          status = "disabled";
>>>>>> +#endif
>>>
>>> This only works if ports are contiguously enabled (0-N). You might not
>>> care, but it is not a pattern that works in general.
>
> Correct - all board designs that include this dtsi file follow such
> commonality (ie. design with SATA0 first, etc).  By having common board
> designs it allows for commonality in dts files rather than duplicating
> information everywhere.  If somebody designs a bizarro board they are free
> to create their own dts file of course.
>>>
>>>   And I'm not a fan
>>> of C preprocessing in DT files in general beyond just defines for
>>> single numbers.
>
> The use of a define to specify the number of SATA ports in the board design
> meets our requirements of being able to maintain many boards.  We need a
> method to specify the number of ports in the board design rather than
> copying and pasting the information in many dts files.  If you have an
> alternative upstreamable mechanism to manage the configuration of many
> boards without copy and paste that would be ideal?

Is this really the only problem with maintaining lots of boards? What
about all the other nodes that are conditionally enabled? Really, I
don't see the problem with 3 lines per node.

Does having an unused port enabled cause problems? If not, you could
handle it all at run-time and just shutdown ports which have no link.
You'd want to do that anyway for boards with a port, but is not
connected to a drive (except for hotplug capable ports).

Maybe we could add a property in /chosen that is a list of nodes to
enable and either the bootloader or kernel could update their
'status'. Or It could even be done in dtc perhaps with some
/directive/.

Rob
