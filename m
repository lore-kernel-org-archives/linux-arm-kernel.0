From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Sep 2012 00:13:43 +0100
Subject: [RFC PATCH] ARM: l2x0: avoid spinlock for sync op on pl310
In-Reply-To: <1347306334-781-1-git-send-email-robherring2@gmail.com>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120910231343.GE31998@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 02:45:34PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The sync op is atomic on the pl310, so a spinlock is not needed. It can
> be a bottleneck for code paths with register accesses, so remove it.
> Removing it gives a 30% improvement to pktgen throughput on highbank.
> 
> A similar spinlock removal was originally done by Catalin Marinas[1], but
> the spinlock part was dropped in the merged version. It is unclear why
> other than it was not a runtime selection. As every readl/writel causes a
> outer_sync, the sync function is likely the most critical.

See:

http://lists.arm.linux.org.uk/lurker/message/20110215.164340.dc0ec480.en.html
