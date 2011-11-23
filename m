From: rabin@rab.in (Rabin Vincent)
Date: Wed, 23 Nov 2011 20:25:09 +0530
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <20111122235041.GB24453@redhat.com>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-4-git-send-email-rabin@rab.in>
 <20111122194213.GC9581@n2100.arm.linux.org.uk>
 <4ECC2A07.8050701@codeaurora.org>
 <20111122233949.GA24453@redhat.com>
 <20111122235041.GB24453@redhat.com>
Message-ID: <20111123145509.GA4973@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:50:41PM -0500, Jason Baron wrote:
> On Tue, Nov 22, 2011 at 06:39:50PM -0500, Jason Baron wrote:
> > Right, for jump labels we have a script at: scripts/gcc-goto.sh, which
> > basically just checks if we can compile 'asm goto' without error, so for
> > %c, you could probably have some simple 'asm()' that uses %c, and see if
> > it compiles. Although, I'm not sure if there's a arch specific dir, for
> > such a thing?
> > 
> > thanks,
> > 
> > -Jason
> 
> hmm...actually we could add it to the top level scripts/gcc-goto.sh,
> that would be fine, I can take a look at that...

Here's a patch.  Atleast on MIPS %c means something else so I had to
ifdef it for ARM:

8<----------------------------
>From ea211ce77e0ea9c5b8cd32b99bfb24e0140f0068 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin@rab.in>
Date: Wed, 23 Nov 2011 20:05:09 +0530
Subject: [PATCH] jump label: detect %c support for ARM

Some versions of ARM GCC don't support the %c specifier fully, but do
support asm goto.  Since we need the %c to support jump labels on ARM,
detect that too in the asm goto detection script to avoid build errors
with these versions.

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 scripts/gcc-goto.sh |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
index 98cffcb..9b744de 100644
--- a/scripts/gcc-goto.sh
+++ b/scripts/gcc-goto.sh
@@ -2,4 +2,20 @@
 # Test for gcc 'asm goto' support
 # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
 
-echo "int main(void) { entry: asm goto (\"\"::::entry); return 0; }" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
+cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
+int main(void)
+{
+#ifdef __arm__
+	/*
+	 * Not related to asm goto, but used by jump label
+	 * and broken on some ARM GCC versions (see GCC Bug 48637).
+	 */
+	static struct { int dummy; int state; } tp;
+	asm ("@ %c0" :: "i" (&tp.state));
+#endif
+
+entry:
+	asm goto ("" :::: entry);
+	return 0;
+}
+END
-- 
1.7.7.3
