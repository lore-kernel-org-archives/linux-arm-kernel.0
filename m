From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 02 Mar 2013 09:52:12 +0000
Subject: [PATCH v5 01/12] gpio: pxa: identify ed mask reg with platform
 data
In-Reply-To: <1361764181-26647-2-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
 <1361764181-26647-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130302095212.1150C3E219B@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Feb 2013 11:49:30 +0800, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> Avoid to judge whether edge mask register exists by CPU. Use platform
> data to identify it instead. The gpio edge mask register exists in MMP
> series SoC.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Hi Haojian,

I don't think patches like this are a good idea. The driver already
knows the difference between different types of chips. Adding /more/
platform data is making life worse, not better. The diffstat is evidence
of that:

>  10 files changed, 65 insertions(+), 1 deletion(-)

If you're looking to get rid of the pxa_gpio_nums() function, then a
much better way to do it is to use a platform_device_id table and
differentiate the type by the name. You can attach data to that table
with the parameters for each chip. For example:

struct pxa_gpio_id_data pxa_gpio_id_data[] = {
	{ .count = 84, type = PXA25X_GPIO, },
	{ .count = 89, type = PXA26X_GPIO, },
	{ .count = 127, type = MMP_GPIO, },
};

static const struct platform_device_id pxa_gpio_id_table[] = {
	{ "pxa25x-gpio", (unsigned long) &pxa_gpio_id_data[0], },
	{ "pxa65x-gpio", (unsigned long) &pxa_gpio_id_data[1], },
	{ "mmp-gpio", (unsigned long) &pxa_gpio_id_data[2], },
};

static struct platform_driver pxa_gpio_driver = {
	.probe = pxa_gpio_probe,
	.driver = {
		.name = "pxa-gpio",
		.of_match_table = of_match_ptr(pxa_gpio_dt_ids),
	},
	.id_table = pxa_gpio_id_table,
};

And that same data table can be used in the of_match_table too.

g.
