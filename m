From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jan 2014 09:03:51 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a gpio
 used as an interrupt source.
In-Reply-To: <CACh+v5Ot4ZwJrE_nJyJn-h-ZNrHfCk60c6KH_ErnFkD+u7atng@mail.gmail.com>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
 <52D3C166.5050908@overkiz.com>
 <20140115180615.GJ9558@ns203013.ovh.net>
 <52D79E51.4030300@overkiz.com> <52D7BCAA.30706@atmel.com>
 <CACh+v5OOx8LgGVN0GFsa5-f=h1kasJVz4r0CfBXdXhK0F8iQAQ@mail.gmail.com>
 <CACRpkdap7mhGyAr6WcM-cOzbKBJp6S-Qi+oDoM-Pwos14SGyyg@mail.gmail.com>
 <CACh+v5Ot4ZwJrE_nJyJn-h-ZNrHfCk60c6KH_ErnFkD+u7atng@mail.gmail.com>
Message-ID: <CACRpkdZ_EPyhy707_r=Gnfen0ZYz6Oj_V5d3mTFvOi2g4e7=6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 2:16 PM, Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:

> I've been thinking hard on the gpio ownership and I'd like your
> opinion on the following assumptions:
>
> - a gpio used as an interrupt is always a gpio configured as an input.
> (corollary : a gpio used for interrupt cannot not be an ouput)

That is the assumption made by the core. Until the day someone
comes up with a weird usecase...

> - a gpio used as an input or interrupt only, could be safely accessed
> by multiple users.

Multiple consumers is the term we would use. But yes.

> - a gpio used as an output should be used as such by only one user.
> Still other users should be allowed to read its value.

Sounds reasonable.

> If those assumptions are true, I believe they can lead to a new
> exclusion scheme:
> - ouput is mutually exclusive with interrupt but not with input
> - only 1 ouput user at a time.

Logical conclusion from the above yes.

> It would do away with our sharing issue and more (chained interrupt
> handlers on gpio interrupt, read/interrupt access through sysfs to a
> gpio requested by a driver)
>
> And I believe that most of the infrastructure is in place to implement this :
> - direction flags in gpio_request_one
> - gpio_lock_as_irq/gpio_unlock_as_irq

So I think what I need to see is a proposed patch, whether it will
hit a particular driver or the gpiolib core, but either would probably
be interesting.

Pls keep linux-gpio and Alexandre on CC for this discussion.

Yours,
Linus Walleij
