Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1364AC282E9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:06:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B892220823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tle0tfYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B892220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PqdGM4XO5pPYP970gTsr4N7l3nxkrsyK+SdxXAFmixY=; b=tle0tfYhE95lCZBx2YKJOjOUVW
	ZxF55PJ3sqKshW1pXc2tU0/Y4UqZgeOyBn/NVJkV+KoNHxcleIAiOsBLNAZiqfDDjAutbQ92j5Ve5
	us/8E3VKzu4VMZDzujNK78OCA8o7QNrmgX/QnsL5BxVPII07TdPClj5TaypTBWWWH1EV6oMJ7PHCY
	Uk0eBEDXJkpUzEJuCKC2kVvoXWBxWoKWD7u2fkxfVMeTKMtuwD2eA83Xopgh/MZ6C90JLqtGe0g8a
	g52p0W9xt8SUB1L4FzE08IivqDGDo6NGXs0jzFTqh2jzkUYlqUHeXcBsDh0aOjb8IJDNOMK7IuimA
	bWou5U+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUax-00069a-Vu; Mon, 21 Jan 2019 08:06:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUZj-00047G-Rq
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:05:21 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0L83rMt038725
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 03:04:55 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q58e74krv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 03:04:54 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 21 Jan 2019 08:04:51 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 08:04:39 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0L84cJ71114462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 08:04:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D32BE4C046;
 Mon, 21 Jan 2019 08:04:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBE7E4C052;
 Mon, 21 Jan 2019 08:04:33 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.125])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jan 2019 08:04:33 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 21 Jan 2019 10:04:33 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 04/21] memblock: drop memblock_alloc_base_nid()
Date: Mon, 21 Jan 2019 10:03:51 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012108-4275-0000-0000-00000301E9EB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012108-4276-0000-0000-0000381015C0
Message-Id: <1548057848-15136-5-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=821 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_000456_473171_74167E0F 
X-CRM114-Status: GOOD (  21.70  )
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

The memblock_alloc_base_nid() is a oneliner wrapper for
memblock_alloc_range_nid() without any side effect.
Replace it's usage by the direct calls to memblock_alloc_range_nid().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/memblock.h |  3 ---
 mm/memblock.c            | 15 ++++-----------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 60e100f..f7ef313 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -490,9 +490,6 @@ static inline bool memblock_bottom_up(void)
 phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
 					phys_addr_t start, phys_addr_t end,
 					enum memblock_flags flags);
-phys_addr_t memblock_alloc_base_nid(phys_addr_t size,
-					phys_addr_t align, phys_addr_t max_addr,
-					int nid, enum memblock_flags flags);
 phys_addr_t memblock_alloc_base(phys_addr_t size, phys_addr_t align,
 				phys_addr_t max_addr);
 phys_addr_t __memblock_alloc_base(phys_addr_t size, phys_addr_t align,
diff --git a/mm/memblock.c b/mm/memblock.c
index a32db30..c80029e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1346,21 +1346,14 @@ phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
 					flags);
 }
 
-phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
-					phys_addr_t align, phys_addr_t max_addr,
-					int nid, enum memblock_flags flags)
-{
-	return memblock_alloc_range_nid(size, align, 0, max_addr, nid, flags);
-}
-
 phys_addr_t __init memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align, int nid)
 {
 	enum memblock_flags flags = choose_memblock_flags();
 	phys_addr_t ret;
 
 again:
-	ret = memblock_alloc_base_nid(size, align, MEMBLOCK_ALLOC_ACCESSIBLE,
-				      nid, flags);
+	ret = memblock_alloc_range_nid(size, align, 0,
+				       MEMBLOCK_ALLOC_ACCESSIBLE, nid, flags);
 
 	if (!ret && (flags & MEMBLOCK_MIRROR)) {
 		flags &= ~MEMBLOCK_MIRROR;
@@ -1371,8 +1364,8 @@ phys_addr_t __init memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align,
 
 phys_addr_t __init __memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
 {
-	return memblock_alloc_base_nid(size, align, max_addr, NUMA_NO_NODE,
-				       MEMBLOCK_NONE);
+	return memblock_alloc_range_nid(size, align, 0, max_addr, NUMA_NO_NODE,
+					MEMBLOCK_NONE);
 }
 
 phys_addr_t __init memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
