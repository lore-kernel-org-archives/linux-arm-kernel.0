Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DF8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:26:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D8720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mdvIihjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D8720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dc8cVzj1j3SBLQtFDEC2E9Umx6KcdNyb5mfqI2+U30A=; b=mdvIihjACCh+YP
	bPlPOZFjmnUVU1abRaDxZt3CLcJxGZX0+ZjbqM3padDCCmnUi6v+WB9ydGGibXGwxzviKETZVQN+Y
	0edbwWWvKTKkN+b1A5dkx6xg7CVBRyGaG+Ic8dFVw/TN+SeCgp2y+lA2FoImVu2ak7eFul2tFEOZ9
	9UD1w6rYaVobguNO7Achn5bla2mlGiB7anUNGHz2/iPyJ9PH79015X6a+J2iH5MoH+wtOmrQYJ0Wj
	HzffjGWvjPtpfFKRrGZBjshrggV94L9mfSjdik+CRD6gCNFxq7dmtDWUnHh7oJX2byXVjAjB+6xLf
	HU7bDSL/s7dQDHj2I2WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj1K0-0002MG-PL; Mon, 14 Jan 2019 12:26:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj1Ju-0002LW-IP
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 12:26:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C929680D;
 Mon, 14 Jan 2019 04:26:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AAE53F5BD;
 Mon, 14 Jan 2019 04:26:19 -0800 (PST)
Date: Mon, 14 Jan 2019 12:26:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190114122616.GD10258@lakrids.cambridge.arm.com>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
 <20190114121359.GB26056@350D>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114121359.GB26056@350D>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_042622_612507_45F72200 
X-CRM114-Status: GOOD (  15.70  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 11:13:59PM +1100, Balbir Singh wrote:
> On Fri, Jan 04, 2019 at 05:50:18PM +0000, Mark Rutland wrote:
> > Hi Torsten,
> > 
> > On Fri, Jan 04, 2019 at 03:10:53PM +0100, Torsten Duwe wrote:
> > > Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
> > > of each function. Replace the first NOP thus generated with a quick LR
> > > saver (move it to scratch reg x9), so the 2nd replacement insn, the call
> > > to ftrace, does not clobber the value. Ftrace will then generate the
> > > standard stack frames.
> 
> Do we know what the overhead would be, if this was a link time change
> for the first instruction?

No, but it should be possible to benchamrk that for a given workload,
which is what I'd like to see.

> Also, I was under the impression that some arch's do ftrace_call_replace
> under stop_machine(), is that a possibility here?

Something like that is a possibility.

I think we need numbers either way.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
