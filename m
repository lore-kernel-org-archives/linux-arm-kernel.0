From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Apr 2014 14:59:54 +0200
Subject: [PATCH 4/4] pinctrl: sirf: move to use irq_get_handler_data
In-Reply-To: <CAGsJ_4y=zNNWAvVOK6zGaY-bufUCbOcZtwE=SuWJ=QpF9rBNHg@mail.gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <1397544229-20545-5-git-send-email-21cnbao@gmail.com>
 <CACRpkdbDeF5gBVv=hQSdX1i9fw=7Or+=qN=g4OXHvHkZKr7vcQ@mail.gmail.com>
 <CAGsJ_4y=zNNWAvVOK6zGaY-bufUCbOcZtwE=SuWJ=QpF9rBNHg@mail.gmail.com>
Message-ID: <CACRpkdYz+JdAbhdR_s9h4m_3JNcpLo-2VzoXYoEd21myB4yZtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 12:59 AM, Barry Song <21cnbao@gmail.com> wrote:

>> If you want to use some other handler data than the gpiochip,
>> you should just use irq_set_chained_handler() and
>> irq_set_handler_data() directly.
>
> i think this should be fixed in the general API but not use one more
> function call to over-write the handler_data which has been filled in
> the API.
> since we have the chance for drivers to set either the whole chip for
> a simple chip,  or bank-specific data for a chip which has multiple
> parent IRQs.

I don't think it's worth it for saving one line. The helper is intended
for the simple case, i.e. where it's enough to just get the gpio_chip
as handler data. Other alternatives need to be open coded.

I'm even considering removing this helper if it's confusing, it doesn't
really add much, gpiochip_irqchip_add() is the important function
to use, not gpiochip_set_chained_irqchip().

Yours,
Linus Walleij
