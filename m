Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:48:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE76206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aags0la/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE76206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rRq1XoEF5PVTt+CSuQRHaJR57xq27mSv65XUkbJy9rw=; b=Aags0la/Azee8G
	v1jhnW4G59hncUxiEs3VInpzOi1DC6ygaTNpm0lqnhPVqvd1+2e19TpFMnUC4exH033H0kIPMOPJq
	XRsLhM0T8KfJQlyFW/8lbPyxQG7/Vr9iO/j0MFb1lggRD5+iCp2E2NZuEB66L3C7ELVCqZOeodkOs
	GLNZNRQHn6reqaSwkTal6E/bmhbCzsRl3epgSqYjSKP9cl79iTB2kaSxc+a5KZY4Ylsfl/lHfPwaP
	QnRMdHcp5769BdLMW1/nfXO6AnLI63vExrVI0NNnmFihaxr1BYxeXjX/2NLR/gsQAlAQeUIkwa17Z
	rR1Nor+r7Eq4bMaZPHSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gttyC-0003r0-4c; Wed, 13 Feb 2019 12:48:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtty9-0003qZ-KW
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:48:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4073080D;
 Wed, 13 Feb 2019 04:48:51 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE75E3F557;
 Wed, 13 Feb 2019 04:48:46 -0800 (PST)
Date: Wed, 13 Feb 2019 12:48:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mmap.2: describe the 5level paging hack
Message-ID: <20190213124842.GD1912@brain-police>
References: <20190211163653.97742-1-jannh@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211163653.97742-1-jannh@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_044853_685199_AB3FD2A2 
X-CRM114-Status: GOOD (  32.49  )
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
Cc: linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@amacapital.net>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, mtk.manpages@gmail.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jann,

On Mon, Feb 11, 2019 at 05:36:53PM +0100, Jann Horn wrote:
> The manpage is missing information about the compatibility hack for
> 5-level paging that went in in 4.14, around commit ee00f4a32a76 ("x86/mm:
> Allow userspace have mappings above 47-bit"). Add some information about
> that.
> 
> While I don't think any hardware supporting this is shipping yet (?), I
> think it's useful to try to write a manpage for this API, partly to
> figure out how usable that API actually is, and partly because when this
> hardware does ship, it'd be nice if distro manpages had information about
> how to use it.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> This patch goes on top of the patch "[PATCH] mmap.2: fix description of
> treatment of the hint" that I just sent, but I'm not sending them in a
> series because I want the first one to go in, and I think this one might
> be a bit more controversial.
> 
> It would be nice if the architecture maintainers and mm folks could have
> a look at this and check that what I wrote is right - I only looked at
> the source for this, I haven't tried it.
> 
>  man2/mmap.2 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index 8556bbfeb..977782fa8 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -67,6 +67,8 @@ is NULL,
>  then the kernel chooses the (page-aligned) address
>  at which to create the mapping;
>  this is the most portable method of creating a new mapping.
> +On Linux, in this case, the kernel may limit the maximum address that can be
> +used for allocations to a legacy limit for compatibility reasons.
>  If
>  .I addr
>  is not NULL,
> @@ -77,6 +79,19 @@ or equal to the value specified by
>  and attempt to create the mapping there.
>  If another mapping already exists there, the kernel picks a new
>  address, independent of the hint.
> +However, if a hint above the architecture's legacy address limit is provided
> +(on x86-64: above 0x7ffffffff000, on arm64: above 0x1000000000000, on ppc64 with
> +book3s: above 0x7fffffffffff or 0x3fffffffffff, depending on page size), the
> +kernel is permitted to allocate mappings beyond the architecture's legacy
> +address limit.

On arm64 we support 36-bit, 39-bit, 42-bit, 47-bit, 48-bit and 52-bit user
virtual addresses, some of which also enforce a particular page size of 4k,
16k or 64k. With the exception of 52-bit, the user virtual address size is
fixed at compile time and mmap() can allocate up to the maximum address
size.

When 52-bit virtual addressing is configured, we continue to allocate up to
48 bits unless either a hint is passed to mmap() as you describe, or
CONFIG_ARM64_FORCE_52BIT=y (this is really intended as a debug option and is
hidden behind EXPERT as well as being off by default).

One thing that just occurred to me is that our ASLR code is probably pretty
weak for addresses greater than 48 bits because I don't think it was updated
when we added 52-bit support. I'll take a deeper look when I get some time.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
