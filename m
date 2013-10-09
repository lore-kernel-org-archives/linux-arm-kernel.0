From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 14:40:49 +0200
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 9, 2013 at 7:42 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> It's naturally expected that when there are multiple phandle entries
> specified in pinctrl-* property, these entries will be applied
> sequentially.  And this is how Linux kernel works.  So let's define
> this behavior in the binding doc.

NAK this this a Linux kernel implementation detail. Sherman Yin
fixed this up so the drivers does not have to imply any sequence
semantic for this.

Study commit 03b054e9696c3cbd3d5905ec96da15acd0a2fe8d
"pinctrl: Pass all configs to driver on pin_config_set()"

It is perfectly legal for a driver to accumulate the settings into
e.g. a single register write if it can, e.g.:

u32 val = 0;

for (i = 0; i < num_configs; i++) {
  switch() {
  FOO:
     val |= 1;
     break;
   BAR:
     val |= 2:
     break;
   BAZ:
     val |=4;
     break;
};

writel(val, base+pinreg);

I.e. the driver may choose to apply configs sequentially, but that is
not@all necessary.

Yours,
Linus Walleij
