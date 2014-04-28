From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 10:15:33 +0100
Subject: [PATCH] ARM: l2c: prima2: only call l2x0_of_init() on matching
 nodes
In-Reply-To: <1398644860-22973-1-git-send-email-mporter@linaro.org>
References: <1398644860-22973-1-git-send-email-mporter@linaro.org>
Message-ID: <20140428091532.GG26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 08:27:40PM -0400, Matt Porter wrote:
> l2x0_of_init() is executed unconditionally within the sirfsoc_l2x0_init()
> early initcall. In a multi v7 kernel this causes bcm281xx and bcm21664
> platform to fail boot since they have their own pre l2x0 init sequence
> that is required. Fix this by checking that a matching OF ID is present
> before calling l2x0_of_init().
> 
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Matt Porter <mporter@linaro.org>
> ---
> Applies against next-20140424 to fix the issue introduced in
> 50655e6 ARM: l2c: prima2: remove cache size override

Err, this only "fixes" it because it effectively disables the L2 cache
_entirely_ - in the above commit, I kill your private compatible strings.

This doesn't make sense.  If the cache is already enabled, then the L2C
code won't try to enable it again.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
