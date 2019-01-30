Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D02121473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i/PjgD80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D02121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HK3R5zFlwjloW4ggp8Po0mabK+azvsNakMznvV0ezh0=; b=i/PjgD80NYNBVM
	bz0oHJwInsuBVvmaVqKbf+tH6Q6q8wFNAR32P6sPe03rFMpVI1VlOc3lNAxUjti6fcb0b25JUE1Ee
	wRB+p1gFrXwNKDz3cpNNbYHrru5PDfYiG4coiTL0IozeZfjxcRmeQ8uF5hgDi4FFB6dl1zQbrgTBi
	kxLYTG/MymuPU2GbbbYBHf+Y489hm0llTSr5PUQ47R4r9H9vKn6TxbWd9yuemPakkEv1SUA2fFaKG
	IICCPEjE2+uRIF8tqkYJaXOPXxp7K7fE6X6rge12YSZkHCnBZFsQB+qbMHoWdMDaXs6UxDQd05ZV3
	khe6ZwoFPblvFQQegofw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gozct-0001nx-6G; Wed, 30 Jan 2019 23:50:39 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gozco-0001mr-DL
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 23:50:36 +0000
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0UNoSoi061321;
 Thu, 31 Jan 2019 08:50:28 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Thu, 31 Jan 2019 08:50:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp
 [153.232.104.119]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0UNoPnB061293
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Thu, 31 Jan 2019 08:50:28 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: fractional-divider: check parent rate only for general
 approximation
Date: Thu, 31 Jan 2019 08:50:22 +0900
Message-Id: <20190130235022.21949-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_155034_674576_03A039D1 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Custom approximation of fractional-divider may not need parent clock
rate checking. For example Rockchip SoCs work fine using grand parent
clock rate even if target rate is greater than parent.

This patch removes parent clock rate check from custom approximation.

For detailied example, clock tree of Rockchip I2S audio hardware.
  - A i2s1_div is integer divider can divide input clock 1/1 ~ 1/16.
    Initialize divider value is 1.
  - A i2s1_frac is fractional divider can divide input to x/y, x and
    y are 16bit integer.
  - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.

CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
GPLL --> |          | ,--------------'    |          |
                      `--> i2s1_frac ---> |          |

Clock mux system try to choose suitable one from i2s1_div and
i2s1_frac for master clock (MCLK) of I2S1.

Bad scenario as follows:
  - Try to set MCLK to 8.192MHz (32kHz audio replay)
    Candidate setting is
    - i2s1_div : GPLL / 60           = 8.192MHz
    i2s1_div is same as target clock rate, so mux choose this.
    i2s1_div output rate is changed 491.52MHz -> 8.192MHz

  - After that try to set to 11.2896MHz (44.1kHz audio replay)
    Candidate settings are
    - i2s1_div : CPLL / 107 = 11.214945MHz
    - i2s1_frac: i2s1_div   = 8.192MHz
      This is because clk_fd_round_rate() thinks target rate
      (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
      and returns parent clock rate.
    Clock mux system choose i2s1_div, but this clock rate is not
    acceptable for I2S driver, so users cannot replay audio.

Expected behavior is:
  - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
    Candidate settings are
    - i2s1_div : CPLL / 107          = 11.214945MHz
    - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
                 (change i2s1_div to GPLL / 1 = 491.52MHz)
      If apply this commit, clk_fd_round_rate() calls custom
      approximate function of Rockchip even if target rate is higher
      than parent. Custom function changes both grand parent
      (i2s1_div) and parent (i2s_frac) settings at same time.
    Clock mux system can choose i2s1_frac and audio works fine.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/clk-fractional-divider.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 545dceec0bbf..b0fc5509e0ff 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long m, n;
 	u64 ret;
 
-	if (!rate || rate >= *parent_rate)
+	if (!rate)
 		return *parent_rate;
 
-	if (fd->approximation)
+	if (fd->approximation) {
 		fd->approximation(hw, rate, parent_rate, &m, &n);
-	else
+	} else {
+		if (rate >= *parent_rate)
+			return *parent_rate;
+
 		clk_fd_general_approximation(hw, rate, parent_rate, &m, &n);
+	}
 
 	ret = (u64)*parent_rate * m;
 	do_div(ret, n);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
