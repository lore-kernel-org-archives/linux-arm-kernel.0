From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 May 2015 12:49:13 +0200
Subject: [PATCH] lib: fix 842 build on 32-bit architectures
In-Reply-To: <CALZtONC5Fc-Dsw_aob7zyycYdS6rP6ckT-wdyxF1WJTNsSLp7g@mail.gmail.com>
References: <2802721.Q9KnE9eNH4@wuerfel>
 <1431561144-29931-1-git-send-email-ddstreet@ieee.org>
 <CALZtONC5Fc-Dsw_aob7zyycYdS6rP6ckT-wdyxF1WJTNsSLp7g@mail.gmail.com>
Message-ID: <9630890.oRRRs96DG8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 May 2015 04:54:07 Dan Streetman wrote:
> On Wed, May 13, 2015 at 7:52 PM, Dan Streetman <ddstreet@ieee.org> wrote:
> >> Building the 842 code on 32-bit ARM currently results in this link
> >> error:
> >>
> >> ERROR: "__aeabi_uldivmod" [lib/842/842_decompress.ko] undefined!
> >
> > Oops!  Guess I should build/test on 32 bit more.
> >
> >>
> >> The reason is that the __do_index function performs a 64-bit
> >> division by a power-of-two number, but it has no insight into
> >> the function arguments.
> 
> wait, do you mean the 64 bit mod, total % fsize?  That should already
> be fixed in Herbert's tree, I changed it to subtraction instead.

Yes, that's the one. I was looking at yesterday's linux-next which still
had the bug, but your fix has made it into today's release, so my patch
is no longer needed.

> In any case, I looked at the code again and I think the fsize
> parameter can be removed, and just simply calculated in the function,
> it's just a shift.  I'll send a patch.

Not necessary for this problem any more, but it could still make sense
if you think that improves the code. You can also try to see if marking
the function inline has any effect on code size or performance if either
of them matters.

	Arnd
