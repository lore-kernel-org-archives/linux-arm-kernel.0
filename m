From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 10 Jan 2017 07:38:44 -0700
Subject: [PATCH] usb: dwc3-exynos fix unspecified suspend clk error
 handling
In-Reply-To: <82fb5295-6640-7e9e-a42a-4067aa88e5b4@cogentembedded.com>
References: <20170110022131.31042-1-shuahkh@osg.samsung.com>
 <82fb5295-6640-7e9e-a42a-4067aa88e5b4@cogentembedded.com>
Message-ID: <0d750439-b625-2c5f-c716-f587670e2786@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2017 04:20 AM, Sergei Shtylyov wrote:
> Hello!
> 
> On 01/10/2017 05:21 AM, Shuah Khan wrote:
> 
>> Fix dwc3_exynos_probe() to call clk_prepare_enable() only when suspend
>> clock is specified. Call clk_disable_unprepare() from remove and probe
>> error path only when susp_clk has been set from remove and probe error
>> paths.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  drivers/usb/dwc3/dwc3-exynos.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>> index e27899b..f97a3d7 100644
>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>> @@ -131,8 +131,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>      if (IS_ERR(exynos->susp_clk)) {
>>          dev_info(dev, "no suspend clk specified\n");
>>          exynos->susp_clk = NULL;
>> -    }
>> -    clk_prepare_enable(exynos->susp_clk);
>> +    } else
>> +        clk_prepare_enable(exynos->susp_clk);
> 
>    CodingStyle: need {} here as well since another branch has them.
> 
> [...]
> 
> MBR, Sergei
> 

Thanks. There is some concerns whether or not this patch is needed.
If we decide to include the patch, I will send v2 with your comment.

thanks,
-- Shuah
