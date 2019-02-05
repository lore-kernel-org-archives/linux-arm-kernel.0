Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A7C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:12:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10042080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMviKANG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10042080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7IdxgK/0EicJRzdV37Kcy5gpqMERk2JBJbdvldpy2QU=; b=HMviKANGz0tD8z
	0wZxv3ejgRJ5589gRqvYbhe29LAu+x8YbQGJDxytYfcFFLbQBPH4vC4ffvuk1zQISzZAou9py1w5y
	29h+DrzRhDRZ+WTYjTkx70tcnX+3NpYpAgAXIPlwdmtfDCIOFYUpuAQYGmrAbtkXiv8CyE7LcRC18
	DC5lGBrMteMV0oFXfwpBq2UJZxYATj0PvUOnSlpy4H++z1gLsjKgHsB+rzOiz/VeEUSYkpChjW538
	CRGZYCAJHePeCvKoWRTtOQWK3xDkvJEy5ufTUFhgCs0TGgkCFktPQ98Hc6A2wHIseFwNUEHLURCsP
	PZzUyWF5ccyT6RmccIjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr810-0006Q4-Tn; Tue, 05 Feb 2019 21:12:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr80m-0006Ln-7x
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 21:12:15 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B32D93C2CDA;
 Tue,  5 Feb 2019 21:12:07 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-91.bos.redhat.com [10.18.17.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B37F5C1B5;
 Tue,  5 Feb 2019 21:12:06 +0000 (UTC)
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
To: Alex Kogan <alex.kogan@oracle.com>, Peter Zijlstra <peterz@infradead.org>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
 <20190205092256.GN17528@hirez.programming.kicks-ass.net>
 <4A727687-51F9-4FD0-9608-CDBAD6A6EF07@oracle.com>
From: Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <9ba407a6-8f16-876e-549a-d82176d2234e@redhat.com>
Date: Tue, 5 Feb 2019 16:12:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4A727687-51F9-4FD0-9608-CDBAD6A6EF07@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 05 Feb 2019 21:12:08 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_131208_511958_CF299731 
X-CRM114-Status: GOOD (  18.66  )
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com,
 will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 Rahul Yadav <rahul.x.yadav@oracle.com>, mingo@redhat.com,
 Steven Sistare <steven.sistare@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDIvMDUvMjAxOSAwNDowNyBQTSwgQWxleCBLb2dhbiB3cm90ZToKPj4gRG9pbmcgdGltZSBh
bmFseXNpcyBvbiBhIHJhbmRvbWl6ZWQgYWxnb3JpdGhtIGlzbid0IG15IGlkZWEgb2YgZnVuLgo+
Pgo+Pj4gSXQgc2VlbXMgdGhhdCBldmVuIHRvZGF5LCBxc3BpbmxvY2sgZG9lcyBub3Qgc3VwcG9y
dCBSVF9QUkVFTVBULCBnaXZlbgo+Pj4gdGhhdCBpdCB1c2VzIHBlci1DUFUgcXVldWUgbm9kZXMu
Cj4+IEl0IGRvZXMgd29yayB3aXRoIFJULCBjb21taXQ6Cj4+Cj4+ICA3YWE1NGJlMjk3NjUgKCJs
b2NraW5nL3FzcGlubG9jaywgeDg2OiBQcm92aWRlIGxpdmVuZXNzIGd1YXJhbnRlZSIpCj4+Cj4+
IGl0IGEgZGlyZWN0IHJlc3VsdCBvZiBSVCBvYnNlcnZpbmcgZnVubmllcyB3aXRoIGl0LiBJJ3Zl
IG5vIGlkZWEgd2h5IHlvdQo+PiB0aGluayBpdCB3b3VsZCBub3Qgd29yay4KPiBKdXN0IHRyeWlu
ZyB0byBnZXQgdG8gdGhlIGJvdHRvbSBvZiBpdCDigJQgYXMgb2YgdG9kYXksIHFzcGlubG9jayBl
eHBsaWNpdGx5IGFzc3VtZXMKPiBubyBwcmVlbXB0aW9uIHdoaWxlIHdhaXRpbmcgZm9yIHRoZSBs
b2NrLgo+Cj4gSGVyZSBpcyB3aGF0IFdhaW1hbiBoYWQgdG8gc2F5IGFib3V0IHRoYXQgaW4gaHR0
cHM6Ly9sd24ubmV0L0FydGljbGVzLzU2MTc3NToKPgo+ICJUaGUgaWRlYSBiZWhpbmQgdGhpcyBz
cGlubG9jayBpbXBsZW1lbnRhdGlvbiBpcyB0aGUgZmFjdCB0aGF0IHNwaW5sb2Nrcwo+IGFyZSBh
Y3F1aXJlZCB3aXRoIHByZWVtcHRpb24gZGlzYWJsZWQuIEluIG90aGVyIHdvcmRzLCB0aGUgcHJv
Y2Vzcwo+IHdpbGwgbm90IGJlIG1pZ3JhdGVkIHRvIGFub3RoZXIgQ1BVIHdoaWxlIGl0IGlzIHRy
eWluZyB0byBnZXQgYQo+IHNwaW5sb2NrLuKAnQo+Cj4gVGhpcyB3YXMgYmFjayBpbiAyMDEzLCBi
dXQgdGhlIGNvZGUgc3RpbGwgdXNlcyBwZXItQ1BVIHF1ZXVlIG5vZGVzLAo+IGFuZCBBRkFJQ1Qs
IHByZWVtcHRpb24gd2lsbCBicmVhayB0aGluZ3MgdXAuCj4KPiBTbyB3aGF0IHlvdSBhcmUgc2F5
aW5nIGlzIHRoYXQgUlQgd291bGQgYmUgZmluZSBhc3N1bWluZyBubyBwcmVlbXB0aW9uIGluCj4g
dGhlIHNwaW5sb2NrIGFzIGxvbmcgYXMgaXQgcHJvdmlkZXMgRklGTz8gT3IgdGhlcmUgaXMgc29t
ZSBmdXR1cmUgY29kZSBwYXRjaCAKPiB0aGF0IHdpbGwgdGFrZSBjYXJlIG9mIHRoZSDigJxubyBw
cmVlbXB0aW9u4oCdIGFzc3VtcHRpb24gKGJ1dCBzdGlsbCBhc3N1bWUgRklGTyk/Cj4KPiBUaGFu
a3MsCj4g4oCUIEFsZXgKClNvbWUgb2YgdGhlIGNyaXRpY2FsIHNlY3Rpb25zIHByb3RlY3RlZCBi
eSBzcGlubG9ja3MgbWF5IGhhdmUgZXhlY3V0aW9uCnRpbWVzIHRoYXQgYXJlIG11Y2ggbG9uZ2Vy
IHRoYW4gZGVzaXJlZC4gVGhhdCBpcyB3aHkgdGhleSBhcmUgY29udmVydGVkCnRvIHJ0LW11dGV4
IGluIHRoZSBSVCBrZXJuZWwuIFRoZXJlIGlzIGFub3RoZXIgY2xhc3Mgb2Ygc3BpbmxvY2tzIGNh
bGxlZApyYXcgc3BpbmxvY2tzLiBUaGV5IGFyZSB0aGUgc2FtZSBhcyByZWd1bGFyIHNwaW5sb2Nr
cyBpbiBub24gUlQta2VybmVsLApidXQgcmVtYWluIHNwaW5sb2NrcyB3aXRoIG5vIHByZWVtcHRp
b24gYWxsb3dlZCBpbiBSVC1rZXJuZWwgYXMgc2xlZXBpbmcKbG9ja3MgY2FuJ3QgYmUgdXNlZCBp
biBhdG9taWMgY29udGV4dC4gVGhpcyBpcyB3aGVyZSB0aGUgcmVwbGFjZW1lbnQgb2YKdGhlIGN1
cnJlbnQgcXNwaW5sb2NrIGNvZGUgYnkgeW91ciBOVU1BLWF3YXJlIHFzcGlubG9jayBtYXkgc2Ny
ZXcgdXAgdGhlCnRpbWluZyBndWFyYW50ZWUgdGhhdCBjYW4gYmUgcHJvdmlkZWQgYnkgdGhlIFJU
LWtlcm5lbC4KCkNoZWVycywKTG9uZ21hbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
