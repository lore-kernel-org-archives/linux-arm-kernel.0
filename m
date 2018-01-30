From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jan 2018 09:36:43 +0100
Subject: [PATCH v2 07/16] iio: adc: sun4i-gpadc-iio: rework: support
 nvmem calibration data
In-Reply-To: <e319fde5-9ede-8be0-03ae-f0a22d50250c@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-8-embed3d@gmail.com>
 <20180129094045.sagz2dnzvdadd4yx@flea.lan>
 <e319fde5-9ede-8be0-03ae-f0a22d50250c@gmail.com>
Message-ID: <20180130083642.cdpd7jnthkdrrk5r@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 01:33:12PM +0100, Philipp Rossak wrote:
> > >   static const struct gpadc_data sun4i_gpadc_data = {
> > > @@ -87,6 +89,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
> > >   	.sample_start = sun4i_gpadc_sample_start,
> > >   	.sample_end = sun4i_gpadc_sample_end,
> > >   	.sensor_count = 1,
> > > +	.supports_nvmem = false,
> > 
> > That's already its value if you leave it out.
> > 
> > >   };
> > >   static const struct gpadc_data sun5i_gpadc_data = {
> > > @@ -100,6 +103,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
> > >   	.sample_start = sun4i_gpadc_sample_start,
> > >   	.sample_end = sun4i_gpadc_sample_end,
> > >   	.sensor_count = 1,
> > > +	.supports_nvmem = false,
> > >   };
> > >   static const struct gpadc_data sun6i_gpadc_data = {
> > > @@ -113,6 +117,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
> > >   	.sample_start = sun4i_gpadc_sample_start,
> > >   	.sample_end = sun4i_gpadc_sample_end,
> > >   	.sensor_count = 1,
> > > +	.supports_nvmem = false,
> > >   };
> > >   static const struct gpadc_data sun8i_a33_gpadc_data = {
> > > @@ -123,6 +128,7 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
> > >   	.sample_start = sun4i_gpadc_sample_start,
> > >   	.sample_end = sun4i_gpadc_sample_end,
> > >   	.sensor_count = 1,
> > > +	.supports_nvmem = false,
> > >   };
> > >   struct sun4i_gpadc_iio {
> > > @@ -141,6 +147,8 @@ struct sun4i_gpadc_iio {
> > >   	struct clk			*mod_clk;
> > >   	struct reset_control		*reset;
> > >   	int				sensor_id;
> > > +	u32				calibration_data[2];
> > > +	bool				has_calibration_data[2];
> > 
> > Why do you have two different values here?
> 
> I think my idea was too complex! I thought it would be better to check if
> calibration data was read, and is able to be written to hardware. those
> information were split per register.
> 
> I think a u64 should be fine for calibration_data. When I write the
> calibration data I can check on the sensor count and write only the lower 32
> bits if there are less than 3 sensors.
> 
> Is this ok for you?

I'd need to see the implementation, but make sure that this is
documented in your driver :)

> 
> > >   	/* prevents concurrent reads of temperature and ADC */
> > >   	struct mutex			mutex;
> > >   	struct thermal_zone_device	*tzd;
> > > @@ -561,6 +569,9 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
> > >   	struct resource *mem;
> > >   	void __iomem *base;
> > >   	int ret;
> > > +	struct nvmem_cell *cell;
> > > +	ssize_t cell_size;
> > > +	u64 *cell_data;
> > >   	info->data = of_device_get_match_data(&pdev->dev);
> > >   	if (!info->data)
> > > @@ -575,6 +586,39 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
> > >   	if (IS_ERR(base))
> > >   		return PTR_ERR(base);
> > > +	info->has_calibration_data[0] = false;
> > > +	info->has_calibration_data[1] = false;
> > > +
> > > +	if (!info->data->supports_nvmem)
> > > +		goto no_nvmem;
> > > +
> > > +	cell = nvmem_cell_get(&pdev->dev, "calibration");
> > > +	if (IS_ERR(cell)) {
> > > +		if (PTR_ERR(cell) == -EPROBE_DEFER)
> > > +			return PTR_ERR(cell);
> > > +		goto no_nvmem;
> > 
> > goto considered evil ? :)
> 
> this was a suggestion from Jonatan in version one, to make the code better
> readable.

Isn't

if (info->data->supports_nvmem && IS_ERR(cell = nvmem_cell_get()))

pretty much the same thing?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/efed7ee2/attachment-0001.sig>
