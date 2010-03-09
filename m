From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 9 Mar 2010 11:13:32 -0600
Subject: [PATCH] locomo: replace locomo_{readl/writel} macros with
	__raw_{readw/writew}
In-Reply-To: <f17812d71003090526r33325407n250c92b1947d9fcf@mail.gmail.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909022427CF@mi8nycmail19.Mi8.com>
	<f17812d71003090526r33325407n250c92b1947d9fcf@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B027084269763682CD9E0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 09, 2010 6:26 AM, Eric Miao wrote:
> On Tue, Mar 9, 2010 at 8:18 AM, H Hartley Sweeten
> <hartleys@visionengravers.com> wrote:
>> The locomo_readl and locomo_writel macros are misnamed. Both
>> use (*(volatile u16 *)(addr)) so they should be a *w variety.
>>
>> Instead of renaming the macros just replace them tree wide with
>> __raw_readw and __raw_writew.
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>>
>
> Hey Hartley,
>
> Could you please rebase this on top of my 'devel' branch?

Not a problem... Where can I git it?

This patch was generated from the linux-next tree, which was
the only one I could find with your irq cleanup patches in it.

> And note locomo_{read,write}l() may also be used in sub-device
> drivers like keyboard, LEDs and etc.

$ git grep --name-only -e 'locomo_readl' --or -e 'locomo_writel'
arch/arm/common/locomo.c
arch/arm/include/asm/hardware/locomo.h
drivers/input/keyboard/locomokbd.c
drivers/leds/leds-locomo.c
drivers/video/backlight/locomolcd.c

I believe I covered all in-tree users.  I guess I should have included
a diffstat.

$ git diff --stat
 arch/arm/common/locomo.c               |  229 ++++++++++++++++----------------
 arch/arm/include/asm/hardware/locomo.h |    3 -
 drivers/input/keyboard/locomokbd.c     |   26 ++--
 drivers/leds/leds-locomo.c             |    4 +-
 drivers/video/backlight/locomolcd.c    |   10 +-
 5 files changed, 135 insertions(+), 137 deletions(-)

If you know of any out-of-tree users of the macros I guess it would be better to
leave them in the header and mark them as deprecated for a while.  I just don't
know how to do that with a macro, other than just adding a comment.

Regards,
Hartley
