From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jun 2012 11:03:01 +0100
Subject: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
In-Reply-To: <CACRpkdahAYSd+H1hgUwwZh3UY7oS1QTym8uyggpmOgBAuSOaxg@mail.gmail.com>
References: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
 <CAOMZO5DGxPQyHpPLLJk1P5kmyfB+9jct1rwEZj918wM84ePRKA@mail.gmail.com>
 <CACRpkdahAYSd+H1hgUwwZh3UY7oS1QTym8uyggpmOgBAuSOaxg@mail.gmail.com>
Message-ID: <20120620100301.GB12537@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 08:37:20AM +0200, Linus Walleij wrote:
> On Sun, Jun 17, 2012 at 4:13 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Sun, Jun 17, 2012 at 10:44 AM, Linus Walleij
> > <linus.walleij@stericsson.com> wrote:
> >
> >> ? ? ? ?uap->pinctrl = devm_pinctrl_get(&dev->dev);
> >> ? ? ? ?if (IS_ERR(uap->pinctrl)) {
> >> ? ? ? ? ? ? ? ?ret = PTR_ERR(uap->pinctrl);
> >> - ? ? ? ? ? ? ? goto unmap;
> >> + ? ? ? ? ? ? ? goto out;
> >> ? ? ? ?}
> >> ? ? ? ?uap->pins_default = pinctrl_lookup_state(uap->pinctrl,
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PINCTRL_STATE_DEFAULT);
> >> @@ -1915,7 +1917,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
> >> ? ? ? ?uap->clk = clk_get(&dev->dev, NULL);
> >
> > Maybe you can use devm_clk_get here too.
> 
> That requires all users of the driver to be using CONFIG_CLKDEV, which
> I *think* is safe to do, but better check: Russell, do you know if
> it's safe to use
> this feature from clkdev in the PL011 driver?

No idea.  What I have said is that the devm_* clk_get interfaces should
not be dependent on clkdev being built.
