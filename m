From: zonque@gmail.com (Daniel Mack)
Date: Tue, 12 Jul 2011 14:02:28 +0200
Subject: [PATCH V6 4/4] MTD: pxa3xx_nand: enhance suspend and resume
	routine
In-Reply-To: <CACTFLANDZN6gAorV1MYEFD3FnAnomPqLgx44pPUeUaxKjApG_Q@mail.gmail.com>
References: <1310096084-14646-1-git-send-email-leiwen@marvell.com>
	<1310466535-15287-5-git-send-email-leiwen@marvell.com>
	<CACTFLANDZN6gAorV1MYEFD3FnAnomPqLgx44pPUeUaxKjApG_Q@mail.gmail.com>
Message-ID: <CACTFLAPB0JE9FJc8jdbaoME_qmPbN1N-HyPVN7Kb5-op6Pa1EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 1:39 PM, Daniel Mack <zonque@gmail.com> wrote:
> On Tue, Jul 12, 2011 at 12:28 PM, Lei Wen <leiwen@marvell.com> wrote:
>> This patch add protection on the suspend&resume path to prevent
>> some unexpected behavior, like interrupt occur at the very second
>> of resume back and it don't follow normal command path, which lead
>> to bug.
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> ---
>> ?drivers/mtd/nand/pxa3xx_nand.c | ? 28 ++++++++++++++++++++++++++++
>> ?1 files changed, 28 insertions(+), 0 deletions(-)
>>
>
> [...]
>
>> @@ -1267,6 +1283,18 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
>> ? ? ? ?info->cs = 0xff;
>> ? ? ? ?clk_enable(info->clk);
>>
>> + ? ? ? /*
>> + ? ? ? ?* As the spec, the NDSR would be updated to 0x1800 when
>> + ? ? ? ?* do the nand_clk disable/enable.
>> + ? ? ? ?* To prevent it damage state machine of the driver, clear
>> + ? ? ? ?* all status before resume
>> + ? ? ? ?*/
>> + ? ? ? nand_writel(nand, NDSR, NDSR_MASK);
>
> This doesn't build:
>
> ?CC ? ? ?drivers/mtd/nand/pxa3xx_nand.o
> drivers/mtd/nand/pxa3xx_nand.c: In function 'pxa3xx_nand_resume':
> drivers/mtd/nand/pxa3xx_nand.c:1292: error: 'nand' undeclared (first
> use in this function)
> drivers/mtd/nand/pxa3xx_nand.c:1292: error: (Each undeclared
> identifier is reported only once
> drivers/mtd/nand/pxa3xx_nand.c:1292: error: for each function it appears in.)
> drivers/mtd/nand/pxa3xx_nand.c:1294: error: 'mtd' undeclared (first
> use in this function)
> make[3]: *** [drivers/mtd/nand/pxa3xx_nand.o] Error 1
>
> I guess this was not even compile tested? Anyway, I did a trivial
> fix-up and will test.

Also, with this (fixed) patch applied, the system doesn't resume at
all. No messages, it simply doesn't come back.


Daniel
