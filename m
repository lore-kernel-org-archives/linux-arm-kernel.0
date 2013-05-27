From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 May 2013 12:37:15 +0200
Subject: [PATCH v2] ARM: at91: Fix link breakage when !CONFIG_PHYLIB
In-Reply-To: <20130527080909.GB2919@ludovic.desroches@atmel.com>
References: <1369467542-25519-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20130525200557.GO24476@game.jcrosoft.org>
 <20130527080909.GB2919@ludovic.desroches@atmel.com>
Message-ID: <51A3375B.3090205@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/2013 10:09, Ludovic Desroches wrote:
> On Sat, May 25, 2013 at 10:05:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 09:39 Sat 25 May     , Alexandre Belloni wrote:
>>> Fixes:
>>> arch/arm/mach-at91/built-in.o: In function `ksz9021rn_phy_fixup':
>>> :(.text+0x1174): undefined reference to `mdiobus_write'
>>> :(.text+0x1188): undefined reference to `mdiobus_write'
>>> :(.text+0x119c): undefined reference to `mdiobus_write'
>>> :(.text+0x11b0): undefined reference to `mdiobus_write'
>>> arch/arm/mach-at91/built-in.o: In function `sama5_dt_device_init':
>>> :(.init.text+0x1e34): undefined reference to `phy_register_fixup_for_uid'
>>>
>>> when CONFIG_PHYLIB is not selected.
> Signed-off-by missing.
>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>

I'll send a v3...

>>> ---
>>> Changes in v2:
>>> 	use IS_BUILTIN
>>> 	use CONFIG_PHYLIB and not CONFIG_PHY
>>>
>> I do not like this, I prefer we just drop the fixup by adding the dt support
>> to the micrel phy as done for broadcom
>>
> Yes it will be a better solution but we don't have it. Even if we add dt
> support for micrel phy it won't go into 3.10 so it has to be fixed before the
> release.

The fixup is also done like that on i.mx6. I think we'll have to stick
to that for now.

>> if !PHYLIB just add an inline declaration of 
>> phy_register_fixup_for_uid
>>
>> so gcc will drop ksz9021rn_phy_fixup automatically

By using IS_BUILTIN, gcc is already optimizing out the offeding lines,
else you would still get the linking error.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
