Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A73DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:32:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B90218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvnDOrc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B90218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hfXeT4QGQtjmn1AvOtX09vAvQ6oQ64lLUE8f/xK7Q9w=; b=cvnDOrc9ZahiRG
	kY1W9ON7BjVFNN5JcuxxwJ7/GRIY9VQRtOKy+6WL1Y3AXTnZ4TIKNpGSjxXcQemJ04sFGSHqJz052
	kSuwOXVIkiJh67vjIAnXzBBTdUjPTIVG36XWqCIfl+Spy6A68CoeAOaEIz7NCA8knHg2DCMJ3REQE
	aHUXHqbUX+4ToxAKLF2X++ojlnhtLFPxpq/cHdhNATNhrqdSQCFyp1eJdCow8HKP1u7BwOR9k9yGm
	whETEW7EPH/L1ngB/CJ2d4R4oPLgbUl6SqVk+se2CFUK8iRU0golXI+pvZNBU9EFe+K9n/VaKk4Ci
	+jvtMfPYrUPw+la59gRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxTN-00036L-4s; Wed, 30 Jan 2019 21:32:41 +0000
Received: from eddie.linux-mips.org ([148.251.95.138] helo=cvs.linux-mips.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxTJ-00035w-Lg
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:32:39 +0000
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992820AbfA3VcenLVLh (ORCPT
 <rfc822;linux-arm-kernel@lists.infradead.org>);
 Wed, 30 Jan 2019 22:32:34 +0100
Date: Wed, 30 Jan 2019 22:32:33 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
Message-ID: <20190130213233.GA20881@lenoch>
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_133237_709157_1B69A8A5 
X-CRM114-Status: GOOD (  24.15  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 02:06:07PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 30, 2019 at 12:16 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > The call path is:
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
> >                 pm_runtime_mark_last_busy
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Although we should be safe because we haven't yet changed the clocksource
> > at that time, we can't because of seqcount protection.
> >
> > Use ktime_get_mono_fast_ns() instead which is lock safe for such case
> >
> > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > monotonic across an update and as a result can goes backward. According to
> > update_fast_timekeeper() description: "In the worst case, this can
> > result is a slightly wrong timestamp (a few nanoseconds)". For
> > PM runtime autosuspend, this means only that the suspend decision can
> > be slightly sub optimal.
> >
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> I've queued this one up as a fix for 5.0, but unfortunately it clashes
> with the patch from Ladislav Michl at
> https://patchwork.kernel.org/patch/10755477/ which has been dropped
> now.
> 
> Can you or Ladislav please rebase that patch on top of this one and repost?
> 
> > ---
> >
> > - v2: Updated commit message to explain the impact of using
> >   ktime_get_mono_fast_ns()
> >
> >  drivers/base/power/runtime.c | 10 +++++-----
> >  include/linux/pm_runtime.h   |  2 +-
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 457be03..708a13f 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -130,7 +130,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
> >  {
> >         int autosuspend_delay;
> >         u64 last_busy, expires = 0;
> > -       u64 now = ktime_to_ns(ktime_get());
> > +       u64 now = ktime_get_mono_fast_ns();
> >
> >         if (!dev->power.use_autosuspend)
> >                 goto out;
> > @@ -909,7 +909,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
> >          * If 'expires' is after the current time, we've been called
> >          * too early.
> >          */
> > -       if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
> > +       if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
> >                 dev->power.timer_expires = 0;
> >                 rpm_suspend(dev, dev->power.timer_autosuspends ?
> >                     (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
> > @@ -928,7 +928,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
> >  int pm_schedule_suspend(struct device *dev, unsigned int delay)
> >  {
> >         unsigned long flags;
> > -       ktime_t expires;
> > +       u64 expires;
> >         int retval;
> >
> >         spin_lock_irqsave(&dev->power.lock, flags);
> > @@ -945,8 +945,8 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
> >         /* Other scheduled or pending requests need to be canceled. */
> >         pm_runtime_cancel_pending(dev);
> >
> > -       expires = ktime_add(ktime_get(), ms_to_ktime(delay));
> > -       dev->power.timer_expires = ktime_to_ns(expires);
> > +       expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC);

Just FYI, this one does not compile                                        ^
I'm going to send updated optimization patch anyway as fixing this one will not
break it :)

> > +       dev->power.timer_expires = expires;
> >         dev->power.timer_autosuspends = 0;
> >         hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
> >
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 54af4ee..fed5be7 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
> >
> >  static inline void pm_runtime_mark_last_busy(struct device *dev)
> >  {
> > -       WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
> > +       WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
> >  }
> >
> >  static inline bool pm_runtime_is_irq_safe(struct device *dev)
> > --
> > 2.7.4
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
