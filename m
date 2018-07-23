From: MNARANI@xilinx.com (Manish Narani)
Date: Mon, 23 Jul 2018 09:34:50 +0000
Subject: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk
 related functions
In-Reply-To: <20180721172423.11efb5ea@archlinux>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
 <f4b8e687-217f-15b1-b0b1-b95dbc3dcc2a@metafoo.de>
 <20180721172423.11efb5ea@archlinux>
Message-ID: <SN6PR02MB4959F2ABE80C54242B8BF0C9C1560@SN6PR02MB4959.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

Thanks for your comments.

> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23 at kernel.org]
> Sent: Saturday, July 21, 2018 9:54 PM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Manish Narani <MNARANI@xilinx.com>; knaack.h at gmx.de;
> pmeerw at pmeerw.net; Michal Simek <michals@xilinx.com>; linux-
> iio at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Anirudha Sarangi <anirudh@xilinx.com>; Srinivas
> Goud <sgoud@xilinx.com>
> Subject: Re: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk related
> functions
> 
> On Thu, 19 Jul 2018 18:40:26 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > On 07/18/2018 01:12 PM, Manish Narani wrote:
> > > This patch adds check for return values from clock related functions.
> > > This was reported by static code analysis tool.
> >
> > This patch seems to do something else.
> Indeed, definitely doing two things only one of which is mentioned.
> Please break it up and resend.
I will break it up and resend.

> 
> Jonathan
> 
> >
> > >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  drivers/iio/adc/xilinx-xadc-core.c | 24 ++++++++++++++++++++++--
> > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/xilinx-xadc-core.c
> > > b/drivers/iio/adc/xilinx-xadc-core.c
> > > index 248cffa..47eb364 100644
> > > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > > @@ -322,6 +322,7 @@ static irqreturn_t
> > > xadc_zynq_interrupt_handler(int irq, void *devid)
> > >
> > >  #define XADC_ZYNQ_TCK_RATE_MAX 50000000  #define
> > > XADC_ZYNQ_IGAP_DEFAULT 20
> > > +#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
> > >
> > >  static int xadc_zynq_setup(struct platform_device *pdev,
> > >  	struct iio_dev *indio_dev, int irq) @@ -332,6 +333,7 @@ static int
> > > xadc_zynq_setup(struct platform_device *pdev,
> > >  	unsigned int div;
> > >  	unsigned int igap;
> > >  	unsigned int tck_rate;
> > > +	int ret;
> > >
> > >  	/* TODO: Figure out how to make igap and tck_rate configurable */
> > >  	igap = XADC_ZYNQ_IGAP_DEFAULT;
> > > @@ -341,6 +343,13 @@ static int xadc_zynq_setup(struct
> > > platform_device *pdev,
> > >
> > >  	pcap_rate = clk_get_rate(xadc->clk);
> > >
> > > +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> > > +		ret = clk_set_rate(xadc->clk,
> > > +				   (unsigned
> long)XADC_ZYNQ_PCAP_RATE_MAX);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	if (tck_rate > pcap_rate / 2) {
> > >  		div = 2;
> > >  	} else {
> > > @@ -366,6 +375,12 @@ static int xadc_zynq_setup(struct platform_device
> *pdev,
> > >  			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE
> |
> > >  			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
> > >
> > > +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> > > +		ret = clk_set_rate(xadc->clk, pcap_rate);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -887,6 +902,9 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
> > >  	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
> > >  	unsigned int div;
> > >
> > > +	if (!clk_rate)
> > > +		return -EINVAL;
> > > +
> > >  	if (info != IIO_CHAN_INFO_SAMP_FREQ)
> > >  		return -EINVAL;
> > >
> > > @@ -1239,8 +1257,10 @@ static int xadc_probe(struct platform_device
> *pdev)
> > >  		goto err_free_irq;
> > >
> > >  	/* Disable all alarms */
> > > -	xadc_update_adc_reg(xadc, XADC_REG_CONF1,
> XADC_CONF1_ALARM_MASK,
> > > -		XADC_CONF1_ALARM_MASK);
> > > +	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1,
> XADC_CONF1_ALARM_MASK,
> > > +				  XADC_CONF1_ALARM_MASK);
> > > +	if (ret)
> > > +		goto err_free_irq;
> > >
> > >  	/* Set thresholds to min/max */
> > >  	for (i = 0; i < 16; i++) {
> > >
> >

Thanks,
Manish Narani
