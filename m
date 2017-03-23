From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 10:32:01 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170320110718.e44s2gip36m75bqj@pengutronix.de>
References: <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
 <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
 <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de>
Message-ID: <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:07 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Geert,
>
> On Mon, Mar 20, 2017 at 11:38:52AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Mar 20, 2017 at 11:31 AM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > On Mon, Mar 20, 2017 at 10:56:14AM +0100, Geert Uytterhoeven wrote:
>> >> Documentation/gpio/consumer.txt rightfully sates:
>> >> | Note that gpio_get*_optional() functions (and their managed variants), unlike
>> >> | the rest of gpiolib API, also return NULL when gpiolib support is disabled.
>> >> | This is helpful to driver authors, since they do not need to special case
>> >> | -ENOSYS return codes.  System integrators should however be careful to enable
>> >> | gpiolib on systems that need it.
>> >
>> > I cannot find this paragraph in Documentation/gpio/consumer.txt:
>> >
>> >         $ git grep -e 'ENOSYS' v4.11-rc3 -- Documentation/gpio/
>> >         <void>
>>
>> It was added by commit 22c403676dbbb7c6 ("gpio: return NULL from
>> gpiod_get_optional when GPIOLIB is disabled")
>
> Ah, that's in next.
>
> I still think this is wrong and I'm a bit disappointed that Linus merged
> this patch (without saying so in the thread even) as I thought Linus and
> I agreed on this being a bad idea.

I think it is not good, but what we have before this patch is worse.

I.e. it is the lesser evil.

Before this patch the API is inconsistent: it gives NULL if GPIOLIB
is defined and -ENOSYS if GPIOLIB is not defined.

After this patch it gives NULL in both cases, and that is at least
consistent.

It would be great if someone steps in and fix it so as to return
relevant errors (or error pointers rather) in both cases. However
I guess it will lead a bunch of fallouts in the consumers, albeit
they are not super-many.

Yours,
Linus Walleij
