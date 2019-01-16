Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:36:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9723206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q59NphOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9723206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1xzJU7HU95oI0DnR3wactUk8mwlSEhwZb0yjlzX/WG4=; b=Q59NphOV+0zmXJ1hvh82WMMsQ
	iLEsn36N/EtLXbXDgQ8MZuo/hnundDyo2C06aGvbEpgh9/kZ/QpJUc0sktM4N5ciAKOgTrXXf1m0C
	uSGexJkeNrW0g2wXWQ8dp+jsVRfd2j841gwjG0s4YxwR9fzSjhGHtZJ4G4uU4ygNSAtxaw78P4SuZ
	0CtzA1cX5JXLiFUxjrwRo+uN6CrL5CGnRglM5xl4PXPuUBQ7B2YEkiBtRXaTteDlW99ntSF+yoEfL
	cCX4oWXC2cecXoyOtqiQuZHEbFRyQbQWWTCPfgWd3fXzTKpE30d2g1Hsp1DoImqp8ieDm9WNXtPRw
	0qK2xKbhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiYU-0000Nt-Lg; Wed, 16 Jan 2019 10:36:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiYR-0000N9-S3
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:36:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7399AA78;
 Wed, 16 Jan 2019 02:36:12 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C9523F5AF;
 Wed, 16 Jan 2019 02:36:09 -0800 (PST)
Subject: Re: [PATCH 3/7] coresight: Use event attributes for sink selection
To: mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org,
 gregkh@linuxfoundation.org
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-4-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b688e813-a3a3-011a-a0b1-0eeeffe8816d@arm.com>
Date: Wed, 16 Jan 2019 10:36:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115230742.13730-4-mathieu.poirier@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_023615_920253_0AF93756 
X-CRM114-Status: GOOD (  26.23  )
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
 jolsa@redhat.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

On 15/01/2019 23:07, Mathieu Poirier wrote:
> This patch uses the information conveyed by perf_event::attr::config2
> to select a sink to use for the session.  That way a sink can easily be
> selected to be used by more than one source, something that isn't currently
> possible with the sysfs implementation.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++------
>   drivers/hwtracing/coresight/coresight-priv.h  |  1 +
>   drivers/hwtracing/coresight/coresight.c       | 39 +++++++++++++++++++
>   3 files changed, 44 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 292bd409a68c..685d16001d0b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -201,18 +201,10 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
> +	sink = coresight_get_sink_by_id(event->attr.config2);

Please could we also expose this information under "format", so that the
userspace knows where to fill in the sink id ? The other advantage is, we
could always change the size of the sink_id with the above, if we decide
to do something different with the sinks.

And also, I think this should be :

	if (event->attr.config2) {
		sink = coresight_get_sink_by_id(event->attr.config2)
		if (!sink)
			return -ENODEV;
	} else {
		sink = coresight_get_enabled_sink(true);
	}
So that we don't fallback to an enabled sink when a sink id is explicitly
specified ?

> +	if (!sink)
> +		sink = coresight_get_enabled_sink(true);
>   	if (!sink || !sink_ops(sink)->alloc_buffer)
>   		goto err;
>   
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 579f34943bf1..071bb98d358f 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
>   int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
>   struct coresight_device *coresight_get_sink(struct list_head *path);
>   struct coresight_device *coresight_get_enabled_sink(bool reset);
> +struct coresight_device *coresight_get_sink_by_id(u64 id);
>   struct list_head *coresight_build_path(struct coresight_device *csdev,
>   				       struct coresight_device *sink);
>   void coresight_release_path(struct list_head *path);
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 526f122a38ee..7e2ce0beb2a0 100644
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
> +	unsigned long hash;
> +
> +	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> +	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> +		/*
> +		 * See function etm_perf_sink_name_show() to know where this
> +		 * comes from.
> +		 */
> +		hash = hashlen_hash(hashlen_string(NULL, dev_name(dev)));
> +
> +		if (hash == (*(unsigned long *)data))
> +			return 1;

nit: is it worth storing the sink_id of a sink in the csdev ? May be if we add
attribute field to the csdev (as mentioned in the previous patch), we could
simply use it here to compare.

Rest looks fine to me.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
