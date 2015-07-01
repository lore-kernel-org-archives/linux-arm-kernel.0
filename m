From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 1 Jul 2015 12:07:08 +0200
Subject: [RFC 2/3] i2c: mux: demux-pinctrl: add driver
In-Reply-To: <CAMuHMdW+rd+U0VQjitbyJ3AiZakhLztdYe27n1rkK9tFWT=z4w@mail.gmail.com>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
 <1435700651-3543-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdW+rd+U0VQjitbyJ3AiZakhLztdYe27n1rkK9tFWT=z4w@mail.gmail.com>
Message-ID: <20150701100707.GA1926@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +Changing I2C controllers:
> > +
> > +The created mux-device will have a file "cur_master" in its sysfs-entry. Write
> > +0 there for the first master listed in the "i2c-parent" property, 1 for the
> > +second etc. Reading the file will give you a list with the active master
> > +marked.
> 
> This paragraph doesn't belong in the DT binding doc, but somewhere
> under Documentation/i2c/

Yes.

> > +struct i2c_demux_pinctrl_priv {
> > +       int cur_chan;
> > +       int num_chan;
> 
> unsigned int

When comparing variables, I prefer to have them the same signedness.

> > +static struct property status_okay = { .name = "status", .length = 3, .value = "ok" };
> 
> "okay" or "ok"?

Both are valid, I took the shorter one.

> > +       struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
> > +       int count = 0, i;
> 
> unsigned int i

Same as above.

> 
> > +
> > +       for (i = 0; i < priv->num_chan; i++)
> > +               count += sprintf(buf + count, "%c %d - %s\n",
> > +                                i == priv->cur_chan ? '*' : ' ', i,
> > +                                priv->chan[i].parent_np->full_name);
> > +       //FIXME: Check count > PAGE_SIZE
> 
> Can you use seq_printf() for device attributes?

I can't find a reference to that.


> > +static ssize_t cur_master_store(struct device *dev, struct device_attribute *attr,
> > +                           const char *buf, size_t count)
> > +{
> > +       struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
> > +       unsigned long val;
> 
> unsigned int
> 
> > +       int ret;
> > +
> > +       ret = kstrtoul(buf, 0, &val);
> 
> kstrtouint()

Yes, I agree to the last two.

Thanks for the review,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150701/fa07ecde/attachment.sig>
