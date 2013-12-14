From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 14 Dec 2013 12:28:39 -0500
Subject: [PATCH CRITICAL] ARM: s3c64xx: dt: Fix boot failure due to double
 clock initialization
In-Reply-To: <CAOesGMgj1mOp+TnazcEd98NPdTQ=Mm-zbD4jMuAeZfx8V9MPzQ@mail.gmail.com>
References: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
 <201312140400.16794.arnd@arndb.de>
 <CAOesGMgj1mOp+TnazcEd98NPdTQ=Mm-zbD4jMuAeZfx8V9MPzQ@mail.gmail.com>
Message-ID: <52AC9547.3000308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

On Saturday 14 December 2013 12:50 AM, Olof Johansson wrote:
> On Fri, Dec 13, 2013 at 7:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 13 December 2013, Tomasz Figa wrote:
>>> Commit
>>>
>>> 4178bac ARM: call of_clk_init from default time_init handler
>>>
>>> added implicit call to of_clk_init() from default time_init callback,
>>> but it did not change platforms calling it from other callbacks, despite
>>> of not having custom time_init callbacks. This caused double clock
>>> initialization on such platforms, leading to boot failures. An example
>>> of such platform is mach-s3c64xx.
>>>
>>> This patch fixes boot failure on s3c64xx by dropping custom init_irq
>>> callback, which had a call to of_clk_init() and moving system reset
>>> initialization to init_machine callback. This allows us to have
>>> clocks initialized properly without a need to have custom init_time or
>>> init_irq callbacks.
>>>
>>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>>
>> I see of_clk_init(NULL) getting called on two other ARM platforms:
>>
>> $ git grep -w of_clk_init arch/arm
>> arch/arm/kernel/time.c:         of_clk_init(NULL);
>> arch/arm/mach-keystone/pm_domain.c:     of_clk_init(NULL);
>> arch/arm/mach-mvebu/armada-370-xp.c:    of_clk_init(NULL);
>> arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c:        of_clk_init(NULL);
>>
>> Are the other two platforms ok here?
>>
>> I assume that mvebu is fine since Sebastian would have noticed breaking
>> that one and it has a custom init_time function, but keystone seems
>> broken in the same way as s3c64xx. Santosh, can you have a look?
> 
> Yeah, and Free Electrons also sent two systems to Kevin so he has them
> in his boot test setup, and they're still happy there. Keystone lacks
> such coverage though, so Santosh will need to check.
> 
Keystone isn't broken as such but some warnings are produced because of
the change. This was noticed on keystone quite a while back and a
patch[1] is already in my queue. It didn't click me that other
machines might have been also affected at that point of time. 

Regards,
Santosh
[1] http://www.spinics.net/lists/arm-kernel/msg288578.html
