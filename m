From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 24 Sep 2013 10:34:03 +0300
Subject: [PATCH] video: mmp: drop needless devm cleanup
In-Reply-To: <20130923161944.GU12758@n2100.arm.linux.org.uk>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130923161944.GU12758@n2100.arm.linux.org.uk>
Message-ID: <5241406B.8090106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/13 19:19, Russell King - ARM Linux wrote:
> On Mon, Sep 23, 2013 at 06:13:10PM +0200, Uwe Kleine-K?nig wrote:
>> The nice thing about devm_* is that the driver doesn't need to free the
>> resources but the driver core takes care about that. This also
>> simplifies the error path quite a bit and removes the wrong check for a
>> clock pointer being NULL.
>>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> ---
>>  drivers/video/mmp/hw/mmp_ctrl.c | 17 ++---------------
>>  1 file changed, 2 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
>> index 75dca19..6ac7552 100644
>> --- a/drivers/video/mmp/hw/mmp_ctrl.c
>> +++ b/drivers/video/mmp/hw/mmp_ctrl.c
>> @@ -514,7 +514,7 @@ static int mmphw_probe(struct platform_device *pdev)
>>  	if (IS_ERR(ctrl->clk)) {
>>  		dev_err(ctrl->dev, "unable to get clk %s\n", mi->clk_name);
>>  		ret = -ENOENT;
>> -		goto failed_get_clk;
>> +		goto failed;
>>  	}
>>  	clk_prepare_enable(ctrl->clk);
>>  
>> @@ -551,21 +551,8 @@ failed_path_init:
>>  		path_deinit(path_plat);
>>  	}
>>  
>> -	if (ctrl->clk) {
>> -		devm_clk_put(ctrl->dev, ctrl->clk);
>> -		clk_disable_unprepare(ctrl->clk);
> 
> And this patch also fixes the above: disabling/unpreparing _after_ putting
> the thing - which was quite silly... :)

Hmm, I wonder if that causes any issues... I.e. should this patch go for
3.12, or is 3.13 fine?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/c25c927b/attachment-0001.sig>
