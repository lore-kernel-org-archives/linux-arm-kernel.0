Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85966C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:51:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A84222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="imjc4Fiw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ZvbKmuhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A84222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Mime-Version:References:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=VxYx7YpMdW24uzKZNZVeF5zGoWG6q0R+x+xrdaimKc8=; b=imjc4FiwMMheVa
	AMZIdVBQXJLegPUSuTgQqzgupFUrpJFYoiwkS//OJP941lHfLhIUwN0SKYM8w3/ggJLMWwKINo46r
	My6oNIgNpMDZ5LeqYFeRupJs2FiozYnx7XnzgIh/oWkt8Id7WrdcYocNPqW1PbwJZx/hWkoVVbnWt
	D/qu8nJJLZYf5sY0m5eOzYRjCrCqd1UMqWginT+XvuVDc3m2qyIcY4unxCqoV+hOrF09tjYITmkP/
	y5El3J6kN9qINuldff86DHcWHhbJMyIfTd+DtKxEt/VwWY8T55nmQQU7c1l0Btm/v1Ku9EI1zaNwc
	hi7PefU2AXLpTpHVEWxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guul5-0006pc-6S; Sat, 16 Feb 2019 07:51:35 +0000
Received: from m12-15.163.com ([220.181.12.15])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guul1-0006pD-9T
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 07:51:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Mime-Version:Message-ID; bh=Ucs3u
 lYeyXDgczU/nt6GtMmcH88O0xxSGbAp8V7Ju7A=; b=ZvbKmuhNTCkw4+2nr3HY9
 XamIQOq0ayGZUS/oHpiMV8ct3KupSQhlx2W5zKdgWSV4B9xHjyqyWk49DomtzoHX
 MtXjEuAFa9jP9aJRejCHyL4678RbI6f8quLyIkp3oUeYmeDyVPuSWh6DeCiMMFYF
 AbkA61eQnoPe+g9xku8d5I=
Received: from WIN-20190131HRV (unknown [117.36.118.253])
 by smtp11 (Coremail) with SMTP id D8CowABnAiH8wGdch5OGDg--.54895S2;
 Sat, 16 Feb 2019 15:51:25 +0800 (CST)
Date: Sat, 16 Feb 2019 15:50:19 +0800
From: "sxauwsk@163.com" <sxauwsk@163.com>
To: "Shubhrajyoti Datta" <shubhrajyoti.datta@gmail.com>
Subject: [PATCH] i2c: cadence: try reset when master receive error interrupts
References: <20190129195214.30272-1-sxauwsk@163.com>, 
 <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>
X-Priority: 3
X-GUID: 330EB380-DC8E-4023-9E19-B85588D3136D
X-Has-Attach: no
X-Mailer: Foxmail 7.2.9.156[cn]
Mime-Version: 1.0
Message-ID: <2019021615501780626817@163.com>
X-CM-TRANSID: D8CowABnAiH8wGdch5OGDg--.54895S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1rXrW5AFWxGr4xXr4fKrg_yoW8uF45pa
 18GanIkrWIqF12qFnFqr17XFyruw4rKFyUKr4rtas7uF1q9rnxt347tFW5uF4fCry5Aw1I
 vrZ0ya9rGF1YvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSOJ5UUUUU=
X-Originating-IP: [117.36.118.253]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/1tbiVB1dJlUMHGCePgAAs3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_235131_801270_2830E318 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 "michal.simek" <michal.simek@xilinx.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PkhpIFN4YXV3c2ssCj4KPk9uIFdlZCwgSmFuIDMwLCAyMDE5IGF0IDM6MTMgUE0gc3hhdXdzayA8
c3hhdXdza0AxNjMuY29tPiB3cm90ZToKPj4KPj4gV2hlbiB0aGUgYWRhcHRlciByZWNlaXZlIGVy
cm9yIGludGVycnVwdHMsIHN1Y2ggYXMgTkFDSywgYXJiaXRyYXRpb24gbG9zdCwKPj4gY2Ruc19p
MmNfbWFzdGVyX3hmZXIgcmV0dXJuIHRvIHRoZSBjYWxsZXIgZGlyZWN0bHkgaW5zdGVhZCBvZiBy
ZXN1bWluZwo+PiB0aGUgYWRhcHRlciB3aGljaCByZXN1bHRlZCBpbiB0aGUgYWRhcHRlciBiZWlu
ZyBvdXQgb2YgY29udHJvbC4KPj4KPj4gU28gd2hlbiBkcml2ZXIgZGV0ZWN0IGVycl9zdGF0dXMg
dGhlbiB0cnkgdG8gcmVwYWlyIGFuZCBmaXggaXQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IHN4YXV3
c2sgPHN4YXV3c2tAMTYzLmNvbT4KPj4gLS0tCj4+wqAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1j
YWRlbmNlLmMgfCAxMiArKysrKysrLS0tLS0KPj7CoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1jYWRlbmNlLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWNhZGVuY2UuYwo+PiBp
bmRleCBiMTM2MDU3MTgyOTEuLmUxMDA0OGQ3NTI0YSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9p
MmMvYnVzc2VzL2kyYy1jYWRlbmNlLmMKPj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1j
YWRlbmNlLmMKPj4gQEAgLTU0OCwxMCArNTQ4LDYgQEAgc3RhdGljIGludCBjZG5zX2kyY19wcm9j
ZXNzX21zZyhzdHJ1Y3QgY2Ruc19pMmMgKmlkLCBzdHJ1Y3QgaTJjX21zZyAqbXNnLAo+PsKgwqDC
oMKgwqDCoMKgwqAgY2Ruc19pMmNfd3JpdGVyZWcoQ0ROU19JMkNfSVhSX0FMTF9JTlRSX01BU0ss
Cj4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBD
RE5TX0kyQ19JRFJfT0ZGU0VUKTsKPj4KPj4gLcKgwqDCoMKgwqDCoCAvKiBJZiBpdCBpcyBidXMg
YXJiaXRyYXRpb24gZXJyb3IsIHRyeSBhZ2FpbiAqLwo+PiAtwqDCoMKgwqDCoMKgIGlmIChpZC0+
ZXJyX3N0YXR1cyAmIENETlNfSTJDX0lYUl9BUkJfTE9TVCkKPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FQUdBSU47Cj4+IC0KPj7CoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+PsKgIH0KPj4KPj4gQEAgLTYxNywxMyArNjEzLDE5IEBAIHN0YXRpYyBpbnQgY2Ruc19p
MmNfbWFzdGVyX3hmZXIoc3RydWN0IGkyY19hZGFwdGVyICphZGFwLCBzdHJ1Y3QgaTJjX21zZyAq
bXNncywKPj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWQtPmJ1c19ob2xkX2ZsYWcgPSAwOwo+Pgo+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IGNkbnNfaTJjX3Byb2Nlc3NfbXNnKGlkLCBtc2dzLCBhZGFwKTsKPj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFyZXQpCj4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+Pgo+SW4gY2FzZcKgIHRoZSBBcmJpdHJhdGlvbiBlcnJv
ciBoYXBwZW5kwqAgdGhlIGNkbnNfaTJjX3Byb2Nlc3NfbXNnIHdvdWxkIHJldHVybiAwCj5hbmQg
d2Ugd2lsbCBtaXNzIHRoZSBjaGVja8KgIGJlbG93Lgo+Cj5BbSBJIG1pc3Npbmcgc29tZXRoaW5n
ID8KPgo+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFJlcG9ydCB0aGUgb3Ro
ZXIgZXJyb3IgaW50ZXJydXB0cyB0byBhcHBsaWNhdGlvbiAqLwo+PsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChpZC0+ZXJyX3N0YXR1cykgewo+PsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjZG5zX2kyY19tYXN0ZXJfcmVzZXQoYWRh
cCk7Cj4+Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBJZiBpdCBpcyBidXMgYXJiaXRyYXRpb24gZXJyb3IsIHRyeSBhZ2FpbiAqLwo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlkLT5lcnJfc3RhdHVz
ICYgQ0ROU19JMkNfSVhSX0FSQl9MT1NUKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVBR0FJTjsKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBnb3RvIG91dDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0KPj4gKwo+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoaWQtPmVycl9zdGF0dXMgJiBDRE5TX0kyQ19JWFJfTkFDSykgewo+PsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ID0gLUVOWElPOwo+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+IC0tCj4+IDIuMTkuMgo+Pgo+PiAK
CkluIGNkbnNfaTJjX3Byb2Nlc3NfbXNnIHByb2Nlc3MsIHdoZW4gZGV0ZWN0IGFyYml0cmF0aW9u
IGxvc3QgZXJyb3IgcmV0dXJuIC1FQUdBSU4gdG8gwqBjZG5zX2kyY19tYXN0ZXJfeGZlciwgwqBu
b3QgcmV0dXJuIDAKdGhhdCBtZWFuIGNkbnNfaTJjX3Byb2Nlc3NfbXNnIMKganVzdCBnbyBvdXQg
aWdub3JlIGVycm9yIGNoZWNrIGFuZCDCoHByb2JsZW0gb2NjdXIsIFNvIHdlIHNob3VsZCBkbyBz
b21ldGhpbmcgd2hlbiBhcmJpdHJhdGlvbiBlcnJvciBkZXRlY3QuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
