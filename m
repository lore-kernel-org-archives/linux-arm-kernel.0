From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jan 2018 09:32:05 +0100
Subject: [PATCH v2 10/16] iio: adc: sun4i-gpadc-iio: add support for A83T
 thermal sensor
In-Reply-To: <94bc070d-8675-95fe-2857-188f7cc66071@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-11-embed3d@gmail.com>
 <20180129094803.uiojqkmaeuihbe4p@flea.lan>
 <94bc070d-8675-95fe-2857-188f7cc66071@gmail.com>
Message-ID: <20180130083205.j4b2wua7knymkfn6@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;5002;0c
On Mon, Jan 29, 2018 at 12:53:48PM +0100, Philipp Rossak wrote:
> 
> 
> On 29.01.2018 10:48, Maxime Ripard wrote:
> > On Mon, Jan 29, 2018 at 12:29:13AM +0100, Philipp Rossak wrote:
> > > This patch adds support for the A83T ths sensor.
> > > 
> > > The A83T supports interrupts. The interrupt is configured to update the
> > > the sensor values every second.
> > > 
> > > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > > ---
> > >   drivers/iio/adc/sun4i-gpadc-iio.c | 38 ++++++++++++++++++++++++++++++++++++++
> > >   include/linux/mfd/sun4i-gpadc.h   | 18 ++++++++++++++++++
> > >   2 files changed, 56 insertions(+)
> > > 
> > > diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> > > index 8196203d65fe..9f7895ba1966 100644
> > > --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> > > +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> > > @@ -170,6 +170,40 @@ static const struct gpadc_data sun8i_h3_ths_data = {
> > >   		SUN8I_H3_THS_TEMP_PERIOD(0x7),
> > >   };
> > > +static const struct gpadc_data sun8i_a83t_ths_data = {
> > > +	.temp_offset = -2724,
> > > +	.temp_scale = -70,
> > > +	.temp_data = {SUN8I_H3_THS_TDATA0,
> > > +		SUN8I_A83T_THS_TDATA1,
> > > +		SUN8I_A83T_THS_TDATA2,
> > > +		0},
> > > +	.sample_start = sunxi_ths_sample_start,
> > > +	.sample_end = sunxi_ths_sample_end,
> > > +	.sensor_count = 3,
> > > +	.supports_nvmem = false,
> > > +	.support_irq = true,
> > > +	.ctrl0_map = SUN4I_GPADC_CTRL0_T_ACQ(0x1f3),
> > > +	.ctrl2_map = SUN8I_H3_THS_ACQ1(0x1f3),
> > 
> > Where are these values coming from?
> > 
> 
> These values are calculated with the formulas from the datasheet and also
> tested on hardware. These settings seem ok.

You should at least put a comment explaining how you got to these values.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/13ffd600/attachment.sig>
