Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09E1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:37:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB95208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UnfwD/wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB95208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yw3j1dXEDbJzZykxYjgHKYLymne8jauJ9kRdTFqyUko=; b=UnfwD/wLWTT9QD
	XrTWKXJ6Nqq7ZuLlJyBLjT/jwF32h6DFZ98266udT0fGSZHQhu6kvBreV+8cC5ghOjnG08XQSWlWB
	AE9xveDzX2WU8VaXUZecmEPILFkM0WTxFZ4TT89hop90SrhKhBaOtDDg9cNNFSBFBLtvKH2ByV3CV
	M+c7vs66roCvQBXu5WpDUOy+AmVT0s+LTMW1wTlI6xlHbu+oVL+/y9YqAZWPQ9QVjlit3d1eRVN1f
	WdMUyIy5ovNPavLfeiqxtjXZz/MkPdhUFpS+QRltOhgqC9noqf9VXkexJdhOe+En2FaoCKRvTNsep
	WqFCCEVrYzoyFsi/nGhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVES0-0001sa-5i; Fri, 07 Dec 2018 11:37:44 +0000
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVERw-0001jC-HN
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:37:42 +0000
Received: from [192.168.2.10] ([212.251.195.8])
 by smtp-cloud7.xs4all.net with ESMTPA
 id VERgg67NpgJOKVERkgYaor; Fri, 07 Dec 2018 12:37:28 +0100
Subject: Re: [PATCH] media: cedrus: don't initialize pointers with zero
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <dd25052db89ccf292f2a5e45b7e94e8e6d000c40.1544180158.git.mchehab+samsung@kernel.org>
 <ff5fe553-fee4-bc5c-d1e9-9dc4cc1319ba@xs4all.nl>
 <20181207093106.4f112d0b@coco.lan>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <4a2f5566-c021-ed9c-a9f0-03d6bcd894d0@xs4all.nl>
Date: Fri, 7 Dec 2018 12:37:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181207093106.4f112d0b@coco.lan>
Content-Language: en-US
X-CMAE-Envelope: MS4wfArV9RumTkhV/FgkPMJwmznHSeceNc7RT87Bcouykbh4+FyCr8WoQ1xEJwAbG3bDEhrDM6eELbYNQkCJki3p/J98QtxIM0Nurl9pk8bUzXuu4fx4y4UX
 zPYr2X0NZEH+7p6rQtlNW6vtk7wabbkuP+xFSMtdYkPmMiSqCIfNAhOM31Urg7LXh7mfFt5BBYwCdGzniTarXLR/DLvzRLg7vVvWUGjx36zAyc6OCxlo0MgM
 K3hfu6pzD0PTYzPAsQPC38qZACVMd+2ZrCFA3Vmy/Ylr6ywCycWlpEpa0lz2GARoawcNxKrKy1ko9HnXb2HT9c3YUyEptx02hsOiRc4V+Vzf8tuB8SuIY7a9
 4hdNGWB+aOzjmoR6iu559yEaGtoZK6tHLAFg5K9f4QpvGoqaqTvVOxxKlPbjMiU81T/0SIIKZlOymu76rEuQtm+Aq8l+XbYLGZylC9D8wI6Fbq0uNE/pnvBH
 6LdzXu3rU9srsdoH
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_033740_714506_F47DEE4E 
X-CRM114-Status: GOOD (  23.59  )
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
Cc: devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/07/2018 12:31 PM, Mauro Carvalho Chehab wrote:
> Em Fri, 7 Dec 2018 12:14:50 +0100
> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> 
>> On 12/07/2018 11:56 AM, Mauro Carvalho Chehab wrote:
>>> A common mistake is to assume that initializing a var with:
>>> 	struct foo f = { 0 };
>>>
>>> Would initialize a zeroed struct. Actually, what this does is
>>> to initialize the first element of the struct to zero.
>>>
>>> According to C99 Standard 6.7.8.21:
>>>
>>>     "If there are fewer initializers in a brace-enclosed
>>>      list than there are elements or members of an aggregate,
>>>      or fewer characters in a string literal used to initialize
>>>      an array of known size than there are elements in the array,
>>>      the remainder of the aggregate shall be initialized implicitly
>>>      the same as objects that have static storage duration."
>>>
>>> So, in practice, it could zero the entire struct, but, if the
>>> first element is not an integer, it will produce warnings:
>>>
>>> 	drivers/staging/media/sunxi/cedrus/cedrus.c:drivers/staging/media/sunxi/cedrus/cedrus.c:78:49:  warning: Using plain integer as NULL pointer
>>> 	drivers/staging/media/sunxi/cedrus/cedrus_dec.c:drivers/staging/media/sunxi/cedrus/cedrus_dec.c:29:35:  warning: Using plain integer as NULL pointer
>>>
>>> A proper way to initialize it with gcc is to use:
>>>
>>> 	struct foo f = { };
>>>
>>> But that seems to be a gcc extension. So, I decided to check upstream  
>>
>> No, this is not a gcc extension. It's part of the latest C standard.
> 
> Sure? Where the C standard spec states that? I've been seeking for
> such info for a while, as '= {}' is also my personal preference.

I believe it was added in C11, but I've loaned the book that stated
that to someone else, so I can't check.

In any case, it's used everywhere:

git grep '= *{ *}' drivers/

So it is really pointless to *not* use it.

Regards,

	Hans

> I tried to build the Kernel with clang, just to be sure that this
> won't cause issues with the clang support, but, unfortunately, the
> clang compiler (not even the upstream version) is able to build
> the upstream Kernel yet, as it lacks asm-goto support (there is an
> OOT patch for llvm solving it - but it sounds too much effort for
> my time to have to build llvm from their sources just for a simple
> check like this).
> 
>> It's used all over in the kernel, so please use {} instead of { NULL }.
>>
>> Personally I think {} is a fantastic invention and I wish C++ had it as
>> well.
> 
> Fully agreed on that.
> 
>>
>> Regards,
>>
>> 	Hans
>>
>>> what's the most commonly pattern. The gcc pattern has about 2000 entries:
>>>
>>> 	$ git grep -E "=\s*\{\s*\}"|wc -l
>>> 	1951
>>>
>>> The standard-C compliant pattern has about 2500 entries:
>>>
>>> 	$ git grep -E "=\s*\{\s*NULL\s*\}"|wc -l
>>> 	137
>>> 	$ git grep -E "=\s*\{\s*0\s*\}"|wc -l
>>> 	2323
>>>
>>> So, let's initialize those structs with:
>>> 	 = { NULL }
>>>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>>> ---
>>>  drivers/staging/media/sunxi/cedrus/cedrus.c     | 2 +-
>>>  drivers/staging/media/sunxi/cedrus/cedrus_dec.c | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
>>> index b538eb0321d8..44c45c687503 100644
>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
>>> @@ -75,7 +75,7 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
>>>  	memset(ctx->ctrls, 0, ctrl_size);
>>>  
>>>  	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
>>> -		struct v4l2_ctrl_config cfg = { 0 };
>>> +		struct v4l2_ctrl_config cfg = { NULL };
>>>  
>>>  		cfg.elem_size = cedrus_controls[i].elem_size;
>>>  		cfg.id = cedrus_controls[i].id;
>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
>>> index e40180a33951..4099a42dba2d 100644
>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
>>> @@ -26,7 +26,7 @@ void cedrus_device_run(void *priv)
>>>  {
>>>  	struct cedrus_ctx *ctx = priv;
>>>  	struct cedrus_dev *dev = ctx->dev;
>>> -	struct cedrus_run run = { 0 };
>>> +	struct cedrus_run run = { NULL };
>>>  	struct media_request *src_req;
>>>  	unsigned long flags;
>>>  
>>>   
>>
> 
> 
> 
> Thanks,
> Mauro
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
