From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 14 Jul 2015 17:53:12 +0100
Subject: [PATCH v2 03/10] arm64: esr.h type fixes and cleanup
In-Reply-To: <20150714155446.GE12675@leverpostej>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-4-git-send-email-Dave.Martin@arm.com>
 <20150714155446.GE12675@leverpostej>
Message-ID: <20150714165312.GF10670@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 04:54:46PM +0100, Mark Rutland wrote:
> On Mon, Jul 13, 2015 at 02:25:50PM +0100, Dave P Martin wrote:
> > ESR_ELx is a 32-bit register, so it is not necessary for all the
> > template values defined by esr.h to be forced to 64-bit (long).
> 
> While it's potentially misleading, does forcing these to be 64-bit cause
> a real issue? If so, it would be good to mention in the commit message.
> 
> Mark.

GCC (at least, >= 4.9.2) generates warnings when these values, or
expressions involving them, are assigned to 32-bit structure members.

However, Will wasn't a big fan of my original solution to this problem,
so I'll take a final look before posting the final series to see if
there's a less invasive approach.

An explicit cast at the site of the truncating assignment(s) might do
the trick.

Cheers
---Dave

[...]

> > This patch introduces a UINT() macro analogous to UL(), and applies
> > it consistently.  (Unfortunately, the more succinct U and UI names
> > are already used in unrelated code, and cause conflicts since
> > memory.h is widely included.)
> > 
> > Since this change touches many lines already, I've taken the
> > opportunity to squash some redundant parentheses and bogus
> > whitespace at the same time.
> > 
> > The missing include of <asm/memory.h> (for UL(), UINT() etc.) is
> > also added.

[...]
