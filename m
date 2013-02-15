From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Feb 2013 11:07:20 +0000
Subject: [PATCH 8/9] [HACK] ARM: imx: work around v7_cpu_resume link error
In-Reply-To: <1360882071-4072668-9-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-9-git-send-email-arnd@arndb.de>
Message-ID: <20130215110720.GL17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 11:47:50PM +0100, Arnd Bergmann wrote:
> Patch c08e20d24 "arm: Add v7_invalidate_l1 to cache-v7.S"
> moves the v7_invalidate_l1 symbol out of imx/headsmp.S,
> which seems to cause a link error because it is now
> too far away from v7_cpu_resume when building an
> allyesconfig kernel.
> 
> If we move the v7_cpu_resume function from the .data
> section to .text, that creates another link error
> for the reference to phys_l2x0_saved_regs, but we
> can move all of the above to .text.
> 
> I believe that this is not a correct bug fix but just
> a bad workaround, so I'm open to ideas from people
> who understand the bigger picture.

Unfortunately, this ends up with writable data in the .text section, which
is supposed to be read-only.  We should try to preserve that status, even
though we don't enforce it.

I guess the problem is that we end up with the .data segment soo far away
from the .text segment that these branches no longer work (and remember
that this code executes with the MMU off.)

The only solution I can think is that we need to do quite a bit of magic
here to jump to an absolute address, but taking account of the V:P offset.
That's not going to be particularly nice, and it's going to then also have
to jump back the other way - to the cpu_resume code which is also in the
.data section.
