From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 7 Sep 2018 10:51:19 -0700
Subject: [GIT PULL] arm64: fix for -rc3
In-Reply-To: <20180907154516.GG12788@arm.com>
References: <20180907154516.GG12788@arm.com>
Message-ID: <CA+55aFw97E=pUTRejXDAVYbK90cgF=1R3MPxE3t9fDoKctOGNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2018 at 8:45 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Just one small fix here, preventing a VM_WARN_ON when a !present PMD/PUD
> is "freed" as part of a huge ioremap() operation. The correct behaviour
> is to skip the free silently in this case, which is a little weird (the
> function is a bit of a misnomer), but it follows the x86 implementation.

Hmm. I've obviously pulled it, but it does strike me that maybe the
confusing semantics could be fixed?

There's only one call site, and only two implementations (x86 and arm64).

Maybe the whole "read pmd, check for present" could just be in the
caller, avoiding that oddity wrt name-vs-behavior.

I'm not entirely sure why that code has that special case to begin
with. I guess this is the only case of a kernel mapping of a hugepage,
and people wanted to avoid polluting the generic code with stuff that
was only relevant for architectures that implemented it? But we
already have that ioremap_pmd_enabled() guard, so architectures that
don't do this wouldn't actually have any extra code.

Anyway, I'll let it be, but I think it could be a good idea to simply
change the semantics, and in the process also make it a lot clearer
what that thing actually is expected to do.

                 Linus
