Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB547C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:02:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7641720989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CrEHcgLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7641720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:
	MIME-Version:References:Subject:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dAbYKFaHr0JG9AvXjOiYTA7qycP3LH+MlO7A0ELODso=; b=CrEHcgLuyO43In
	kYczAJqG+FeeCZdRc8Dti/irxHCOx/+IltMt+52VHXP9NWbu0ME9tNQjOIZ/7B43lkSjQKyb30bxT
	/4kIx7MNaIgFwomWw51JWQiakeMgyyDqWRiTT8UgjeAJJVnncrNQmUjy+vp84KPla2RlslzOWS2I5
	RVrCfFiamjwvZ2ycoI3PFXK+L2blYPa8ASQa4l7EJSO0fTp3at0r10qxTH9M4c8QxzGyjdQXAOn4Q
	Gc9u2toaJ3piuFVTwas0c/DQ0KMQnpXAi8JEAayprP1Itf+R5gTzjViRrQAbAPkIO0vZkEdRh52hn
	7gaMwOx8eq/lQr1fkLwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUU0U-0002f6-71; Wed, 05 Dec 2018 10:02:14 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUU0Q-0002e5-LS
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:02:12 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB59x1g9039193
 for <linux-arm-kernel@lists.infradead.org>; Wed, 5 Dec 2018 05:01:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p6c65h2nw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 05 Dec 2018 05:01:57 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 5 Dec 2018 10:01:52 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 5 Dec 2018 10:01:46 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB5A1jai4194674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 10:01:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0960FAE045;
 Wed,  5 Dec 2018 10:01:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD2E7AE051;
 Wed,  5 Dec 2018 10:01:41 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Wed,  5 Dec 2018 10:01:41 +0000 (GMT)
Date: Wed, 5 Dec 2018 15:31:41 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v2] Uprobes: Fix kernel oops with delayed_uprobe_remove()
References: <20181204005803.787578e7@vmware.local.home>
 <20181205033423.26242-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205033423.26242-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18120510-0008-0000-0000-0000029D245C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120510-0009-0000-0000-000022078688
Message-Id: <20181205100141.GA8473@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-05_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_020210_810629_75FB485A 
X-CRM114-Status: GOOD (  24.16  )
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
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, linux@armlinux.org.uk, peterz@infradead.org,
 jolsa@redhat.com, ralf@linux-mips.org, liu.song.a23@gmail.com, oleg@redhat.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 alexander.shishkin@linux.intel.com, paul.burton@mips.com, mingo@redhat.com,
 mhiramat@kernel.org, ananth@linux.vnet.ibm.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, alexis.berlemont@gmail.com, acme@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-12-05 09:04:23]:

> There could be a race between task exit and probe unregister:
> 
>   exit_mm()
>   mmput()
>   __mmput()                     uprobe_unregister()
>   uprobe_clear_state()          put_uprobe()
>   delayed_uprobe_remove()       delayed_uprobe_remove()
> 
> put_uprobe() is calling delayed_uprobe_remove() without taking
> delayed_uprobe_lock and thus the race sometimes results in a
> kernel crash. Fix this by taking delayed_uprobe_lock before
> calling delayed_uprobe_remove() from put_uprobe().
> 
> Detailed crash log can be found at:
>   https://lkml.org/lkml/2018/11/1/1244
> 
> Reported-by: syzbot+cb1fb754b771caca0a88@syzkaller.appspotmail.com
> Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> ---
>  kernel/events/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 322e97bbb437..abbd8da9ac21 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -572,7 +572,9 @@ static void put_uprobe(struct uprobe *uprobe)
>  		 * gets called, we don't get a chance to remove uprobe from
>  		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
>  		 */
> +		mutex_lock(&delayed_uprobe_lock);
>  		delayed_uprobe_remove(uprobe, NULL);
> +		mutex_unlock(&delayed_uprobe_lock);
>  		kfree(uprobe);
>  	}
>  }
> -- 
> 2.19.2
> 

-- 
Thanks and Regards
Srikar Dronamraju


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
