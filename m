Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE049C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:11:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771C620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o69ctRmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771C620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jIUuoRk1JGStSCy1jeCpJGmYffRM/kxG1KMCr3zOK8Q=; b=o69ctRmAVsxXf4
	IhA/CjUDAOcFgR2Q5kD+AIud3CzieYDM8/cn4JxluYb386L+8+qf2MuVeHDMozb2X3wn1UG/TP4xK
	kss9u6oM6SdbYgfD9ST1RDs3LCHGilnN3DssRv7vgNm0DhdkurRFrYdxvj15ahqvbuxq7zbriAwpu
	dvTd+lOfmprvejIvkeHwCHgAzgv/etV/aK2iLGiBl9VIHSTzUGklBqdABJCOJfPsTukKhUiN78JKx
	cQeK9wI6CxzNo1TD0YZ7OrVWGVyDqQudZFOtP5vaoZUALiUe7ZjKY9hCSvN3SmEvJGlXf76tqY9BI
	gqlJa403ZGF2UTSuGslw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQlw-0000hs-Jt; Thu, 13 Dec 2018 13:11:24 +0000
Received: from [190.15.121.82] (helo=quaco.ghostprotocols.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQlt-0000hQ-Tz
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:11:22 +0000
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id EE48E41B1D; Thu, 13 Dec 2018 10:11:13 -0300 (-03)
Date: Thu, 13 Dec 2018 10:11:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v3 0/8] perf cs-etm: Correct packets handling
Message-ID: <20181213131113.GH21027@kernel.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkyFZqUYghGmSS-j50EaOvce57CP+Y737xRF3HjPrHDVqw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYkyFZqUYghGmSS-j50EaOvce57CP+Y737xRF3HjPrHDVqw@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Em Wed, Dec 12, 2018 at 11:45:44AM -0700, Mathieu Poirier escreveu:
> On Tue, 11 Dec 2018 at 00:40, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > perf cs-etm module converts decoder elements to packets and then we have
> > more context crossing packets to generate synthenize samples, finally
> > perf tool can faciliate samples for statistics and report the results.
> >
> > This patch series is to address several issues found related with
> > packets handling and samples generation when worked firstly on branch
> > sample flags support for Arm CoreSight trace data, so this patch series
> > is dependency for sample flags setting, will send another dedicated
> > patch series for sample flags later.
> >
> > In this patch series, the first two patches are mainly to fix issues in
> > cs_etm__flush(): patch 0001 corrects packets swapping in cs_etm__flush()
> > and this can fix the wrong branch sample caused by the missed packets
> > swapping; patch 0002 is to fix the wrong samples generation with stale
> > packets at the end of trace block.
> >
> > Patch 0003 and 0004 are for minor fixing; patch 0003 removes unused field
> > 'cs_etm_decoder::trace_on', this can simplize the switch-case code for all
> > discontinuity packet generation by using one code block; patch 0004 is to
> > refactor enumeration cs_etm_sample_type.
> >
> > Patch 0005 is to rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY, we use
> > a more general packet type to present trace discontinuity, so it can be
> > used by TRACE_ON event, and also can be used by NO_SYNC and EO_TRACE
> > elements.
> >
> > Patch 0006 is used to support NO_SYNC packet, otherwise the trace
> > decoding cannot reflect the tracing discontinuity caused by NO_SYNC
> > packet.
> >
> > Patch 0007 is used to support EO_TRACE packet, which also introduces
> > the tracing discontinuity at the end of trace and we should save last
> > trace data for it.
> >
> > Patch 0008 is used to generate branch sample for exception packets.
> >
> > Credit to Mike Leach and Robert Walker who made me clear for underlying
> > mechanism for NO_SYNC/EO_TRACE elements, Mike also shared the detailed
> > explanation for why we can treat NO_SYNC and TRACE_ON elements as the
> > same, so except following Mike & Rob suggestion for trace discontinuity
> > consolidation, most commit log of patches 0006/0007 also come from
> > Mike's explanation.
> >
> > This patch series is applied directly on the acme's perf/core branch [1]
> > with latest commit aaab25f03e9e ("perf trace: Allow selecting use the
> > use of the ordered_events code").
> >
> > With applying the dependency patch, this patch series has been tested
> > for branch samples dumping with below command on Juno board:
> >
> >   # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux
> 
> Good day Arnaldo,
> 
> I have reviewed all the changes in this set - please consider adding
> to your next branch.  Let me know if you want a pull request.

Thanks, applied manually, pushing now to my tmp.perf/core branch, please
take a look at the commit log messages to see if I didn't messed up
anything. :-)

- Arnaldo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
