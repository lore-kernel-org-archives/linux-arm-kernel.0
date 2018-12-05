Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FE2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:41:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6C6206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tgAQfoDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6C6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DIedmoHYrWsWtLnL1WzuvItNDM9SaPabEuDumZ1YCzo=; b=tgAQfoDNvHRdEx
	1slih+B52+xmJFgp7O5DfyhcmcoEHawFZruIL7tgcT0v97GcHcKXiNYDdYX3dKksqqvImLMepY1q5
	SIXwmvoCi4t2lTL7PZoI1UuZBc+Q11LknBQdr5N5pgwHCSZGmvXpscOHqNXerSslwQkNBKDLXLjTj
	VZu64n1PhuE/z7USBdbxG0ZlWza3LCI6aHPfvtuIe2uzBwvM5SDFJW7LxcdT/gLBRoDWWyax1Z4Sf
	vX+zVExhR8GYgENelO+iXNNWcMHimfRmcM26uvcQ7tiCUNuGlXIO8fODWCvICcZgmk/tvLPnKyRVl
	OB4wfD7EQsNGYS6BD0xQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZIf-0002Bh-Me; Wed, 05 Dec 2018 15:41:21 +0000
Received: from www62.your-server.de ([213.133.104.62])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZIY-0001t2-28
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:41:20 +0000
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1gUZIB-0003bb-Qs; Wed, 05 Dec 2018 16:40:51 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
 by sslproxy06.your-server.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daniel@iogearbox.net>)
 id 1gUZIB-000J5Z-Kg; Wed, 05 Dec 2018 16:40:51 +0100
Subject: Re: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
To: Will Deacon <will.deacon@arm.com>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-3-ard.biesheuvel@linaro.org>
 <20181130182629.GA16085@arm.com>
 <CAKv+Gu9QVHLWu5H3Ok1Kbm=vtzd1KaHUn2VEij6oToW5aPR9uA@mail.gmail.com>
 <20181203124930.GB25097@arm.com>
 <CAKv+Gu8svuTSOzg7wmmK70tRPgFqGvBh5BZR-V+43dMLvT1bJg@mail.gmail.com>
 <12954298-de06-349e-6df2-c218e5bf09a3@iogearbox.net>
 <20181205132444.GA15631@arm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a489da38-73b9-beec-18d8-3bb6783f941c@iogearbox.net>
Date: Wed, 5 Dec 2018 16:40:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181205132444.GA15631@arm.com>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25179/Tue Dec  4 15:18:37 2018)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_074114_218424_680C2437 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>,
 Eric Dumazet <eric.dumazet@gmail.com>, Jann Horn <jannh@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/05/2018 02:24 PM, Will Deacon wrote:
> On Wed, Dec 05, 2018 at 01:24:17PM +0100, Daniel Borkmann wrote:
>> On 12/04/2018 04:45 PM, Ard Biesheuvel wrote:
>>> On Mon, 3 Dec 2018 at 13:49, Will Deacon <will.deacon@arm.com> wrote:
>>>> On Fri, Nov 30, 2018 at 08:20:06PM +0100, Ard Biesheuvel wrote:
>>>>> On Fri, 30 Nov 2018 at 19:26, Will Deacon <will.deacon@arm.com> wrote:
>>>>>> On Fri, Nov 23, 2018 at 11:18:04PM +0100, Ard Biesheuvel wrote:
>>>>>>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>>>>>>> index a6fdaea07c63..76c2ab40c02d 100644
>>>>>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>>>>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>>>>>>> @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>>>>>                                          tmp : orig_prog);
>>>>>>>       return prog;
>>>>>>>  }
>>>>>>> +
>>>>>>> +void *bpf_jit_alloc_exec(unsigned long size)
>>>>>>> +{
>>>>>>> +     return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
>>>>>>> +                                 BPF_JIT_REGION_END, GFP_KERNEL,
>>>>>>> +                                 PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
>>>>>>> +                                 __builtin_return_address(0));
>>>>>>
>>>>>> I guess we'll want VM_IMMEDIATE_UNMAP here if Rich gets that merged.
>>>>>
>>>>> I think akpm already queued up that patch.
>>>>>
>>>>>> In the
>>>>>> meantime, I wonder if it's worth zeroing the region in bpf_jit_free_exec()?
>>>>>> (although we'd need the size information...).
>>>>>>
>>>>>
>>>>> Not sure. What exactly would that achieve?
>>>>
>>>> I think the zero encoding is guaranteed to be undefined, so it would limit
>>>> the usefulness of any stale, executable TLB entries. However, we'd also need
>>>> cache maintenance to make that stuff visible to the I side, so it's probably
>>>> not worth it, especially if akpm has queued the stuff from Rich.
>>>>
>>>> Maybe just add an:
>>>>
>>>> /* FIXME: Remove this when VM_IMMEDIATE_UNMAP is supported */
>>>> #ifndef VM_IMMEDIATE_UNMAP
>>>> #define VM_IMMEDIATE_UNMAP      0
>>>> #endif
>>>>
>>>> so we remember to come back and sort this out? Up to you.
>>>
>>> I'll just make a note to send out that patch once the definition lands via -akpm
>>
>> Could I get an ACK from you for this patch, then I'd take the series into bpf-next.
> 
> Gah, thanks for the ping: I thought I acked this initially, but turns out I
> didn't.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Applied, thanks everyone!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
