Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:50:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4EF2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DnNLM40f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4EF2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QnrvH3YB7GoQ4L4VneQSpryhxCdR7HT/LQMfKSrHz2k=; b=DnNLM40ft3he7g
	EAU7iTHU7SdIv2784AYHisgD0iCGZh0WMHNAfFmqirSRyL4yQyR1BLlcEnn/DMwD3OJyZ7gzIAkh6
	Iv13fehgRI6oJqJl9odfZD4PesNfson48coGLJTHAeAKRfzgx1JcTbhzYh3xyfSK5BF06dJQsnSw7
	GbJJAiZA/3LRdtX5oAMKG3jy6RCEhS1TuWpINmSltGn/TkJFthhEcIy5GcuGBXK6mZtgTThjr1xC8
	Zk07oM+S/i3bM0jWSdD4IjBsYWF1901+px7AlP2HhH+p5x0C6xFKLRXuvHzMPkbUYwk/5iQ3XACL3
	5KkFjg30MNZtdltKpIVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz1T0-0003A5-I0; Wed, 27 Feb 2019 15:49:54 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz1Sw-00039Q-BO
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 15:49:52 +0000
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gz1So-0002nP-GO; Wed, 27 Feb 2019 16:49:42 +0100
Date: Wed, 27 Feb 2019 16:49:37 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
In-Reply-To: <9c1da773-7fae-69ad-484b-224f3e76ea09@arm.com>
Message-ID: <alpine.DEB.2.21.1902271640260.26197@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
 <9c1da773-7fae-69ad-484b-224f3e76ea09@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_074950_533733_F9086718 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Vincenzo,

On Wed, 27 Feb 2019, Vincenzo Frascino wrote:
> 
> The clocksource array has two elements (CLOCKSOURCE_RAW, CLOCKSOURCE_MONO) and
> the situation with my scheme should be the following:

Oops. I misread the patch, but still...

> 	u32		seq:			+    0
> 	s32		clock_mode;		+    4
> 	u64		cycle_last;		+    8
> 	struct vdso_cs	cs[2];			+    16
> 	struct vdso_ts	basetime[VDSO_BASES];	+    48
> 
> which I agree makes still things a bit worse.

> > It's easy enough to benchmark these implementations and without trying I'm
> > pretty sure that you can see the performance drop nicely. Please do so next
> > time and provide the numbers in the changelogs.
> > 
> 
> I did run some benchmarks this morning to quantify the performance impact and
> seems that using vdsotest[1] the difference in between a stock linux kernel
> 5.0.0-rc7 and one that has unified vDSO, running on my x86 machine (Xeon Gold
> 5120T), is below 1%. Please find the results below, I will add them as well to
> the next changelog.

I have some doubts about 1%.
			    	   NEW	STOCK
clock-gettime-monotonic:    vdso:  31	 28    ~ 10% slower
clock-gettime-realtime:     vdso:  32    29    ~ 10% slower

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
