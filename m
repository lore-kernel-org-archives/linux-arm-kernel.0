From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Jul 2016 22:08:02 +0200
Subject: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
In-Reply-To: <20160721121253.GE14925@dell>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
 <20160719073109.GD17074@dell>
 <d64cf632-41a4-3e23-6239-7f854cbb0293@kernel.org>
 <20160721121253.GE14925@dell>
Message-ID: <20160721200802.GL5993@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4205;0c
On Thu, Jul 21, 2016 at 01:12:53PM +0100, Lee Jones wrote:
> On Wed, 20 Jul 2016, Jonathan Cameron wrote:
> 
> > On 19/07/16 08:31, Lee Jones wrote:
> > > On Mon, 18 Jul 2016, Jonathan Cameron wrote:
> > > 
> > >> On 15/07/16 10:59, Quentin Schulz wrote:
> > >>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> > >>> controller and a thermal sensor. For now, only the ADC and the thermal
> > >>> sensor drivers are probed by the MFD, the touchscreen controller support
> > >>> will be added later.
> > >>>
> > >>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > >> Hmm. Previous patch includes the header this one creates.  Ordering issue?
> > >> The depends kind of prevents build failures by ensuring that can't be built
> > >> until this one is in place, but it is certainly an ugly way to do it.
> > >>
> > >> Few little bits innline.
> > >>> ---
> > >>>
> > >>> v2:
> > >>>  - add license headers,
> > >>>  - reorder alphabetically includes,
> > >>>  - add SUNXI_GPADC_ prefixes for defines,
> > >>>
> > >>>  drivers/mfd/Kconfig                 |  14 +++
> > >>>  drivers/mfd/Makefile                |   2 +
> > >>>  drivers/mfd/sunxi-gpadc-mfd.c       | 197 ++++++++++++++++++++++++++++++++++++
> > >>>  include/linux/mfd/sunxi-gpadc-mfd.h |  23 +++++
> > >>>  4 files changed, 236 insertions(+)
> > >>>  create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
> > >>>  create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h
> > > 
> > > [...]
> > > 
> > >>> +static struct mfd_cell sun6i_gpadc_mfd_cells[] = {
> > >>> +	{
> > >>> +		.name	= "sun6i-a31-gpadc-iio",
> > >>> +		.resources = adc_resources,
> > >>> +		.num_resources = ARRAY_SIZE(adc_resources),
> > >>> +	}, {
> > >>> +		.name = "iio_hwmon",
> > >> I still really dislike using this to force the probe of that driver but
> > >> kind of up to the hwmon / mfd guys on this.
> > > 
> > > Can you at least say *why* you don't like it?
> > It just feels odd to have an mfd child that isn't really dependent
> > on the mfd hardware itself.
> > 
> > Still if you are happy, mfd is your domain and my objections were
> > as you probably noticed not that strong - or well described!)
> > 
> > So I'm fine with this.
> 
> I see.  So it's not actually part of the same IP/chip?

The chip has a temperature sensor, and we want to expose that
temperature through IIO.

But we don't really have the choice on how we probe iio-hwmon
here. The binding was already there, and we have to keep it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/22b492d8/attachment.sig>
