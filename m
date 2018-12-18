Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50434C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:14:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211CF217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KT1Gc46x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211CF217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C2JshMgjvwOOHmreIUBj9mXsOLtkctPZWKVCrkKE2AY=; b=KT1Gc46x69u9COpgZHdzag+sK
	rS23SXx1phS9S4w3DWCBo0OSJiOJyYeDURdals9cwWG4wRDrdsPEYLP8ZG4Ta3IDVbwRi/ZOa/gmD
	Dg6zONraOg0KQjF7ZIhlImvlUytU/fQ6Lh3FmCpV1GNDPjWxl2SQGZhMCg5DTUf6oTttRBAr+dLD3
	skYZD3mBPY/4VCe+mZj9DlO3L1G3EL+VOdOlDHlMaH3aJzsuiANY/j7AAZ55YhipydaS7Wjr+2K9E
	c5PIO+pi5Nn/yDMBemEmjBGPPWNseHQbjec1Iui+TTsme62pY2NIcLLh5XfpOmXnKwKIlTqLHhg82
	gURtDt/tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZG8l-0007yW-JC; Tue, 18 Dec 2018 14:14:31 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZG8h-0007wD-IC
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:14:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7091480D;
 Tue, 18 Dec 2018 06:14:15 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 442BB3F675;
 Tue, 18 Dec 2018 06:14:12 -0800 (PST)
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
To: Mathieu Poirier <mathieu.poirier@linaro.org>, acme@kernel.org,
 peterz@infradead.org, gregkh@linuxfoundation.org
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
Date: Tue, 18 Dec 2018 14:14:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_061427_609037_40FCD6E0 
X-CRM114-Status: GOOD (  30.16  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org,
 alexander.shishkin@linux.intel.com, will.deacon@arm.com,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

On 17/12/2018 17:21, Mathieu Poirier wrote:
> This patch uses the PMU driver configuration held in event::hw::drv_config
> to select a sink for each event that is created (the old sysFS way of
> working is kept around for backward compatibility).
> 
> By proceeding in this way a sink can be used by multiple sessions
> without having to play games with entries in sysFS.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 74 ++++++++++++++++++++----
>   1 file changed, 62 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f21eb28b6782..a7e1fdef07f2 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -4,6 +4,7 @@
>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>    */
>   
> +#include <linux/amba/bus.h>
>   #include <linux/coresight.h>
>   #include <linux/coresight-pmu.h>
>   #include <linux/cpumask.h>
> @@ -11,6 +12,7 @@
>   #include <linux/list.h>
>   #include <linux/mm.h>
>   #include <linux/init.h>
> +#include <linux/ioport.h>
>   #include <linux/perf_event.h>
>   #include <linux/percpu-defs.h>
>   #include <linux/slab.h>
> @@ -177,6 +179,26 @@ static void etm_free_aux(void *data)
>   	schedule_work(&event_data->work);
>   }
>   
> +static struct coresight_device *etm_drv_config_sync(struct perf_event *event)

minor nit: The name doesn't quite imply what we do here. Did you mean
s/sync/sink ?

> +{
> +	struct coresight_device *sink = NULL;
> +	struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
> +
> +	/*
> +	 * Make sure we don't race with perf_drv_config_replace() in
> +	 * kernel/events/core.c.
> +	 */
> +	raw_spin_lock(&drv_config->lock);
> +
> +	/* Copy what we got from user space if applicable. */
> +	if (drv_config->config)
> +		sink = drv_config->config;
> +
> +	raw_spin_unlock(&drv_config->lock);
> +
> +	return sink;
> +}
> +
>   static void *etm_setup_aux(struct perf_event *event, void **pages,
>   			   int nr_pages, bool overwrite)
>   {
> @@ -190,18 +212,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   		return NULL;
>   	INIT_WORK(&event_data->work, free_event_data);
>   
> -	/*
> -	 * In theory nothing prevent tracers in a trace session from being
> -	 * associated with different sinks, nor having a sink per tracer.  But
> -	 * until we have HW with this kind of topology we need to assume tracers
> -	 * in a trace session are using the same sink.  Therefore go through
> -	 * the coresight bus and pick the first enabled sink.
> -	 *
> -	 * When operated from sysFS users are responsible to enable the sink
> -	 * while from perf, the perf tools will do it based on the choice made
> -	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
> -	 */
> -	sink = coresight_get_enabled_sink(true);
> +	/* First get the sink config from user space. */
> +	sink = etm_drv_config_sync(event);
> +	if (!sink)
> +		sink = coresight_get_enabled_sink(true);
> +
>   	if (!sink || !sink_ops(sink)->alloc_buffer)
>   		goto err;
>   
> @@ -454,6 +469,40 @@ static void etm_addr_filters_sync(struct perf_event *event)
>   	filters->nr_filters = i;
>   }
>   
> +static int etm_drv_config_find_sink(struct device *dev, void *data)
> +{
> +	struct amba_device *adev = to_amba_device(dev->parent);
> +	struct resource *res = &adev->res;
> +	u64 value = *((u64 *)data);
> +
> +	/*
> +	 * The HW mapping of a component is unique.  If the value we've been
> +	 * given matches the component's start address, then we must have found
> +	 * the device we are looking for.
> +	 */

To be frank, I don't quite like the idea of passing the base address of the
component as the key to locate a device, (even though that is unique and readily
available). I would rather prefer a programmable way to map the keys to the
"sink" devices, which works platform agnostic (e.g, ACPI support, where the base
address is not obvious from the name). Also if we decide to use a platform
agnostic naming scheme, it becomes even more complex.

We could assign a static "id/key" exported either via the device sysfs dir or
the "pmu" dir. I prefer the latter.

Thoughts ?

And whatever we decide to choose, needs to be clearly documented under the 
Documentation/perf/cs_etm.txt.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
