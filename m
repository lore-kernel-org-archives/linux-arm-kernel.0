From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 23 Mar 2015 18:29:11 +0800
Subject: [RFC] pinmux: group and function definitions in the device tree
In-Reply-To: <20150323100913.GJ9742@pengutronix.de>
References: <20150319153950.GC30114@odux.rfo.atmel.com>
 <20150319185637.GV4927@pengutronix.de>
 <20150320150609.GB32259@odux.rfo.atmel.com>
 <20150323064424.GD9742@pengutronix.de>
 <20150323090827.GD32259@odux.rfo.atmel.com>
 <20150323100913.GJ9742@pengutronix.de>
Message-ID: <37858913-F9BB-41D8-A380-7F8C44E08A4F@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Mar 23, 2015, at 6:09 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> On Mon, Mar 23, 2015 at 10:08:27AM +0100, Ludovic Desroches wrote:
>> On Mon, Mar 23, 2015 at 07:44:24AM +0100, Sascha Hauer wrote:
>>> On Fri, Mar 20, 2015 at 04:06:09PM +0100, Ludovic Desroches wrote:
>>>> On Thu, Mar 19, 2015 at 07:56:37PM +0100, Sascha Hauer wrote:
>>>>> On Thu, Mar 19, 2015 at 04:39:50PM +0100, Ludovic Desroches wrote:
>>>>>> 	[...]
>>>>>> 
>>>>>> 	pinctrl_defs {
>>>>>> 		mci0 {
>>>>>> 			mci0_ioset0_1bit_grp {
>>>>>> 				at91,pins = <68 69 70>;
>>>>>> 				at91,mux = <2>;
>>>>>> 			};
>>>>>> 
>>>>>> 			mci0_ioset0_4bit_grp {
>>>>>> 				at91,pins = <68 69 70 71 72 73>;
>>>>>> 				at91,mux = <2>;
>>>>>> 			};
>>>>>> 
>>>>>> 			mci0_ioset0_8bit_grp {
>>>>>> 				at91,pins = <68 69 70 71 72 73 74 75 76 77>;
>>>>>> 				at91,mux = <2>;
>>>>>> 			};
>>>>>> 		};
>>>>>> 	};
>>>>> 
>>>>> Why are different groups here? Do you want to put them into the dtsi?
>>>> 
>>>> We used to have a configuration per pin in our products. On next ones we
>>>> will have some constraints ie. on the controller side we still have a
>>>> configuration per pin but we will introduced the notion of iosets. This
>>>> notion involves that timings are guaranteed only in one ioset. That's
>>>> why we can't mix signals from several iosets because. On the controller side
>>>> we can do all we want so I would like to use groups as a software protection.
>>> 
>>> What does happen when you mix signals of different iosets? It won't work
>>> so the developer will change it. What do you need the software
>>> protection for?
>>> 
>> 
>> I can't say it won't work, it could work in some cases. My fear is to
>> have some support cases because of this. It seems easy to spot this kind
>> of issue but experience tell us that we can loose time for this kind of
>> "stupid" error.
> 
> Hm, the software (dts in this case) developer will only mix signals of
> different iosets when he is forced to by the board designer. It's the
> board designer that has made this mistake, the software developer will
> only try to make it work anyway. I doubt that the board designer will
> design the board based on the possibilities shown in the dts files.
> 
>>>>>> - A subnode for these definitions in order to not parse the whole
>>>>>>  pinctrl node to retrieve groups and functions.
>>>>>> - Using node names as function and group names.
>>>>>> - Can we get generic properties to define the groups? Of course a 'pins'
>>>>>>  property is mandatory. In my case I will need an extra one to tell the
>>>>>>  controller how to mux the pins (a same pin can have up to 7 muxing
>>>>>>  possibilities).
>>>>> 
>>>>> Did you have a look at the RFC I sent for these kind of controllers [1] and
>>>>> the final result for the Mediatek driver currently in Linux-next [2]?.
>>>>> 
>>>>> The binding has both the config and the pins in a single node and thus
>>>>> is very compact.
>>>>> 
>>>> 
>>>> Thanks for the links. Well I had a look to them and now I am a bit
>>>> lost...
>>>> 
>>>> I agree with this binding but it involves to get rid of
>>>> pinconf_generic_dt_node_to_map_all, isn't it? What do group and function
>>>> become? It seems these concepts have disappeared.
>>> 
>>> The binding I suggested changes nothing with pinconf, only the pinmux
>>> information is added to the same node. You can still call
>>> pinconf_generic_dt_node_to_map_all() on the nodes, it will simply ignore
>>> the pinmux information. You would have to handle them separately (or
>>> write some generic helper if you like)
>> 
>> Yes, I can still use it. What I mean is there is no generic helper at the
>> moment to get both pinmux (excepting using the function property) and
>> pinconf information. Is it planned to have something generic for the
>> pinmux property?
> 
> Not yet, but it would be a good idea to add something generic.
> 
>> I see MTK_GET_PIN_NO and MTK_GET_PIN_FUNC macros, on my side,
>> I think it will feet my needs. Maybe we only need to remove the MTK
>> prefix and put these macros in another header.
>> 
>> In the mediatek driver, I have also noticed that we have a group for
>> each pin. I have the feeling that the concept of groups disappear, isn't
>> it?
> 
> This may be because the concept of groups doesn't most hardware.
> There really is hardware out there which can only handle the pins in
> groups (that is, a single mux switches multiple pins), but this hardware
> is not very common. Most hardware can indeed control every pin
> indivually. In this situation some drivers are consequent and make a
> group out of each pin which renders the group concept moot. Other
> drivers just interpret each device node as pin group which creates
> artificial groups which do not exist in hardware.

This is what we do on the current pinctrl-at91

and as we do not see the specific of this new IP for at91 it?s difficult to see
if we can use generic or not.

Personally I do prefer when the number of possibility are not high to have a big
soc dtsi.

But in the case of I.MX yes it?s impossible to manage

Best Regards,
J.
