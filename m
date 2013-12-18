From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Dec 2013 13:50:58 -0500
Subject: [PATCH V2 2/8] string: fix strncmp function
In-Reply-To: <20131218160114.GP2609@titan.lakedaemon.net>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-3-git-send-email-p.wilczek@samsung.com>
 <20131218121551.GH4360@n2100.arm.linux.org.uk>
 <52B193BE.1080206@gmail.com>
 <20131218125203.GI4360@n2100.arm.linux.org.uk>
 <20131218160114.GP2609@titan.lakedaemon.net>
Message-ID: <20131218185058.GR2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 11:01:15AM -0500, Jason Cooper wrote:
> On Wed, Dec 18, 2013 at 12:52:03PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Dec 18, 2013 at 01:23:26PM +0100, Daniel Mack wrote:
> > > On 12/18/2013 01:15 PM, Russell King - ARM Linux wrote:
> > > > For instance, can you be sure that there aren't any uses of strncmp()
> > > > which already test for less-than-zero etc?
> > > 
> > > In this case, yes. The code as it stands is very small, and users only
> > > check for the return value of these functions to be 0.
> > > 
> > > But I wonder whether that patch is needed at all. At least the rest of
> > > this series does not even seem to introduce new call sites of strcmp()
> > > or strncmp() ...
> > 
> > The implementation appears to be buggy as it stands - all it does is
> > sum up the differences in the whole string.
> > 
> > What if you're comparing two strings:
> > 
> > 	ac
> > 	ca
> > 
> > The first character has a difference of +2, the second has a difference
> > of -2.  Sum those together and you get zero.  Oh, the two strings are
> > identical!
> 
> Yes, you are correct, the implementation isn't perfect.  I'll correct it
> since I introduced it.

I've pushed the following:

-------8<---------------------------------
commit c3da82f0caa50c0efadbd6f129a326dda3fe3dec
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Wed Dec 18 18:24:43 2013 +0000

    string: use kernel version of strncmp()
    
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/string.c b/string.c
index 5105490143c8..629c281f3abd 100644
--- a/string.c
+++ b/string.c
@@ -18,14 +18,18 @@ int strlen(const char *str)
 
 int strncmp(const char *stra, const char *strb, int len)
 {
-	int diff=0;
-	const char *a = stra;
-	const char *b = strb;
-
-	while ((a - stra) < len)
-		diff += *a++ - *b++;
-
-	return diff;
+	unsigned char c1, c2;
+
+	while (len) {
+		c1 = *stra++;
+		c2 = *strb++;
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (!c1)
+			break;
+		len--;
+	}
+	return 0;
 }
 
 void *gethexaddr(const char *str, const char **end)
