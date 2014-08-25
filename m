From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 25 Aug 2014 09:34:10 +0200
Subject: [PATCH 2/2] input: cros_ec_keyb: Add of match table
In-Reply-To: <53F89A52.60605@cogentembedded.com>
References: <1408748582-29029-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1408748582-29029-3-git-send-email-sjoerd.simons@collabora.co.uk>
 <53F89A52.60605@cogentembedded.com>
Message-ID: <1408952050.31096.5.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Sat, 2014-08-23 at 17:42 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 8/23/2014 3:03 AM, Sjoerd Simons wrote:
> 
> > To enable the cros_ec_keyb driver to be auto-loaded when build as
> > module add an of match table (and export it) to match the modalias
> > information passed on to userspace as the Cros EC MFD driver registers
> > the MFD subdevices with an of_compatibility string.
> 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> >   drivers/input/keyboard/cros_ec_keyb.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> 
> > diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> > index 791781a..0bdbf2d 100644
> > --- a/drivers/input/keyboard/cros_ec_keyb.c
> > +++ b/drivers/input/keyboard/cros_ec_keyb.c
> > @@ -342,10 +342,20 @@ static int cros_ec_keyb_resume(struct device *dev)
> >
> >   static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
> >
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id cros_ec_keyb_of_match[] = {

>     Perhaps better to use '__maybe_unused' instead of #ifdef...

Hmm, looks like the rtc-ds1742.c driver is the only one in the kernel
tree using that strategy, while all others use #ifdef CONFIG_OF. So i'm
inclined to keep the #ifdef here, ooi what is your rationale behind
suggesting __maybe_unused?


> > +	{ .compatible = "google,cros-ec-keyb" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, cros_ec_keyb_of_match);
> > +#endif
> > +
> > +
> 
>     Too many empty lines.



> >   static struct platform_driver cros_ec_keyb_driver = {
> >   	.probe = cros_ec_keyb_probe,
> >   	.driver = {
> >   		.name = "cros-ec-keyb",
> > +		.of_match_table = of_match_ptr (cros_ec_keyb_of_match),
> 
>     There shouldn't be space before (.

Will fix the identation issues in a v2.

Thanks for the review,
 Sjoerd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/9ab07e2c/attachment.bin>
