From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 11:57:00 +0000
Subject: [PATCH] mmci: supply per-instance regulator name
In-Reply-To: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
References: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101202115700.GF29347@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 12:35:07PM +0100, Linus Walleij wrote:
> On the Ux500 we have different regulators to different card slots
> and eMMCs, and some have no regulator. Move the hardcoded "vmmc"
> regulator name to platform data and supply it that way for the
> platforms that use it. Remove the ugly and unneeded #ifdef around
> the regulator fetch code at the same time.

It seems that the regulator code is making all the same mistakes that
historically were made with the clk API code.

Rather than using the struct device, it's trying to use the regulator
name to distinguish individual sources of supply.  This can only lead
to lots of regulator names being passed around from layer to layer,
rather than the now proven cleaner method that the clk API always set
out to do.

I'd like regulator people to think long and hard about the sanity of
passing names all the way from platform code into drivers and back
into the regulator code before I consider this patch any further.
