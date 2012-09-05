From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Sep 2012 22:05:34 +0100
Subject: [PATCH v2 20/31] arm64: User access library function
In-Reply-To: <20120905210135.GA87548@MacBook-Pro.local>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-21-git-send-email-catalin.marinas@arm.com>
 <201208151449.54834.arnd@arndb.de>
 <20120905191312.GH24085@n2100.arm.linux.org.uk>
 <20120905210135.GA87548@MacBook-Pro.local>
Message-ID: <20120905210534.GI24085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 10:01:37PM +0100, Catalin Marinas wrote:
> There are indeed a few KB gain in code size but that's probably coming
> from the exception table since otherwise you just replace a bl with
> ldrt. It depends on what the compiler does as well, the arm code has
> some carefully chosen registers when calling the __get_user_x function.

It's more than that - it's not just the ldr but also a zeroing of a
temporary register to hold the error code should the instruction fault.
So it's not only the exception tables but also an increase in the
main path - and that's where you benefit from having it out of line and
thereby a hotter i-cache.

> If you do the access_ok inline and the __get_user_x separately, the size
> increase is even greater (at least in the arm64 case it can get to over
> 20KB). I think x86 does the access_ok check out of line.

Please talk to Will about get_user() and put_user().  Afterwards you
will definitely want to keep them out of line on 64-bit ARM.
