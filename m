From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jun 2013 10:46:02 +0100
Subject: [PATCH v3] clk: implement clk_unregister
In-Reply-To: <1370248626-3760-1-git-send-email-jiada_wang@mentor.com>
References: <1370248626-3760-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <20130603094602.GI18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 05:37:06PM +0900, Jiada Wang wrote:
> Currently clk_unregister is unimplemented, it is required in case
> sub modules want actually remove clk device registered by clk_register.
> This patch adds the implementation of clk_unregister.

So what if someone has clk_get()'d this clock but not prepared it?
No, this is the wrong approach.  If we want to do this then clocks
must be reference counted and freed when the refcount gets to zero,
just like struct device etc.

We have struct kref as the base structure in the kernel for dealing
with these problems, please look at using it.
