From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 02 Jan 2012 02:44:36 +0000
Subject: Circular dependency between <linux/kernel.h> and <asm/bug.h> on ARM
Message-ID: <1325472276.13595.200.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 87e040b6456fd3416a1f6831c1eedaef5c0a94ff ("ARM: 7017/1: Use
generic BUG() handler") makes BUG() use BUILD_BUG_ON().  However,
BUILD_BUG_ON() is not defined in <linux/bug.h> but in <linux/kernel.h>.

arch/include/asm/bug.h does not include <linux/kernel.h> and *cannot* do
so because the latter already includes <asm/bug.h>.

Maybe BUILD_BUG_ON() should be moved out to a header of its own, or else
this particular use should be moved to some other file.  This needs to
be fixed somehow, as it obviously leads to build failures, e.g.:

https://buildd.debian.org/status/fetch.php?pkg=linux-2.6&arch=armel&ver=3.2~rc7-1~experimental.1&stamp=1325142904

Ben.

-- 
Ben Hutchings
All the simple programs have been written, and all the good names taken.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120102/df7dcba0/attachment.sig>
