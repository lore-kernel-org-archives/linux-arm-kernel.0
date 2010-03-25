From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 25 Mar 2010 21:17:54 +0900
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <63386a3d1003250130w6f34854ag2ca163799e9b7bed@mail.gmail.com>
References: <4BAAD5BB.7050101@samsung.com>
	<1b68c6791003242234h106d9530p12b5a046a906227e@mail.gmail.com>
	<63386a3d1003250130w6f34854ag2ca163799e9b7bed@mail.gmail.com>
Message-ID: <1b68c6791003250517y4e2789baoe147e5982c363682@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 5:30 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/3/25 jassi brar <jassisinghbrar@gmail.com>:
>
>> I too have been writing a driver for PL330 after taking into account the
>> suggestions of Russell, Ben and other participants of the thread
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009856.html
>>
>> If you don't think this driver conflicts with the theme of the thread,
>> may I ask you to please put this driver on hold until you checkout my implementation
>> of solution to the issue... which should be soon.
>
> Please post the code as it looks today even if it's not compiling
> instead of asking others
> to hold their patches back. It will be obvious from what you have if
> there is some special
> use you're covering.
My approach is to write a separate PL330 core driver as the backend which
can be reused by any DMA API implementer driver. That will avoid
having two copies
of the PL330 driver, among other benefits. And if this patch is accepted, there
_will_ exist two copies of the PL330 driver -- one in drivers/dma/pl330_dmac.c
and another in arch/arm/plat-samsung/. Only the former will be lying unused
until some other SoC vendor decided to use PL330, because S3C has come too
long a way to change its drivers to driver/dma/ API and modify DMA
drivers for every SoC.

I plan something like, arch/arm/common/pl330-core.c implementing the specs in
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0424a/DDI0424A_dmac_pl330_r0p0_trm.pdf
and drivers/dma/pl330.c implement DMA API for SoCs that chose to use it...
and arch/arm/plat-samsung/dma-pl330.c implementing regular S3C DMA API.

I don't claim to have a silver bullet, nobody has atm, but my approach
is at least
more aligned with what maintainers want.

I have the pl330-core part almost ready, but i need time to implement
some _testable_
implementation of the scheme. If maintainers want to see structure of
my code, I can
share it too, but I think I pretty much made it clear.

> Perhaps Joonyoung can simply port over the stuff
> you need to this driver if you show your code.
Having worked on Samsung SoCs(with PL330 DMAC) based products, I would be
_very_ surprised if any user found this implementation useful.
Let alone testing, this implementation can't even explain usability
for fast peripherals
with shallow FIFOs. I didn't give feedback for this patch because I am
not sure if this
is the right way to go at all.

regards.
