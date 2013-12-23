From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 23 Dec 2013 09:49:24 +0200
Subject: OMAP display subsystem - does it work?
In-Reply-To: <20131220160432.GZ27438@atomide.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
 <20131220114837.GH32243@n2100.arm.linux.org.uk> <52B44982.4020501@ti.com>
 <20131220160432.GZ27438@atomide.com>
Message-ID: <52B7EB04.6000606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-20 18:04, Tony Lindgren wrote:

>> This looks odd... Presuming the panel device was probed successfully, it
>> should always get the gpios or return an error. Only if gpio_is_valid()
>> returns false for the gpio, it skips it and continues. But in this case,
>> the gpio number comes from the platform data, so it should always be valid.
>>
>> And if it wasn't probed successfully, then there shouldn't be a fb0.
> 
> I bet that's it though. If the display is probed before twl4030 GPIO
> is initialized, the GPIO numbers will be 0. I'm using omap2plus_defconfig
> which has DSS built as modules.

Ah, right, I see. The gpio numbers for the panel pdata are initialized
to -1 (not 0) in the board file. The twl init code will set those to
their appropriate numbers, but if the panel is probed before twl, the
panel driver just presumes gpios are not needed as they are -1.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131223/a6bd5089/attachment.sig>
