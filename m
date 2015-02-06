From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Feb 2015 00:42:10 +0000
Subject: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
In-Reply-To: <54D3EB29.4090007@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <54D3C803.30706@samsung.com> <54D3CD6A.1010209@codeaurora.org>
 <54D3EB29.4090007@codeaurora.org>
Message-ID: <20150206004210.GB8670@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 02:14:01PM -0800, Stephen Boyd wrote:
> Actually we can bury the __clk_create_clk() inside
> __of_clk_get_from_provider(). We should also move __clk_get() into there
> because right now we have a hole where whoever calls
> of_clk_get_from_provider() never calls __clk_get() on the clk, leading
> to possible badness. v2 coming soon.

There's some other issues here too...

sound/soc/kirkwood/kirkwood-i2s.c:

        priv->clk = devm_clk_get(&pdev->dev, np ? "internal" : NULL);
...
        priv->extclk = devm_clk_get(&pdev->dev, "extclk");
        if (IS_ERR(priv->extclk)) {
...
	} else {
                if (priv->extclk == priv->clk) {
                        devm_clk_put(&pdev->dev, priv->extclk);
                        priv->extclk = ERR_PTR(-EINVAL);
                } else {
                        dev_info(&pdev->dev, "found external clock\n");
                        clk_prepare_enable(priv->extclk);
                        soc_dai = kirkwood_i2s_dai_extclk;
                }

It should be fine provided your "trick" is only done for DT clocks,
but not for legacy - with legacy, a NULL in the clkdev tables will
match both these requests, hence the need to compare the clk_get()
return value to tell whether we get the same clock.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
