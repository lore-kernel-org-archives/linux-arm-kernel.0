From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 12 Jul 2011 18:56:39 +0300
Subject: [PATCH V6 4/4] MTD: pxa3xx_nand: enhance suspend and resume
	routine
In-Reply-To: <CACTFLAPB0JE9FJc8jdbaoME_qmPbN1N-HyPVN7Kb5-op6Pa1EA@mail.gmail.com>
References: <1310096084-14646-1-git-send-email-leiwen@marvell.com>	<1310466535-15287-5-git-send-email-leiwen@marvell.com>	<CACTFLANDZN6gAorV1MYEFD3FnAnomPqLgx44pPUeUaxKjApG_Q@mail.gmail.com>
	<CACTFLAPB0JE9FJc8jdbaoME_qmPbN1N-HyPVN7Kb5-op6Pa1EA@mail.gmail.com>
Message-ID: <4E1C6EB7.80506@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/11 15:02, Daniel Mack wrote:

> On Tue, Jul 12, 2011 at 1:39 PM, Daniel Mack <zonque@gmail.com> wrote:
>> On Tue, Jul 12, 2011 at 12:28 PM, Lei Wen <leiwen@marvell.com> wrote:
>>> This patch add protection on the suspend&resume path to prevent
>>> some unexpected behavior, like interrupt occur at the very second
>>> of resume back and it don't follow normal command path, which lead
>>> to bug.
>>>
>>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>>> ---
>>>  drivers/mtd/nand/pxa3xx_nand.c |   28 ++++++++++++++++++++++++++++
>>>  1 files changed, 28 insertions(+), 0 deletions(-)
>>>
>> [...]
>>
>>> @@ -1267,6 +1283,18 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
>>>        info->cs = 0xff;
>>>        clk_enable(info->clk);
>>>
>>> +       /*
>>> +        * As the spec, the NDSR would be updated to 0x1800 when
>>> +        * do the nand_clk disable/enable.
>>> +        * To prevent it damage state machine of the driver, clear
>>> +        * all status before resume
>>> +        */
>>> +       nand_writel(nand, NDSR, NDSR_MASK);
>> This doesn't build:
>>
>>  CC      drivers/mtd/nand/pxa3xx_nand.o
>> drivers/mtd/nand/pxa3xx_nand.c: In function 'pxa3xx_nand_resume':
>> drivers/mtd/nand/pxa3xx_nand.c:1292: error: 'nand' undeclared (first
>> use in this function)
>> drivers/mtd/nand/pxa3xx_nand.c:1292: error: (Each undeclared
>> identifier is reported only once
>> drivers/mtd/nand/pxa3xx_nand.c:1292: error: for each function it appears in.)
>> drivers/mtd/nand/pxa3xx_nand.c:1294: error: 'mtd' undeclared (first
>> use in this function)
>> make[3]: *** [drivers/mtd/nand/pxa3xx_nand.o] Error 1
>>
>> I guess this was not even compile tested? Anyway, I did a trivial
>> fix-up and will test.
> Also, with this (fixed) patch applied, the system doesn't resume at
> all. No messages, it simply doesn't come back.

I was skeptic about the clock being disabled in Lei's patch,
as I observed system hangs if that clock was disabled back then in 2.6.31,
but wanted to give it a try, because things has changed since then.

Now I see, that Lei already sent v7 without clock toggling...



-- 
Regards,
Igor.
