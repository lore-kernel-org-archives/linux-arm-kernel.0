From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Apr 2015 22:44:10 -0600
Subject: [PATCH 9/9] ARM: BCM283x: Register fixed clocks for uart in the
 DT.
In-Reply-To: <1429639796-2169-10-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-10-git-send-email-eric@anholt.net>
Message-ID: <5539CA1A.1040009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 12:09 PM, Eric Anholt wrote:
> We were previously relying on the fixed clock registration in
> clk-bcm2835, but there doesn't seem to be any real reason to not just
> define it in the DT (and for the 2836 port, I would have needed to
> change the clock's physical address in clk-bcm2835.c).  Also, because
> we weren't registering the apb_pclk in clk-bcm2835 as a clock device,
> we were picking up the uart clock node as apb_pclk by accident.

Doesn't the following do just that?

clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT,
                              126000000);

Anyway, with this patch, shouldn't we fix drivers/clk/clk-bcm2835.c not
to register clocks that match those that are added to DT in this patch?
Actually, to maintain DT ABI (new kernels working with old or new DT),
we probably need to keep the code in clk-bcm2835.c, but make it
conditional upon whether there's a clock node in the DT file.
