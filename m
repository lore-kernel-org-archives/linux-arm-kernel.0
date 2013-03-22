From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Mar 2013 15:39:11 +0100
Subject: [PATCH 0/9] More ux500 multiplatform stuff
In-Reply-To: <201303221334.07330.arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
 <CACRpkdbaRyHxeJM=JT+9CtVf-_u90wCzjePDvsNq-EQd_NxLdg@mail.gmail.com>
 <201303221334.07330.arnd@arndb.de>
Message-ID: <CACRpkdbdmJrM48dPyV3zWpi6QLnVYcSTnkZbTDTXRSrd+pyVew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 2:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 22 March 2013, Linus Walleij wrote:
>> On Thu, Mar 21, 2013 at 10:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > This is
>> > what I came up with, on top of your patches. Feel free to take what
>> > you need if you don't already have the same patches.
>> >
>> > I've successfully built "allmodconfig" with all the other v6/v7
>> > platforms enabled as well.
>>
>> Unfortunately the platform stops booting after
>> 2/9 "ARM: ux500: split out prcmu initialization"
>> so I will look closer at this.
>
> Yes, I can see how it has potential for introducing bugs. I hope it's
> something obvious that you can find easily.

You bet:

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index bc8f870..8eb8c49 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2680,7 +2680,7 @@ static int db8500_irq_init(struct device_node
*np, int irq_base)
        int i;

        /* In the device tree case, just take some IRQs */
-       if (!np)
+       if (np)
                irq_base = 0;

        db8500_irq_domain = irq_domain_add_simple(

After this the U8500 and U8520 boot to prompt with all the patches
applied!

Patches only need to be agreed upon and ACKed.

I now feel confident that we can merge ux500 multiplatform support
for v3.10.

Yours,
Linus Walleij
