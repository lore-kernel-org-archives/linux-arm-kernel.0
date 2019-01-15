Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1596AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA48920675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tg/44xmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA48920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nYObYem8LhKELqRi8+SP3vhVz661Rg4v+DWQ66oWrJ0=; b=Tg/44xmu8zOw7b
	6ijsY1z7BYI8F6YpSxl/OuE9nhoL2hRHl5TsTcSqqwB2tnsGyEPgyCG7Cm9Md5EaER0iiIVeEqyaZ
	KkbvqwDnyLq0i1peRpnRyF1A9HZ7eZrs+R1RYy4eNIFVkHVeC1Cr+zwTm6nrUAJVyKgGcYANOwOTP
	oCnEjK5wvr9XM7drymbYzz1nM/6bVVjqchU33lRqxZfzU0LeYW3HyktTOyJRprO+zf7nc2HiUsjfM
	vtgvr2OqlM46CEuG1ZiZmdeFojQL1pqBd+JkjBNRHu70xr1kfBpNdfGEJ/oXM7eLR7mMH4MvcOjUO
	hMais9CUfypEeYczD8qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQeu-0008LL-7s; Tue, 15 Jan 2019 15:29:44 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQer-0008Kq-0A
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:29:42 +0000
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gjQeo-0005XC-QI; Tue, 15 Jan 2019 16:29:38 +0100
Date: Tue, 15 Jan 2019 16:29:38 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v4 01/24] kernel: Standardize vdso_datapage
In-Reply-To: <7b0c86a9-b22b-ec89-436e-c8a6a69146b6@arm.com>
Message-ID: <alpine.DEB.2.21.1901151627560.1561@nanos.tec.linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <20190115135539.24762-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de>
 <7b0c86a9-b22b-ec89-436e-c8a6a69146b6@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_072941_179036_771A1699 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
> On 15/01/2019 14:57, Thomas Gleixner wrote:
> >> +	u64 mask;		/* Clocksource mask (mono = raw) */
> > 
> > mono = raw? This is broken. The VDSO cannot define time different from the
> > regular syscall interfaces.
> > 
> 
> On v2 of this series I had the masks for mono and raw separate, but based on
> your comment (the core timekeeper has them duplicated purely for access pattern
> optimization and simplicity). I unified them. Could you please provide more
> details on what should be done in this case?

The mask is the same, but the mult is different. I'm not seing how this is
implemented. Both MONO and MONO_RAW invoke do_hres() and use the common
mult/shift pair.

Thanks,

	tglx


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
