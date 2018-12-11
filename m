Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C29C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B6A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LhKfki97";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lOb2hJb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B6A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+aDNQEAGYgxshBl/GMOI5ZGuDAU5dtiYfafunC/g+Ow=; b=LhK
	fki97x8rztoOhBDfAHCts7UuxffI7egeCPZUe44ZzGSZBZM31RosC8C08+gZEubsAoTbkl0bchp4m
	yL4VBczMlGPsxu8JdH268eQR10zOaU9iW9eNubjU3mHhqzBNZyESGODCCCNHQsVETJOqE1Ub84Z0j
	QfUx8emM+dE7dh54Z5JvwhdKW1vBtFE8KO4et/ptzI3qNmwz2oWpHsUrj/4H4EkRHEkqhTUtpbrh8
	kRimenTG7S6M3ysTobe8K2YUEAWoIUONReYDQUXLETFhvMG4NdDI5NluWMtgblyLIb1TIDww3U6AM
	gulhTeN6F9n0+kT/lU4VUWj8h63Q3gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWfns-0002BD-Pf; Tue, 11 Dec 2018 11:02:16 +0000
Received: from conuserg-11.nifty.com ([210.131.2.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWfnp-0002AW-1N
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 11:02:15 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id wBBB1C5b017210;
 Tue, 11 Dec 2018 20:01:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5b017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544526073;
 bh=Z/kHxnD36c3oVOGfo1iWK8KYD5sXAJ88UzOGKFNqvfQ=;
 h=From:To:Cc:Subject:Date:From;
 b=lOb2hJb4WTGHwsHZAMoJG6Axbi3gbyL/FI1KnvYeUbegRSTFmInqWEQMhaNjFFMUh
 IYRRTFww77M5vu8WEf0HR+iqrqAdNeZVQeoCQCCBhfjVtmzTRWwTDB2VESsENB2xnX
 0f3UYJweUyciKDaiRjShBvhDY74qJYy8eBTk27i2WPWsWv5ESdFIfEucfQpTKXlPR0
 V7ZHnwdADLDaG/cvFu9xTh4IqfxIdnrkg3v9hAI7b8yQ0JSOrfjVnBKw61MZK6vvse
 kY0FUQtdbpeoW9S46ipXyrWyDPQqPCcUMpU2IoCXo+MhYll8oE5Kj2v/pPKvv7dg8i
 sCJ5D+/UClOsg==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 00/27] kconfig: remove all reduce/shift conflicts,
 refactor lexer, fix various issues
Date: Tue, 11 Dec 2018 20:00:43 +0900
Message-Id: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_030213_418425_433D3BB1 
X-CRM114-Status: UNSURE (   9.57  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>,
 Ulf Magnusson <ulfalizer@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


When I tryed to change something, I was often hit by annoying
shift/reduce conflicts in the parser.

The lexer and parser are too cluttered.

So, I decided to clean-up now.

  - Fix all shift/reduce conflicts in the parser

  - Rewrite the lexer. The linear keyword search was removed.
    The number of states descreased from 6 to 4.

  - Fix various subtle issues



Masahiro Yamada (27):
  kconfig: fix file name and line number of warn_ignored_character()
  kconfig: fix memory leak when EOF is encountered in quotation
  kconfig: require T_EOL to reduce visible statement
  kconfig: remove unneeded pattern matching to whitespaces
  kconfig: refactor pattern matching in STRING state
  kconfig: fix ambiguous grammar in terms of new lines
  kconfig: clean up EOF handling in the lexer
  kconfig: warn no new line at end of file
  kconfig: remove grammatically ambiguous "unexpected option" diagnostic
  kconfig: remove grammatically ambiguous option_error
  kconfig: remove redundant if_block rule
  kconfig: remove redundant menu_block rule
  kconfig: loosen the order of "visible" and "depends on" in menu entry
  kconfig: rename depends_list to comment_option_list
  kconfig: remove redundant token defines
  kconfig: use distinct tokens for type and default properties
  kconfig: refactor scanning and parsing "option" properties
  kconfig: use specific tokens instead of T_ASSIGN for assignments
  kconfig: use T_WORD instead of T_VARIABLE for variables
  microblaze: surround string default in Kconfig with double quotes
  treewide: surround file paths in Kconfig files with double quotes
  kconfig: ban the use of '.' and '/' in unquoted words
  kconfig: refactor end token rules
  kconfig: stop associating kconf_id with yylval
  kconfig: switch to ASSIGN_VAL state in the second lexer
  kconfig: update current_pos in the second lexer
  kconfig: remove keyword lookup table entirely

 arch/arm/Kconfig                 |   2 +-
 arch/arm/kvm/Kconfig             |   2 +-
 arch/arm64/Kconfig               |   2 +-
 arch/arm64/kvm/Kconfig           |   2 +-
 arch/ia64/Kconfig                |   2 +-
 arch/m68k/Kconfig                |   6 +-
 arch/microblaze/Kconfig.platform |   2 +-
 arch/mips/kvm/Kconfig            |   2 +-
 arch/openrisc/Kconfig            |   2 +-
 arch/powerpc/Kconfig             |   4 +-
 arch/powerpc/kvm/Kconfig         |   2 +-
 arch/riscv/Kconfig               |   2 +-
 arch/s390/Kconfig                |   2 +-
 arch/s390/kvm/Kconfig            |   2 +-
 arch/sh/Kconfig                  |   2 +-
 arch/sparc/Kconfig               |   2 +-
 arch/x86/Kconfig                 |   2 +-
 arch/x86/kvm/Kconfig             |   2 +-
 block/Kconfig                    |   2 +-
 crypto/Kconfig                   |   4 +-
 drivers/crypto/Kconfig           |   2 +-
 drivers/gpu/drm/i915/Kconfig     |   2 +-
 drivers/hwmon/Kconfig            |   2 +-
 drivers/i2c/Kconfig              |   6 +-
 drivers/pps/Kconfig              |   4 +-
 drivers/ras/Kconfig              |   2 +-
 drivers/thermal/Kconfig          |   2 +-
 drivers/w1/Kconfig               |   4 +-
 kernel/Kconfig.preempt           |   2 +-
 lib/Kconfig.debug                |   4 +-
 scripts/kconfig/kconf_id.c       |  52 --------
 scripts/kconfig/lkc.h            |  19 +--
 scripts/kconfig/menu.c           |  43 +++---
 scripts/kconfig/preprocess.c     |   3 +-
 scripts/kconfig/zconf.l          | 232 +++++++++++++++++---------------
 scripts/kconfig/zconf.y          | 280 ++++++++++++++++-----------------------
 security/Kconfig                 |  16 +--
 security/integrity/Kconfig       |   4 +-
 38 files changed, 313 insertions(+), 414 deletions(-)
 delete mode 100644 scripts/kconfig/kconf_id.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
