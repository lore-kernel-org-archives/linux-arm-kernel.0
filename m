From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Oct 2011 17:43:09 +0100
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <20111003163107.GQ3731@opensource.wolfsonmicro.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<4E89C3FA.9020206@gmail.com>
	<20111003142524.GN3731@opensource.wolfsonmicro.com>
	<4E89D3C4.8090001@gmail.com>
	<20111003163107.GQ3731@opensource.wolfsonmicro.com>
Message-ID: <20111003164309.GA19925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 05:31:08PM +0100, Mark Brown wrote:
> I dunno, I get the impression that some of this is due to the current
> limitations of the clock API rather than due to a lack of clocks -
> perhaps that's specific to the applications I look at, though.
> applications 

The clk API per-se has nothing to do with how clocks are registered.
There are two things that are the clk API:

1. clkdev - which deals with translating devices + connection IDs to
   struct clk.  This has no ordering requirements wrt requiring
   parents to be "initialized" before their children (it has no care
   about that at all because it's not within its definition.)

   For this, registration is about connecting device + connection IDs
   to a struct clk.

2. the driver API, defining how the opaque struct clk is looked up,
   obtained and then manipulated.  This has no 'registration' stuff.

So, whether clocks are a tree or flat is unspecified.  It's unspecified
whether there's any particular order required.

In fact, with a clock tree, it's entirely possible that only the leaf
clocks will be 'registered' with clkdev.  How the rest of the clock tree
is initialized is beyond the scope of the driver clk API.
