From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Jul 2015 22:13:27 -0600
Subject: [PATCH v2 2/4] irqchip: bcm2835: If a parent interrupt is
 registered, chain from it.
In-Reply-To: <87bnf4giq7.fsf@eliezer.anholt.net>
References: <1436837718-956-1-git-send-email-eric@anholt.net>
 <1436837718-956-3-git-send-email-eric@anholt.net>
 <55AEFB1D.6090108@wwwdotorg.org> <87bnf4giq7.fsf@eliezer.anholt.net>
Message-ID: <55B1BB67.1090603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 12:17 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> On 07/13/2015 07:35 PM, Eric Anholt wrote:
>>> The BCM2836 (Raspberry Pi 2) uses two levels of interrupt
>>> handling with the CPU-local interrupts being the root, so we
>>> need to register ours as chained off of the CPU's local
>>> interrupt.
>> 
>> Sorry for the slow review; laziness after vacation!
>> 
>>> diff --git
>>> a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>> b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>
>>>
>>> 
+The BCM2836 contains the same interrupt controller with the same
>>> +interrupts, but the per-CPU interrupt controller is the root,
>>> and an +interrupt there indicates that the ARMCTRL has an
>>> interrupt to handle. + Required properties:
>>> 
>>> - compatible : should be "brcm,bcm2835-armctrl-ic"
>> 
>> Since there are some differences between the bcm2835 and bcm2836
>> HW blocks, I'd expect the compatible value to be different for
>> each. In particular...
> 
> Well, there are actually no differences within this block of the HW
> (HDL is unmodified), it's just where the output interrupt line gets
> consumed. But it's not much extra to add a new compatible value, so
> sure.

Mmm. I suppose that's true indeed.

So, I guess either of the following is fine for bcm2836 by me:

compatible = "brcm,bcm2836-armctrl-ic";
compatible = "brcm,bcm2836-armctrl-ic", "brcm,bcm2835-armctrl-ic";

The 2836 value is always needed since DT should contain the most
specific compatible value for the implementation. The 2835 value is
optional based on whether the HW block is 100% backwards-compatible
with the older HW block; a driver for the old block can run unmodified
against the new block. It's debatable whether that's true here; the
interface to this HW block itself is unchanged between
implementations, yet the way the driver for it integrates into the
system differs since it either is/isn't a top-level IRQ chip.
