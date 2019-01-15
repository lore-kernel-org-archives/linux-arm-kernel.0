Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:20:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C21020657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FBkayGV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C21020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lDpT4/v2gwe9tkGmm/YV1tNAWTkjoPXCPFZd18gpw0I=; b=FBkayGV+y4QPXA
	zgWXegvoRPZH9upWUvkxv3liSG/iVYQqBpQNH2cTK25XZcHw/kxvcCxnvbj//2b2tOR5NgL/oetxk
	2u5aWzuNBRvMYlvFusunmuaBsk41jnYToTDp2zMY8T//kdAeu3C0ZNCSnu0YGaX4OitufkbRn0JWl
	iDupvU3tz55C3gd4S9Y84Ekxf0+gcfKJ93yZeuLXQQ7HynuJW0TIPuo8FVFeww/xQkHGuXwcgdMz7
	QqhLpxrMg6MYLjTUN5LYIA/soOMdaBVLLFQP/Z5R+8R53bicQHTYEllDBs4sxfanL5GfZJ2PoMRnS
	nr2b29TdJe/09PLf07BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjMlc-0002Yv-S2; Tue, 15 Jan 2019 11:20:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjMlZ-0002YW-Ue
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 11:20:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B02A1596;
 Tue, 15 Jan 2019 03:20:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9487D3F70D;
 Tue, 15 Jan 2019 03:20:19 -0800 (PST)
Date: Tue, 15 Jan 2019 11:20:17 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/4] arm64: kprobes: Remove unneeded RODATA check
Message-ID: <20190115112016.GD43491@lakrids.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753347659.31541.11277302003578292109.stgit@devbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154753347659.31541.11277302003578292109.stgit@devbox>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_032021_996604_A6CA6103 
X-CRM114-Status: GOOD (  16.25  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 03:24:36PM +0900, Masami Hiramatsu wrote:
> Remove unneeded RODATA check from arch_prepare_kprobe().
> 
> Since check_kprobe_address_safe() already ensured that
> the probe address is in kernel text, we don't need to
> check whether the address in RODATA or not. That must
> be always false.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/probes/kprobes.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index b2d4b7428ebc..1dae500d0a81 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -91,8 +91,6 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>  	unsigned long probe_addr = (unsigned long)p->addr;
> -	extern char __start_rodata[];
> -	extern char __end_rodata[];
>  
>  	if (probe_addr & 0x3)
>  		return -EINVAL;
> @@ -106,10 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	if (search_exception_tables(probe_addr))
>  		return -EINVAL;
>  
> -	if (probe_addr >= (unsigned long) __start_rodata &&
> -	    probe_addr <= (unsigned long) __end_rodata)
> -		return -EINVAL;
> -
>  	/* decode instruction */
>  	switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
>  	case INSN_REJECTED:	/* insn not supported */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
