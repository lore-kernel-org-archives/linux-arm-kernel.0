From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Fri, 28 Sep 2012 11:22:27 +0200
Subject: pxa:spitz_pm.c: commit b6eede11 breaks spitz resume under certain
 conditions.
In-Reply-To: <CAHod+Gc1L0pPZhnPL6Q2rx0KT=-VqdWaTd1FJt2aA9hTMZyeDg@mail.gmail.com>
References: <CAHod+GeMyc+5ERmzY4CYp3SJK-6LOQrhLrLiXSuV3Pdr8+UzSg@mail.gmail.com>
 <CAMPhdO-6iWUWm=vTp-e25BkYBuM5kQfxNW57xKNtKDRU-5Ymgw@mail.gmail.com>
 <CAHod+Gc1L0pPZhnPL6Q2rx0KT=-VqdWaTd1FJt2aA9hTMZyeDg@mail.gmail.com>
Message-ID: <CAHod+GfbcB4d_siaTXn5a163b5sivUTqkWim8r2KJASh=7iGuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I believe that was derived from the legacy code, so if you think it's
> a bug and can get a proper fix, just go with it. Note, however, if the
> code affects poodle/corgi, you may take another look and make sure
> it doesn't break the rest ones.

I think i found the actual problem here.

-       pxa_gpio_mode(GPIO18_RDY|GPIO_OUT | GPIO_DFLT_HIGH);
+       pxa2xx_mfp_config(&gpio18_config[0], 1);

These two lines don't do the same thing. The first one sets GPIO18 as
output, default high.
The second one sets GPIO18 to alternate function RDY. Similar thing
happens here:

-       pxa_gpio_mode(GPIO18_RDY_MD);
-       pxa_gpio_mode(10 | GPIO_IN);
+       pxa2xx_mfp_config(&gpio18_config[1], 1);

 This is probably due to the fact that
prior to pxa-regs.h breakup, GPIO18_RDY was defined as 18
and GPIO18_RDY_MD defined the RDY alternate function.

Basically, this bug is caused by a gpio naming mixup.

A simple fix would be:

 static unsigned long gpio18_config[] = {
-       GPIO18_RDY,
        GPIO18_GPIO,
+       GPIO18_RDY,
 };

I tested this and it works. If you think this is correct
i'll post a proper patch.

I also looked at the original sharp kernel sources.
Only tosa used the RDY signal for it's tc6393tx chip, other machines simply
configured gpio18 as output in their suspend routines.
