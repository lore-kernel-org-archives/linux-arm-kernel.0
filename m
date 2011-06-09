From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Jun 2011 18:38:36 +0100
Subject: [RFC PATCH 0/2] ARM: Add a generic macro for declaring
	proc_info structs
In-Reply-To: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
References: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110609173836.GF24424@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 06:21:50PM +0100, Dave Martin wrote:
> Based on recent problems with variable-size Thumb instructions
> inside tables, this patch adds an experimental macro for declaring
> proc_info structs, as an example of the kind of build-time robustness
> we could implement for these and similar structures.

Could we just check the size of the proc_info region in the linker
is a multiple of the struct size we expect?

> However, this may be taking a sledgehammer to crack a nut,
> and it will cause some churn, though it could leave is with a
> cleaner situation afterwards.

It does look very much like a sledge hammer to me.  All we're really
after is whether the size of the region is what we expect it to be -
which will tell us whether there's a T2 instruction in there.

It's also fragile - if the struct has a member inserted, who says that
the offsets in the macro will be updated anyway... so it still suffers
from the same problem of no real build-time checking.

At least if we check that the size of the region is a multiple of the
struct size, we can catch whether there's any mismatch between the
struct size and assembly rather trivially.
