Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92766C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622D120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d3qNrA1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622D120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MxcyshN1DT3GbsZqTGryc8+gKGb8WlCUSzlJAE8Is5A=; b=d3qNrA1fArYe6d
	dGz0MJV9Idbro6jSS3YPFR3OnMF6D7m8w0Gue0LkvBMw6oosd6RT9Isv58JtU8TfdzSCoxFcYpksL
	6xmpRQZmRsYbCYXL62SyqYcbYo2olrgMnOZh+REhhI38utqZo8zURtPuWFb9CPe3uM1fXsXZW0rhq
	tDdg9dyqDXbfW1zsifWsJLvpfdms6zVJElmd7Qva293Ihf+Fl/6d++HoGimqYKLrgSbE7ymiUfrRB
	8s1LPqAUzjxp+JMJs141hTI8vdxf98glD0t0btwcP+v8ksSqne//crVn/j+N5q16bkNL83h3AHboV
	Zu2d7O/SuzjYP1L/Bp5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWT9Y-0005Au-3o; Mon, 10 Dec 2018 21:31:48 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWT9U-0004yQ-D8
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:31:46 +0000
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gWT97-0004lA-Vf; Mon, 10 Dec 2018 22:31:22 +0100
Date: Mon, 10 Dec 2018 22:31:21 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
In-Reply-To: <20181210140703.GM5289@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1812102229480.1667@nanos.tec.linutronix.de>
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
 <20181210140703.GM5289@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_133144_590508_D1E45E65 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: mark.rutland@arm.com, marc.zyngier@arm.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>, longman@redhat.com,
 akpm@linux-foundation.org, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018, Peter Zijlstra wrote:
> On Mon, Dec 10, 2018 at 08:52:28AM -0500, Qian Cai wrote:
> > Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
> > warning.
> > 
> > [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
> > [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
> > [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
> > [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
> > [    0.000000]  acpi_table_parse+0x1ac/0x218
> > [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
> > [    0.000000]  timer_probe+0x1bc/0x254
> > [    0.000000]  time_init+0x44/0x98
> > [    0.000000]  start_kernel+0x4ec/0x7d4
> 
> It seems to me we want something like:
> 
> ---
>  kernel/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 91d5c38eb7e5..e1ee8caf28b5 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
>  
>  void lockdep_assert_cpus_held(void)
>  {
> +	if (system_state < SYSTEM_RUNNING)
> +		return;
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
 
Hmm, no. SYSTEM_SCHEDULING is what you want because RUNNING is set way too
late.

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
