From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sat, 16 Apr 2016 20:58:49 -0400
Subject: [PATCH] i2c: exynos5: Fix possible ABBA deadlock by keeping I2C
 clock prepared
In-Reply-To: <20160416161147.GA2794@kozik-lap>
References: <1460757887-18128-1-git-send-email-javier@osg.samsung.com>
 <20160416161147.GA2794@kozik-lap>
Message-ID: <5712DFC9.8000402@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

Thanks a lot for your feedback.

On 04/16/2016 12:11 PM, Krzysztof Kozlowski wrote:
> On Fri, Apr 15, 2016 at 06:04:47PM -0400, Javier Martinez Canillas wrote:

[snip]

>>
>> Fix this by only preparing the clock on probe and {en,dis}able in the
>> rest of the driver.
>>
>> This patch is similar to commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA
>> deadlock by keeping clock prepared") that fixes the same bug in other
>> driver for an I2C controller found in Samsung SoCs.
> 
> I wish this would be fixed by introducing more granular clock locks
> (e.g. per controller) instead of implementing another workaround.
> I think this driver shouldn't care about this deadlock... although I see
> that this is the simplest solution for now.
>

Agreed, but that would be a much intrusive core change affecting every single
platform so I didn't feel brave enough to attempt it :)

But regardless of the ABBA deadlock, there are reasons why the clk API is
split into an {,un}prepare and {en,dis}able functions (e.g: non-atomic vs
atomic) and it is a common pattern for drivers to prepare the clock(s) on
setup (i.e: probe), unprepare on driver removal, and just {en,dis}able the
clock(s) during runtime.

So I believe this patch is good on its own and at least makes the driver more
consistent with most I2C controller drivers that do the same w.r.t clocks. The
fact that the deadlock is fixed by this change is just a nice side effect IMHO.

[snip]

>> @@ -810,6 +816,8 @@ static int exynos5_i2c_remove(struct platform_device *pdev)
>>  
>>  	i2c_del_adapter(&i2c->adap);
>>  
>> +	clk_unprepare(i2c->clk);
>> +
>>  	return 0;
>>  }
> 
> Please unprepare the clock when suspending. There is no point of having
> it prepared in that level.
>

Yes, I in fact thought the same when writing the patch but was reluctant to
change the prepared state in suspend because I don't have a way to test the
S2R path in this board due broken firmware that prevents the cores to enter
into deep sleep states (I believe is the same issue we faced with CPUidle).

But I'll do the change that you suggested since I agree with you.

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
