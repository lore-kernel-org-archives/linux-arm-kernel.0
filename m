Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38314C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B7C222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N54I9Kby";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3rMYQH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B7C222D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=stltYOubgbi09N7gocmziU0zbnP9fWnW/7BCYXvyWfc=; b=N54I9KbykF3LEg
	UHHyKKic2e12Kt4ZklMDap7wBd5fhyraATR2s6R98054ESgyrgjVjxKDHyYuI16p5jKTOv9ivmy9o
	b0qPOa4y7U2/6HPAEXiRdF6RLir+jKaLXbbiZjOvKpfMb76dE3viB4Yj7/he2Cl2TNtqe2cl0mjva
	60TzBs3O4orSh/fdWq4LSGfKmre/ffc/j29Vqrnz1W9KFyjgZUQV0h5btgR5zMxxcorcQ49VQTedm
	2mp/CB+Z1EIwZ9X0g9yno2BdGYBSydl7AInJ6BSxPKUGXA/DtlFYrBxvZuNLyALmNrZZqy3z1IvHx
	lwzFJntFnxqolaF/Eolg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRer-00045S-D7; Fri, 15 Feb 2019 00:47:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guReo-00044q-8p
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:47:12 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B547521B68;
 Fri, 15 Feb 2019 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191630;
 bh=+hE+qlOmRMqLG/tS2/yHWVVTDT/v4Eay2XDgTd6ofWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a3rMYQH8FXs5Ba6G2BHGy/VAT/F/5IVIddbrO8i8aebpIyJOHQaS/1ymQTRxJpWV0
 hDLdo/XJZSgXFdJ8XRxufx8UxFxmPMUNb1Q11yaS6/glS8h+4Kn3bexUhHb/dsFvfC
 AQNearcf4LmPbK4YnwjJhvz/Y9uBwoFukJ66xQg4=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 19/43] perf coresight: Do not test for libopencsd by default
Date: Thu, 14 Feb 2019 21:45:15 -0300
Message-Id: <20190215004539.23571-20-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164710_343747_44DB1892 
X-CRM114-Status: GOOD (  13.63  )
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Kim Phillips <kim.phillips@arm.com>, Mike Leach <mike.leach@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki Poulouse <suzuki.poulose@arm.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since it is not yet that generally available, avoid testing for the
presence of libcoresight in the fast path test-all.bin feature test.

  # dnf search opencsd
  No matches found.
  # dnf search OpenCSD
  No matches found.
  # cat /etc/fedora-release
  Fedora release 29 (Twenty Nine)
  #

I.e. right now, in my system test-all.bin is failing all the time since
Fedora29 doesn't have libopencsd available:

  $ cat /tmp/build/perf/feature/test-all.make.output
  In file included from test-all.c:174:
  test-libopencsd.c:2:10: fatal error: opencsd/c_api/opencsd_c_api.h: No such file or directory
   #include <opencsd/c_api/opencsd_c_api.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  compilation terminated.

See:

  6ab2b762befd ("perf build: Disable libbabeltrace check by default")

For the rationale, as soon as libopencsd becomes more generally packaged
and available, we do the same thing we did with babeltrace, enabling it
by default, as done in:

  24787afbcd01 ("perf tools: Enable LIBBABELTRACE by default")

For now, to explicitely ask for opencsd, make sure you have it installed
and use:

   make -C tools/perf CORESIGHT=1

The feature test output will be there as an empty file:

  $ ls -la /tmp/build/perf/feature/test-libopencsd.make.output

Because the binary used for the feature check was successfully built:

  $ ls -la /tmp/build/perf/feature/test-libopencsd.bin
  -rwxrwxr-x. 1 acme acme 18336 Feb 12 14:49 /tmp/build/perf/feature/test-libopencsd.bin
  $ ldd /tmp/build/perf/feature/test-libopencsd.bin
	linux-vdso.so.1 (0x00007fffe18cc000)
	libopencsd_c_api.so.0 => /lib64/libopencsd_c_api.so.0 (0x00007fb8e67f6000)
	libopencsd.so.0 => /lib64/libopencsd.so.0 (0x00007fb8e676f000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fb8e65a9000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007fb8e6411000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fb8e628d000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fb8e6272000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fb8e6828000)
  $

And the resulting perf binary will be linked with it:

  -rw-rw-r--. 1 acme acme 0 Feb 12 14:49 /tmp/build/perf/feature/test-libopencsd.make.output
  $ ldd ~/bin/perf | grep opencsd
	libopencsd_c_api.so.0 => /lib64/libopencsd_c_api.so.0 (0x00007fd43097f000)
	libopencsd.so.0 => /lib64/libopencsd.so.0 (0x00007fd4308f8000)
  $

To make sure this gets built before pushing things upstream I have a
ubuntu:19.04-x-arm64 container that has:

  [root@quaco x-arm64]# grep CORESIGHT Dockerfile
  ENV EXTRA_MAKE_ARGS=CORESIGHT=1
  [root@quaco x-arm64]#

So that I always build with libopencsd before pushing things upstream.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-20vyy39jw9jgrijesi30fgox@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature   | 2 +-
 tools/build/feature/test-all.c | 5 -----
 tools/perf/Makefile.config     | 3 ++-
 tools/perf/Makefile.perf       | 2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 5467c6bf9ceb..bb9dca65eb5f 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -70,7 +70,6 @@ FEATURE_TESTS_BASIC :=                  \
         sched_getcpu			\
         sdt				\
         setns				\
-        libopencsd			\
         libaio
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
@@ -84,6 +83,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libbabeltrace                  \
          libbfd-liberty                 \
          libbfd-liberty-z               \
+         libopencsd                     \
          libunwind-debug-frame          \
          libunwind-debug-frame-arm      \
          libunwind-debug-frame-aarch64  \
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 20cdaa4fc112..74329957553a 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -170,10 +170,6 @@
 # include "test-setns.c"
 #undef main
 
-#define main main_test_libopencsd
-# include "test-libopencsd.c"
-#undef main
-
 #define main main_test_libaio
 # include "test-libaio.c"
 #undef main
@@ -217,7 +213,6 @@ int main(int argc, char *argv[])
 	main_test_sched_getcpu();
 	main_test_sdt();
 	main_test_setns();
-	main_test_libopencsd();
 	main_test_libaio();
 
 	return 0;
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e6360d47e73a..cf4a8329c4c0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -388,7 +388,8 @@ ifeq ($(feature-setns), 1)
   $(call detected,CONFIG_SETNS)
 endif
 
-ifndef NO_CORESIGHT
+ifdef CORESIGHT
+  $(call feature_check,libopencsd)
   ifeq ($(feature-libopencsd), 1)
     CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
     LDFLAGS += $(LIBOPENCSD_LDFLAGS)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 09df1c8a4ec9..c2ccc54618d1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -102,7 +102,7 @@ include ../scripts/utilities.mak
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
 #
-# Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
+# Define CORESIGHT if you DO WANT support for CoreSight trace decoding.
 #
 # Define NO_AIO if you do not want support of Posix AIO based trace
 # streaming for record mode. Currently Posix AIO trace streaming is
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
