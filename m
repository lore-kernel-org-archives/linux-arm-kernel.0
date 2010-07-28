From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 28 Jul 2010 15:38:10 +0800
Subject: [PATCH 02/29] pxa3xx_nand: fix compile warning
In-Reply-To: <20100728072338.GA29277@n2100.arm.linux.org.uk>
References: <AANLkTimJbfRUwzRUT0Z6_eMOm-SpYeti-FjY-eE5a7cV@mail.gmail.com>
	<AANLkTikHFbaUjocnH9Fm8EHV75rCFEZ03EkMqbWPzHc+@mail.gmail.com>
	<20100728072338.GA29277@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinsKD-xdmmvSc8XBVLCAT-1wRZ4jxphy29Vn4Ma@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 3:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 28, 2010 at 02:17:23PM +0800, Eric Miao wrote:
>> On Wed, Jul 28, 2010 at 1:56 PM, Haojian Zhuang
>> <haojian.zhuang@gmail.com> wrote:
>> > From c374a3f27c56f9112b97960eaa3194a08db6f4a4 Mon Sep 17 00:00:00 2001
>> > From: Lei Wen <leiwen@marvell.com>
>> > Date: Tue, 22 Jun 2010 20:19:35 +0800
>> > Subject: [PATCH 02/29] pxa3xx_nand: fix compile warning
>> >
>> > The compile output as below:
>> > WARNING: modpost: Found 1 section mismatch(es).
>> >
>> > Signed-off-by: Lei Wen <leiwen@marvell.com>
>> > ---
>> > ?drivers/mtd/nand/pxa3xx_nand.c | ? ?2 +-
>> > ?1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
>> > index 3ffcbcd..52cec28 100644
>> > --- a/drivers/mtd/nand/pxa3xx_nand.c
>> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
>> > @@ -1069,7 +1069,7 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
>> > ? ? ? ?this->chip_delay = 25;
>> > ?}
>> >
>> > -static int pxa3xx_nand_probe(struct platform_device *pdev)
>> > +static int __devinit pxa3xx_nand_probe(struct platform_device *pdev)
>>
>> Ack
>
> __devinit is not always the right thing for this. ?Not having any
> attribute is the safest thing. ?Having any kind of init tag means
> that there's a circumstance when the function will be freed, and
> if the function pointer is called...
>

Should be quite safe if all the NAND devices are registered during
the initcall phase, which is normally true. Yet indeed will create
problems if they are registered later, e.g. in modules.
