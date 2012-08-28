From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 28 Aug 2012 22:58:48 +0200
Subject: [PATCH] ARM: S3C24XX: Add .get_rate callback for "camif-upll"
 clock
In-Reply-To: <503BFB86.20607@samsung.com>
References: <1346098329-32059-1-git-send-email-sylvester.nawrocki@gmail.com>
 <503BFB86.20607@samsung.com>
Message-ID: <503D3108.1030804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2012 12:58 AM, Kukjin Kim wrote:
> On 08/27/12 13:12, Sylwester Nawrocki wrote:
>> Add missing get_rate callback for the "camif-upll" clock, so frequency
>> of this clock is properly reported with clk_get_rate().
>>
>> Signed-off-by: Sylwester Nawrocki<sylvester.nawrocki@gmail.com>
>> ---
>> arch/arm/mach-s3c24xx/clock-s3c2440.c | 14 ++++++++++++++
>> 1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2440.c 
>> b/arch/arm/mach-s3c24xx/clock-s3c2440.c
>> index cb2883d..749220f 100644
>> --- a/arch/arm/mach-s3c24xx/clock-s3c2440.c
>> +++ b/arch/arm/mach-s3c24xx/clock-s3c2440.c
>> @@ -87,6 +87,19 @@ static int s3c2440_camif_upll_setrate(struct clk 
>> *clk, unsigned long rate)
>> return 0;
>> }
>>
>> +static unsigned long s3c2440_camif_upll_getrate(struct clk *clk)
>> +{
>> + unsigned long parent_rate = clk_get_rate(clk->parent);
>> + unsigned long camdivn = __raw_readl(S3C2440_CAMDIVN);
>> +
>> + if (!(camdivn& S3C2440_CAMDIVN_CAMCLK_SEL))
>> + return parent_rate;
>> +
>> + camdivn&= S3C2440_CAMDIVN_CAMCLK_MASK;
>> +
>> + return parent_rate / (camdivn + 1) / 2;
> 
> Well, why do we need '/ 2' here?

I simply followed documentation of the camera clock divider register
(CAMDIVN). This is how CAMCLK_SEL and CAMCLK_DIV bit fields are described
there:

CAMDIVN      |  Bit  |       Description
--------------------------------------------------------------------------
CAMCLK_SEL   | [4]   | 0 : Use CAMCLK with UPLL output(CAMCLK=UPLL output)
             |       | 1 : CAMCLK is divided by CAMCLK_DIV value
-------------+-------+----------------------------------------------------
CAMCLK_DIV   | [3:0] | CAMCLK divide factor setting register(0 ? 15).
             |       | Camera clock = UPLL / [(CAMCLK_DIV +1)x2].
             |       | This bit is valid when CAMCLK_SEL=1.

So, camera clock frequency = parent_rate / ((camdivn + 1) * 2).
This is exactly same as 'parent_rate / ( camdivn + 1) / 2'.

To be 1000% sure I compared frequency values reported from clk_get_rate()
in the driver with values measured with an oscilloscope at the CAMCLKOUT
pin. Everything was as expected (UPLL - 48 MHz, CAMCLKOUT - 12 MHz).

Also, it's easy to confirm correctness of this code by inversing equations
found in function s3c2440_camif_upll_setrate(), i.e.

 camdivn &= ~(S3C2440_CAMDIVN_CAMCLK_SEL | S3C2440_CAMDIVN_CAMCLK_MASK);
 if (rate != parent_rate) {
 	camdivn |= S3C2440_CAMDIVN_CAMCLK_SEL;
 	camdivn |= (((parent_rate / rate) / 2) - 1);
 }

 __raw_writel(camdivn, S3C2440_CAMDIVN);

--
Regards,
Sylwester
