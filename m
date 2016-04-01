From: davem@davemloft.net (David Miller)
Date: Fri, 01 Apr 2016 15:18:20 -0400 (EDT)
Subject: [PATCH] net: mvneta: fix changing MTU when using per-cpu
 processing
In-Reply-To: <1459516878-2802-1-git-send-email-mw@semihalf.com>
References: <1459516878-2802-1-git-send-email-mw@semihalf.com>
Message-ID: <20160401.151820.127036849232206611.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Fri,  1 Apr 2016 15:21:18 +0200

> After enabling per-cpu processing it appeared that under heavy load
> changing MTU can result in blocking all port's interrupts and transmitting
> data is not possible after the change.
> 
> This commit fixes above issue by disabling percpu interrupts for the
> time, when TXQs and RXQs are reconfigured.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Applied, thanks.

When I reviewed this I was worried that this was yet another case where
the ndo op could be invoked in a potentially atomic or similar context,
whereby on_each_cpu() would be illegal to use.

But that appears to not be the case, and thus this change is just fine.

Thanks.
