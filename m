From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Sep 2011 21:55:00 +0100
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <CAGsJ_4xhQZUKx85+4mZLqFrAF+XmUqZp=VCRYwJyNafTUe814g@mail.gmail.com>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<20110915013937.GE1488@S2100-06.ap.freescale.net>
	<20110915083248.GG6267@n2100.arm.linux.org.uk>
	<CAGsJ_4xpc-8zzGkZ9LThqP7in27n6uX4LRGAf+AtoWTM4p=82w@mail.gmail.com>
	<20110917104518.GD16381@n2100.arm.linux.org.uk>
	<CAGsJ_4ysZ7C7PZ7eCLyrLuUGux2U8mVknobaJ4tRdk1g97z-dA@mail.gmail.com>
	<20110917145614.GG16381@n2100.arm.linux.org.uk>
	<CAGsJ_4xhQZUKx85+4mZLqFrAF+XmUqZp=VCRYwJyNafTUe814g@mail.gmail.com>
Message-ID: <20110923205500.GW17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 01:33:39PM +0800, Barry Song wrote:
> Do you think the following is what you want?

Almost.  A couple of things:

1. Making the variables static means that folk like OMAP can't read the
   values at resume time from their assembly (forcing them to save and
   restore them, rather than using the already saved copy.)

2. It probably makes sense to make a structure out of the saved state
   information so that assembly code doesn't have to individually find
   the address of each variable.  Instead, they can find the address of
   the structure (in physical memory if that's what they need) and use
   offsets.

With (2) its probably worth adding a comment about the structure being
used in platform code and it should only ever be appended to.
(Alternatively, we could use the asm-offsets.h generation stuff to
create preprocessor symbols for the offsets in the struct if we put the
struct in a header file.)
