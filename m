From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu,  6 Apr 2017 20:07:24 +0100
Subject: [RFC kvm-unit-tests PATCH 5/8] Makefile: add explicit mkdir for .o
 targets
In-Reply-To: <20170406190727.5624-1-alex.bennee@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
Message-ID: <20170406190727.5624-6-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is fairly direct way of ensuring the target build directories are
created before we build a binary blob. mkdir -p fails gracefully if
the directory is already there.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 781186e..56598df 100644
--- a/Makefile
+++ b/Makefile
@@ -79,8 +79,13 @@ $(LIBFDT_archive): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
 	$(AR) rcs $@ $^
 
 %.o: %.S
+	mkdir -p $(dir $@)
 	$(CC) $(CFLAGS) -c -nostdlib -o $@ $<
 
+%.o: %.c
+	mkdir -p $(dir $@)
+	$(CC) $(CFLAGS) -c -o $@ $<
+
 -include */.*.d */*/.*.d
 
 all: $(shell git -C $(SRCDIR) rev-parse --verify --short=8 HEAD >build-head 2>/dev/null)
-- 
2.11.0
