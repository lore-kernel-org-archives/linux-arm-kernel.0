From: olof@lixom.net (Olof Johansson)
Date: Sun, 1 Jan 2012 23:01:27 -0800
Subject: Circular dependency between <linux/kernel.h> and <asm/bug.h> on
 ARM
In-Reply-To: <1325472276.13595.200.camel@deadeye>
References: <1325472276.13595.200.camel@deadeye>
Message-ID: <CAOesGMgXRev24e0bmGD71J04=Aon7bs0YeK7mwX8Na12uR_b6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 1, 2012 at 6:44 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> Commit 87e040b6456fd3416a1f6831c1eedaef5c0a94ff ("ARM: 7017/1: Use
> generic BUG() handler") makes BUG() use BUILD_BUG_ON(). ?However,
> BUILD_BUG_ON() is not defined in <linux/bug.h> but in <linux/kernel.h>.
>
> arch/include/asm/bug.h does not include <linux/kernel.h> and *cannot* do
> so because the latter already includes <asm/bug.h>.

Sure it can, but it's not ideal. Since the BUILD_BUG_ON is only used
in bug.h in a #define, it will be resolved below the includes of
either so there should be no ordering issue between the two.

I coincidentally posted a patch earlier to do just that, I didn't see
your email until later.

> Maybe BUILD_BUG_ON() should be moved out to a header of its own, or else
> this particular use should be moved to some other file. ?This needs to
> be fixed somehow, as it obviously leads to build failures, e.g.:
>
> https://buildd.debian.org/status/fetch.php?pkg=linux-2.6&arch=armel&ver=3.2~rc7-1~experimental.1&stamp=1325142904

Or perhaps moving BUILD_BUG_ON to include/linux/bug.h?

The quickest fix for now might be to take out the BUILD_BUG_ON(),
especially so close to 3.2-final.


-Olof
