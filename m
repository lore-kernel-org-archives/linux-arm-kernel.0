From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 01 Aug 2014 01:26:34 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DACE73.8080009@suse.de>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com> <53DA9709.10602@suse.de>
 <53DA9BA9.60808@gmail.com> <53DACE73.8080009@suse.de>
Message-ID: <53DAD0AA.7040105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.08.2014 01:17, Andreas F?rber wrote:
> Am 31.07.2014 21:40, schrieb Tomasz Figa:
>> On 31.07.2014 21:20, Andreas F?rber wrote:
>>> Am 31.07.2014 21:05, schrieb Tomasz Figa:
>>>> On 31.07.2014 18:08, Andreas F?rber wrote:
[snip]
>>>>> +&dp_hpd {
>>>>> +	samsung,pins = "gpc3-0";
>>>>> +	samsung,pin-function = <0>;
>>>>> +	samsung,pin-pud = <3>;
>>>>> +	samsung,pin-drv = <0>;
>>>>> +};
>>>>
>>>> Hmm, what node is this referencing? I believe this should rather
>>>> reference the pin controller and add a new board-specific pinconf/pinmux
>>>> group instead....
>>>
>>> It's a -pinctrl node. See v3->v4 change log and discussion on v3.
>>>
>>
>> Well, this is clearly a board specific node anyway, because it does not
>> refer to a special function, but simply an input/interrupt GPIO. If it
>> somehow has landed in generic pinctrl dtsi then it should be removed
>> from there and this patch should simply introduce its own instance of
>> dp_hpd node, so you did the right thing in v3.
> 
> Well, my point was that the 3.8 tree contains only one dp-hpd node, not
> two as we would get by adding a new node here.
> 
> Apart from Spring, it's used in Snow and SMDK5250, so moving it there
> seems feasible and the cleanest solution to me.
> 

What I mean is that in exynos5250-pinctrl.dtsi only generic SoC pin
groups should be defined and those more or less correspond to groups
with samsung,pin-function set to something other than 0 (input) or 1
(output). Now here hpd_gpio is just a normal GPIO input used as
interrupt source to detect when a cable is plugged or unplugged. This is
by no means generic to the SoC, because any GPIO with interrupt
capability can be used for this purpose. This means that the whole
pin{conf,mux} group should be defined on board level.

Best regards,
Tomasz

>>>> [snip]
>>>>
>>>>> +/*
>>>>> + * Disabled pullups since external part has its own pullups and
>>>>> + * double-pulling gets us out of spec in some cases.
>>>>> + */
>>>>> +&i2c2_bus {
>>>>> +	samsung,pin-pud = <0>;
>>>>> +};
>>>>
>>>> OK, here overriding a generic pinconf group is justified and nicely
>>>> explained by a comment.
>>>
>>> You seem to assume that I actually understand these things. ;)
>>> Just copied from -cros-common/-snow.
>>>
>>
>> It is good if those things are being done with some level of
>> understanding. The DT mechanics are quite well documented in
>> Documentation/devicetree/bindings, while for HW-specific bits I believe
>> Chromium guys could give you a hand.
> 
> I did read and even fix documentation for those bindings that I added
> myself in Spring, just not for those that were already in common code,
> like this one here.

My intention was that if there is something not clear, rather than
blindly copy-pasting it, it might be worth to ask people that might
know. Although any issues should generally be found at review stage, so
I don't really have any objections, assuming that Chromium people assure
that this patch adds valid data indeed.

> 
> A tps65090 patch has been ignored since being asked to extend the commit
> message, v3 was recently sent. Help getting that in appreciated.

Will take a look if time allows. Thanks for your work on this.

Best regards,
Tomasz
