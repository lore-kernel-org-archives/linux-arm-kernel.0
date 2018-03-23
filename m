From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 23 Mar 2018 13:36:04 +0200
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
Message-ID: <1521804964.23017.96.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-03-22 at 19:16 -0500, Timur Tabi wrote:
> On 03/21/2018 11:58 AM, Stephen Boyd wrote:
> > +static int msm_gpio_init_valid_mask(struct gpio_chip *chip,
> > +				    struct msm_pinctrl *pctrl)
> > +{
> > +	int ret;
> > +	unsigned int len, i;
> > +	unsigned int max_gpios = pctrl->soc->ngpios;
> > +
> > +	/* The number of GPIOs in the ACPI tables */
> > +	ret = device_property_read_u16_array(pctrl->dev, "gpios",
> > NULL, 0);
> > +	if (ret > 0 && ret < max_gpios) {
> 
> This needs to be ret <= max_gpios, otherwise it will fail if every
> GPIO 
> is available.
> 
> And it should print an error message and return an error code if ret
> > 
> max_gpios.

Perhaps makes sense to do the opposite condition

if (ret < 0 || ret > max_gpios) {
 ... error handling ...
}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
