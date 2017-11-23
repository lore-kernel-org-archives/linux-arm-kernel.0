From: martin@martin.st (=?ISO-8859-15?Q?Martin_Storsj=F6?=)
Date: Thu, 23 Nov 2017 14:01:44 +0200 (EET)
Subject: [PATCH v2] arm: detect buggy binutils when in thumb2 mode
In-Reply-To: <20171123115021.25213-1-Jason@zx2c4.com>
References: <20171123114802.24942-1-Jason@zx2c4.com>
 <20171123115021.25213-1-Jason@zx2c4.com>
Message-ID: <alpine.DEB.2.20.1711231358420.12424@cone.martin.st>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Nov 2017, Jason A. Donenfeld wrote:

> On older versions of binutils, \sym points to an aligned address. On
> newer versions of binutils, \sym sometimes points to the unaligned thumb
> address in certain circumstances. In order to homogenize this behavior,
> rather than adding 1, we could simply OR in 1, so that already unaligned
> instructions don't change. While that works, the downside is that we have
> to add an `orr` instruction to a fast path. The assembler can't do this at
> assemble time via "|1" because "invalid operands (.text and *ABS* sections)
> for `|'". A better solution would be to have consistent binutils behavior,
> but that ship has sailed.
>
> So, this commit adds a detection mechanism, which began as a small thing
> from Russell King that I then rewrote to use pure bash instead of
> shelling out, so that it doesn't slow down the build process. The detection
> mechanism _could_ be used to modify the assembly we generate, but for now
> it's just being used to catch buggy binutils and abort the build process in
> that case.
>
> The rest of this commit message contains all of the relevant information
> about the boot bug when compiled in thumb2 mode.
>
> My tests concerned these versions:
> broken: GNU ld (Gentoo 2.29.1 p3) 2.29.1
> working: GNU ld (GNU Binutils for Ubuntu) 2.26.1

FWIW, this issue stems from this change: 
https://sourceware.org/bugzilla/show_bug.cgi?id=21458

The same issue caused problems in libavcodec as well, where we chose to 
work around the issue in this fashion:
https://git.libav.org/?p=libav.git;a=commitdiff;h=9dde6ab06c48f9447cd16f39bee33569cddb7be4;hp=547db1eaecd597031165a2bf637acaaacde52788

Related debian bug report, with a different workaround: 
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=870622

(In libav, we chose the workaround since the .eqv one suggested in the 
debian bug report didn't really work well with assemblers for other 
platforms.)

// Martin
