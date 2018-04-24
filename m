From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Apr 2018 14:56:09 +0100
Subject: [PATCH] arm64: support __int128 with clang
In-Reply-To: <20180424133527.GB24599@arm.com>
References: <20171223004323.1986-1-Jason@zx2c4.com>
 <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
 <20180424133527.GB24599@arm.com>
Message-ID: <20180424135608.m5uxhmclhnljpbau@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 02:35:27PM +0100, Will Deacon wrote:
> On Sun, Apr 15, 2018 at 06:20:11PM +0200, Jason A. Donenfeld wrote:
> > Would you review/merge this when you have a chance?
> 
> No real objection from me, but does the arm64 kernel actually build with
> clang?

I belevie that currently it is not possible to use a released version of
clang to build a working kernel without additional patches (at least
5.0.0, there don't seem to be any 6.0.0 binaries that can target
AArch64). Issues include:

* Released versions of clang don't support the 's' constraint used in
  some hyp code.

* Released versions of clang don't support 'rX' as a register name, as
  is used by some workaround code shared between arm/arm64.

* Additional flags need to be passed for hyp code to function correctly,
  since clang will convert switch statements into jump tables, meaning
  they aren't position-independent.

I tried building a tip-of-tree clang recently (r330441 with llvm
r330440) to see what was solved so far, but this blew up when bulding
the kernel, and I was going to wait for the 7.0.0 release before trying
again.

Thanks,
Mark.
