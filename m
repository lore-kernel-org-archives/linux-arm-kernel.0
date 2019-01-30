Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080FAC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:16:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFAF2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YX3F1IrU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdbWLO+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFAF2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qrH4pRE1nw8J7LgNn+c/2KfsNXNis4s9BPuGTw/VlEA=; b=YX3
	F1IrUGpvlCv4I/9k25mRzxSVLtcFbYa5aL+5VdCBaxSZUldo6SIVsfKFg143jMqOWWYk8PwMWgDAp
	eE5vjA7/Y48lBevwHDxnWsvn4oWPjwLo8Wqn27AQ1kcxMjhlVK9lQmwnsIzn4xTXtuBiUviNepLqK
	WFU+upQ4p7vGjznU9wn1bw9neWYWgRd46XUcb3m90nu2/3+Hb+DIWw0T459JOdWUgfEWJRo/WJQuu
	QXQaBZtRiVqG7CWigw6a71MIuYAK8M9osntXtu21QH48yvBOZa7An6SrUxv0F9anX3yPZ/Wb0CO3z
	n4ZmW4n80K4ZzpwQCtIueKFl7kQvewg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonr9-0000mh-Jg; Wed, 30 Jan 2019 11:16:35 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonr7-0000m3-7O
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:16:34 +0000
Received: by mail-wm1-x343.google.com with SMTP id m22so21287650wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ynD/SKO0NKYF/TZnALi5yaZz+mi8VJz9rkAXrSOgxSg=;
 b=fdbWLO+0W3s4gxf54oKHr34BvQZE1DTRv1+2imPUtVYqpY5T1J/RczVnUNU8ZucjA/
 dkxKQTvDiQ0gKZh7ri4Py9/BqT5Wtceyq9u9lrC6mQl39TVPqaybKqbovIHmD3bhVE17
 WwiHuRbEuXfbY4iZ+uLxwqNJfwCOd4UsQKCbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ynD/SKO0NKYF/TZnALi5yaZz+mi8VJz9rkAXrSOgxSg=;
 b=SNuxNxB8GlgZZnbO84lsJihSc9sLkv72dW8cNoGFZ3NxoDFr3xn93fAZHbe+TwsDQB
 WECf4jlkMX1e6Yg6ZB16/2LNpstQNjQVZltrDtO8aoqSX5KHM0JrmS3Q3kcW7pM8gt9V
 9RVlyaj7MK3PI0uYUm7KvcjpXVQFtbtps+WwMo+ylFrTMo5feaHSCsHa1lRphv4fscVR
 kBXAHSf5sGPxySVCEP+VIw7lBARGumeC7DMQCo/2CVkraEV3WMW9j+cEu0XS7wuf+KTx
 UZNMdI2rxoOxA0MtSVc+aimO5Dlv1vFGvk9g1tWo6rHUQ3S16rK03iVEy4hWByU47lQ5
 IoXQ==
X-Gm-Message-State: AJcUukdIuOUQHrkl+s3u71uEXHU2qT/ZcwjS5iOf0UeVn/2yEozEhChg
 yMR0E2apf3/nMBW2aI8a699SHg==
X-Google-Smtp-Source: ALg8bN5lST2LvgHuXidA21jm/or7QqwCfXtbdWussrt5ZKWA7LVBGL9QY2XV1K9Ny1rXX6gT1lV+4w==
X-Received: by 2002:a1c:3282:: with SMTP id
 y124mr25933459wmy.134.1548846991495; 
 Wed, 30 Jan 2019 03:16:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:79e5:6689:e4d2:d212])
 by smtp.gmail.com with ESMTPSA id p10sm4502173wmd.14.2019.01.30.03.16.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 03:16:30 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Subject: [PATCH v2 ] PM-runtime: fix deadlock with ktime
Date: Wed, 30 Jan 2019 12:16:24 +0100
Message-Id: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_031633_272044_4A3E90C7 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A deadlock has been seen when swicthing clocksources which use PM runtime.
The call path is:
change_clocksource
    ...
    write_seqcount_begin
    ...
    timekeeping_update
        ...
        sh_cmt_clocksource_enable
            ...
            rpm_resume
                pm_runtime_mark_last_busy
                    ktime_get
                        do
                            read_seqcount_begin
                        while read_seqcount_retry
    ....
    write_seqcount_end

Although we should be safe because we haven't yet changed the clocksource
at that time, we can't because of seqcount protection.

Use ktime_get_mono_fast_ns() instead which is lock safe for such case

With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
monotonic across an update and as a result can goes backward. According to
update_fast_timekeeper() description: "In the worst case, this can
result is a slightly wrong timestamp (a few nanoseconds)". For
PM runtime autosuspend, this means only that the suspend decision can
be slightly sub optimal.

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

- v2: Updated commit message to explain the impact of using 
  ktime_get_mono_fast_ns()

 drivers/base/power/runtime.c | 10 +++++-----
 include/linux/pm_runtime.h   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 457be03..708a13f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -130,7 +130,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 {
 	int autosuspend_delay;
 	u64 last_busy, expires = 0;
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = ktime_get_mono_fast_ns();
 
 	if (!dev->power.use_autosuspend)
 		goto out;
@@ -909,7 +909,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
+	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
@@ -928,7 +928,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 int pm_schedule_suspend(struct device *dev, unsigned int delay)
 {
 	unsigned long flags;
-	ktime_t expires;
+	u64 expires;
 	int retval;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
@@ -945,8 +945,8 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	expires = ktime_add(ktime_get(), ms_to_ktime(delay));
-	dev->power.timer_expires = ktime_to_ns(expires);
+	expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC);
+	dev->power.timer_expires = expires;
 	dev->power.timer_autosuspends = 0;
 	hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
 
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 54af4ee..fed5be7 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
+	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
 }
 
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
