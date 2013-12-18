From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Dec 2013 13:56:24 -0500
Subject: [PATCH V2 2/8] string: fix strncmp function
In-Reply-To: <20131218160114.GP2609@titan.lakedaemon.net>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-3-git-send-email-p.wilczek@samsung.com>
 <20131218121551.GH4360@n2100.arm.linux.org.uk>
 <52B193BE.1080206@gmail.com>
 <20131218125203.GI4360@n2100.arm.linux.org.uk>
 <20131218160114.GP2609@titan.lakedaemon.net>
Message-ID: <20131218185624.GS2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 11:01:15AM -0500, Jason Cooper wrote:
> On Wed, Dec 18, 2013 at 12:52:03PM +0000, Russell King - ARM Linux wrote:
> > Oh, and the other nitpick with the code is this:
> > 
> > 	*(a++)
> > 
> > Really, are those parens really needed?  If you don't know the precendence
> > there, then you really shouldn't be programming in C, because this might
> > also be buggy:
> > 
> > 	*(a++) - *(b++)
> > 
> > because if we declare that we don't know the precedence rules, it could be
> > that this is evaluated as *((a++) - (*(b++))) which would lead to errors!
> > Maybe some more parens should be added to make it clear!  Or maybe we
> > should just learn the precedence rules and realise that:
> > 
> > 	*a++ - *b++
> > 
> > is correct and clear and there's no need for any stupid idiotic parens
> > here.
> > 
> > Yes, I loath unnecessary parens.

and I've also pushed the following:

---------------8<----------------------------
commit 6a5d02f396107b2a0f4337d11e63c12ecd2a49c1
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Wed Dec 18 18:19:38 2013 +0000

    string: remove unneeded parentheses
    
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/string.c b/string.c
index 0bd71798c4e6..5105490143c8 100644
--- a/string.c
+++ b/string.c
@@ -10,7 +10,7 @@ int strlen(const char *str)
 {
 	const char *c = str;
 
-	while (*(c++))
+	while (*c++)
 		;
 
 	return c - str;
@@ -23,7 +23,7 @@ int strncmp(const char *stra, const char *strb, int len)
 	const char *b = strb;
 
 	while ((a - stra) < len)
-		diff += *(a++) - *(b++);
+		diff += *a++ - *b++;
 
 	return diff;
 }
