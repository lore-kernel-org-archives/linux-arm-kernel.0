Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B7C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:00:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E4F20854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mlFNp/J1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Gyl0oqkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E4F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K2hV5dqD7c9wT3/k83lioiDGlbjVcLP6WbgjtPRBxC0=; b=mlFNp/J13yKBja
	rAQYayzwMGA3qdny2/1QwxUOGpQEF//DkT+a7gC5osfI4yF/Hn4aPv3H7oeJFBnCQBC/grDToo2x5
	AC268cVQFl852UknijOgiwiMFw0A2HIHLW7BL11WfUdiNxPCK6U/z9m42lLM7ApGZKla2rdotFl6d
	IR9SSlUWn5a7rrorXxGrGRN1UpOGkOYNkedEROhNgAmF8Q1NomehzQrNntsYiZVhPBfqkWRrLlY6Y
	M4j4ZARia/tduR64g07x28vYLsv+++PQQGeGp725S6ExYLX+CA6X2/KmMssFpbtyjBzJinvQjg/l8
	zWkgDidUFXMXILx/yXcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glrub-0005cV-5U; Tue, 22 Jan 2019 09:00:01 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glruX-0005bf-HA
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 08:59:59 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 65AFE5C1869;
 Tue, 22 Jan 2019 09:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1548147592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34pKV0yV+V0SIokoQwQR8ivL4IXCi+WSHju/feFhZrA=;
 b=Gyl0oqkSEjjq1B6MJpa5CuCjmGB5RPr+eLz42q8smIbpo4WD36JZHjgayX1m9DSKva/4eN
 jobvgw7VDNNchrWwMQBEia0QlovN+3iFcwavGNokfQFITx8FoyKncSPaGba5bwD/UkkrCp
 pw6HK1ygUtoDSOe/OELozVT99Zq1Vfo=
MIME-Version: 1.0
Date: Tue, 22 Jan 2019 09:59:49 +0100
From: Stefan Agner <stefan@agner.ch>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] drivers/perf: handle multiple CPUs with single interrupts
In-Reply-To: <20190121172325.GD47506@lakrids.cambridge.arm.com>
References: <20190121144111.22716-1-stefan@agner.ch>
 <20190121172325.GD47506@lakrids.cambridge.arm.com>
Message-ID: <730dcd70a60efc0756570153b6ea84d2@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_005957_862282_6F7E7F62 
X-CRM114-Status: GOOD (  29.94  )
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
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21.01.2019 18:23, Mark Rutland wrote:
> Hi Stefan,
> 
> On Mon, Jan 21, 2019 at 03:41:11PM +0100, Stefan Agner wrote:
>> Currently, if only a single interrupt is available, the code assigns
>> this single interrupt to the first CPU. All other CPUs are left
>> unsupported. This allows to use perf events only on processes using
>> the first CPU. This is not obvious to the user.
>>
>> Instead, disable interrupts but support all CPUs. This allows to use
>> the PMU on all CPUs for all events other than sampling events which do
>> require interrupt support.
> 
> Even for non-sampling events we use the overflow interrupt to ensure
> that we don't lose count across overflows, and without that interrupt,
> we cannot guarantee that the results are accurate.
> 
> For example:
> 
> 	Program counter to 0
> 	Start program
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	Stop program
> 	Counter reads as 5
> 
> 
> ... which we cannot distinguish from:
> 
> 	Program counter to 0
> 	Start program
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	< counter overflows, no interrupt >
> 	Stop program
> 	Counter reads as 5
> 
> ... and thus cannot provide any reasonable confidence in results.

Oh ok I see, this is not what we want at all!

Currently we register that one IRQ for CPU0. So what happens today is:

 	Program counter to 0
 	Start program
        < program scheduled on CPU0 >
 	< counter overflows, interrupt >
        < program scheduled on CPU1 >
 	< counter overflows, no interrupt >
 	< counter overflows, no interrupt >
 	Stop program
 	Counter reads as 5

Which is off too...

I could also reproduce this by manually moving the process between
CPU0/1...

We probably should not probe the driver at all then? It seems rather
unwise to provide users PMU data which might be plain wrong.

> 
> In theory, we could use a hrtimer to periodically refresh the events to
> prevent this, but this would need to be set at some very high frequency
> to account for the fastest potential counter, and would significantly
> degrade performance.
> 
> I don't think that's going to be reliable, and given that, I don't think
> that we can support muxed IRQs in this way.

Is it possible to get the overflow interrupts as well as read the PMU
counters for another CPU?

If not, I assume the interrupt bounce mechanism from ux500 is the only
way?

--
Stefan

> 
> Thanks,
> Mark.
> 
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> This has been observed and tested on a i.MX 6DualLite, but is probably
>> valid for i.MX 6Quad as well.
>>
>> It seems that ux500 once had support for single IRQ on a SMP system,
>> however this got removed with:
>> Commit 2b05f6ae1ee5 ("ARM: ux500: remove PMU IRQ bouncer")
>>
>> I noticed that with this patch I get an error when trying to use perf stat:
>>   # perf top
>>   Error:
>>   cycles: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>>
>> Without this patch perf top seems to work, but it seems not to use any
>> sampling events (?):
>>   # perf top
>> PerfTop:    7215 irqs/sec  kernel:100.0%  exact:  0.0% [4000Hz cpu-clock:pppH], (all, 2 CPUs)
>> ....
>>
>> Also starting perf top and explicitly selecting cpu-clock seems to work
>> and show the same data as before this change.
>>   # perf top -e cpu-clock:pppH
>> PerfTop:    7214 irqs/sec  kernel:100.0%  exact:  0.0% [4000Hz cpu-clock:pppH], (all, 2 CPUs)
>>
>> It seems that perf top falls back to cpu-clock in the old case, but not
>> once sampling events are not supported...
>>
>> --
>> Stefan
>>
>>
>>  drivers/perf/arm_pmu_platform.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
>> index 933bd8410fc2..80b991417b6e 100644
>> --- a/drivers/perf/arm_pmu_platform.c
>> +++ b/drivers/perf/arm_pmu_platform.c
>> @@ -105,23 +105,26 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>>  		return num_irqs;
>>  	}
>>
>> +	if (num_irqs == 1) {
>> +		int irq = platform_get_irq(pdev, 0);
>> +		if (irq && irq_is_percpu_devid(irq))
>> +			return pmu_parse_percpu_irq(pmu, irq);
>> +	}
>> +
>>  	/*
>>  	 * In this case we have no idea which CPUs are covered by the PMU.
>>  	 * To match our prior behaviour, we assume all CPUs in this case.
>> +	 * Multiple CPUs with a single PMU irq are currently not handled.
>> +	 * Rather than supporting only the first CPU, support all CPUs but
>> +	 * without interrupt capability.
>>  	 */
>> -	if (num_irqs == 0) {
>> -		pr_warn("no irqs for PMU, sampling events not supported\n");
>> +	if (num_irqs == 0 || (nr_cpu_ids > 1 && num_irqs == 1)) {
>> +		pr_info("No per CPU irqs for PMU, sampling events not supported\n");
>>  		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
>>  		cpumask_setall(&pmu->supported_cpus);
>>  		return 0;
>>  	}
>>
>> -	if (num_irqs == 1) {
>> -		int irq = platform_get_irq(pdev, 0);
>> -		if (irq && irq_is_percpu_devid(irq))
>> -			return pmu_parse_percpu_irq(pmu, irq);
>> -	}
>> -
>>  	if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(pdev->dev.of_node)) {
>>  		pr_warn("no interrupt-affinity property for %pOF, guessing.\n",
>>  			pdev->dev.of_node);
>> --
>> 2.20.1
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
