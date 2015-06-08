From: joshc@ni.com (Josh Cartwright)
Date: Mon, 8 Jun 2015 08:49:14 -0500
Subject: [PATCH v2 2/2] iio: adc: xilinx-xadc: Add label as an optional
 argument for aux channels
In-Reply-To: <55747616.1010901@kernel.org>
References: <555B78A3.2030202@metafoo.de>
 <1432135352-29848-1-git-send-email-xander.huff@ni.com>
 <1432135352-29848-2-git-send-email-xander.huff@ni.com>
 <55747616.1010901@kernel.org>
Message-ID: <20150608134914.GF633@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 07, 2015 at 05:49:26PM +0100, Jonathan Cameron wrote:
> On 20/05/15 16:22, Xander Huff wrote:
> > To better facilitate user-mode access to optional aux channels, allow
> > device trees to specify a custom label for defined channels.
> > 
> > Signed-off-by: Xander Huff <xander.huff@ni.com>
> > Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
> > Reviewed-by: Josh Cartwright <joshc@ni.com>
> > ---
> >  drivers/iio/adc/xilinx-xadc-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> > index ce93bd8..bda4241 100644
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -1119,6 +1119,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
> >  			if (ret || reg > 16)
> >  				continue;
> >  
> > +			of_property_read_string(child, "label",
> > +						&chan->extend_name);
> > +
> >  			if (of_property_read_bool(child, "xlnx,bipolar"))
> >  				chan->scan_type.sign = 's';
> >  
> > 
> I think what Lars was suggesting was a change to the IIO side of this rather than
> just changing the device tree binding.

I'm not so sure.  His observation was just that the typical name of
these properties is 'label', which I think makes sense and is commonly
used.

Naming things is hard.

Perhaps, though, an improvement may be made if we lifted this out of the
xadc driver and moved it into the IIO core (I can't imagine that this
driver is the only one representing each channel with a separate node in
DT).

> Perhaps an additional per channel attribute called _label which would
> allow for board specific labelling?

This would seem a bit odd in DT-land; if a user wanted a different label
name for their board, they would just rename it in their device tree for
that board.  Fortunately, with the structured dtsi include files, this
is pretty painless to do.

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150608/962be065/attachment.sig>
