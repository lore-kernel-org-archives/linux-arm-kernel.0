From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 27 Aug 2013 08:04:39 +0200
Subject: [RFC PATCH 2/3] pinctrl: at91: add support for generic pinconf
In-Reply-To: <521C22EA.1050908@wwwdotorg.org>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
 <1377380259-11290-1-git-send-email-b.brezillon@overkiz.com>
 <20130826175333.GF18627@ns203013.ovh.net> <521BA235.1090104@overkiz.com>
 <521C22EA.1050908@wwwdotorg.org>
Message-ID: <521C4177.4030104@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2013 05:54, Stephen Warren wrote:
> On 08/26/2013 12:45 PM, boris brezillon wrote:
>> Hello Jean-Christophe,
>>
>> Le 26/08/2013 19:53, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
>>> On 23:37 Sat 24 Aug     , Boris BREZILLON wrote:
>>>> Add support for generic pin configuration to pinctrl-at91 driver.
> ...
>>>> a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
> ...
>>>> configures various pad settings
>>>>    such as pull-up, multi drive, etc.
>>>>      Required properties for iomux controller:
>>>> -- compatible: "atmel,at91rm9200-pinctrl"
>>>> +- compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl".
>>>> +  Add "generic-pinconf" to the compatible string list to use the
>>>> generic pin
> ...
>>>> +pinctrl at fffff400 {
>>>> +    #address-cells = <1>;
>>>> +    #size-cells = <1>;
>>>> +    ranges;
>>>> +    compatible = "atmel,at91rm9200-pinctrl", "generic-pinconf",
>>>> "simple-bus";
>>> nack your break the backword compatibility
>>>
>>> if we use a old kernel with this new dt nothing will work
>>> as the old kernel will never known the the "generic-pinconf" means
>>> anything
>> Your're right, I didn't think of this case (old kernel with new dt).
> Well, just to be clear: If a new DT uses a new compatible value of any
> kind, be it adding "generic-pinconf" or switching to "foo-yyy" rather
> than "foo-yyy", it won't be compatible... That somewhat implies that you
> can't ever replace an old binding with something new.

That's absolutely right, however the behaviour won't be the same in both 
cases.

1) If your (new) dt defines its pinctrl using the "foo-pinconf" 
compatible string and
     your (old) kernel does not support it, the pinctrl will never probe 
the pinctrl definitions.
     Moreover, if you want to define both old ("foo-pinctrl") and new 
("foo-pinconf") pinctrl
     definitions in your dt in order to support several kernel versions, 
nothing prevents you
     from doing it.

2) In the other hand, if you use an additional "generic-pinconf" 
compatible string to signify
     wether or not the pinctrl definition use the generic pinconf dt 
binding, the (old) kernel
     will probe the pinctrl definitions, ignore the "generic-pinconf" 
string, and fail when parsing
     the pinctrl configuration nodes (which are invalid pinctrl function 
nodes in the current dt binding).
     We have the same problem when using the 'atmel,generic-pinconf' 
property inside a pinctrl node:
     old kernels won't take this property into account.
