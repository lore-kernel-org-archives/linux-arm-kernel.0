Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EECDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:48:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF3C206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LRH0+8Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF3C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=W70GG6SIyLynlZkN7ysn3wBF2lpl5Q2306Lh2XkuslA=; b=LRH0+8SdN0uQokOtHXqJSJqZtW
	XEaNw98QwLOi+1IZcQTGGFi9Kr5vgYxvkRoM77LFtYv10RGaK39YG51d2qJFFksw3z+xtZv4RVusY
	Kl1XvVFNgbgkJIfS7Hw52r7DvQAMG19aKCw5E0jMj6NjvKBGY4C2DS/fGpcB7/lksXaoIH46OcTDs
	56+fuDOIq9ZHTpwef9bExZFYU86Z8Z04IglQHmuCntx4UwvFcf98hnXgRyjFwchuVeDWJTSqTqlOk
	VX0XsY+QQsOStFFwCWXU1IYmIyXWPktb5pOfyay70VodcpgNvkHjbwlJJKrEL/gFLmecO4kzGrgNS
	CY1WP1oQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjlYi-0005Qv-Bo; Wed, 16 Jan 2019 13:48:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlVy-0002ZJ-GK
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:46:34 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0GDeioN110775
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 08:45:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q25b3s87w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 08:45:53 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Wed, 16 Jan 2019 13:45:50 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 13:45:40 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0GDjeAi50659422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 13:45:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9A2DA4051;
 Wed, 16 Jan 2019 13:45:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B025DA404D;
 Wed, 16 Jan 2019 13:45:35 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Jan 2019 13:45:35 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Wed, 16 Jan 2019 15:45:35 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 15/21] sparc: add checks for the return value of
 memblock_alloc*()
Date: Wed, 16 Jan 2019 15:44:15 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-0016-0000-0000-0000024644A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-0017-0000-0000-000032A061CE
Message-Id: <1547646261-32535-16-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_054555_544431_3662ACDA 
X-CRM114-Status: GOOD (  23.70  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>,
 linux-xtensa@linux-xtensa.org, linux-alpha@vger.kernel.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add panic() calls if memblock_alloc*() returns NULL.

Most of the changes are simply addition of

        if(!ptr)
                panic();

statements after the calls to memblock_alloc*() variants.

Exceptions are pcpu_populate_pte() and kernel_map_range() that were
slightly refactored to accommodate the change.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sparc/kernel/prom_32.c  |  2 ++
 arch/sparc/kernel/setup_64.c |  6 ++++++
 arch/sparc/kernel/smp_64.c   | 12 ++++++++++++
 arch/sparc/mm/init_64.c      | 11 +++++++++++
 arch/sparc/mm/srmmu.c        |  8 ++++++++
 5 files changed, 39 insertions(+)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index e7126ca..869b16c 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -33,6 +33,8 @@ void * __init prom_early_alloc(unsigned long size)
 	void *ret;
 
 	ret = memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!ret)
+		panic("%s: Failed to allocate %lu bytes\n", __func__, size);
 
 	prom_early_allocated += size;
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 51c4d12..fd2182a 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -624,8 +624,14 @@ void __init alloc_irqstack_bootmem(void)
 
 		softirq_stack[i] = memblock_alloc_node(THREAD_SIZE,
 						       THREAD_SIZE, node);
+		if (!softirq_stack[i])
+			panic("%s: Failed to allocate %lu bytes align=%lx nid=%d\n",
+			      __func__, THREAD_SIZE, THREAD_SIZE, node);
 		hardirq_stack[i] = memblock_alloc_node(THREAD_SIZE,
 						       THREAD_SIZE, node);
+		if (!hardirq_stack[i])
+			panic("%s: Failed to allocate %lu bytes align=%lx nid=%d\n",
+			      __func__, THREAD_SIZE, THREAD_SIZE, node);
 	}
 }
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index f45d876..a8275fe 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1628,6 +1628,8 @@ static void __init pcpu_populate_pte(unsigned long addr)
 		pud_t *new;
 
 		new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
 		pgd_populate(&init_mm, pgd, new);
 	}
 
@@ -1636,6 +1638,8 @@ static void __init pcpu_populate_pte(unsigned long addr)
 		pmd_t *new;
 
 		new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
 		pud_populate(&init_mm, pud, new);
 	}
 
@@ -1644,8 +1648,16 @@ static void __init pcpu_populate_pte(unsigned long addr)
 		pte_t *new;
 
 		new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
 		pmd_populate_kernel(&init_mm, pmd, new);
 	}
+
+	return;
+
+err_alloc:
+	panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
+	      __func__, PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ef340e8..f2d70ff 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1809,6 +1809,8 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 
 			new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE,
 						  PAGE_SIZE);
+			if (!new)
+				goto err_alloc;
 			alloc_bytes += PAGE_SIZE;
 			pgd_populate(&init_mm, pgd, new);
 		}
@@ -1822,6 +1824,8 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 			}
 			new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE,
 						  PAGE_SIZE);
+			if (!new)
+				goto err_alloc;
 			alloc_bytes += PAGE_SIZE;
 			pud_populate(&init_mm, pud, new);
 		}
@@ -1836,6 +1840,8 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 			}
 			new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE,
 						  PAGE_SIZE);
+			if (!new)
+				goto err_alloc;
 			alloc_bytes += PAGE_SIZE;
 			pmd_populate_kernel(&init_mm, pmd, new);
 		}
@@ -1855,6 +1861,11 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 	}
 
 	return alloc_bytes;
+
+err_alloc:
+	panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
+	      __func__, PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+	return -ENOMEM;
 }
 
 static void __init flush_all_kernel_tsbs(void)
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a400ec3..aaebbc0 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -305,11 +305,17 @@ static void __init srmmu_nocache_init(void)
 
 	srmmu_nocache_pool = memblock_alloc(srmmu_nocache_size,
 					    SRMMU_NOCACHE_ALIGN_MAX);
+	if (!srmmu_nocache_pool)
+		panic("%s: Failed to allocate %lu bytes align=0x%x\n",
+		      __func__, srmmu_nocache_size, SRMMU_NOCACHE_ALIGN_MAX);
 	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
 
 	srmmu_nocache_bitmap =
 		memblock_alloc(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
 			       SMP_CACHE_BYTES);
+	if (!srmmu_nocache_bitmap)
+		panic("%s: Failed to allocate %zu bytes\n", __func__,
+		      BITS_TO_LONGS(bitmap_bits) * sizeof(long));
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
 
 	srmmu_swapper_pg_dir = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
@@ -468,6 +474,8 @@ static void __init sparc_context_init(int numctx)
 
 	size = numctx * sizeof(struct ctx_list);
 	ctx_list_pool = memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!ctx_list_pool)
+		panic("%s: Failed to allocate %lu bytes\n", __func__, size);
 
 	for (ctx = 0; ctx < numctx; ctx++) {
 		struct ctx_list *clist;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
