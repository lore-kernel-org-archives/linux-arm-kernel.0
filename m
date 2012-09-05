From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Sep 2012 22:01:37 +0100
Subject: [PATCH v2 20/31] arm64: User access library function
In-Reply-To: <20120905191312.GH24085@n2100.arm.linux.org.uk>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-21-git-send-email-catalin.marinas@arm.com>
 <201208151449.54834.arnd@arndb.de>
 <20120905191312.GH24085@n2100.arm.linux.org.uk>
Message-ID: <20120905210135.GA87548@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 08:13:12PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 15, 2012 at 02:49:54PM +0000, Arnd Bergmann wrote:
> > It's fairly unusual to have out of line get_user/put_user functions.
> > What is the reason for this, other than copying from ARM?
> 
> Actually, we never used to out of line on ARM, and then I experimented,
> and found there was a net benefit - not only in code size but also
> there appeared to be a performance benefit by out of lining them.

There are indeed a few KB gain in code size but that's probably coming
from the exception table since otherwise you just replace a bl with
ldrt. It depends on what the compiler does as well, the arm code has
some carefully chosen registers when calling the __get_user_x function.

If you do the access_ok inline and the __get_user_x separately, the size
increase is even greater (at least in the arm64 case it can get to over
20KB). I think x86 does the access_ok check out of line.

For now I changed the arm64 code to inline as most of the other
architectures but I'll revisit this when I get some hardware. Another
thing to be optimised is the size of the exception table entry. I use
two .quad declarations for the fault address and branch but I guess they
could be made relative to PAGE_OFFSET and only use .long (or some
prel31).

-- 
Catalin
