From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 15:04:42 +0100
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
In-Reply-To: <20120413121914.GN24211@n2100.arm.linux.org.uk>
References: <20120413012230.GA30438@windriver.com>
 <CAAQ0ZWReL=+bm9UOnt2=Dfy0zeWbJe3=y3pPzUKRzm2y277kFQ@mail.gmail.com>
 <20120413103207.GL24211@n2100.arm.linux.org.uk>
 <20120413104452.GR3168@opensource.wolfsonmicro.com>
 <20120413104900.GM24211@n2100.arm.linux.org.uk>
 <20120413120706.GT3168@opensource.wolfsonmicro.com>
 <20120413121914.GN24211@n2100.arm.linux.org.uk>
Message-ID: <20120413140442.GV3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 01:19:14PM +0100, Russell King - ARM Linux wrote:

> That really doesn't make any difference about whether I can push 7366/1
> as is or not.  If the fix for the missing header is going through some
> other git tree, I can't push 7366/1 until that fix has gone in - and
> I'm not going to be tracking when that happens.

I've got quite limited visibility on how this stuff gets handled; the
patch tracking system always feels like a bit of a black hole to me as
I'm never sure when to send things to it or when they might get applied
and the usual mechanisms for indicating how things get applied (tags in
the header and comments after the ---) aren't available.

I have to say was rather surprised when I realised you had applied my
change for -rc rather than for -next.

> TBH, its something that _you_ need to manage - you created this regression
> in the first place by changing the regulator API without first reviewing
> all the callsites.  Grep is a wonderful tool for finding those.  So I'll

You know as well as I do that a grep of all the users isn't going to
turn up everything reliably, this is one of the reasons why people
should be testing -next (which apparently nobody had been doing on any
of the affected platforms).

Looking at the code I suspect that my initial read was that if anything
hit that case we'd crash as vcore is left with an error pointer, though
unusually for such code the IS_ERR() is actually used at every call
site so it actually managed to work.  Plus the fact that the code was
never supposed to work in the first place, of course.

> leave it entirely up to you to figure out how to fix the AMBA regression
> you caused in a sane way in -rc - and without causing any additional
> regressions by doing so.

> If you want me to apply 7367/1 instead, then please say so directly.  If
> you want 7366/1 plus the header file fixed, then that needs to be figured
> out.

Right from my initial reply to it I've said that 7367/1 was a good,
minimal fix for 3.4 but that for 3.5 we should be doing 7366/1 or
thereabouts.  Like I say I was quite surprised when you applied the
larger fix for 3.4, though there are good arguments in favour of doing
that in that it removes an API which nobody should be using.  So long as
what we end up with in 3.5 is 7366/x (which I think everyone agrees is
the goal) I'm not too fussed about which solution is adopted for 3.4.

There's two ways to go about this:

 - Apply 7366/3 (which keeps regulator/consumer.h in linux/amba.h but is
   otherwise the same as 7366/1) and then either leave things or clean
   up the header in 3.5.

 - Apply 7367/1 for 3.4 and then rebase 7366/x after it and put that in
   -next for inclusion in 3.5.

Which one is chosen is a matter of taste for you.  I'd initially
expected the second approach but as it seems you're comfortable with the
larger patch we may as well go with it, the header file should be the
only dependency.

For the benefit of people reading the mails 7366/x is the change to
remove the regulator usage from AMBA (amba: Remove AMBA level regulator
support) and 7367/x is the change to just change the return code (amba:
adapt to regulator probe deferral change).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/ad988d8c/attachment-0001.sig>
