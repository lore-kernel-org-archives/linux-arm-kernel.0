From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 14:01:15 +0200
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
In-Reply-To: <CAOh2x=nizQYXWFu3deQPXr93Nqv77Pnj5DNhYZw_vYyY2go3vA@mail.gmail.com>
References: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
 <4FA15267.4090306@wwwdotorg.org>
 <CAOh2x=nrNDrtNjOroWOm6HkYkc3f2qfaWrtN97d1M3rWv1qmsQ@mail.gmail.com>
 <CACRpkda2jBmjPCgt=5rfqdCQH9Lipq4aejeQq-Qbw0_Nk6o-yg@mail.gmail.com>
 <CAOh2x=nizQYXWFu3deQPXr93Nqv77Pnj5DNhYZw_vYyY2go3vA@mail.gmail.com>
Message-ID: <CACRpkdZGAQpt1bqhTFmxcC7OKb4uds6ru-aNs-aT+M+H4TKuJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 5:51 PM, viresh kumar <viresh.linux@gmail.com> wrote:
> On Mon, May 7, 2012 at 6:38 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Wed, May 2, 2012 at 6:51 PM, viresh kumar <viresh.linux@gmail.com> wrote:
>>
>>> So i need someway of accessing gpio chip
>>> from pinctrl driver. How should i do it?
>>
>> I once proposed a patch like this to gpiolib and Grant NACK:ed it.
>> It was one of the reasons I created pinctrl to begin with...

Actually I was exposing gpio_to_chip() but the reason for
rejection is the same.

> @Grant/Linus: Any specific reason, why it got rejected?

Quoting:
http://marc.info/?l=linux-kernel&m=130281083417581&w=2

"Similar to interrupt handling, it probably isn't a good idea to expose
the gpio_chip directly."

So in the struct irqchip we found that the ability for drivers to access
and play around with the intrinsics of that struct made it hard to
maintain and subject to much suspicious code.

> I don't feel there is anything wrong in this approach and is a very
> clean solution to bind two drivers.

Yeah :-/

The same argument could be made to expose gpio_to_chip()
for any driver not using device tree.

>> The U300 solution isn't super-clean, and I have another
>> solution for Nomadik which is cleaner, but there GPIO and
>> pinctrl is in the same file. Expect to mail that out tomorrow.
>
> Even that is not so clean. You are creating another mess in order to fix one.
> Two drivers implementing separate functionality must be kept separate.

In the Nomadik case there is not so much mess I think, and I have
thought about maybe just more or less concatenating the two
separate U300 driver files (pinctrl-u300.c and pinctrl-coh901.c)
into one, with a single probe call and a single set of resources
(e.g. two base addresses and so on) provided to it. That would
be quite clean.

Yours,
Linus Walleij
