From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Feb 2013 17:46:50 +0100
Subject: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
In-Reply-To: <20130206163811.GI17833@n2100.arm.linux.org.uk>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
 <20130206115219.GE17833@n2100.arm.linux.org.uk>
 <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
 <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
 <20130206163811.GI17833@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZDks681kDBrNcztWw_vr-5azWxsuDQaDa36Ze=0+B2Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 6, 2013 at 5:38 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> However, I'm just wondering if this shows that we _do_ need to get rid
> of a pile of __init marked functions as well as fixing this, thanks to
> the deferred probing we now have (maybe the whole __init thing becomes
> useless with deferred probing?)

And all __initdata and __initconst as well.

> There's nothing really to guarantee
> that the pinctrl stuff will be available by the time the init sections
> are discarded (it could be in a loadable module?) or indeed any other
> resources that might be necessary.

I don't dare to guess how deferred probing is supposed to work
with loadable modules. When I start to think of it my mind
boggles. But I think maybe all drivers that support module loading
are tagging things wrong. Shouldn't they all be using
__init_or_module, __initdata_or_module, __initconst_or_module
so they only get discarded unless compiled as modules?

As far as I can tell from <linux/init.h> that is the intention.

Talk about can of worms :-(

> I think in this regard, deferred probing has opened a similar can of
> worms which hotplug devices created (which eventually ended up with
> killing the __dev* marking).

I'm afraid you're right.

Pinctrl core grabbing of pins seems to trigger the problem more
often on platforms that are using it.

Yours,
Linus Walleij
