Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C15C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:03:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1507320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O29TPKBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1507320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mUmsfyATwYJwvjnbhT/K+AkY7+Sirbgu7BLXQqoCd7w=; b=O29TPKBmt8l4Ji
	ek88gHMolQGOChjWa9f0ulHpYI/vABWXFfVEJiyY/o2ZbAmCQkvowSARXbsCrEE2S39ytm6ONPWVG
	Xv10GLj87sIO1n1Eha8VUeImIQXf+rbVp/WVWWlgtl8cRbY9kvFoWpVZpPk93a9A+8dc/0BTtpoq3
	PvdN/S0v5hdF0IKHcF2ypeXTWxXhLjvYAD99OGIh4Pg4WTlBLmY3nxsvJvSMDeZ4IXD8QZWwZxBn6
	RR3MqTzQl7M3i7GjKnRh4iKnSeTD2aGGe+J1y2vsv8VxhPJY6BKj51EaoCIYhE27XGO5cIq1oThdl
	uFAICq6UzBcZTkw0GReQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUMX8-0002ST-0z; Wed, 05 Dec 2018 02:03:26 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUMX4-0002On-9X
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 02:03:24 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C58A3B2F8FC19;
 Wed,  5 Dec 2018 10:03:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.210) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Dec 2018
 10:02:55 +0800
Subject: Re: [PATCH v7 22/25] ACPI / APEI: Kick the memory_failure() queue for
 synchronous errors
To: James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-23-james.morse@arm.com>
From: Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <9d153a07-aa7a-6e0c-3bd3-994a66f9639a@huawei.com>
Date: Wed, 5 Dec 2018 10:02:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20181203180613.228133-23-james.morse@arm.com>
X-Originating-IP: [10.177.19.210]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_180322_519815_D1500C68 
X-CRM114-Status: GOOD (  29.20  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will
 Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>,
 Wang Xiongfeng <wangxiongfeng2@huawei.com>, linux-acpi@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James & Boris,

On 2018/12/4 2:06, James Morse wrote:
> memory_failure() offlines or repairs pages of memory that have been
> discovered to be corrupt. These may be detected by an external
> component, (e.g. the memory controller), and notified via an IRQ.
> In this case the work is queued as not all of memory_failure()s work
> can happen in IRQ context.
> 
> If the error was detected as a result of user-space accessing a
> corrupt memory location the CPU may take an abort instead. On arm64
> this is a 'synchronous external abort', and on a firmware first
> system it is replayed using NOTIFY_SEA.
> 
> This notification has NMI like properties, (it can interrupt
> IRQ-masked code), so the memory_failure() work is queued. If we
> return to user-space before the queued memory_failure() work is
> processed, we will take the fault again. This loop may cause platform
> firmware to exceed some threshold and reboot when Linux could have
> recovered from this error.
> 
> If a ghes notification type indicates that it may be triggered again
> when we return to user-space, use the task-work and notify-resume
> hooks to kick the relevant memory_failure() queue before returning
> to user-space.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> current->mm == &init_mm ? I couldn't find a helper for this.
> The intent is not to set TIF flags on kernel threads. What happens
> if a kernel-thread takes on of these? Its just one of the many
> not-handled-very-well cases we have already, as memory_failure()
> puts it: "try to be lucky".
> 
> I assume that if NOTIFY_NMI is coming from SMM it must suffer from
> this problem too.
> ---
>  drivers/acpi/apei/ghes.c | 65 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 6cbf9471b2a2..3e7da9243153 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -47,6 +47,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/uuid.h>
>  #include <linux/ras.h>
> +#include <linux/task_work.h>
>  
>  #include <acpi/actbl1.h>
>  #include <acpi/ghes.h>
> @@ -136,6 +137,26 @@ static atomic_t ghes_estatus_cache_alloced;
>  
>  static int ghes_panic_timeout __read_mostly = 30;
>  
> +static bool ghes_is_synchronous(struct ghes *ghes)
> +{
> +	switch (ghes->generic->notify.type) {
> +	case ACPI_HEST_NOTIFY_NMI:	/* fall through */
> +	case ACPI_HEST_NOTIFY_SEA:
> +		/*
> +		 * These notifications could be repeated if the interrupted
> +		 * instruction is run again. e.g. a read of bad-memory causing
> +		 * a trap to platform firmware.
> +		 */
> +		return true;
> +	default:
> +		/*
> +		 * Other notifications are asynchronous, and not related to the
> +		 * interrupted instruction. e.g. an IRQ.
> +		 */
> +		return false;
> +	}
> +}
> +
>  static void __iomem *ghes_map(u64 pfn, int fixmap_idx)
>  {
>  	phys_addr_t paddr;
> @@ -379,14 +400,33 @@ static void ghes_clear_estatus(struct acpi_hest_generic_status *estatus,
>  				      fixmap_idx);
>  }
>  
> -static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
> +struct ghes_memory_failure_work {
> +	int cpu;
> +	struct callback_head work;
> +};
> +
> +static void ghes_kick_memory_failure(struct callback_head *head)
> +{
> +	struct ghes_memory_failure_work *callback;
> +
> +	callback = container_of(head, struct ghes_memory_failure_work, work);
> +	memory_failure_queue_kick(callback->cpu);
> +	kfree(callback);
> +}
> +
> +static void ghes_handle_memory_failure(struct ghes *ghes,
> +				       struct acpi_hest_generic_data *gdata,
> +				       int sev)
>  {
> -#ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
>  	unsigned long pfn;
> -	int flags = -1;
> +	int flags = -1, ret;
> +	struct ghes_memory_failure_work	*callback;
>  	int sec_sev = ghes_severity(gdata->error_severity);
>  	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
>  
> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
> +		return;
> +
>  	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>  		return;
>  
> @@ -407,7 +447,22 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>  
>  	if (flags != -1)
>  		memory_failure_queue(pfn, flags);

We may need to take MF_ACTION_REQUIRED flags for memory_failure() in SEA condition.
And there is no return value check for memory_failure() in memory_failure_work_func(),
I'm not sure whether we need to check the return value.

static void memory_failure_work_func(struct work_struct *work)
{
        struct memory_failure_cpu *mf_cpu;
        struct memory_failure_entry entry = { 0, };
        unsigned long proc_flags;
        int gotten;

        mf_cpu = container_of(work, struct memory_failure_cpu, work);
        for (;;) {
                spin_lock_irqsave(&mf_cpu->lock, proc_flags);
                gotten = kfifo_get(&mf_cpu->fifo, &entry);
                spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
                if (!gotten)
                        break;
                if (entry.flags & MF_SOFT_OFFLINE)
                        soft_offline_page(pfn_to_page(entry.pfn), entry.flags);
                else
                        memory_failure(entry.pfn, entry.flags);
        }
}

If the recovery fails here, we need to take other actions, such as force to send a SIGBUS signal.


> -#endif
> +
> +	/*
> +	 * If the notification indicates that it was the interrupted
> +	 * instruction that caused the error, try to kick the
> +	 * memory_failure() queue before returning to user-space.
> +	 */
> +	if (ghes_is_synchronous(ghes) && current->mm != &init_mm) {
> +		callback = kzalloc(sizeof(*callback), GFP_ATOMIC);
> +		if (!callback)
> +			return;
> +		callback->work.func = ghes_kick_memory_failure;
> +		callback->cpu = smp_processor_id();
> +		ret = task_work_add(current, &callback->work, true);
> +		if (ret)
> +			kfree(callback);
> +	}
>  }
>  
>  /*
> @@ -480,7 +535,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  			ghes_edac_report_mem_error(sev, mem_err);
>  
>  			arch_apei_report_mem_error(sev, mem_err);
> -			ghes_handle_memory_failure(gdata, sev);
> +			ghes_handle_memory_failure(ghes, gdata, sev);
>  		}
>  		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			ghes_handle_aer(gdata);
> 

-- 
Thanks,
Xie XiuQi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
