From: vapier@gentoo.org (Mike Frysinger)
Date: Tue, 21 Aug 2012 14:53:16 -0400
Subject: [PATCH v2 16/31] arm64: ELF definitions
In-Reply-To: <20120821182731.GJ12708@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <CAMuHMdVEX0egzFETMJ=LA_PB+7Qc=Ph-7uxofVr__wOE-0cvLQ@mail.gmail.com>
 <20120821182731.GJ12708@arm.com>
Message-ID: <201208211453.18583.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012 14:27:31 Catalin Marinas wrote:
> On Tue, Aug 21, 2012 at 07:17:19PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Aug 21, 2012 at 6:06 PM, Catalin Marinas wrote:
> > > But I can see on x86 that it always reports x86_64 even if the task is
> > > x86_32.
> > 
> > Really?
> > 
> > $ uname -m
> > x86_64
> > $ linux32 uname -m
> > i686
> > $
> 
> Well, you set the personality explicitly with linux32. What I tested was
> with an x86_32 uname called directly (without linux32) and even though
> the ELF was a 32-bit one, it was reporting x86_64. In this AArch64
> patch, a compat task was automatically setting the linux32 personality
> (which x86 does not do).

i don't think any arch does this.

$ uname -m
ppc64
$ linux32 uname -m
ppc

$ uname -m
sparc64
$ linux32 uname -m
sparc

$ uname -m
x86_64
$ linux32 uname -m
i686

$ uname -m
s390x
$ linux32 uname -m
s390

> Arnd's point is that the ELF file should not affect the personality and
> hence the uname value. This should only be done by an explicit call to
> sys_personality().

correct.  if someone really wants to launch their whole userland with the 
adjusted personality, they could always boot the kernel with:
	init=/usr/bin/linux32 /sbin/init
but the kernel shouldn't be doing this automatically.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/0313a2db/attachment.sig>
