From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 02 Mar 2018 09:29:43 +0900
Subject: [PATCH v5 6/6] drm/bridge/sii8620: use micro-USB cable
 detection logic to detect MHL
In-Reply-To: <54edf1d7-056f-ad75-4d94-e1efa2ffdc1c@samsung.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071142eucas1p10203dac2558db034a4a3287220213601@eucas1p1.samsung.com>
 <20180227071134.28063-7-a.hajda@samsung.com> <5A953C21.5020007@samsung.com>
 <87dd3281-0471-ab2a-90c6-3f2d4bdf4750@samsung.com>
 <5A95DB2B.6000003@samsung.com>
 <54edf1d7-056f-ad75-4d94-e1efa2ffdc1c@samsung.com>
Message-ID: <5A989AF7.50704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018? 02? 28? 22:44, Andrzej Hajda wrote:
> On 27.02.2018 23:26, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018? 02? 27? 21:05, Andrzej Hajda wrote:
>>> On 27.02.2018 12:08, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 2018? 02? 27? 16:11, Andrzej Hajda wrote:
>>>>> From: Maciej Purski <m.purski@samsung.com>
>>>>>
>>>>> Currently MHL chip must be turned on permanently to detect MHL cable. It
>>>>> duplicates micro-USB controller's (MUIC) functionality and consumes
>>>>> unnecessary power. Lets use extcon attached to MUIC to enable MHL chip
>>>>> only if it detects MHL cable.
>>>>>
>>>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>>> ---
>>>>> v5: updated extcon API
>>>>>
>>>>> This is rework of the patch by Maciej with following changes:
>>>>> - use micro-USB port bindings to get extcon, instead of extcon property,
>>>>> - fixed remove sequence,
>>>>> - fixed extcon get state logic.
>>>>>
>>>>> Code finding extcon node is hacky IMO, I guess ultimately it should be done
>>>>> via some framework (maybe even extcon), or at least via helper, I hope it
>>>>> can stay as is until the proper solution will be merged.
>>>>>
>>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>>> ---
>>>>>  drivers/gpu/drm/bridge/sil-sii8620.c | 97 ++++++++++++++++++++++++++++++++++--
>>>>>  1 file changed, 94 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
>>>>> index 9e785b8e0ea2..62b0adabcac2 100644
>>>>> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
>>>>> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
>>>>> @@ -17,6 +17,7 @@
>>>>>  
>>>>>  #include <linux/clk.h>
>>>>>  #include <linux/delay.h>
>>>>> +#include <linux/extcon.h>
>>>>>  #include <linux/gpio/consumer.h>
>>>>>  #include <linux/i2c.h>
>>>>>  #include <linux/interrupt.h>
>>>>> @@ -25,6 +26,7 @@
>>>>>  #include <linux/list.h>
>>>>>  #include <linux/module.h>
>>>>>  #include <linux/mutex.h>
>>>>> +#include <linux/of_graph.h>
>>>>>  #include <linux/regulator/consumer.h>
>>>>>  #include <linux/slab.h>
>>>>>  
>>>>> @@ -81,6 +83,10 @@ struct sii8620 {
>>>>>  	struct edid *edid;
>>>>>  	unsigned int gen2_write_burst:1;
>>>>>  	enum sii8620_mt_state mt_state;
>>>>> +	struct extcon_dev *extcon;
>>>>> +	struct notifier_block extcon_nb;
>>>>> +	struct work_struct extcon_wq;
>>>>> +	int cable_state;
>>>>>  	struct list_head mt_queue;
>>>>>  	struct {
>>>>>  		int r_size;
>>>>> @@ -2175,6 +2181,77 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>>>>>  	ctx->rc_dev = rc_dev;
>>>>>  }
>>>>>  
>>>>> +static void sii8620_cable_out(struct sii8620 *ctx)
>>>>> +{
>>>>> +	disable_irq(to_i2c_client(ctx->dev)->irq);
>>>>> +	sii8620_hw_off(ctx);
>>>>> +}
>>>>> +
>>>>> +static void sii8620_extcon_work(struct work_struct *work)
>>>>> +{
>>>>> +	struct sii8620 *ctx =
>>>>> +		container_of(work, struct sii8620, extcon_wq);
>>>>> +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
>>>>> +
>>>>> +	if (state == ctx->cable_state)
>>>>> +		return;
>>>>> +
>>>>> +	ctx->cable_state = state;
>>>>> +
>>>>> +	if (state > 0)
>>>>> +		sii8620_cable_in(ctx);
>>>>> +	else
>>>>> +		sii8620_cable_out(ctx);
>>>>> +}
>>>>> +
>>>>> +static int sii8620_extcon_notifier(struct notifier_block *self,
>>>>> +			unsigned long event, void *ptr)
>>>>> +{
>>>>> +	struct sii8620 *ctx =
>>>>> +		container_of(self, struct sii8620, extcon_nb);
>>>>> +
>>>>> +	schedule_work(&ctx->extcon_wq);
>>>>> +
>>>>> +	return NOTIFY_DONE;
>>>>> +}
>>>>> +
>>>>> +static int sii8620_extcon_init(struct sii8620 *ctx)
>>>>> +{
>>>>> +	struct extcon_dev *edev;
>>>>> +	struct device_node *musb, *muic;
>>>>> +	int ret;
>>>>> +
>>>>> +	/* get micro-USB connector node */
>>>>> +	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
>>>>> +	/* next get micro-USB Interface Controller node */
>>>>> +	muic = of_get_next_parent(musb);
>>>>> +
>>>>> +	if (!muic) {
>>>>> +		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +	edev = extcon_find_edev_by_node(muic);
>>>>> +	of_node_put(muic);
>>>>> +	if (IS_ERR(edev)) {
>>>>> +		if (PTR_ERR(edev) == -EPROBE_DEFER)
>>>>> +			return -EPROBE_DEFER;
>>>>> +		dev_err(ctx->dev, "Invalid or missing extcon\n");
>>>>> +		return PTR_ERR(edev);
>>>>> +	}
>>>>> +
>>>>> +	ctx->extcon = edev;
>>>>> +	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
>>>>> +	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
>>>>> +	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
>>>> You better to use devm_extcon_register_notifier().
>>> With devm version I risk that in case of device unbind notification will
>>> be called after .remove callback, it seems to me quite dangerous. Or am
>>> I missing something?
>> If you use the cancel_work_sync() in remove() instead of flush_work(),
>> you can use the 'devm_extcon_*'.
> 
> cancel_work_sync() does not prevent works scheduled later from execution
> [1] and this scenario is possible with devm_extcon_register_notifier()
> and cancel_work_sync().
> So we end up with:
>     sii8620_remove() calls cancel_work_sync()
> ...
>     notifier(called asynchronously) schedules sii8620_extcon_work()
> ...
>     notifier is removed by devm framework
>     sii8620 context is destroyed by devm framework
> ...
>     sii8620_extcon_work is executed on destroyed context !!! BUG !!!
> 
> For me it seems that devm_extcon_register_notifier is not safe in this case.
> 
> [1]: Since documentation was not clear I have performed live test
> confirming my suspicions.

You're right. Sorry for confusion.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
