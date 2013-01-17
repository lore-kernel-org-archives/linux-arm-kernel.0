From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 11:34:31 +0200
Subject: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport
 power functions
In-Reply-To: <50F7C4A7.5060202@ti.com>
References: <1358372702-13102-1-git-send-email-coelho@ti.com>
 <50F7C4A7.5060202@ti.com>
Message-ID: <20130117093417.GH10814@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 10:30:15AM +0100, Peter Ujfalusi wrote:
> Hi Luca,
> 
> On 01/16/2013 10:45 PM, Luciano Coelho wrote:
> > The code to enable and disable the WiLink shared transport has been
> > removed from the TI-ST driver, so it must be implemented in the board
> > files instead.  Add the relevant operations to Panda's board file.
> > 
> > Additionally, add the UART2 muxing data, so it's properly configured.
> > 
> > Cc: stable <stable@vger.kernel.org> [3.7]
> > Signed-off-by: Luciano Coelho <coelho@ti.com>
> > ---
> > 
> > In v2: use gpio_request_one() instead of gpio_request() and
> > gpio_direction_output(). (Thanks Fabio!)
> > 
> >  arch/arm/mach-omap2/board-omap4panda.c |   50 +++++++++++++++++++++++++++++---
> >  1 file changed, 46 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> > index 5c8e9ce..f44fccf 100644
> > --- a/arch/arm/mach-omap2/board-omap4panda.c
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
> > @@ -51,18 +51,50 @@
> >  #define GPIO_HUB_NRESET		62
> >  #define GPIO_WIFI_PMENA		43
> >  #define GPIO_WIFI_IRQ		53
> > +#define GPIO_BT_EN		46
> >  
> >  /* wl127x BT, FM, GPS connectivity chip */
> > +static int plat_kim_chip_enable(struct kim_data_s *kim_data)
> > +{
> > +	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
> > +	mdelay(5);
> > +	gpio_set_value(GPIO_BT_EN, GPIO_HIGH);
> > +	mdelay(100);
> > +
> > +	return 0;
> > +}
> > +
> > +static int plat_kim_chip_disable(struct kim_data_s *kim_data)
> > +{
> > +	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
> > +	mdelay(1);
> > +	gpio_set_value(GPIO_BT_EN, GPIO_HIGH);
> > +	mdelay(1);
> > +	gpio_set_value(GPIO_BT_EN, GPIO_LOW);
> > +
> > +	return 0;
> > +}
> > +
> >  static struct ti_st_plat_data wilink_platform_data = {
> > -	.nshutdown_gpio	= 46,
> >  	.dev_name	= "/dev/ttyO1",
> >  	.flow_cntrl	= 1,
> >  	.baud_rate	= 3000000,
> > -	.chip_enable	= NULL,
> > -	.suspend	= NULL,
> > -	.resume		= NULL,
> > +	.chip_enable	= plat_kim_chip_enable,
> > +	.chip_disable	= plat_kim_chip_disable,
> 
> I just wonder how this is going to work with DT... You are not going to have
> the ability to use callback in this form.
> I think the GPIO handling should be done in the driver itself rather than in
> the board file.

that can (should ?) be moved to ti-st eventually. In fact I don't know
why it was removed in the first place, we would need Pavan to help us
with that query.

Still, for -rc, the minimal patch had to be cooked, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/fcb572ec/attachment.sig>
