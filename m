Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EC6C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:47:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16802087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="axHNV6Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16802087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nncPoL82pqJaC7+9JDcZN0FdMyUjkHvon8544g0nmV8=; b=axHNV6Sm+FKoIPWvmxsfRXB6J
	I6PejPrq0uf0VNsr8n71KYyA4LVs6Ysz6Niv5UgTznS7dqmhMLlxbIW0Nhn5KGexkDAel4pnjqxsz
	i+IuBUgpfzRkWsR2Gr+yhIMhl+qascNURppH74Ic8nTPnaR+5RMYUL3a+12KOlj9K84DBoIz2UR4J
	X+hlbY7/CaJ7qs5soQuZILvx2I414f1wv7e0vcwzTkQq/EzrL78JGpiayia1rUF2DiZISo8iIfHfp
	MCBQbEc1Us5OEibF92LZzVSGvVcxneWO0l98rNdhLoK3TeFa3kKC6FMJYhfCzoZIakSCIYrDbB0Jb
	ypbPvCwTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotxP-0003Op-49; Wed, 30 Jan 2019 17:47:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotxL-0003O3-Vc
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:47:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE9C80D;
 Wed, 30 Jan 2019 09:47:23 -0800 (PST)
Received: from [10.37.12.221] (unknown [10.37.12.221])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385933F557;
 Wed, 30 Jan 2019 09:47:19 -0800 (PST)
Subject: Re: [PATCH v2 3/7] coresight: Use event attributes for sink selection
To: mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
 <20190122181144.26645-4-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5ce969d1-847f-cc89-a074-1697e21ce6e5@arm.com>
Date: Wed, 30 Jan 2019 17:49:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190122181144.26645-4-mathieu.poirier@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_094724_025055_027A1CEA 
X-CRM114-Status: GOOD (  28.61  )
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
 alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com,
 ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/22/2019 06:11 PM, Mathieu Poirier wrote:
> This patch uses the information conveyed by perf_event::attr::config2
> to select a sink to use for the session.  That way a sink can easily be
> selected to be used by more than one source, something that isn't currently
> possible with the sysfs implementation.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-etm-perf.c  | 24 ++++++------
>   drivers/hwtracing/coresight/coresight-priv.h  |  1 +
>   drivers/hwtracing/coresight/coresight.c       | 39 +++++++++++++++++++
>   3 files changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index c68a0036532c..ea031eb673b3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -31,11 +31,14 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>   PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
>   PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
>   PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
> +/* Sink ID - same for all ETMs */
> +PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
>   
>   static struct attribute *etm_config_formats_attr[] = {
>   	&format_attr_cycacc.attr,
>   	&format_attr_timestamp.attr,
>   	&format_attr_retstack.attr,
> +	&format_attr_sinkid.attr,
>   	NULL,
>   };
>   
> @@ -191,6 +194,7 @@ static void etm_free_aux(void *data)
>   static void *etm_setup_aux(struct perf_event *event, void **pages,
>   			   int nr_pages, bool overwrite)
>   {
> +	u32 id;
>   	int cpu = event->cpu;
>   	cpumask_t *mask;
>   	struct coresight_device *sink;
> @@ -201,18 +205,14 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
> +	/* First get the selected sink from user space. */
> +	if (event->attr.config2) {
> +		id = (u32)event->attr.config2;
> +		sink = coresight_get_sink_by_id(id);
> +	} else {
> +		sink = coresight_get_enabled_sink(true);
> +	}
> +
>   	if (!sink || !sink_ops(sink)->alloc_buffer)
>   		goto err;
>   
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 579f34943bf1..b936c6d7e13f 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
>   int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
>   struct coresight_device *coresight_get_sink(struct list_head *path);
>   struct coresight_device *coresight_get_enabled_sink(bool reset);
> +struct coresight_device *coresight_get_sink_by_id(u32 id);
>   struct list_head *coresight_build_path(struct coresight_device *csdev,
>   				       struct coresight_device *sink);
>   void coresight_release_path(struct list_head *path);
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index d7fa90be6f42..c5f2df186a19 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -11,6 +11,7 @@
>   #include <linux/err.h>
>   #include <linux/export.h>
>   #include <linux/slab.h>
> +#include <linux/stringhash.h>
>   #include <linux/mutex.h>
>   #include <linux/clk.h>
>   #include <linux/coresight.h>
> @@ -541,6 +542,44 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
>   	return dev ? to_coresight_device(dev) : NULL;
>   }
>   
> +static int coresight_sink_by_id(struct device *dev, void *data)
> +{
> +	struct coresight_device *csdev = to_coresight_device(dev);
> +	u32 hash;
> +
> +	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> +	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> +		/*
> +		 * See function etm_perf_sink_name_show() to know where this
> +		 * comes from.
> +		 */
> +		hash = hashlen_hash(hashlen_string(NULL, dev_name(dev)));
> +
> +		if (hash == (*(u32 *)data))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * coresight_get_sink_by_id - returns the sink that matches the id
> + * @id: Id of the sink to match
> + *
> + * The name of a sink is unique, whether it is found on the AMBA bus or
> + * otherwise.  As such the hash of that name can easily be used to identify
> + * a sink.
> + */
> +struct coresight_device *coresight_get_sink_by_id(u32 id)
> +{
> +	struct device *dev = NULL;
> +
> +	dev = bus_find_device(&coresight_bustype, NULL, &id,
> +			      coresight_sink_by_id);
> +
> +	return dev ? to_coresight_device(dev) : NULL;
> +}
> +

The patch looks good to me. As mentioned in the previous patch, we may
be able to optimize the look up a bit using dev_ext_attribute. Either
way,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
