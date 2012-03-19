From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 10:54:01 -0600
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <201203191545.40933.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <201203191501.10232.arnd@arndb.de>
 <4F674BC4.2070802@wwwdotorg.org> <201203191545.40933.arnd@arndb.de>
Message-ID: <4F6764A9.8090907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2012 09:45 AM, Arnd Bergmann wrote:
> On Monday 19 March 2012, Stephen Warren wrote:
>>> Maybe one can use named properties in a new device node in that case,
>>> like this:
>>>
>>>       bus {
>>>               dma: dma-controller {
>>>                       #dma-cells = <1>;
>>>               };
>>>
>>>               device {
>>>                       compatible = "device";
>>>                       channel: dma-channel {
>>>                               type = <0x1>;
>>>                               name = "foo";
>>>                               number = <23>;
>>>                               direction = <3>;
>>>                       };
>>>                       dma-requests = <&dma &channel>;
>>>               };
>>>       };
>>
>> For reference, this is very similar to how the pinctrl bindings work,
>> except that they require the "channel" node to be a child of the DMA
>> controller, and hence "dma-requests" doesn't contain <&dma &channel>,
>> just <&channel>, since "dma" is the parent (or grand-parent) of "channel".
> 
> Right, but the difference beytween the pinctrl binding and what I
> describe here is that the channel description would be part of the
> dma engine driver specific binding, not the generic binding that
> is visible to device drivers.

That's actually true for pinctrl as well: Common pinctrl bindings cover
the content/format of "dma-requests" and a requirement for a
"dma-channel" node, whereas the per-pin-controller bindings define the
content of node "dma-channel".
