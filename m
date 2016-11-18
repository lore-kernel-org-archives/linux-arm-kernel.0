From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2016 17:32:39 +0000
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <CAD=FV=VoycW9btkdKubq_Uxh52PYK5R1X2GD10DcxRQj2K-_UQ@mail.gmail.com>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk>
 <CAD=FV=VoycW9btkdKubq_Uxh52PYK5R1X2GD10DcxRQj2K-_UQ@mail.gmail.com>
Message-ID: <20161118173239.GN1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 09:13:18AM -0800, Doug Anderson wrote:
> Mason's change adds no complexity to the code and seems like a
> generally good idea.
> 
> As per John Stultz [1] there is agreement that udelay() really
> shouldn't delay less than the requested amount.

There is NO such agreement, read the reference that I gave, which is
a statement from Linus who clearly says that if you're stupid enough
to want udelay() to be accurate to within 5% then you're doing
something wrong.

FACT: software-based udelay()s are _always_ short by the very nature
of the way the delay loop is calibrated.

It's not something that's going to get fixed either - read the full
thread from my reference, and you'll see that Linus has said that
udelay() being short is not something anyone should care about.
That's at odds from John, and Linus' opinion rather trumps everyone
elses - it's Linus' kernel, his is the ultimate last say on anything.

>  In fact, we even have
> a test committed to the tree: "kernel/time/test_udelay.c".  As your
> reference says, maybe 1% isn't enough to throw a hissyfit about, but
> when the change is so simple and adds no complexity then it seems like
> a worthwhile thing to do.

Maybe, but my point is that it's just encouraging this fiction that
udelay() never delays shorter than the requested delay.

Also, given that this is architecture code, it's my decision to make,
not yours.  So while you can supply any attributation you like, I'm
saying no at the moment - unless someone can show that it causes
_significant_ errors.

In other words, if it causes significantly short or long delays that
the reasonable inflation of delay value that drivers are expected to
make becomes a problem, then yes, it should be fixed.  If it's merely
"lets stop udelay() returning slightly early" then no, I'm not
interested because it's encouraging the fiction.

And... if a data sheet says "needs a delay of 2us" and you put in the
driver udelay(2) then you're doing it wrong, and you need to read
Linus' mails on this subject, such as the one I've provided a link
to... that udelay() must be _at least_ udelay(3), if not 4.

The best thing when using udelay() is to remember the most important
point - udelay() is very _approximate_.

Adding Linus in case he wishes to add to the discussion.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
