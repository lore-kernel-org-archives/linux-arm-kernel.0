Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9075EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B50420823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gJaa2mjK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DFIqnPKo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="hgzmBbWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B50420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=io11rFN1j5L2/YI4TzUbSADYPrAbyoVysU0NiX+M0Jo=; b=gJaa2mjKgVXbqE
	M51cLXmKGH69M+lEKJIsUI5QpbuxR8G5yr0SeRVZnKcSv45WkqvMMaf3JC00gcEGAjYWfFIAhLasK
	yBj9COzELRv+1AqcJyKMQOB426UhwnryuA+S4RRAfmJhgdeMjl74JvqQG3WwcMxeSUu4XVGcfk8e0
	qyIiI9dgyvH+02Ie2f8IdPiiV6Gix49mcZiAdATjqpU1SCbGXswrdYxveRinqsxbaJ9ssp2BkNGrD
	p1uMKtpXH1+/3oP+ZadEy/cJA1dAezGZZUy/NWWdIok70gnd596DSL1eMLBxD+G8qLyTj0YFVXETj
	amgYf40/uix7OuugGVIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKE4-0007rV-0E; Wed, 06 Feb 2019 10:14:40 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKDS-0007Et-P4
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:14:04 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16AA75g016819; Wed, 6 Feb 2019 02:14:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hhtZVHCRcI1BBAdinCqqmRaof8yQo0lW3rGEBD9Baew=;
 b=DFIqnPKoUvWOViXV0AEBW+35mSdq4bj+dPagfew9JglQhHAqv54FUDEMkov0J+ZU11PQ
 chnynMngnbFMUBRALtSt8HOyK5mZD3XHB0+c5dNOT9I9TqtLzEA6kS5r6r7VOkeF3oAA
 DxybN1WmL0hFkdeGpqzDd1lkc8ejnHisIOOGl2sJ0uztt2shNcXpD9DAHftg4PN7lRzM
 smf+mAKOa8IkMv2xEPq5GWZr7GiU3WotclzVakEtS/sDjgEOKnU3lVklcveqFvLLRj+d
 RdpiCK1cS0ivry5wzBofqElaq2fOY+nR6++0H/RVB1+5jMnLOnjbmoLxezasQeYbfHJj 2w== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 2qfc2augvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 06 Feb 2019 02:14:00 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:13:59 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:13:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhtZVHCRcI1BBAdinCqqmRaof8yQo0lW3rGEBD9Baew=;
 b=hgzmBbWEWGk1qE/yL9axdaiwa8GDJlDbN0FGw2BYO4ndQQwtu4siRugf68tcbLcjbCoLUVV77Z9NzzulGd2FA7HAW3fQHk8QAIyqAXrvL5cL+dkWYwiyQJ/tpgdlfqZydj6rwcIdSc0pKeF25nJAsMHqXbfyA35B8CQ1bJxPTMA=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:58 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:57 +0000
From: Vadim Lomovtsev <vlomovtsev@marvell.com>
To: "sgoutham@cavium.com" <sgoutham@cavium.com>, "rric@kernel.org"
 <rric@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] net: thunderx: add nicvf_send_msg_to_pf result check for
 set_rx_mode_task
Thread-Topic: [PATCH 4/8] net: thunderx: add nicvf_send_msg_to_pf result check
 for set_rx_mode_task
Thread-Index: AQHUvgSqmCU6de6Jv0qcSr8F4NhaJg==
Date: Wed, 6 Feb 2019 10:13:55 +0000
Message-ID: <20190206101351.16744-5-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR18MB1238;
 20:EbpgrC+WymjHkd8HQEB8/oNnJyXQLkpBkAeiZTMsK0LzEArhboF/aPrQAZskT4V/OH9MpAiw0AhdanenMn6mlpAvOFl5tjt4G4zSSdOS0ofpX4G5INQpYmZhWtMbt9aOLbrhW5c/YmxZbb1Sjd8PM7hZAJDLiFDF8NtykXRU7GQ=
x-ms-office365-filtering-correlation-id: 28fcbcfc-7361-41bb-e9d5-08d68c1bcea8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR18MB1238; 
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB1238FD8E83D3AAAA136FA15ACD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR18MB1238;
 H:CY4PR18MB1112.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ltUAxn7yTMeVos6mFagaNwdlwPxw13Q/xbIbwG5Ge7C3beacu8xwHXcRdJ7morZfuE6Q1rS/ctzq08llseREKFJdR0nOCMFy1RvSOrq5hOlHMkF/HKxljcvZCNkAA/YG6MD3hqX9w9oVtY4NNqxKcTcca5QA2eoL9u3PbBUfFjulyHLj02z+e/RzNogOgkLZmyJaYTjVg+fmHHbgCKK/TlbEfAOnNXFx2Ht8N/h0ODJ5bRV/0WUDE0gYX/WrC1CtQv00HSLKLoiLwDubgU/1CPB2rwooNYt8jqNlWNOmIQeOhe40uwuKu2KqPo7gG1glrzImGUCuZ/qbWVP9ak/cqhpojNOEcxHJxsrzHkK3jCzfPkPQu6OhPwR4CNg4vEb5Ve+hRYCWmSrmCx8hEQFFz/vb+OHssDEU9igfKL06xPI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fcbcfc-7361-41bb-e9d5-08d68c1bcea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:55.8788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1238
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_06:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_021403_056307_391B6A23 
X-CRM114-Status: GOOD (  14.13  )
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
Cc: "dnelson@redhat.com" <dnelson@redhat.com>,
 Vadim Lomovtsev <vlomovtsev@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The rx_set_mode invokes number of messages to be send to PF for receive
mode configuration. In case if there any issues we need to stop sending
messages and release allocated memory.

This commit is to implement check of nicvf_msg_send_to_pf() result.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index b0e8a04e0f1e..dbd8862d60d6 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1956,7 +1956,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 
 	/* flush DMAC filters and reset RX mode */
 	mbx.xcast.msg = NIC_MBOX_MSG_RESET_XCAST;
-	nicvf_send_msg_to_pf(nic, &mbx);
+	if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+		goto free_mc;
 
 	if (mode & BGX_XCAST_MCAST_FILTER) {
 		/* once enabling filtering, we need to signal to PF to add
@@ -1964,7 +1965,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 		 */
 		mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
 		mbx.xcast.data.mac = 0;
-		nicvf_send_msg_to_pf(nic, &mbx);
+		if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+			goto free_mc;
 	}
 
 	/* check if we have any specific MACs to be added to PF DMAC filter */
@@ -1973,9 +1975,9 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 		for (idx = 0; idx < mc_addrs->count; idx++) {
 			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
 			mbx.xcast.data.mac = mc_addrs->mc[idx];
-			nicvf_send_msg_to_pf(nic, &mbx);
+			if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+				goto free_mc;
 		}
-		kfree(mc_addrs);
 	}
 
 	/* and finally set rx mode for PF accordingly */
@@ -1983,6 +1985,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 	mbx.xcast.data.mode = mode;
 
 	nicvf_send_msg_to_pf(nic, &mbx);
+free_mc:
+	kfree(mc_addrs);
 }
 
 static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
-- 
2.17.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
