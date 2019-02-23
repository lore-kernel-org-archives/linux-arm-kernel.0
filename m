Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:35:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD38205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cQ/9nKZe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahha/rDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD38205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=btSmKWwJb/jwpVUAlFiStyg1u0fnvW/ZOPwIIdGcfj8=; b=cQ/9nKZeMVyLsef333lxpAH8S
	Nnd3cGcAF91elKZqsEVbtXfmZ81ngmj7pXItLfEjP5+wkIjanDs+fWJK1e0uBOkh+jbj2PAtFdSa7
	wupqQJU/1fn88f+AUo4jVUrBsCv2+HZImULMEMPr3hgMdijl3If16zhit/k21yiikCLHlz+czzWY7
	RPPHmaklYhQ9CgIcN/ifq3wdd7t80XzfhfVbICcUrkCPFy+m+mkpafPSSFrbYPc9X4alRxPv7rfD0
	rhmZgTwva+/VnRCEG/pHePyPcfQCh2cWofY7nFvpKs752wMlTPiyrxLEn11Mf3HbVAG+eLtnt1EQh
	9GekUl16A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxLHI-000615-B0; Sat, 23 Feb 2019 00:34:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxLHE-00060O-Ch
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 00:34:50 +0000
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9F512086D
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 00:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550882087;
 bh=jhu1Yi2gJXqlzjwoANGn+vbwR0vsgFhKWSrka+2kJg0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ahha/rDmw06BtD9ISwmH2K5TA2+82t0uCMZ3ip+xEEEq5EXA9XbBBJCCHAvL90WOx
 9bd8nbVdL8a5NHFmAiIQZBxRWSndwqGJtN0COa2kAlMcTEhnZd78PDshNt+OQfu3Ed
 g6i9YnN2gM5IfVKRKgYQA5PqCZxfXwDETx26kc/o=
Received: by mail-wm1-f43.google.com with SMTP id x7so3443927wmj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 16:34:47 -0800 (PST)
X-Gm-Message-State: AHQUAuY3wsN3kNknCJhAxOZyBBoLXBNX6MjI7BWes805MywQwXirSGBK
 2fcM+2XheG5lMrvs2MRKIFhcdMnZoUppkL/2chL0qQ==
X-Google-Smtp-Source: AHgI3IbNo8Pa5++OWBvgsADjn0lan4WdbnomuH74mnRu6g8n5CIda5041Qo/4+RPbWr6iCbpNrHFTuPLxX0iZs/K87Y=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr4216681wmf.32.1550882086028; 
 Fri, 22 Feb 2019 16:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
In-Reply-To: <20190222222635.GK14054@worktop.programming.kicks-ass.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 22 Feb 2019 16:34:34 -0800
X-Gmail-Original-Message-ID: <CALCETrVw18nHQGPqg_OF=pD7NePafYQ_c1MhfSm_OCQ-O3xzhQ@mail.gmail.com>
Message-ID: <CALCETrVw18nHQGPqg_OF=pD7NePafYQ_c1MhfSm_OCQ-O3xzhQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000d3c00a058284df45"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_163448_553030_E29DFD8B 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--000000000000d3c00a058284df45
Content-Type: text/plain; charset="UTF-8"

[mailing lists removed because this is a potentially large source of exploits]

On Fri, Feb 22, 2019 at 2:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Feb 22, 2019 at 07:10:34PM +0100, Thomas Gleixner wrote:
>
> > But correct :)
>
> > I agree, that a function which is doing the actual copy should be callable,
> > but random other functions? NO!
>
> So find the below patch -- which spotted fail in ptrace.c
>

Um, wait a moment.  You didn't find an oddity in ptrace.c.  You found
a giant freaking error in uaccess.h.

Am I missing something?  How are there not zillions of instances of
this that your patch ought to catch?  Or is genregs_get() really the
only example?

--000000000000d3c00a058284df45
Content-Type: text/x-patch; charset="US-ASCII"; name="uaccess.patch"
Content-Disposition: attachment; filename="uaccess.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jsgr0hw70>
X-Attachment-Id: f_jsgr0hw70

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3VhY2Nlc3MuaAppbmRleCA3ODBmMmI0MmM4ZWYuLmRmMDU3MWEwN2I1NSAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCisrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3VhY2Nlc3MuaApAQCAtNDMxLDggKzQzMSwxMCBAQCBkbyB7CQkJCQkJCQkJXAog
KHsJCQkJCQkJCVwKIAlfX2xhYmVsX18gX19wdV9sYWJlbDsJCQkJCVwKIAlpbnQgX19wdV9lcnIg
PSAtRUZBVUxUOwkJCQkJXAorCV9fdHlwZW9mX18oKihwdHIpKSBfX3B1X3ZhbDsJCQkJXAorCV9f
cHVfdmFsID0geDsJCQkJCQlcCiAJX191YWNjZXNzX2JlZ2luKCk7CQkJCQlcCi0JX19wdXRfdXNl
cl9zaXplKCh4KSwgKHB0ciksIChzaXplKSwgX19wdV9sYWJlbCk7CVwKKwlfX3B1dF91c2VyX3Np
emUoX19wdV92YWwsIChwdHIpLCAoc2l6ZSksIF9fcHVfbGFiZWwpOwlcCiAJX19wdV9lcnIgPSAw
OwkJCQkJCVwKIF9fcHVfbGFiZWw6CQkJCQkJCVwKIAlfX3VhY2Nlc3NfZW5kKCk7CQkJCQlcCg==
--000000000000d3c00a058284df45
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--000000000000d3c00a058284df45--

