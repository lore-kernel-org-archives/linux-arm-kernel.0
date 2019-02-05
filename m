Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC13BC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:48:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A6C207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TZYj8fSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A6C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/zL/Kfnig4b6UDcMnM31WuxNg9A+Qn/5EurD6WKUTjg=; b=TZYj8fSdXbE2r4
	N8YPylp2NG+Bc6k0oKlx1ZRS7XoZLvUPCC22uJ9zqz38GP/i7XYdHAqj+e+sgAbVz+UcaW4L+hwZA
	3KyOuvGE3DL9FIEpkJMI5LfDQqn+IfemtjQ0d4kcfzBGSs8PNReGd9siXI4A1kd4xHfzVnb8vOiGf
	EBBkVUhUEJ7Xz8KU5GdrXaPhN3bSEIDGWGK90jPIWvMgc7AB7SN06UDujc2v+6K9i2iC+WSiOm8Xn
	HAwePHrb8QWlzoRXVQSQISTWvTIzr8zFwikfUD/c70l2Io12AyvSpMA6UMNl2mt0COqo6noxf1QR/
	piFkiv8JSG0v/EuE1PoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr15Y-0008CB-Ud; Tue, 05 Feb 2019 13:48:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr15U-0008BV-Kc
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 13:48:34 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77E2F8830E;
 Tue,  5 Feb 2019 13:48:30 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-91.bos.redhat.com [10.18.17.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 578B571D4F;
 Tue,  5 Feb 2019 13:48:28 +0000 (UTC)
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
To: Peter Zijlstra <peterz@infradead.org>, Alex Kogan <alex.kogan@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
 <20190205092256.GN17528@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <16095d28-d3e9-7394-d3c6-1bd24381173d@redhat.com>
Date: Tue, 5 Feb 2019 08:48:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 05 Feb 2019 13:48:31 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_054832_717101_09A20ED5 
X-CRM114-Status: GOOD (  15.67  )
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
 rahul.x.yadav@oracle.com, mingo@redhat.com, steven.sistare@oracle.com,
 Thomas Gleixner <tglx@linutronix.de>, daniel.m.jordan@oracle.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDIvMDUvMjAxOSAwNDoyMiBBTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cj4gT24gTW9uLCBG
ZWIgMDQsIDIwMTkgYXQgMTA6MzU6MDlQTSAtMDUwMCwgQWxleCBLb2dhbiB3cm90ZToKPj4+IE9u
IEphbiAzMSwgMjAxOSwgYXQgNTowMCBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRl
YWQub3JnPiB3cm90ZToKPj4+Cj4+PiBPbiBXZWQsIEphbiAzMCwgMjAxOSBhdCAxMDowMTozNVBN
IC0wNTAwLCBBbGV4IEtvZ2FuIHdyb3RlOgo+Pj4+IENob29zZSB0aGUgbmV4dCBsb2NrIGhvbGRl
ciBhbW9uZyBzcGlubmluZyB0aHJlYWRzIHJ1bm5pbmcgb24gdGhlIHNhbWUKPj4+PiBzb2NrZXQg
d2l0aCBoaWdoIHByb2JhYmlsaXR5IHJhdGhlciB0aGFuIGFsd2F5cy4gV2l0aCBzbWFsbCBwcm9i
YWJpbGl0eSwKPj4+PiBoYW5kIHRoZSBsb2NrIHRvIHRoZSBmaXJzdCB0aHJlYWQgaW4gdGhlIHNl
Y29uZGFyeSBxdWV1ZSBvciwgaWYgdGhhdAo+Pj4+IHF1ZXVlIGlzIGVtcHR5LCB0byB0aGUgaW1t
ZWRpYXRlIHN1Y2Nlc3NvciBvZiB0aGUgY3VycmVudCBsb2NrIGhvbGRlcgo+Pj4+IGluIHRoZSBt
YWluIHF1ZXVlLiAgVGh1cywgYXNzdW1pbmcgbm8gZmFpbHVyZXMgd2hpbGUgdGhyZWFkcyBob2xk
IHRoZQo+Pj4+IGxvY2ssIGV2ZXJ5IHRocmVhZCB3b3VsZCBiZSBhYmxlIHRvIGFjcXVpcmUgdGhl
IGxvY2sgYWZ0ZXIgYSBib3VuZGVkCj4+Pj4gbnVtYmVyIG9mIGxvY2sgdHJhbnNpdGlvbnMsIHdp
dGggaGlnaCBwcm9iYWJpbGl0eS4KPj4+Pgo+Pj4+IE5vdGUgdGhhdCB3ZSBjb3VsZCBtYWtlIHRo
ZSBpbnRlci1zb2NrZXQgdHJhbnNpdGlvbiBkZXRlcm1pbmlzdGljLAo+Pj4+IGJ5IHN0aWNraW5n
IGEgY291bnRlciBvZiBpbnRyYS1zb2NrZXQgdHJhbnNpdGlvbnMgaW4gdGhlIGhlYWQgbm9kZQo+
Pj4+IG9mIHRoZSBzZWNvbmRhcnkgcXVldWUuIEF0IHRoZSBoYW5kb2ZmIHRpbWUsIHdlIGNvdWxk
IGluY3JlbWVudAo+Pj4+IHRoZSBjb3VudGVyIGFuZCBjaGVjayBpZiBpdCBpcyBiZWxvdyBhIHRo
cmVzaG9sZC4gVGhpcyBhZGRzIGFub3RoZXIKPj4+PiBmaWVsZCB0byBxdWV1ZSBub2RlcyBhbmQg
bmVhcmx5LWNlcnRhaW4gbG9jYWwgY2FjaGUgbWlzcyB0byByZWFkIGFuZAo+Pj4+IHVwZGF0ZSB0
aGlzIGNvdW50ZXIgZHVyaW5nIHRoZSBoYW5kb2ZmLiBXaGlsZSBzdGlsbCBiZWF0aW5nIHN0b2Nr
LAo+Pj4+IHRoaXMgdmFyaWFudCBhZGRzIGNlcnRhaW4gb3ZlcmhlYWQgb3ZlciB0aGUgcHJvYmFi
aWxpc3RpYyB2YXJpYW50Lgo+Pj4gKGFsc28gaGVhdmlseSBzdWZmZXJzIGZyb20gdGhlIHNvY2tl
dCA9PSBub2RlIGNvbmZ1c2lvbikKPj4+Cj4+PiBIb3cgd291bGQgeW91IHN1Z2dlc3QgUlQgJ3R1
bmVzJyB0aGlzPwo+Pj4KPj4+IFJUIHJlbGllcyBvbiBGSUZPIGZhaXJuZXNzIG9mIHRoZSBiYXNp
YyBzcGlubG9jayBwcmltaXRpdmVzOyB5b3UganVzdAo+Pj4gY29tcGxldGVseSB3cmVja2VkIHRo
YXQuCj4+IFRoaXMgaXMgdHJ1ZSB0aGF0IENOQSB0cmFkZXMgc29tZSBmYWlybmVzcyBmb3Igc2hv
cnRlciBsb2NrIGhhbmRvdmVyCj4+IGxhdGVuY3ksIG11Y2ggbGlrZSBhbnkgb3RoZXIgTlVNQS1h
d2FyZSBsb2NrLgo+Pgo+PiBDYW4geW91IGV4cGxhaW4sIGhvd2V2ZXIsIHdoYXQgZXhhY3RseSBi
cmVha3MgaGVyZT8KPiBUaW1lbGluZXNzIGd1YXJhbnRlZXMuIEZJRk8tZmFpciBoYXMgd2VsbCBk
ZWZpbmVkIHRpbWUgYmVoYXZpb3VyOyB5b3UKPiBrbm93IGV4YWN0bHkgaG93IGxvbmcgeW91IGdl
dCB0byB3YWl0IGJlZm9yZSB5b3UgYWNxdWlyZSB0aGUgbG9jaywKPiBuYW1lbHkgaG93ZXZlciBt
YW55IHdhaXRlcnMgYXJlIGluIGZyb250IG9mIHlvdSBtdWx0aXBsaWVkIGJ5IHRoZSB3b3JzdAo+
IGNhc2Ugd2FpdCB0aW1lLgo+Cj4gRG9pbmcgdGltZSBhbmFseXNpcyBvbiBhIHJhbmRvbWl6ZWQg
YWxnb3JpdGhtIGlzbid0IG15IGlkZWEgb2YgZnVuLgoKUlQgZG9lc24ndCB3b3JrIHdlbGwgd2l0
aCBOVU1BIHFzcGlubG9jayBpcyBhbm90aGVyIHJlYXNvbiB3aHkgSSB3YW50IGl0CnRvIGJlIGEg
c2VwYXJhdGUgc2xvdyBwYXRoLiBXZSB3aWxsIGRpc2FibGUgaXTCoCBvbiBhIFJUIGtlcm5lbCB3
aGVyZQpndWFyYW50ZWVkIGxvdyBsYXRlbmN5IGlzIGEgbXVzdCBhbmQgdGhyb3VnaHB1dCBpc24n
dCBhcyBpbXBvcnRhbnQuCgpDaGVlcnMsCkxvbmdtYW4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
