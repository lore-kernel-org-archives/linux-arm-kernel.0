From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Sep 2015 23:50:09 +0100
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
Message-ID: <20150902225008.GQ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 03:07:49PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sun, Aug 30, 2015 at 2:34 PM, Vladimir Zapolskiy
> <vladimir_zapolskiy@mentor.com> wrote:
> > +static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
> > +{
> > +       struct i2c_adapter *adap;
> > +       struct dw_hdmi_i2c *i2c;
> > +       int ret;
> > +
> > +       i2c = devm_kzalloc(hdmi->dev, sizeof(*i2c), GFP_KERNEL);
> > +       if (!i2c)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       mutex_init(&i2c->lock);
> > +       init_completion(&i2c->cmp);
> > +
> > +       adap = &i2c->adap;
> > +       adap->class = I2C_CLASS_DDC;
> > +       adap->owner = THIS_MODULE;
> > +       adap->dev.parent = hdmi->dev;
> 
> I think you may want to add "adap->dev.of_node = hdmi->dev->of_node;"
> here.  That will allow device trees to specify the i2c bus by using an
> alias.

Never copy the of_node from one device to another.  That allows the
bus matching to unintentionally match the of_node against the wrong
driver.

Also, is it appropriate to hook non-DDC devices to a DDC bus?  I suspect
that's asking for trouble.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
