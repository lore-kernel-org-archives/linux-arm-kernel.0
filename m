From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 28 May 2012 16:43:41 +0800
Subject: [PATCH v9 3/3] MTD: at91: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <1338123053.19389.9.camel@koala>
References: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
 <1338038677-6752-4-git-send-email-josh.wu@atmel.com>
 <1338123053.19389.9.camel@koala>
Message-ID: <4FC33ABD.7020405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/27/2012 8:50 PM, Artem Bityutskiy wrote:
> On Sat, 2012-05-26 at 21:24 +0800, Josh Wu wrote:
>> +       while ((pmecc_readl_relaxed(host->ecc, SR)&  PMECC_SR_BUSY)) {
>> +               if (unlikely(timeout_count++>  PMECC_MAX_TIMEOUT_COUNT)) {
>> +                       dev_err(host->dev, "PMECC: Timeout to get ECC value.\n");
>> +                       return; /* Time out */
> How this error is communicated then up the the user?

If this error happened, that should mean the PMECC is not configurated 
correctly. I think I only I can do is that prompt to user and then call 
BUG() here.

>
>> +               }
>> +               cpu_relax();
>> +       }
> I see this pattern all over the place - why people consider it reliable?
> Is this code guaranteed to run on the same CPU?
>
> Why not to use loops_per_jiffie * msecs_to_jiffies(TIMOUT) instead to
> calculate how many iterations to do? Yes, due to HW register reading and
> cpu_relax() the real timeout will be larger, but this is about error
> anyway, so it does not hurt to iterate longer?
>

I will fix that in next version. thanks.

Best Regards,
Josh Wu
