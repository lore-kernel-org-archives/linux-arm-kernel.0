From: vda.linux@googlemail.com (Denys Vlasenko)
Date: Sat, 26 Feb 2011 18:16:18 +0100
Subject: [PATCH 1/2] lib: vsprintf: optimised put_dec() function
In-Reply-To: <20110224141818.7fd0207f.akpm@linux-foundation.org>
References: <a02a83033d5d61c5d78f110b44f24ae5cd94ab06.1298384703.git.mina86@mina86.com>
	<op.vrfg66mgvgw7ix@mnazarewicz-glaptop>
	<20110224141818.7fd0207f.akpm@linux-foundation.org>
Message-ID: <201102261816.18459.vda.linux@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 February 2011 23:18, Andrew Morton wrote:
> On Thu, 24 Feb 2011 23:10:09 +0100
> "Michal Nazarewicz" <mnazarewicz@google.com> wrote:
> 
> > On Thu, 24 Feb 2011 22:52:42 +0100, Andrew Morton wrote:
> > > Also, the funky indenting to align on the "=" is atypical for kernel
> > > code and is inconsistent with the rest of vsprintf.c.  Just a single
> > > space, please.
> > 
> > Want me to resubmit with spaces fixed?
> 
> nah, we'll live.
> 
> I'd prefer that you find a workload where it actually matters :)

/proc data has a lot of decimal numbers, and many tools parse it
repeatedly. Think {,power,io}top, mpstat with a few thousands
of processes. I observed 10% overall speedup in those tools on i386
when vsprintf was optimised last time.

While we are at it, how about adding this trivial patch?

It should speed up generation of small integers: 1,2...7.
They are quite typical values. Look at the output of, say

cat /proc/$$/stat
cat /proc/net/unix

-- 
vda

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d3023df..c399d38 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -455,8 +455,8 @@ char *number(char *buf, char *end, unsigned long long num,
 
 	/* generate full string in tmp[], in reverse order */
 	i = 0;
-	if (num == 0)
-		tmp[i++] = '0';
+	if (num < 8)
+		tmp[i++] = num + '0';
 	/* Generic code, for any base:
 	else do {
 		tmp[i++] = (digits[do_div(num,base)] | locase);
