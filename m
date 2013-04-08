From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Apr 2013 12:41:28 -0700
Subject: [PATCH] ARM: dts: fix bad merge of display timing node to
 exynos5250-smdk5250.dts
In-Reply-To: <2824266.emLkgITIHc@flatron>
References: <1365439879-3398-1-git-send-email-dianders@chromium.org>
 <51630C7C.9040003@gmail.com>
 <CAD=FV=UcKTBjKtyQFY4odTpBDKbNQEAHjyahqgNCsD570zq=pw@mail.gmail.com>
 <2824266.emLkgITIHc@flatron>
Message-ID: <CAD=FV=X7-DvuCpPeJwKDZeacbRzR+oB+upzzg=PK3_PmSnxbig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Mon, Apr 8, 2013 at 12:27 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Common Clock Framework by default automatically gates unused clocks, just
> like regulator core does with unused regulators. Maybe this is the cause?

Yes, I'm nearly certain that's the case here.  The reset code doesn't
belong to any driver (it's in mach-exynos/common.c) it certainly
doesn't grab any clock.

I tried quickly to see if there was an easy clock to grab but got a
bit stuck.  In the old way of doing things clocks could be global and
grabbed without a dev node.  That may still be possible now, but in
the 15 minutes I spent I couldn't figure it out and so it went to the
back burner.  ...or we could make a real reset device, but that might
be overkill?

> There is a CLK_IGNORE_UNUSED flag which disables this behavior for all
> clocks which have it set. Maybe it should be set for the problematic
> clock?

Didn't know about that one, thanks!  It seems like a bit annoying that
we'd have to keep this clock all the time just to get reset working,
though.  I guess in 3.4 that's what we did, though I don't know if it
was intentional...

-Doug
