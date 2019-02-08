Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBD4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:15:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B28A20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DMWGTSAe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TzCDwQGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B28A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vcrc1CiIhjwLhvG+86UoRFLzSMswWyfbmLERdYhg23M=; b=DMWGTSAej+o5JfIs65BjIsfbQ
	c088PxUGYwwKxY8dKM5DroBOZSR6nKhaaFRiNcaDX+p7WLmRqm9lUBJKJEY7IKBfkbb2ZI33I+Pk7
	zQ7Nqr9dDbPu6/Fwwx5kHAtsZ7cXHAYSGTSKUeKXfw4wVmKvbsO4r42Ithm1utsNk1V21fA5sxFno
	jdn8KPrlFkrLIcS64awoc+sQaJMsqESfzT7lUzFFOniLXsDOG9v4KF23F6DnHBlelPN9PET/5AN9f
	hrdmypRo8ak5gDcgejTi5RmqPXuEKCA/lI2Fsi/+dFTT4u3hTLPXUIijl6ecfET4SAci6UkD4OuHA
	zK5v+ofqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9kL-0006kg-J8; Fri, 08 Feb 2019 17:15:25 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9kD-0006fu-ED
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:15:24 +0000
Received: by mail-pg1-x544.google.com with SMTP id z10so1838416pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=izFIc9YNpqMzrt/FcH2BTUU57hEhVEyMVNJiaHuKRKk=;
 b=TzCDwQGjpYtC7fJa5Y+4LxZzqGMq3AauwCE1C9UFWBRR++m+rHWNY1A0wzavWfIO5h
 ezXR5w1c2KDqVcB9Nj+Q4GH5Kkw+fOeymJ5DqL/OlPPY/a9qH6oY7eWDbHanTagSRaHK
 Iqcbji7nyN1bsEgv7n2zuKMpltwh8d/OE+nkkHZZmNiMbwXtnmJlC4z91vqwH/IKYhw2
 uB43pNpx9zbFA2fXgFtrXhRPNbyTiLjIaqVYbiZzv1jp2GGJ6vUeC/kxVIIFY0CaM3DM
 ELN8PZWJqeW7MdofPXPCJGWec9KExNskXn0YUpUyTL2tfMAz3L5f6RD8h98RN9ljXTuG
 4BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=izFIc9YNpqMzrt/FcH2BTUU57hEhVEyMVNJiaHuKRKk=;
 b=QDoZV+ijfAVZyNlAxwToyphDwi8IUZr+9zeRym5lXYxRuKxug+a8KvkutCAdE5X7w/
 Jy5kKVPbgN0tO1uPys6cG6+ouyO5NxCI9NRc0g56PN5aEc57UBPR11/tKfRUC+Fa+V1K
 Dt8/Xhs43+tmqEZ3qvNBowTJ/OHybYsURW8YoldvRNC+sCf07pMRHedmDk/zuusVubZs
 9ltg50nyONOdaAL01woReAVUWo0SugB+8eqikRqbF/QKpN+WWwYZrniXOX+d9e78eJJU
 vHzfQe3iUnlmwziZjJjOk7a/9MdBAA/7LVzHVNqK/HVg1tkjazvbMrfOslc2iPZlJUJC
 8RiQ==
X-Gm-Message-State: AHQUAub1CvZQelNTRldyVhJ2uvdiF5OtNubW6GmjUfCy0ScnK16ocJvJ
 KF4KVD7OqzndpatkBY4E627IlbQ2LIctYutY4kOw/mpV
X-Google-Smtp-Source: AHgI3IZQiySeY2RzaU27iXwGpVMtLcDLAcVIuCD1Bkfq8xsltQPa1JesGpHQxnjvPLTbCTb2TI2k0tlRZhG4up3iz1w=
X-Received: by 2002:a63:ab0b:: with SMTP id p11mr21880900pgf.264.1549646114047; 
 Fri, 08 Feb 2019 09:15:14 -0800 (PST)
MIME-Version: 1.0
References: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
 <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
 <89b343eb-16ff-1020-2efc-55ca58fafae7@lca.pw>
 <CAAeHK+zxxk8K3WjGYutmPZr_mX=u7KUcCUYXHi+OgRYMfcvLTg@mail.gmail.com>
 <d8cdc634-0f7d-446e-805a-c5d54e84323a@lca.pw>
 <59db8d6b-4224-2ec9-09de-909c4338b67a@lca.pw>
In-Reply-To: <59db8d6b-4224-2ec9-09de-909c4338b67a@lca.pw>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 8 Feb 2019 18:15:02 +0100
Message-ID: <CAAeHK+wsULxYXnGJnQXx9HjZMiU-5jb5ZKC+TuGQihc9L386Xg@mail.gmail.com>
Subject: Re: CONFIG_KASAN_SW_TAGS=y not play well with kmemleak
To: Qian Cai <cai@lca.pw>
Content-Type: multipart/mixed; boundary="000000000000288e3a0581651aae"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_091517_512434_26B33200 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--000000000000288e3a0581651aae
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 8, 2019 at 5:16 AM Qian Cai <cai@lca.pw> wrote:
>
> Kmemleak is totally busted with CONFIG_KASAN_SW_TAGS=y because most of tracking
> object pointers passed to create_object() have the upper bits set by KASAN.

Hi Qian,

Yeah, the issue is that kmemleak performs a bunch of pointer
comparisons that break when pointers are tagged. Try the attached
patch, it should fix the issue. I don't like the way this patch does
it though, I'll see if I can come up with something better.

Thanks for the report!

> However, even after applied this patch [1] to fix a few things, it still has
> many errors during boot.
>
> https://git.sr.ht/~cai/linux-debug/tree/master/dmesg
>
> What I don't understand is that even the patch did call kasan_reset_tag() in
> paint_ptr(), it still complained on objects with upper bits set which indicates
> that this line did not run.
>
> return (__s64)(value << shift) >> shift;
>
> [   42.462799] kmemleak: Trying to color unknown object at 0xffff80082df80000 as
> Grey
> [   42.470524] CPU: 128 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc5+ #17
> [   42.477153] Call trace:
> [   42.479639]  dump_backtrace+0x0/0x450
> [   42.483362]  show_stack+0x20/0x2c
> [   42.486733]  __dump_stack+0x20/0x28
> [   42.490276]  dump_stack+0xa0/0xfc
> [   42.493649]  paint_ptr+0xa8/0xf4
> [   42.496934]  kmemleak_not_leak+0xa4/0x15c
> [   42.501013]  init_section_page_ext+0x1bc/0x328
> [   42.505528]  page_ext_init+0x4dc/0x75c
> [   42.509336]  kernel_init_freeable+0x684/0x1104
> [   42.513857]  kernel_init+0x18/0x2a4
> [   42.517407]  ret_from_fork+0x10/0x18
>
> [1]
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index f9d9dc250428..70343d887f34 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -588,7 +588,7 @@ static struct kmemleak_object *create_object(unsigned long
> ptr, size_t size,
>         spin_lock_init(&object->lock);
>         atomic_set(&object->use_count, 1);
>         object->flags = OBJECT_ALLOCATED;
> -       object->pointer = ptr;
> +       object->pointer = (unsigned long)kasan_reset_tag((void *)ptr);
>         object->size = size;
>         object->excess_ref = 0;
>         object->min_count = min_count;
> @@ -748,11 +748,12 @@ static void paint_it(struct kmemleak_object *object, int
> color)
>  static void paint_ptr(unsigned long ptr, int color)
>  {
>         struct kmemleak_object *object;
> +       unsigned long addr = (unsigned long)kasan_reset_tag((void *)ptr);
>
> -       object = find_and_get_object(ptr, 0);
> +       object = find_and_get_object(addr, 0);
>         if (!object) {
>                 kmemleak_warn("Trying to color unknown object at 0x%08lx as %s\n",
> -                             ptr,
> +                             addr,
>                               (color == KMEMLEAK_GREY) ? "Grey" :
>                               (color == KMEMLEAK_BLACK) ? "Black" : "Unknown");
>                 return;
>
>

--000000000000288e3a0581651aae
Content-Type: text/x-patch; charset="US-ASCII"; name="kasan-kmemleak-fix.patch"
Content-Disposition: attachment; filename="kasan-kmemleak-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jrwb89kb0>
X-Attachment-Id: f_jrwb89kb0

ZGlmZiAtLWdpdCBhL21tL2ttZW1sZWFrLmMgYi9tbS9rbWVtbGVhay5jCmluZGV4IGY5ZDlkYzI1
MDQyOC4uNTM1NGU3NGYwZDE5IDEwMDY0NAotLS0gYS9tbS9rbWVtbGVhay5jCisrKyBiL21tL2tt
ZW1sZWFrLmMKQEAgLTQzNyw2ICs0MzcsOCBAQCBzdGF0aWMgc3RydWN0IGttZW1sZWFrX29iamVj
dCAqbG9va3VwX29iamVjdCh1bnNpZ25lZCBsb25nIHB0ciwgaW50IGFsaWFzKQogewogCXN0cnVj
dCByYl9ub2RlICpyYiA9IG9iamVjdF90cmVlX3Jvb3QucmJfbm9kZTsKIAorCXB0ciA9ICh1bnNp
Z25lZCBsb25nKWthc2FuX3Jlc2V0X3RhZygodm9pZCAqKXB0cik7CisKIAl3aGlsZSAocmIpIHsK
IAkJc3RydWN0IGttZW1sZWFrX29iamVjdCAqb2JqZWN0ID0KIAkJCXJiX2VudHJ5KHJiLCBzdHJ1
Y3Qga21lbWxlYWtfb2JqZWN0LCByYl9ub2RlKTsKQEAgLTU3NSw2ICs1NzcsOCBAQCBzdGF0aWMg
c3RydWN0IGttZW1sZWFrX29iamVjdCAqY3JlYXRlX29iamVjdCh1bnNpZ25lZCBsb25nIHB0ciwg
c2l6ZV90IHNpemUsCiAJc3RydWN0IGttZW1sZWFrX29iamVjdCAqb2JqZWN0LCAqcGFyZW50Owog
CXN0cnVjdCByYl9ub2RlICoqbGluaywgKnJiX3BhcmVudDsKIAorCXB0ciA9ICh1bnNpZ25lZCBs
b25nKWthc2FuX3Jlc2V0X3RhZygodm9pZCAqKXB0cik7CisKIAlvYmplY3QgPSBrbWVtX2NhY2hl
X2FsbG9jKG9iamVjdF9jYWNoZSwgZ2ZwX2ttZW1sZWFrX21hc2soZ2ZwKSk7CiAJaWYgKCFvYmpl
Y3QpIHsKIAkJcHJfd2FybigiQ2Fubm90IGFsbG9jYXRlIGEga21lbWxlYWtfb2JqZWN0IHN0cnVj
dHVyZVxuIik7CkBAIC03MDEsNiArNzA1LDggQEAgc3RhdGljIHZvaWQgZGVsZXRlX29iamVjdF9w
YXJ0KHVuc2lnbmVkIGxvbmcgcHRyLCBzaXplX3Qgc2l6ZSkKIAlzdHJ1Y3Qga21lbWxlYWtfb2Jq
ZWN0ICpvYmplY3Q7CiAJdW5zaWduZWQgbG9uZyBzdGFydCwgZW5kOwogCisJcHRyID0gKHVuc2ln
bmVkIGxvbmcpa2FzYW5fcmVzZXRfdGFnKCh2b2lkICopcHRyKTsKKwogCW9iamVjdCA9IGZpbmRf
YW5kX3JlbW92ZV9vYmplY3QocHRyLCAxKTsKIAlpZiAoIW9iamVjdCkgewogI2lmZGVmIERFQlVH
CkBAIC03ODksNiArNzk1LDggQEAgc3RhdGljIHZvaWQgYWRkX3NjYW5fYXJlYSh1bnNpZ25lZCBs
b25nIHB0ciwgc2l6ZV90IHNpemUsIGdmcF90IGdmcCkKIAlzdHJ1Y3Qga21lbWxlYWtfb2JqZWN0
ICpvYmplY3Q7CiAJc3RydWN0IGttZW1sZWFrX3NjYW5fYXJlYSAqYXJlYTsKIAorCXB0ciA9ICh1
bnNpZ25lZCBsb25nKWthc2FuX3Jlc2V0X3RhZygodm9pZCAqKXB0cik7CisKIAlvYmplY3QgPSBm
aW5kX2FuZF9nZXRfb2JqZWN0KHB0ciwgMSk7CiAJaWYgKCFvYmplY3QpIHsKIAkJa21lbWxlYWtf
d2FybigiQWRkaW5nIHNjYW4gYXJlYSB0byB1bmtub3duIG9iamVjdCBhdCAweCUwOGx4XG4iLApA
QCAtMTMzNCw2ICsxMzQyLDkgQEAgc3RhdGljIHZvaWQgc2Nhbl9ibG9jayh2b2lkICpfc3RhcnQs
IHZvaWQgKl9lbmQsCiAJdW5zaWduZWQgbG9uZyAqZW5kID0gX2VuZCAtIChCWVRFU19QRVJfUE9J
TlRFUiAtIDEpOwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKKwlzdGFydCA9ICh1bnNpZ25lZCBs
b25nICopa2FzYW5fcmVzZXRfdGFnKCh2b2lkICopc3RhcnQpOworCWVuZCA9ICh1bnNpZ25lZCBs
b25nICopa2FzYW5fcmVzZXRfdGFnKCh2b2lkICopZW5kKTsKKwogCXJlYWRfbG9ja19pcnFzYXZl
KCZrbWVtbGVha19sb2NrLCBmbGFncyk7CiAJZm9yIChwdHIgPSBzdGFydDsgcHRyIDwgZW5kOyBw
dHIrKykgewogCQlzdHJ1Y3Qga21lbWxlYWtfb2JqZWN0ICpvYmplY3Q7CkBAIC0xMzQ0LDcgKzEz
NTUsNyBAQCBzdGF0aWMgdm9pZCBzY2FuX2Jsb2NrKHZvaWQgKl9zdGFydCwgdm9pZCAqX2VuZCwK
IAkJCWJyZWFrOwogCiAJCWthc2FuX2Rpc2FibGVfY3VycmVudCgpOwotCQlwb2ludGVyID0gKnB0
cjsKKwkJcG9pbnRlciA9ICh1bnNpZ25lZCBsb25nKWthc2FuX3Jlc2V0X3RhZygodm9pZCAqKSpw
dHIpOwogCQlrYXNhbl9lbmFibGVfY3VycmVudCgpOwogCiAJCWlmIChwb2ludGVyIDwgbWluX2Fk
ZHIgfHwgcG9pbnRlciA+PSBtYXhfYWRkcikK
--000000000000288e3a0581651aae
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--000000000000288e3a0581651aae--

