From: broonie@kernel.org (Mark Brown)
Date: Thu, 13 Feb 2014 15:58:37 +0000
Subject: [PATCH] arm64: smp: Add a memory barrier before we start
 secondary cores
In-Reply-To: <F28028BE-865B-4338-BA62-3F766B922A63@arm.com>
References: <1392205594-29186-1-git-send-email-broonie@kernel.org>
 <20140212122727.GB29132@mudshark.cambridge.arm.com>
 <20140212124717.GL28112@sirena.org.uk>
 <20140212134332.GK29702@arm.com>
 <20140212145644.GP28112@sirena.org.uk>
 <F28028BE-865B-4338-BA62-3F766B922A63@arm.com>
Message-ID: <20140213155837.GR28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 06:23:14PM +0000, Catalin Marinas wrote:

> I think we should aim to understand the code better rather than just
> adding the spinlocks. Some simple questions:

I agree that understanding the code is good, my point is that if the
code needs serious thinking about to understand then it's probably not
good code even if it is correct given that it's not super performance
critical.

> - Who uses the topology information and when? (the scheduler? first time after or
> before secondaries are started?)

It's used directly by the architecture topology code only (to generate
information read by the scheduler).  The scheduler appears to deal with
its own concurrency requirements and it appears to use information it
gets immediately.

> - Who updates the topology information? (primary and secondary startup
> code?)

Each CPU that comes on line.

> - What about hotplug?

Removal currently doesn't do anything to these data structures (nor is
it expected to).  Starting the CPU will redo the startup code which
should produce the same result again (anything dynamic would need work
to support dynamic topology information anyway).

> - Can any of the above happen in parallel on different CPUs?

Everything looks serialised, though I may be missing some cases or have
lost something in an indirection.

A lack of locking also seems reasonably consistent with other
architectures from a quick survey.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/07be9ae2/attachment.sig>
