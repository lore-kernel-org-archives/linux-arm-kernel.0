Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1387C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:08:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9483A20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FO4hXKb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9483A20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nUSSCKraHchg8RtxYhBoh4/Il5wNbr7SXhmdxprP23k=; b=FO4hXKb4PU6DOv
	TgAzaymROoD7KTuX5oPYoUFqhl8wevyoGnYxLHQ+Ymxnzy4F/lb2fK1ol1nn1U2qVwSDZurW01zZh
	0CesbLESUs3Z7SWccP/8SEJojPYTsPq+CIQ3UxBkNM+MOx5rMmrSUQW3YfKDIRp6BJcW2xGtTG3MB
	eHvAvphrNtisPd+IdEBt94fR7suL+GJAFysFfGb7v6cVko9Vr2HqffUo/K/NTN2YpZfUisPyPqPhn
	riDA/ziYrsOTvns+XIFGp0h9rTaxHAlPaVj9G/sATCJm1rEjzNSZ5QgDvSiNBIRTRbqOeXZpjX27L
	frStZUGDIJPAJnoF3O7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSfiX-0003pQ-1U; Fri, 30 Nov 2018 10:08:13 +0000
Received: from www62.your-server.de ([213.133.104.62])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSfiD-0003aF-OD
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:07:55 +0000
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1gSfht-0001eZ-0m; Fri, 30 Nov 2018 11:07:33 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
 by sslproxy05.your-server.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daniel@iogearbox.net>)
 id 1gSfhs-000X48-Nu; Fri, 30 Nov 2018 11:07:32 +0100
Subject: Re: [PATCH] arm64/bpf: use movn/movk/movk sequence to generate kernel
 addresses
From: Daniel Borkmann <daniel@iogearbox.net>
To: Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20181123172902.21480-1-ard.biesheuvel@linaro.org>
 <20181127182203.GA19721@arm.com>
 <c8f11ce3-1ab4-5e54-85f6-2431c7eb8a7a@iogearbox.net>
Message-ID: <adb5d79f-189b-b5b7-ff22-a6c4807e0f25@iogearbox.net>
Date: Fri, 30 Nov 2018 11:07:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <c8f11ce3-1ab4-5e54-85f6-2431c7eb8a7a@iogearbox.net>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25166/Fri Nov 30 07:15:29 2018)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_020753_783248_1FF04F4E 
X-CRM114-Status: GOOD (  10.69  )
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
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ast@fb.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/27/2018 07:24 PM, Daniel Borkmann wrote:
> On 11/27/2018 07:22 PM, Will Deacon wrote:
>> Hi Ard,
>>
>> On Fri, Nov 23, 2018 at 06:29:02PM +0100, Ard Biesheuvel wrote:
>>> On arm64, all executable code is guaranteed to reside in the vmalloc
>>> space (or the module space), and so jump targets will only use 48
>>> bits at most, and the remaining bits are guaranteed to be 0x1.
>>>
>>> This means we can generate an immediate jump address using a sequence
>>> of one MOVN (move wide negated) and two MOVK instructions, where the
>>> first one sets the lower 16 bits but also sets all top bits to 0x1.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>>
>> Denial, Alexei, shall I take this via arm64, or would you rather take
>> it via davem?
> 
> Yeah we can take it via bpf trees, thanks.

And now applied, thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
