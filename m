From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 17 May 2012 18:08:00 -0600
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
In-Reply-To: <CACRpkdZGAQpt1bqhTFmxcC7OKb4uds6ru-aNs-aT+M+H4TKuJg@mail.gmail.com>
References: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
 <4FA15267.4090306@wwwdotorg.org>
 <CAOh2x=nrNDrtNjOroWOm6HkYkc3f2qfaWrtN97d1M3rWv1qmsQ@mail.gmail.com>
 <CACRpkda2jBmjPCgt=5rfqdCQH9Lipq4aejeQq-Qbw0_Nk6o-yg@mail.gmail.com>
 <CAOh2x=nizQYXWFu3deQPXr93Nqv77Pnj5DNhYZw_vYyY2go3vA@mail.gmail.com>
 <CACRpkdZGAQpt1bqhTFmxcC7OKb4uds6ru-aNs-aT+M+H4TKuJg@mail.gmail.com>
Message-ID: <20120518000800.B9F333E062C@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2012 14:01:15 +0200, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 7, 2012 at 5:51 PM, viresh kumar <viresh.linux@gmail.com> wrote:
> > On Mon, May 7, 2012 at 6:38 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >> On Wed, May 2, 2012 at 6:51 PM, viresh kumar <viresh.linux@gmail.com> wrote:
> >>
> >>> So i need someway of accessing gpio chip
> >>> from pinctrl driver. How should i do it?
> >>
> >> I once proposed a patch like this to gpiolib and Grant NACK:ed it.
> >> It was one of the reasons I created pinctrl to begin with...
> 
> Actually I was exposing gpio_to_chip() but the reason for
> rejection is the same.
> 
> > @Grant/Linus: Any specific reason, why it got rejected?
> 
> Quoting:
> http://marc.info/?l=linux-kernel&m=130281083417581&w=2
> 
> "Similar to interrupt handling, it probably isn't a good idea to expose
> the gpio_chip directly."
> 
> So in the struct irqchip we found that the ability for drivers to access
> and play around with the intrinsics of that struct made it hard to
> maintain and subject to much suspicious code.
> 
> > I don't feel there is anything wrong in this approach and is a very
> > clean solution to bind two drivers.
> 
> Yeah :-/
> 
> The same argument could be made to expose gpio_to_chip()
> for any driver not using device tree.

Linus, feel free to corner me at connect and we'll talk about it
again.

however, there is a bigger issue now.  I'm changing the xlate
mechanism to allow multiple gpio_chips to refer to the same device
tree node which will break the assumption that this patch uses.  The
reason for this is to make it easier to support banked gpio
controllers where a separate gpio_chip is used for each bank, but it
is still described by a single device tree node.  To properly resolve
this will require a full gpio specifier reference instead of just the
phandle.  Will that work for your use-case?

g.
