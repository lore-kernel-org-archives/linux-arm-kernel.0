From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Sep 2013 10:41:22 -0600
Subject: [RFC PATCH alt 4/4] pinctrl: at91: rework debounce configuration
In-Reply-To: <52340B68.5020505@overkiz.com>
References: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
 <1379058813-3489-1-git-send-email-b.brezillon@overkiz.com>
 <52339479.6030402@wwwdotorg.org> <52340B68.5020505@overkiz.com>
Message-ID: <523734B2.6050208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2013 01:08 AM, boris brezillon wrote:
> Hello Stephen,
> 
> Le 14/09/2013 00:40, Stephen Warren a ?crit :
>> On 09/13/2013 01:53 AM, Boris BREZILLON wrote:
>>> AT91 SoCs do not support per pin debounce time configuration.
>>> Instead you have to configure a debounce time which will be used for all
>>> pins of a given bank (PIOA, PIOB, ...).
...
>>>   Required properties for pin configuration node:
...
>>> -DEBOUNCE_VAL    (0x3fff << 17): debounce val.
>>
>> This change would break the DT ABI since it removes a feature that's
>> already present.
...
>> I suppose it's still up to the Atmel maintainers to decide whether this
>> is appropriate, or whether the impact to out-of-tree DT files would be
>> problematic.
>>
>> Assuming the DT ABI can be broken, I think I'd prefer to do so, rather
>> than take "non-alt" patch 4/4, since a per-pin DEBOUNCE_VAL clearly
>> doesn't correctly model the HW, assuming the patch description is
>> correct. I don't think arguments re: the generic pinconf debounce
>> property hold; if the Linux-specific/internal generic property doesn't
>> apply, the DT binding should not be bent to adjust to it, but should
>> rather still represent the HW itself.
> 
> What about the last point in my list: "reconfigure debounce after
> startup" ?
> 
> Here is an example that may be problematic:
> 
> Let's say you have one device using multiple configuration of pins
> ("default", "xxx", "yyy").
> The "default" config needs a particular debounce time on a given pin and
> the "xxx" and "yyy"
> configs need different debounce time on the same pin.
> 
> How would you solve this with this patch approach ?

Each state has a different pin configuration node, and hence can specify
a different debounce value. This patch has no impact on that (it just
changes whether the state-specific node specifies the debounce value in
a single standalone property, or encodes it into each entry in the pins
property, all within the same node).
