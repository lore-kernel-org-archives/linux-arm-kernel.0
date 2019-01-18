Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4AEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:38:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DE820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aOYpsnDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DE820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Date:
	Message-Id:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=kAIaAYHLAoQw+kBT4RQ+uAfmof0mIR4+CxLVZGqNVn8=; b=aOY
	psnDiVQKPM8xS/2HOwUdDKFTsiJHZOrnkxsPZk+21bm2T7w7aJos9uczI5uMjz2xB3NjaWvXwfuJY
	R4n4Lw75BGiaI1bGei22H+d6/ss4AOJgccJUFR9jVhiBjntK/rDHw2de+3EvPajo+mX9UXaKRnaRF
	uFDoewbY/71WkKARYUMsnT22laYjEWF7EyJQXa6S/LDxvVKCcDExpeDiXu4CfWTrUpO9gnjQSTMBa
	KydMZTCu1aDYrwW524BNlay4fOjgBDI4DX/WIChZZ8caPez+BSWHLVGKqMfriI6wUQjGX+r172up1
	vJ28vSze44ajt/zcMpmklIeNbUS2FAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX9V-0002Qo-KV; Fri, 18 Jan 2019 16:37:53 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX9J-0002KY-W2
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:37:52 +0000
Received: by newverein.lst.de (Postfix, from userid 2005)
 id 6A99268CEB; Fri, 18 Jan 2019 17:37:36 +0100 (CET)
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v7 0/3] arm64: ftrace with regs
Message-Id: <20190118163736.6A99268CEB@newverein.lst.de>
Date: Fri, 18 Jan 2019 17:37:36 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083742_461049_4D3FF5FE 
X-CRM114-Status: UNSURE (   5.89  )
X-CRM114-Notice: Please train this message.
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
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

So here's v7 of ftrace with regs only. I've split out the CC_FLAGS_FTRACE
cleanup and the gcc activation into separate patches, respectively. The set
should include all of Mark's requested changes. Most notably, it now patches
in the first insn "mov x9, lr" right at startup, to avoid the races we
discussed; I'm conveniently abusing the initial _make_nop for that. The empty
mcount: routine caused a lot of Q's, so it's gone now.

I updated the accompanying livepatch patches here as well, in case somebody is
interested ;) They have only been updated to match this current ftrace-regs set,
not more.

The whole series applies cleanly on 5.0-rc2

in detail:

changes since v6:

* change the stack layout once more; I hope I have it the "standard" way now.
  And yes, it looks simpler and cleaner; thanks, Mark, for nagging.

* split out the independent Kconfig and Makefile changes

* fixed style issues

* s/fp/x29/g

* MCOUNT_ADDR is now merely a 64-bit magic, as this is totally sufficient.

* QUICK_LR_SAVE renamed back to MOV_X9_X30.

* place MOV_X9_X30 insns on bootup, and only flip b <-> nop at runtime

* graph tracer "ifdeffery" reshuffle

	Torsten
  

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
