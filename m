Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C72EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:09:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BFF2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iw8sHuyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BFF2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DRX3qz4H8Fy7UQ05FQqllYlaNUsJ90ievLxu0q1Ll0U=; b=Iw8sHuyuPcO1St
	gTz1H74kMMSOb55VGmB3GCuOWXP6ZxmBM0GOzgVtxGy+5jPIqg9AYhUQPU6CBE/Fx2WW10u8RFnSu
	2q3DQOmv7WwAgFVuWpeiBD7y0SLfnAWL6n1QWaZLN2f4xBRYYalb+K+y6wckuGAtzS2MNY57aZJtj
	goeyRSHBoXlWXCS5pxD4z5RsqR5SKaVLybm9Do/0O/qilW8bxS+2uk1wg4ixvSxXRUVL7qnJIVjPs
	9N2Vvb7ScznbTy4PIohb26qxiL41YSRBs140ASUFwKlAB5BBuT0BkY5UwkTjCV2Lz3hgAG1TuwQqa
	4Ro7tHNm/blQZ/SkqhRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqAa-0007Vz-EC; Mon, 18 Feb 2019 21:09:44 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvq8p-0005QC-41; Mon, 18 Feb 2019 21:07:58 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M894P-1gzOdr1DG7-005Hqb; Mon, 18 Feb 2019 22:07:24 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Subject: [PATCH 1/8] compat ABI: use non-compat openat and open_by_handle_at
 variants
Date: Mon, 18 Feb 2019 22:07:05 +0100
Message-Id: <20190218210712.3503891-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:Orj12xgdgMLKf/0v9QWyyXfYt0be3LlRpxJPHPgrMPDM0BnJ6WV
 BiLjhwLgc5U1C/Ku6TThTvBytLILEw94wcflD2P4D8aMVj1M6BMTtsRvQzpDcQi5i2KJmXB
 F+hHXIGVuNx9XyXbHpXSVjE9Lmp6xT8wlf1TVaf6ckTcv5FJ+tMk94wMt83YlYfQSPdcQQA
 vUP00Bef/iee0lCoDfhSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AmDHvMow4jU=:wgjN+bHjmauBTwC5INBuZa
 kwbgPKcxBciSswCZ8/hJX+dA1uKNGxkSQqFWNgUDq9u0H35s+lBE0HS7/bwFirv911RTPPV64
 1QQOCoG/Xv16krmGDJ0c0FzpFwadl4hNLJI+Of0fiQby0i/vJelQdmZf0mt/pgQAazojAZe/e
 FWGpoxzc87oMSDeCUkmRkMA8mZlSuVFPeffCZ7ItzTPBD1xRE4ZLjuMLdzFP14X2czSBqH/UY
 Qt98uvuQb7EUmsBv6mfPxSoUAJ+xKyi4AGkXToXFKc9WOxk4oVhtemBgsFNLGANMqI804JiBv
 700hovB3xfegQzjPemFFwbqE+VpkKpGnOBo+j5MxJvZa03KP3teLkNLAJJmpJu9X7/P/V5fLC
 kNo31gUG4OUYLmep7kwSXhwP46H8zabPtxvXjLdzCWuNQIagzzPoMHMK53ARD8D1gfuZ3Lq+E
 V0DRm9L/csRhGFpfi1EAIYC60T1NxI1BuKAMPqmji5oCBs9q34kiY4mwkWt2J8XVqod77IJ8u
 Yf2GWsxQRDzHfuxfF4pbfj/LBpeaNJUQD8894H24It3r7y4vmCe5Tq0DkkONzy/RhHtKS3ckF
 NRb9duTX2JUd+mqkIgwf8c+sC1K4i+njwigthjhjFPzpp1qDiHQ7BKuyPaDeU5NeFTyPLBjSW
 AQ75D7twBBuOAdhOdZbLdPptocCntHHJS0RbZTTRKKS3NOJpQiiCwk/+18PZkGe7zRx+jzjAs
 Y3NEYyjIAXAUv4vZQ0frh0vqCvbkPt9qcs+E0Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_130755_687980_71B9F7A4 
X-CRM114-Status: UNSURE (   9.59  )
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
Cc: linux-arch@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
 arnd@arndb.de, yury.norov@gmail.com, Yury Norov <ynorov@caviumnetworks.com>,
 linux-api@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Vineet Gupta <vgupta@synopsys.com>, Guo Ren <guoren@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, linux-hexagon@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>,
 Stafford Horne <shorne@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Yury Norov <ynorov@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yury Norov <ynorov@caviumnetworks.com>

The only difference between native and compat openat and open_by_handle_at
is that non-compat version forces O_LARGEFILE, and it should be the
default behaviour for all architectures, as we are going to drop the
support of 32-bit userspace off_t.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index acf9a07ab2ff..b928eff3bf92 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -179,7 +179,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -678,8 +678,7 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
 #define __NR_clock_adjtime 266
 __SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
 #define __NR_syncfs 267
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
