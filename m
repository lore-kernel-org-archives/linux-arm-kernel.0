From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun, 03 Mar 2013 12:59:03 +0100
Subject: [PATCH v6 01/16] clk: samsung: add common clock framework helper
 functions for Samsung platforms
In-Reply-To: <51333149.1060105@gmail.com>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <1361175686-19400-2-git-send-email-thomas.abraham@linaro.org>
 <201303030208.49722.heiko@sntech.de> <51333149.1060105@gmail.com>
Message-ID: <51333B07.7050106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2013 12:17 PM, Sylwester Nawrocki wrote:
> On 03/03/2013 02:08 AM, Heiko St?bner wrote:
>> But is there an easy way to define more than one alias? On the s3c2416
>> for
>> example the hsmmc hclk is the "hsmmc" io-clock, as well as the source
>> for the
>> "mmc_busclk.0". Same for the "uart" pclk, that is also a baud clock
>> source.
[...]
> But those multiple aliases are important only for machines with device
                                                              ^^^^^
Sorry, this should have read "without". Also please note that due to
representing original struct clk_clksrc objects (mux + div + gate clock)
with separate primitive clocks device drivers may not work as before
where clk_{set/get}_parent() was called. I.e. a separate consumer clock
id needs to be used to control a clock mux. Hmm, however this issue
doesn't affect anything on s3c24xx, since such composite clocks have
been introduced only starting from s3c64xx.

I guess to create multiple aliases now a new helper function could be
created that takes as an argument a clock index (as in enum exynos4_clks)
and adds a clkdev lookup entry to a matched clk object. Probably it
wouldn't be difficult to rework the driver to be registering all clkdev
entries like this.

Do you have your source tree in any public git available ? ;) Perhaps
I could find a time to adjust and try it with s3c2440 based board.

> tree support, aren't they ?
