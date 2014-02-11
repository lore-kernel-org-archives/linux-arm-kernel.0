From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Feb 2014 22:04:43 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <CAKfTPtDrLX6ZSV9cZckGztorrYRc-PNknaJch3nry=PzonZJHw@mail.gmail.com>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140210162230.GK25305@arm.com>
 <20140210164647.GB13533@sirena.org.uk>
 <CAKfTPtDih6n5ckhXUgNKrbw5EFt45uuQFFPKB2aN0NGGG96Pmg@mail.gmail.com>
 <20140211103428.GC8693@mudshark.cambridge.arm.com>
 <CAKfTPtDjF2bZsoj+tgBH-ZXYXNbXQ2mBie0FVgUy2vb_jY12FQ@mail.gmail.com>
 <20140211140749.GE3748@arm.com>
 <CAKfTPtDrLX6ZSV9cZckGztorrYRc-PNknaJch3nry=PzonZJHw@mail.gmail.com>
Message-ID: <20140211220443.GB28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 03:46:04PM +0100, Vincent Guittot wrote:
> On 11 February 2014 15:07, Catalin Marinas <catalin.marinas@arm.com> wrote:

> > As Will said, smp_*mb() do not ensure absolute visibility, only relative
> > to subsequent memory accesses on the same processor. So just placing a
> > barrier at the end of a function does not mean much, it only shows half
> > of the problem it is trying to solve.

> OK, that's probably the shortcut that has been made, we want to drain
> the write buffer to make modification available to other cpus and I
> though smp_wmb and the associated mb(ishst) was there for that
> purpose.

It does also explain where I got to trying to figure out what exactly
the mechanism was!

> > So my proposal is to remove the smp_wmb() from topology.c and add it
> > where it is relevant as described above. If we have some race in
> > topology.c (like for example we may later decide to start more
> > secondaries at the same time), it needs to be solved using spinlocks.

I'll just repost a version dropping them from the topology series and
separately add the barriers elsewhere.  The 32 bit ARM implementation
probably ought to be fixed as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/af5fc293/attachment-0001.sig>
