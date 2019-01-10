Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9833AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:35:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504CF206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SpGkUOmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504CF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GGh3W8J9SNWlN4TMxVQ2kdXWtBRJmPfzaA3nHHQWLwE=; b=SpGkUOmfTjqWxP
	83wIeQtsSWnLLyMREOMJhs2QHFW3eQZYam6EJkssafXBHbmoixnK/iC5mjh6F1SRss38GoAUMe8X4
	F7IkRm6kvOPxuNXgauCJ5+bkaoTqdzCCHtD4r1Ai1O0VbPJulxCb8Tyf1yf0VWU4jyw31yQMJTXIC
	pz/zXNXaEsUKcMGzm7DkDvpUhfXnh/S04XjlPLwInejWe287L0kf7yO+YhyTiYEU0XIeSEQM+BdNI
	CwVXiLbjbmO9QLuq2/ZxniJ+FlLUHeC/ssko65vDSVRP7LraH/XJOifqBiI+wFESaRgeOXFhE/l+0
	Obg99ntgV4QgoDtNl8YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdIX-0002mC-Vn; Thu, 10 Jan 2019 16:35:13 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdIE-00026l-LD
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:34:57 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N3bfB-1hOpxi10ex-010gXM; Thu, 10 Jan 2019 17:25:21 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] sparc64: fix sparc_ipc type conversion
Date: Thu, 10 Jan 2019 17:24:32 +0100
Message-Id: <20190110162435.309262-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:8LjwLF71onD7Un3igtIcMvlIPZOlhlWUzQRoDccuK5lL0rN5NIV
 3nd9PCzb2nQdqQGzIkmdHxgElT6H3c8JzOETRrNb/eN8Z8I6WwBRWsQELv4pGUHfxbWt0fM
 GzgRAOsetyOd9IeatPWWGPu/dnvSY6mChK/iYK7FaIyDgWu+fwsSDLwxUJrfQ/jg0vOF2D0
 ftdh9RqhNUIobjsFwQMQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0BWmXoijGEY=:mXNccY1RGCVRMbSFRhQ+6x
 E4ZBAUUnFiV4gXwLDQLiQXmf4NXTwcJ0njKyf6/9RKQzx3gASMGb382l3tq/sKmqcU8gnWI3L
 C2hBos8gwdWPihh5uiW/+dcXkrMweKm5539JrJtnQ9ePODr+q+nHhi+Wv57lrjIHmB7I0FTyX
 20zyJeMWeEVBDo8C3LPbFsYhkxkALf+Z60kNRW3N+jbwgwqH+8PYvfT1bOPXWqLttIdZAKGSp
 WQ7QPWHih03FrKolgHmxnKwdOnW/odw+HN5Jcp1gJfCi1dM8RD79Arri+fLxBrArV1YnQZD9t
 jEPgLSvYYp55MxtOaWObJ2hBGYms8iN30QEAXsSl4/Un5eJzcXFfol4t1oN4SuZM2OVAPrAsH
 HoqMgjNfSLAW+IGzI2fDY+UtFM6XbuY5qllQLPmHneoTbPkiMoHf4lYdIPY/cg4NR1vQriqix
 AvKJB02TCY5iSmuq/upSSqWBjuSdjvSHkT4L+qTRLrxqepISxhVJ0Vc3RODKuzMhAuouEfH3a
 cP+IuHhtI5pswkIR9MLTR30lLdzkvArScCESVlfNXu0YYVBArrgCNcFUUPRpJjM0ymsmMWg0N
 ZCiKh/XmP47hv4dWr4u1y0e8PLNn8i4mNbeWw63FUQ+ekQWMbR7Kew5E5CDxOLFSCnV1F1MbC
 sYmeo+cw0VGW2iI9f3u4+J7WJI7Av5sfck99J1/spFIIEZHQniODy0Ir0kCFJ+AwVjcKQCVTE
 yUBkeZDcMisd1eHR1HD9hjLFDq6PJ/QMKbpjKg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_083455_375406_939367F5 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk,
 mingo@redhat.com, geert@linux-m68k.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>,
 heiko.carstens@de.ibm.com, linux-m68k@lists.linux-m68k.org,
 ink@jurassic.park.msu.ru, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

__kernel_timespec and timespec are currently the same type, but once
they are different, the type cast has to be changed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 274ed0b9b3e0..1c079e7bab09 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -344,7 +344,7 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call, int, first, unsigned long, second
 			goto out;
 		case SEMTIMEDOP:
 			err = sys_semtimedop(first, ptr, (unsigned int)second,
-				(const struct timespec __user *)
+				(const struct __kernel_timespec __user *)
 					     (unsigned long) fifth);
 			goto out;
 		case SEMGET:
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
