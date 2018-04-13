From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 13 Apr 2018 09:33:17 -0700
Subject: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
In-Reply-To: <20180413094211.GN16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
Message-ID: <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2018 at 2:42 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> Yes, it does solve the problem at hand with strace - the exact patch I
> tested against 4.16 is below.

Ok, good.

> However, FPE_FLTUNK is not defined in older kernels, so while we can
> fix it this way for the current merge window, that doesn't help 4.16.

I wonder if we should even bother with FPE_FLTUNK.

I suspect we might as well use FPE_FLTINV, I suspect, and not have
this complexity at all. That case is not worth worrying about, since
it's a "this shouldn't happen anyway" and the *real* reason will be in
the kernel logs due to vfs_panic().

So it's not like this is something that the user should ever care
about the si_code about.

> Given that the path we're talking about is unlikely to happen (as
> mentioned in my second paragraph) I still think reverting Eric's patch
> is the right way forward for older kernels.

I'd much rather get rid of that FPE_FIXME, and leave that whole mess behind.

So the attached patch seems simple and should work with 4.16 too.

Let's not leave this as some kind of nasty maintenance issue, and just
go for simple and stupid.

Hmm?

                Linus
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch.diff
Type: text/x-patch
Size: 1037 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180413/9e2e47ed/attachment.bin>
