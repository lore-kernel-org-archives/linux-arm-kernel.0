From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 22 Dec 2016 16:01:19 -0800
Subject: [PATCH 1/2] soc: ti: Use remoteproc auto_boot feature
In-Reply-To: <1f5b2631-f744-a5c1-55c1-82eb27d5cbd7@ti.com>
References: <1481846632-4778-1-git-send-email-spjoshi@codeaurora.org>
 <1f5b2631-f744-a5c1-55c1-82eb27d5cbd7@ti.com>
Message-ID: <9092e066-b2ad-ee42-de5f-d66b84a10cfd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On 12/21/2016 7:16 PM, Suman Anna wrote:
> Hi Sarang,
>
> On 12/15/2016 06:03 PM, Sarangdhar Joshi wrote:
>> The function wkup_m3_rproc_boot_thread waits for asynchronous
>> firmware loading to complete successfully before calling
>> rproc_boot(). The same can be achieved by just setting
>> rproc->auto_boot flag. Change this. As a result this change
>> removes wkup_m3_rproc_boot_thread and moves m3_ipc->sync_complete
>> initialization to the wkup_m3_ipc_probe().
>>
>> Other than the current usage, the firmware_loading_complete is
>> only used in rproc_del() where it's no longer needed.  This
>> change is in preparation for removing firmware_loading_complete
>> completely.
>
> Based on the comments so far, I am assuming that you are dropping this
> series.

No, may not be dropping this. Will try to handle it differently in 
rproc_del() (probably by making use of some state flag).

>
> In any case, this series did break our PM stack. We definitely don't
> want to auto-boot the wkup_m3_rproc device, that responsibility will
> need to stay with the wkup_m3_ipc driver.

Which scenario did it break? Booting up rproc device before 
wkup_m3_ipc_probe() causes issues?

Nevertheless, I think Bjorn's suggestion of just dropping the call to 
wait_for_completion() and keeping kthread looks good, also because of 
the fact that rproc_boot() anyways calls request_firmware() and no 
longer needed to wait on asynchronous loading of firmware.

Regards,
Sarang

>
> regards
> Suman
>
>>
>> CC: Dave Gerlach <d-gerlach@ti.com>
>> CC: Suman Anna <s-anna@ti.com>
>> CC: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
>> ---
>>
>> Hi Suman,
>>
>> Unfortunately, I don't have a TI device and couldn't test this
>> change. Is it possible for you to test this change on TI device?
>>
>> Thanks in advance.
>>
>> Regards,
>> Sarang
>>
>>  drivers/remoteproc/wkup_m3_rproc.c |  2 +-
>>  drivers/soc/ti/wkup_m3_ipc.c       | 35 ++---------------------------------
>>  2 files changed, 3 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
>> index 18175d0..79ea022 100644
>> --- a/drivers/remoteproc/wkup_m3_rproc.c
>> +++ b/drivers/remoteproc/wkup_m3_rproc.c
>> @@ -167,7 +167,7 @@ static int wkup_m3_rproc_probe(struct platform_device *pdev)
>>  		goto err;
>>  	}
>>
>> -	rproc->auto_boot = false;
>> +	rproc->auto_boot = true;
>>
>>  	wkupm3 = rproc->priv;
>>  	wkupm3->rproc = rproc;
>> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
>> index 8823cc8..31090d70 100644
>> --- a/drivers/soc/ti/wkup_m3_ipc.c
>> +++ b/drivers/soc/ti/wkup_m3_ipc.c
>> @@ -17,7 +17,6 @@
>>
>>  #include <linux/err.h>
>>  #include <linux/kernel.h>
>> -#include <linux/kthread.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/irq.h>
>>  #include <linux/module.h>
>> @@ -365,22 +364,6 @@ void wkup_m3_ipc_put(struct wkup_m3_ipc *m3_ipc)
>>  }
>>  EXPORT_SYMBOL_GPL(wkup_m3_ipc_put);
>>
>> -static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
>> -{
>> -	struct device *dev = m3_ipc->dev;
>> -	int ret;
>> -
>> -	wait_for_completion(&m3_ipc->rproc->firmware_loading_complete);
>> -
>> -	init_completion(&m3_ipc->sync_complete);
>> -
>> -	ret = rproc_boot(m3_ipc->rproc);
>> -	if (ret)
>> -		dev_err(dev, "rproc_boot failed\n");
>> -
>> -	do_exit(0);
>> -}
>> -
>>  static int wkup_m3_ipc_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -388,7 +371,6 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
>>  	phandle rproc_phandle;
>>  	struct rproc *m3_rproc;
>>  	struct resource *res;
>> -	struct task_struct *task;
>>  	struct wkup_m3_ipc *m3_ipc;
>>
>>  	m3_ipc = devm_kzalloc(dev, sizeof(*m3_ipc), GFP_KERNEL);
>> @@ -402,6 +384,8 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
>>  		return PTR_ERR(m3_ipc->ipc_mem_base);
>>  	}
>>
>> +	init_completion(&m3_ipc->sync_complete);
>> +
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (!irq) {
>>  		dev_err(&pdev->dev, "no irq resource\n");
>> @@ -449,25 +433,10 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
>>
>>  	m3_ipc->ops = &ipc_ops;
>>
>> -	/*
>> -	 * Wait for firmware loading completion in a thread so we
>> -	 * can boot the wkup_m3 as soon as it's ready without holding
>> -	 * up kernel boot
>> -	 */
>> -	task = kthread_run((void *)wkup_m3_rproc_boot_thread, m3_ipc,
>> -			   "wkup_m3_rproc_loader");
>> -
>> -	if (IS_ERR(task)) {
>> -		dev_err(dev, "can't create rproc_boot thread\n");
>> -		goto err_put_rproc;
>> -	}
>> -
>>  	m3_ipc_state = m3_ipc;
>>
>>  	return 0;
>>
>> -err_put_rproc:
>> -	rproc_put(m3_rproc);
>>  err_free_mbox:
>>  	mbox_free_channel(m3_ipc->mbox);
>>  	return ret;
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
