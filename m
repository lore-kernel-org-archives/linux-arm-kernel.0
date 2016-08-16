From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Aug 2016 10:29:45 -0700
Subject: [PATCH 1/3] clk: meson: Add GXBB AO Clock and Reset controller
 driver
In-Reply-To: <16163435-1310-043d-804f-3bb1fd33cff4@baylibre.com>
References: <1470734008-18849-1-git-send-email-narmstrong@baylibre.com>
 <1470734008-18849-2-git-send-email-narmstrong@baylibre.com>
 <20160813012910.GT361@codeaurora.org>
 <16163435-1310-043d-804f-3bb1fd33cff4@baylibre.com>
Message-ID: <20160816172945.GZ361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16, Neil Armstrong wrote:
> On 08/13/2016 03:29 AM, Stephen Boyd wrote:
> > On 08/09, Neil Armstrong wrote:
> 
> >> +
> >> +static struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
> > 
> > can this be const?
> 
> It would be awesome, but it will be discarded by of_clk_add_hw_provider :

Ok, right.

> >> +iounmap:
> >> +	iounmap(base);
> >> +	return ret;
> >> +}
> >> +
> >> +static const struct of_device_id gxbb_aoclkc_match_table[] = {
> >> +	{ .compatible = "amlogic,gxbb-aoclkc" },
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, gxbb_aoclkc_match_table);
> >> +
> >> +static struct platform_driver gxbb_aoclkc_driver = {
> >> +	.probe		= gxbb_aoclkc_probe,
> > 
> > No remove means leak of iomem mapping.

And OF provider registration.

> > 
> 
> It will be non-modular, so no need of remove. The MODULE_* macros and module.h include will be removed like other clk drivers (gxbb and oxnas for instance).

Ok make sure to remove sysfs unbinding then.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
