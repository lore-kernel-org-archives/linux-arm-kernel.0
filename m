From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Sep 2012 17:10:48 +0100
Subject: [PATCH 05/11] clk: Versatile Express clock generators ("osc")
 driver
In-Reply-To: <20120910191420.20289.1923@nucleus>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-6-git-send-email-pawel.moll@arm.com>
 <20120910191420.20289.1923@nucleus>
Message-ID: <1347379848.2497.13.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, 2012-09-10 at 20:14 +0100, Mike Turquette wrote:
> Quoting Pawel Moll (2012-09-03 09:25:25)
> > +static int vexpress_osc_probe(struct vexpress_config_device *vecdev)
> > +{
> > +       int err;
> > +       struct device_node *node = vecdev->dev.of_node;
> > +       struct vexpress_osc_info *info = vecdev->dev.platform_data;
> > +       struct clk_init_data init;
> > +       struct vexpress_osc *osc;
> > +       struct clk *clk;
> > +       const char * const *dev_ids = NULL;
> > +       u32 range[2];
> > +
> > +       if (vecdev->status & VEXPRESS_CONFIG_DEVICE_PROBED_EARLY)
> > +               return 0;
> > +
> > +       osc = kzalloc(sizeof(*osc), GFP_KERNEL);
> > +       if (!osc) {
> > +               err = -ENOMEM;
> > +               goto error;
> 
> Minor nitpick: the error label tries to free osc, which in this case
> shouldn't be freed because it is NULL.
> 
> <snip>
> > +error:
> > +       kfree(osc);
> > +       return err;

$ grep kfree scripts/checkpatch.pl 
# check for needless kfree() checks
			if ($line =~ /\bkfree\(\Q$expr\E\);/) {
				     "kfree(NULL) is safe this check is probably not required\n" . $hereprev);

$ grep -B2 kfree Documentation/CodingStyle 
	...
out:
	kfree(buffer);

;-)

> Otherwise patch looks good to me.  There are some changes to headers in
> this patch, and it is part of a larger series. How did you want the
> common clk patches to get merged?

I'm re-working the series right now, but generally I planned to push
drivers/clk changes via your tree, unless you want me to get it in
through arm-soc.

Cheers!

Pawel
