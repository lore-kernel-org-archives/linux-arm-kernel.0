From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 10 Jun 2014 17:39:04 +0200
Subject: [RFC/PATCH] ARM: mvebu: Don't apply the quirks if the SoC revision
 is unknown
In-Reply-To: <20140610134040.GA1991@arch.cereza>
References: <1402342036-9168-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <5621673.VW5TXctBgm@wuerfel> <20140610134040.GA1991@arch.cereza>
Message-ID: <53972698.8030704@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2014 15:40, Ezequiel Garcia wrote:
> Hi Arnd,
> 
> Thanks for taking a look.
> 
> On 10 Jun 10:21 AM, Arnd Bergmann wrote:
>> On Monday 09 June 2014 16:27:16 Ezequiel Garcia wrote:
>>> We currently skip the I2C and thermal quirks only if the SoC revision is
>>> known to be one that does not need them. If the SoC revision cannot be
>>> obtained, the current behavior is to apply the quirk assuming it's needed.
>>>
>>> This commit changes this, by requiring the SoC revision to be known in order
>>> to peform a quirk.
>>
>> This clearly needs a better description if we want to apply it. We had
>> a rather long discussion when the code was first added exactly this
>> way and you should explain which of the assumptions we made back then
>> are now incorrect.
>>
>> Is it ever wrong (as opposed to inefficient) to apply the quirk even on a
>> newer SoC?
>>
> 
> Yes, for the thermal quirk it is wrong as it consists in changing the compatible
> string and moving the registers around.
> 
> So if you apply the quirk on a SoC that doesn't need it, thermal won't work.

Actually it is the opposite for the I2C quirk. If you don't apply it on an SoC
which needs it then the i2C won't work, whereas if you apply it on an SoC which
don't need it, then you won't benefit of an optimization but the I2C will remain
usable.

So with your change we can have a situation where the i2c is no more usable.
That's why I would prefer that you don't modify the i2c quirk.


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
