Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0565C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:00:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5F821920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OTzZcp1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5F821920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:
	MIME-Version:References:Subject:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HnRwFdhJdAXCExNwO3d41RkF4R4eSMLs7huBYj/90QQ=; b=OTzZcp1+IG4u4H
	BlP1azEtdKOOdchOj11dmM3e3hplUPY1U3IFj1G+cvZ8gAwUbp6jdVFdjPZoN3lIzs/cUuswnLr0H
	/mc3B1uvQ9WmT3l5HQAyqvEGw7AuCQcPW3DRfvSVhE38cPyz5v/F3MrnMlaWX8+4wDp40dUlPQ56a
	7hHaYAtio5ayatDZtCXKa8Gx6TUg3A5/scoVjUm+fp/WLn+HDVK2SwrjcKkUryo3WZCXCtCRlVu6a
	EGkiBleCO1eQzP8lpk7ig96DU4s8LIVBsTXY1G9+/MLAgMxQlL+KRFWwW83cBzi/pfcu5ehvjTrJh
	8ZLZGlUgkSW2eTm04dgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaP5w-0002H6-Ig; Fri, 21 Dec 2018 18:00:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaP5t-0001z2-KH
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 18:00:19 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBLHwaQh066704
 for <linux-arm-kernel@lists.infradead.org>; Fri, 21 Dec 2018 13:00:06 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ph22qgnb2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 21 Dec 2018 13:00:06 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <paulmck@linux.vnet.ibm.com>; 
 Fri, 21 Dec 2018 18:00:05 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Dec 2018 18:00:01 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBLI00IO20709428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Dec 2018 18:00:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8375FB2066;
 Fri, 21 Dec 2018 18:00:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60BDEB205F;
 Fri, 21 Dec 2018 18:00:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 21 Dec 2018 18:00:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
 id 3C71216C36A7; Fri, 21 Dec 2018 10:00:07 -0800 (PST)
Date: Fri, 21 Dec 2018 10:00:07 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20181217225020.GA16520@hirez.programming.kicks-ass.net>
 <20181218000800.GB25620@tassilo.jf.intel.com>
 <20181218091824.GI2218@hirez.programming.kicks-ass.net>
 <20181221172044.GE25620@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221172044.GE25620@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18122118-0064-0000-0000-0000038A71D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010262; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01135049; UDB=6.00590197; IPR=6.00915221; 
 MB=3.00024789; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-21 18:00:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122118-0065-0000-0000-00003BC300C5
Message-Id: <20181221180007.GQ4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-21_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812210137
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_100017_787920_42B8C3B0 
X-CRM114-Status: GOOD (  35.48  )
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
Reply-To: paulmck@linux.ibm.com
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, hubicka@ucw.cz,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 09:20:44AM -0800, Andi Kleen wrote:
> > In particular turning an address-dependency into a control-dependency,
> > which is something allowed by the C language, since it doesn't recognise
> > these concepts as such.
> > 
> > The 'optimization' is allowed currently, but LTO will make it much more
> > likely since it will have a much wider view of things. Esp. when combined
> > with PGO.
> > 
> > Specifically; if you have something like:
> > 
> > int idx;
> > struct object objs[2];
> > 
> > the statement:
> > 
> >   val = objs[idx & 1].ponies;
> > 
> > which you 'need' to be translated like:
> > 
> >   struct object *obj = objs;
> >   obj += (idx & 1);
> >   val = obj->ponies;
> > 
> > Such that the load of obj->ponies depends on the load of idx. However
> > our dear compiler is allowed to make it:
> > 
> >   if (idx & 1)
> >     obj = &objs[1];
> >   else
> >     obj = &objs[0];
> > 
> >   val = obj->ponies;
> 
> I don't see why a compiler would do such an optimization. Clearly
> the second variant is worse than the first, bigger and needs
> branch prediction resources.
> 
> In fact compilers usually try hard to go into the other direction
> and apply if conversion.
> 
> Has anyone seen real world examples of such changes being done, or is this
> all language lawyering theory?

I have not seen it myself, but I have heard others claim to.  For example,
if "idx & 1" had to be computed for some other reason, especially if there
was a pre-exiting "if" statement with this as its condition.  Or if you
have hardware that has a conditional-move instruction.  And so on.

Do you have a way to guarantee that it never happens?

							Thanx, Paul

> -Andi
> 
> > 
> > Because C doesn't recognise this as being different. However this is
> > utterly broken, because in this translation we can speculate the load
> > of obj->ponies such that it no longer depends on the load of idx, which
> > breaks RCU.
> > 
> > Note that further 'optimization' is possible and the compiler could even
> > make it:
> > 
> >   if (idx & 1)
> >     val = objs[1].ponies;
> >   else
> >     val = objs[0].ponies;
> > 
> > Now, granted, this is a fairly artificial example, but it does
> > illustrate the exact problem.
> > 
> > The more the compiler can see of the complete program, the more likely
> > it can make inferrences like this, esp. when coupled with PGO.
> > 
> > Now, we're (usually) very careful to wrap things in READ_ONCE() and
> > rcu_dereference() and the like, which makes it harder on the compiler
> > (because 'volatile' is special), but nothing really stops it from doing
> > this.
> > 
> > Paul has been trying to beat clue into the language people, but given
> > he's been at it for 10 years now, and there's no resolution, I figure we
> > ought to get compiler implementations to give us a knob.
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
