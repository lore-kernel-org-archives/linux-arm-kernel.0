From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Aug 2015 22:21:27 +0100
Subject: [PATCH 00/18] ARM: use const and __initconst for smp_operations
In-Reply-To: <CAOesGMjku09wsUmwooq2ZXLyV7CPfioi0oAV5EgvW_wE98VYeg@mail.gmail.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
 <CAOesGMjku09wsUmwooq2ZXLyV7CPfioi0oAV5EgvW_wE98VYeg@mail.gmail.com>
Message-ID: <20150824212127.GH7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 02:12:06PM -0700, Olof Johansson wrote:
> Easiest of all would probably be to get the sub-arch patches into one
> release, then switch the prototypes and function definitions in the
> next. If you switch prototypes first you'll get a bunch of warnings,
> right?

Wrong way around. :)

If you change the sub-arches to declare the smp operations as const,
and try and pass them into a function which doesn't take a const-pointer,
you'll get a warning.  The core bits need to go in first before the
sub-arch patches.

I think the series has limited value - it allows us to (a) check that a
small quantity of code doesn't write to these things, and (b) allows us
to move the SMP operations structure from __initdata to __initconstdata.
It's still going to end up in the init region which is read/write in any
case, and still gets thrown away.

Given where we are, I don't think we need to rush this in during the
last week before the merge window opens, even though it's trivial.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
