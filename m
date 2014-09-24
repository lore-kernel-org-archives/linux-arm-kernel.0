From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Sep 2014 13:10:34 +0200
Subject: [PATCH 3/4] gpio: vf610: add gpiolib/IRQ chip driver for Vybird
In-Reply-To: <a7c933339713dc1783770faf1eceb734@agner.ch>
References: <cover.1410020458.git.stefan@agner.ch>
 <ff236f6dab7f3408551f8f4b0345e62b37fd99c5.1410020459.git.stefan@agner.ch>
 <CACRpkdaNbTj+hXtNFZ6DqosHPfHg2G+X2Cb_S_15mULpdebgrQ@mail.gmail.com>
 <a7c933339713dc1783770faf1eceb734@agner.ch>
Message-ID: <CACRpkdbJePuG0g=AFGqjDS4=yW0CXnkpf1Yr_1P4e9Kkpu9n-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 1:51 PM, Stefan Agner <stefan@agner.ch> wrote:
> [Me]
>> postcore again. I don't like this, can you get rid of it?
>
> I guess we could load this driver easily a bit later. IMHO, since lots
> of other driver use GPIO's, we should it load before all the drivers
> gets loaded (before device_initcall).

Nope. We use deferred probing to control that today. Ideally
all drivers should be device_initcall() and deferred probe be used
to order things, not by playing around with initcalls.

> Most GPIO driver do this, some statistic again:
> $ grep -h -o ".*_initcall" drivers/gpio/*.c | sort | uniq -c | sort -n
> -r
>      33 subsys_initcall
>      14 postcore_initcall
>       2 device_initcall
>       2 arch_initcall
>       1 late_initcall
>       1 core_initcall

Yeah old legacy. There are patch attacks to get rid of this.

The reason we can't just change them is because sometimes
dependent drivers do not handle the errorpath very well can can't
defer cleanly.

With a new driver I expect deferred probe to be used.

Yours,
Linus Walleij
