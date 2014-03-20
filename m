From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Mar 2014 21:59:29 +0300
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <201403201250.45005.arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <9096065.aGCg8yZblW@wuerfel> <532AB6B0.7010108@ti.com>
 <201403201250.45005.arnd@arndb.de>
Message-ID: <532B3A91.6000800@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/20/2014 02:50 PM, Arnd Bergmann wrote:

>>>>> The question is whether there is anyone who would do this properly.

>>>>      Nobody cares, it seems. As you can imagine, I stopped to care enough after
>>>> being switched to other projects.

>>> I only care about it because I have the intention to get all 'randconfig'
>>> kernels to build eventually. For stuff that is definitely 'legacy'
>>> and won't get cleaned up properly, I'm fine with a hack.

>>>>> Both the OHCI and MUSB drivers use exactly one register (CFGCHIP2)

>>>>      The idea at the time was to just ioremap() this register but I was not
>>>> very eager.

>>> Yes, that would work, too. However, that would cause problems later
>>> if we ever try to make the davinci platform "multiplatform", unless we also
>>> pass the physical address in a platform resource and make this a larger

>> Some SATA driver work done by Bartlomiej Zolnierkiewicz needed driver
>> access to syscfg registers too and I just asked him to pass the physical
>> addresses using platform resource. I think thats the best bet we have in
>> the absence of a modern interface.

> Ok.

    Depends on what SYSCFG register it uses. It wouldn't be good if that 
register range includes CFGCHIP2.

>>> The syscon (system controller) framework helps share a set of registers
>>> across multiple drivers. If all accesses to the CFGCHIP2 register are
>>> in a single PHY driver, we wouldn't need it.

>> CFGCHIP2 has controls both for USB 1.1 (OHCI) and USB 2.0 (MUSB). Not
>> sure if there can be a single PHY driver for both.

> The phy infrastructure explicitly supports multiple consumers for one
> phy, if I'm reading the code correctly.

    Yes, it does. The issue is that the PHY code is different in MUSB and OHCI 
drivers. I don't think the PHY driver knows what device binds to it.

> 	Arnd

WBR, Sergei
