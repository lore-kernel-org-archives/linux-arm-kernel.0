Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D009C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC09720651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOgnn1wp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VEk8BBPd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jntSlpts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC09720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6HZv1RQNC4rrhnnOit+alK8XVu7l+oMbPvc9MEAj+TM=; b=qOgnn1wpmEhab1
	sbEiSknK2i1wiRl5bjsDIIHnGRoBOTwKRSBcvETEgQcR3f7eQuXWMhsUsQpVj4wGsaCvtRdnZGtUE
	h2poQKzfPcwAO8gS818TKhVDV8xy5oHsK7oGnl1j4TMGruoqd5vxnNI1NY2huYPRo3/Uvq+OAa79C
	28k+P7sspdW5vyn1/kvxe3uBmvFaIdlzc/gMBvHA1o1X9ZYpw1bidsshrYYckNSfUJNSjqVASfnEJ
	88K0nPB/bf4Z9/3oO+/l1pxYHxHFWVraO+5unGWWCZtTsqFSQxsRN7rklk+XBkZ3ZjlX3Zyc/+Ntr
	F58rQhx2xO19R8c18T0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycVR-00037y-UE; Tue, 26 Feb 2019 13:10:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycVP-00037g-U7
 for linux-arm-kernel@bombadil.infradead.org; Tue, 26 Feb 2019 13:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oZc1chqonr5OFHhPY+4ktv/rItkbHorQByl5DMoQXYk=; b=VEk8BBPdORGOnX4NmrMxFYf9HU
 xBjr3Hm0LLP99hKZOdeBzuAAzBtkgbv1un9j0wr+z/wzgWjcBLxht/8w6EuYN1JEjh0sRJhaYeu98
 C1sn6QvSgDb+rM+2o8CrSDJJiEwvtm/bTsNZNDynJyh2HGYUxtCg+KGZvnOq64OpQaycIRrx6r1+I
 pYy2qrK/RcivQLdU+7JZ4fbYUFSNSZuoTMSTKPDZ7gc/ljUEllclzF6wPF3SDfxojdAYijMuZADlF
 JVvKECZBi5ZagBAK7ZwZqV4ZwxQWxdR0GvAPa9mykslvymWHzExV6/YRWGCj9ZEjkA/3S9Uk8bRpN
 9Eu9jfKg==;
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybXs-0005Ot-Vr
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:09:14 +0000
Received: by mail-it1-x141.google.com with SMTP id e24so3478911itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oZc1chqonr5OFHhPY+4ktv/rItkbHorQByl5DMoQXYk=;
 b=jntSlptsuzdjhBIgeOHESJCA5eDSREADmyB3Wdr6i1TYBo2xfGZsUVeSvKIUKwguDF
 D259eXEv6aQL8KB2xo2SkkLKTkXfTfDB6yDPZrhWWheObDlD1ZKPcR58ZJsD7i0Oaugh
 ForT8c9GicMqc7Hm8yYeAkdxYCJhSVlXfdXPijBHvU1nB+uvRFPv0mNlIR0rADXSNpZE
 HqGNpl3nfI7M0I2gBLXrsJglSxI93f4OurERh5oQMEiIv/uWWT1K39n6RaH/auy57gNa
 E2LrL1ppjP4xJIfcLiR6CBsnXrvXJfzauo5rCTHIDdbupajm51fgBwxGWvwsFTf9Sgz8
 zLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oZc1chqonr5OFHhPY+4ktv/rItkbHorQByl5DMoQXYk=;
 b=KFgyPJ10mrr8N0g9X26+24oB5LB7ZV05sjibqU74TGPw+TUotIAeTUM8f61YYXNZZy
 yGW1jgFTsVJebVURU30wd+TTXPafqP9TOJ9ii5eUEG8EgN6/HCm/8gYImblXN0xo2vj6
 eLJ4NTqBflPNSC6daFFQCGa0BKSvwR3qTGEM77FzUy8hswOBGzpeul+qn8HnRewHu+wq
 o8kWzhWt3qQ0c6bpaO0I5VwTdEH6uJVlST1gTXZydrg92fCir3nkRoyP2kClI+Gboajs
 UdjrB6htRH4wOheJbZs/IafyRx38XC1vxrYcF40rsk8HzVHO+MCaQa5EfeABLHVzW8Hm
 MDaQ==
X-Gm-Message-State: AHQUAubHObiMA5bT2QyGdO6VkcM54OQSs00Od/o1BV0em1SyTMF78Nm8
 ELtjDz1kO9WAjKSabbmHeD2OBp0+4QyN6eoVEgo4Fw==
X-Google-Smtp-Source: AHgI3Ia48KktGK5QKsSpai22ijyl/WUU1c7eWEqaBMKU1Ha0YEClEjFEbs7YBo8vin9N54PSQyS+BjuAkyyanLJAupA=
X-Received: by 2002:a02:c78d:: with SMTP id n13mr12224416jao.57.1551182950139; 
 Tue, 26 Feb 2019 04:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-5-brgl@bgdev.pl>
 <0750392d-e298-b467-24c0-3c2779ead3f7@lechnology.com>
In-Reply-To: <0750392d-e298-b467-24c0-3c2779ead3f7@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Feb 2019 13:08:59 +0100
Message-ID: <CAMRc=Mcd886pfbOr3cWwMtRJt34DVAEq63B7W8m2Nqkrddw5FQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] ARM: davinci: WARN_ON() if clk_get() fails
To: David Lechner <david@lechnology.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_070913_110341_C5ABEC5C 
X-CRM114-Status: GOOD (  20.37  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Sekhar Nori <nsekhar@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

d3QuLCA1IGx1dCAyMDE5IG8gMDM6MTggRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9neS5j
b20+IG5hcGlzYcWCKGEpOgo+Cj4gT24gMi80LzE5IDExOjE3IEFNLCBCYXJ0b3N6IEdvbGFzemV3
c2tpIHdyb3RlOgo+ID4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJh
eWxpYnJlLmNvbT4KPiA+Cj4gPiBDdXJyZW50bHkgdGhlIHRpbWVyIGNvZGUgY2hlY2tzIGlmIHRo
ZSBjbG9jayBwb2ludGVyIHBhc3NlZCB0byBpdCBpcwo+ID4gZ29vZCAoIUlTX0VSUihjbGspKS4g
VGhlIG5ldyBjbG9ja3NvdXJjZSBkcml2ZXIgZXhwZWN0cyB0aGUgY2xvY2sgdG8KPiA+IGJlIGZ1
bmN0aW9uYWwgYW5kIGRvZXNuJ3QgcGVyZm9ybSBhbnkgY2hlY2tzIHNvIGVtaXQgYSB3YXJuaW5n
IGlmCj4gPiBjbGtfZ2V0KCkgZmFpbHMuIEFwcGx5IHRoaXMgdG8gYWxsIGRhdmluY2kgcGxhdGZv
cm1zLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pl
d3NraUBiYXlsaWJyZS5jb20+Cj4gPiAtLS0KPiA+ICAgYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2Rh
ODMwLmMgIHwgNCArKysrCj4gPiAgIGFyY2gvYXJtL21hY2gtZGF2aW5jaS9kYTg1MC5jICB8IDQg
KysrKwo+ID4gICBhcmNoL2FybS9tYWNoLWRhdmluY2kvZG0zNTUuYyAgfCA0ICsrKysKPiA+ICAg
YXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RtMzY1LmMgIHwgNCArKysrCj4gPiAgIGFyY2gvYXJtL21h
Y2gtZGF2aW5jaS9kbTY0NHguYyB8IDQgKysrKwo+ID4gICBhcmNoL2FybS9tYWNoLWRhdmluY2kv
ZG02NDZ4LmMgfCA0ICsrKysKPiA+ICAgNiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9kYTgzMC5jIGIvYXJj
aC9hcm0vbWFjaC1kYXZpbmNpL2RhODMwLmMKPiA+IGluZGV4IDJjYzlmZTRjM2E5MS4uOWE0Yjc0
OWNiYjZiIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2RhODMwLmMKPiA+
ICsrKyBiL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9kYTgzMC5jCj4gPiBAQCAtODM0LDYgKzgzNCwx
MCBAQCB2b2lkIF9faW5pdCBkYTgzMF9pbml0X3RpbWUodm9pZCkKPiA+ICAgICAgIGRhODMwX3Bs
bF9pbml0KE5VTEwsIHBsbCwgTlVMTCk7Cj4gPgo+ID4gICAgICAgY2xrID0gY2xrX2dldChOVUxM
LCAidGltZXIwIik7Cj4gPiArICAgICBpZiAoV0FSTl9PTihJU19FUlIoY2xrKSkpIHsKPiA+ICsg
ICAgICAgICAgICAgcHJfZXJyKCJVbmFibGUgdG8gZ2V0IHRoZSB0aW1lciBjbG9ja1xuIik7Cj4K
PiBEbyB3ZSByZWFsbHkgbmVlZCBhIHdhcm5pbmcgX2FuZF8gYW4gZXJyb3I/Cj4KClRoYXQgd2ls
bCBnaXZlIHVzIHRoZSByZWFzb24gQU5EIHBvaW50IHVzIHRvIHRoZSByaWdodCBwbGFjZSBpbiB0
aGUgY29kZS4KCkJhcnQKCj4gPiArICAgICAgICAgICAgIHJldHVybjsKPiA+ICsgICAgIH0KPiA+
Cj4gPiAgICAgICBkYXZpbmNpX3RpbWVyX2luaXQoY2xrKTsKPiA+ICAgfQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
