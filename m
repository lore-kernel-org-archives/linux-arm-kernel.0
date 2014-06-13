From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 13 Jun 2014 09:35:20 -0400
Subject: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from getting
 mapped to crossbar
In-Reply-To: <20140613131005.GF8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-4-git-send-email-r.sricharan@ti.com>
 <20140612125134.GS8664@titan.lakedaemon.net>
 <20140612135715.GE17845@atomide.com>
 <20140612140508.GC8664@titan.lakedaemon.net> <539AA08A.7010001@ti.com>
 <20140613131005.GF8664@titan.lakedaemon.net>
Message-ID: <539AFE18.3020706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 June 2014 09:10 AM, Jason Cooper wrote:
> On Fri, Jun 13, 2014 at 12:26:10PM +0530, Sricharan R wrote:
>> On Thursday 12 June 2014 07:35 PM, Jason Cooper wrote:
> ...
>>> Do you have other changes outside of irqchip depending on this series?
>>> If so, I can set up a topic branch for you guys to base off of.
>>> Otherwise, I'll just apply them to irqchip/core when they're ready.
>>>
>>  There are dts changes which are dependent upon this series.
>>
>>   http://www.spinics.net/lists/linux-omap/msg108116.html
> 
> In general, dts changes shouldn't depend on code changes or vice-versa.
> If they do, that's an indicator that we're breaking compatibility with
> older dtbs.
>
Thats true. The case with cross-bar though is the feature wasn't
completly supported so far before this series. Perhaps the the initial
bindings should have been marked unstable. 
 
> Looking at the dra7.dtsi changes, we're redefining the interrupt
> property, which can't be good. :(
>
> Perhaps a better solution would be to add a property, say 'ti,cross-irq'
> that is the exact same format as 'interrupts', but is used by the
> crossbar driver?
>
We have gone over those earlier and it was agreed to re-use interrupt
properties and for special cases, define a cross-bar property to describe
it.
 
> I'm not convinced of this yet, I suspect we may not actually have a
> dependency between the dtsi changes and the code changes.  We would have
> the ugly "if you have the crossbar node, 'interrupts' means X, if not it
> means Y" in the binding docs.  But the absence of the node prevents the
> crossbar driver from re-interpreting the interrupts property.
> 
In ideal cross-bar hardware you don't need the assumption "if you have the
crossbar node, 'interrupts' means X, if not it means Y"

It is purely because the cross-bar irq router hardware has few nasty
bugs which needs those special handling. And thats the reason, the
property was added.

> Have you tried booting all the different scenarios?  eg:
> 
>   old dtb, new driver
>   new dtb, old driver
>   old dtb, old driver
>   new dtb, new driver
> 
Old driver wasn't complete as mentioned and hence the above
combinations becomes bit irrelevant.

Regards,
Santosh
