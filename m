From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 18 Nov 2014 03:50:37 +0400
Subject: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks
 in pxa-ssp
In-Reply-To: <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
 <878uj98y5v.fsf@free.fr>
 <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
Message-ID: <CALT56yO8tktrXo0rfRd91AtXBE4F5vYfYjm9AL+7dcoam6Oq9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-17 23:05 GMT+03:00 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>:
> 2014-11-17 21:44 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
>> Guess what, Russell's remark on i2c and serial made me cross-check.  And there
>> is a case where this will be called in irq context too ...
>>
>> See :
>> -> do_IRQ
>>   -> lubbock_vbus_irq()
>>     -> pxa25x_udc_vbus_session()
>>       -> pullup()
>>         -> clk_prepare_enable()
>>           -> CRACK
>>
>> Note that your patch is not really the faulty one, I think a threaded irq
>> instead of the "raw" irq should do the trick. And it is granted on UDC api that
>> vbus function is called in a "sleeping" context (Felipe correct me if I'm
>> wrong), so a patch to fix this before your current code would be fine.
>
> OK, I will take a look. It seems the correct way would be to strip this code
> away to a phy, like gpio-vbus or nop phys. Do you have access to lubbock
> (or maybe Daniel, Haojian or Russell has?)?

I have sketched a compile-tested only PHY for the Lubbock platform. Could you
please take a look and test.
The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:

  Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)

are available in the git repository at:

  git://git.infradead.org/users/dbaryshkov/zaurus.git lubbock

for you to fetch changes up to 67d7e1e57af0a42d86476cd2e73fd154b590d3f8:

  usb: gadget: drop lubbock-specific code from pxa25x_udc (2014-11-18
02:43:03 +0300)

----------------------------------------------------------------
Dmitry Eremin-Solenikov (3):
      ARM: pxa: lubbock: add declaration of vbus tranceiver
      usb: phy: add lubbock phy driver
      usb: gadget: drop lubbock-specific code from pxa25x_udc

 arch/arm/mach-pxa/lubbock.c         |   6 +++
 drivers/usb/gadget/udc/pxa25x_udc.c |  61 -----------------------
 drivers/usb/phy/Kconfig             |  10 ++++
 drivers/usb/phy/Makefile            |   1 +
 drivers/usb/phy/phy-lubbock.c       | 225
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 242 insertions(+), 61 deletions(-)
 create mode 100644 drivers/usb/phy/phy-lubbock.c


-- 
With best wishes
Dmitry
