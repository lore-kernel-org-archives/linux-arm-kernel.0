From: rabin@rab.in (Rabin Vincent)
Date: Wed, 22 Feb 2012 19:02:40 +0530
Subject: [PATCHv2 5/6] jump label: detect %c support for ARM
In-Reply-To: <20120220172158.GI26840@n2100.arm.linux.org.uk>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-6-git-send-email-rabin@rab.in>
 <20120220172158.GI26840@n2100.arm.linux.org.uk>
Message-ID: <20120222133240.GA9031@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 05:21:58PM +0000, Russell King - ARM Linux wrote:
> On Sat, Jan 28, 2012 at 07:05:24PM +0530, Rabin Vincent wrote:
> > Some versions of ARM GCC which do support asm goto, have problems
> > handling the the %c specifier.  Since we need the %c to support jump
> > labels on ARM, detect that too in the asm goto detection script to avoid
> > build errors with these versions.
> 
> I'm not sure how this detects properly working %c support.  %c support
> has been rather flakey on ARM for some time, I'm not sure which version
> of gcc was fixed for it.

Right, it only detects that %c on a sym+offset doesn't ICE, which was
what it had been doing since atleast version 4.3.

The assumption was that since asm goto was only added in ~4.5, all older
compilers (regardless of their state of %c support) would choke (as we
want them to) on the existing second half of this script.

I have added the change you suggested below.

> 
> > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
> > 
> > Cc: Jason Baron <jbaron@redhat.com>
> > Cc: linux-kernel at vger.kernel.org
> > Signed-off-by: Rabin Vincent <rabin@rab.in>
> > ---
> >  scripts/gcc-goto.sh |   18 +++++++++++++++++-
> >  1 files changed, 17 insertions(+), 1 deletions(-)
> > 
> > diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
> > index 98cffcb..9b744de 100644
> > --- a/scripts/gcc-goto.sh
> > +++ b/scripts/gcc-goto.sh
> > @@ -2,4 +2,20 @@
> >  # Test for gcc 'asm goto' support
> >  # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
> >  
> > -echo "int main(void) { entry: asm goto (\"\"::::entry); return 0; }" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
> > +cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
> > +int main(void)
> > +{
> > +#ifdef __arm__
> > +	/*
> > +	 * Not related to asm goto, but used by jump label
> > +	 * and broken on some ARM GCC versions (see GCC Bug 48637).
> > +	 */
> > +	static struct { int dummy; int state; } tp;
> > +	asm ("@ %c0" :: "i" (&tp.state));
> 
> While this detects the presence of the ICE, previous compilers included
> the '#' before the constant, which leads to problems.  I think a better
> check would be:
> 	asm(".long %c0" :: "i" (&tp.state));
> 
> to make sure that it spits out something purely numeric, rather than
> something prefixed with a '#'.

OK, done:

8<----------------
>From f3a3bd64f72720def5cfbaedf6ff83ca54f1644b Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin@rab.in>
Date: Wed, 23 Nov 2011 20:05:09 +0530
Subject: [PATCH] jump label: detect %c support for ARM

Some versions of ARM GCC which do support asm goto, do not support
the %c specifier.  Since we need the %c to support jump labels
on ARM, detect that too in the asm goto detection script to avoid
build errors with these versions.

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637

Acked-by: Jason Baron <jbaron@redhat.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 scripts/gcc-goto.sh |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
index 98cffcb..a2af2e8 100644
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
+	asm (".long %c0" :: "i" (&tp.state));
+#endif
+
+entry:
+	asm goto ("" :::: entry);
+	return 0;
+}
+END
-- 
1.7.9
