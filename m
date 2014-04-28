From: george.cherian@ti.com (George Cherian)
Date: Mon, 28 Apr 2014 20:15:35 +0530
Subject: [PATCH 1/6] drivers: net: cpts: Remove hardcoded clock name for
 CPTS
In-Reply-To: <20140428143115.GC30292@saruman.home>
References: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
 <1398658225-25873-2-git-send-email-george.cherian@ti.com>
 <20140428143115.GC30292@saruman.home>
Message-ID: <535E698F.7060104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/28/2014 8:01 PM, Felipe Balbi wrote:
> On Mon, Apr 28, 2014 at 09:40:20AM +0530, George Cherian wrote:
>> CPTS refclk name is hardcoded, which makes it fail in case of DRA7x
>> Remove the hardcoded clock name for CPTS refclk and get the same from DT.
>>
>> Signed-off-by: George Cherian <george.cherian@ti.com>
>> ---
>>   drivers/net/ethernet/ti/cpts.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
>> index 2435139..0b6f6f7 100644
>> --- a/drivers/net/ethernet/ti/cpts.c
>> +++ b/drivers/net/ethernet/ti/cpts.c
>> @@ -236,13 +236,11 @@ static void cpts_overflow_check(struct work_struct *work)
>>   	schedule_delayed_work(&cpts->overflow_work, CPTS_OVERFLOW_PERIOD);
>>   }
>>   
>> -#define CPTS_REF_CLOCK_NAME "cpsw_cpts_rft_clk"
>> -
>> -static void cpts_clk_init(struct cpts *cpts)
>> +static void cpts_clk_init(struct device *dev, struct cpts *cpts)
>>   {
>> -	cpts->refclk = clk_get(NULL, CPTS_REF_CLOCK_NAME);
>> +	cpts->refclk = devm_clk_get(dev, "cpts");
>>   	if (IS_ERR(cpts->refclk)) {
>> -		pr_err("Failed to clk_get %s\n", CPTS_REF_CLOCK_NAME);
>> +		pr_err("Failed to get cpts refclk\n");
> now you have a dev pointer as argument, how about converting this to
> dev_err() ?
Yep will do.. in next version.


-- 
-George
