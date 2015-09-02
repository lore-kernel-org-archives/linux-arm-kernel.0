From: dianders@chromium.org (Doug Anderson)
Date: Wed, 2 Sep 2015 15:07:49 -0700
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 30, 2015 at 2:34 PM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> +static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
> +{
> +       struct i2c_adapter *adap;
> +       struct dw_hdmi_i2c *i2c;
> +       int ret;
> +
> +       i2c = devm_kzalloc(hdmi->dev, sizeof(*i2c), GFP_KERNEL);
> +       if (!i2c)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_init(&i2c->lock);
> +       init_completion(&i2c->cmp);
> +
> +       adap = &i2c->adap;
> +       adap->class = I2C_CLASS_DDC;
> +       adap->owner = THIS_MODULE;
> +       adap->dev.parent = hdmi->dev;

I think you may want to add "adap->dev.of_node = hdmi->dev->of_node;"
here.  That will allow device trees to specify the i2c bus by using an
alias.

See <https://chromium-review.googlesource.com/#/c/297040/> where I've
added this line and
<https://chromium-review.googlesource.com/#/c/297041/> where I've used
it.
