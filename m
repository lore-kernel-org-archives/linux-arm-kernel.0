Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFECC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:48:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354D920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CQpBUvs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354D920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NC81JrZGKnwM5813x/dRBbLojVceXcTii/YHCCaaBF8=; b=CQpBUvs2L3CxtoUO7AUBb6XC/m
	OfYfoQJA4FWDPWhpnhvxeYpPpjeIqCM86+YF+U4yzuFx7+dUAs8R8aJ0f5ct4+UTVk+LzSxZ2Ndjo
	W/xhsesoV8cTxcUXDE+LP0GijesxYqsbWgL9vdazVsnZIsBCirDjwRJ0QrhVH9EUrSl1jlNzbqtQO
	X0RDfyb95a5AUiMo4ZGNEsliOPMpILL/pBE3hf7GKGcET6xOHT4XIVIQXDxPp70zdA04Ag7Uq4qe4
	D9QgBcNSDTFfdbhkHKtIfRbj6TdZhSsOD+F4C6C4ztQRZ+xsKd+r6GTfZ/WS9JuoCw2Z8P6MSrfEm
	ivhV1BGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqSM-0007To-8Y; Mon, 03 Dec 2018 15:48:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqS7-0007Bh-1Q
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:48:08 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB3FiDFK064773
 for <linux-arm-kernel@lists.infradead.org>; Mon, 3 Dec 2018 10:47:56 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p56u7tatk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 03 Dec 2018 10:47:55 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 3 Dec 2018 15:47:44 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 15:47:36 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB3FlZJg49676318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 15:47:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3522342047;
 Mon,  3 Dec 2018 15:47:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E966142045;
 Mon,  3 Dec 2018 15:47:31 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.196])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Dec 2018 15:47:31 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 03 Dec 2018 17:47:31 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/6] sh: prefer memblock APIs returning virtual address
Date: Mon,  3 Dec 2018 17:47:12 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120315-0008-0000-0000-0000029C39CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120315-0009-0000-0000-000022069463
Message-Id: <1543852035-26634-4-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=924 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_074807_203365_2C2EA824 
X-CRM114-Status: GOOD (  21.99  )
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rather than use the memblock_alloc_base that returns a physical address and
then convert this address to the virtual one, use appropriate memblock
function that returns a virtual address.

There is a small functional change in the allocation of then NODE_DATA().
Instead of panicing if the local allocation failed, the non-local
allocation attempt will be made.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sh/mm/init.c | 18 +++++-------------
 arch/sh/mm/numa.c |  5 ++---
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index c8c13c77..3576b5f 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -192,24 +192,16 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
 void __init allocate_pgdat(unsigned int nid)
 {
 	unsigned long start_pfn, end_pfn;
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-	unsigned long phys;
-#endif
 
 	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-	phys = __memblock_alloc_base(sizeof(struct pglist_data),
-				SMP_CACHE_BYTES, end_pfn << PAGE_SHIFT);
-	/* Retry with all of system memory */
-	if (!phys)
-		phys = __memblock_alloc_base(sizeof(struct pglist_data),
-					SMP_CACHE_BYTES, memblock_end_of_DRAM());
-	if (!phys)
+	NODE_DATA(nid) = memblock_alloc_try_nid_nopanic(
+				sizeof(struct pglist_data),
+				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
+				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+	if (!NODE_DATA(nid))
 		panic("Can't allocate pgdat for node %d\n", nid);
-
-	NODE_DATA(nid) = __va(phys);
-	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 #endif
 
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
index 830e8b3..c4bde61 100644
--- a/arch/sh/mm/numa.c
+++ b/arch/sh/mm/numa.c
@@ -41,9 +41,8 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 	__add_active_range(nid, start_pfn, end_pfn);
 
 	/* Node-local pgdat */
-	NODE_DATA(nid) = __va(memblock_alloc_base(sizeof(struct pglist_data),
-					     SMP_CACHE_BYTES, end));
-	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
+	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
+					     SMP_CACHE_BYTES, nid);
 
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
 	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
