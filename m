From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 20 Apr 2012 08:55:29 +0800
Subject: [PATCH] gpio: pxa: Set PXA GPIO irq_chip IRQCHIP_SKIP_SET_WAKE
 flag
In-Reply-To: <87vckvfr3e.fsf@free.fr>
References: <1334788817.8003.YahooMailClassic@web29002.mail.ird.yahoo.com>
 <87vckvfr3e.fsf@free.fr>
Message-ID: <CAN1soZyQPdcwRd5CtDz+iCV9h=Xq-ar=EBKyQ4ya_hE-PZLNXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 3:40 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> Haojian,
>
> I feel there's some change in PXA gpio wakeup handling that's weird.
>
> The effect : gpio_keys driver can't wakeup from suspend to RAM on GPIO0
> activation
>
> A quick analysis (thanks Paul for direction) :
> ?- gpio_keys() calls irq_set_wake(96, 1) (ie. gpio0)
> ?- gpio-pxa driver doesn't care (as it doesn't have any irq_set_wake function)
> ? (see in [1])
>
> Now if I'm directing the mail at is because you're the only one who commited
> between v3.2 and v3.3 in gpio-pxa driver ([2]).
>
> Could you tell me if removing irq_set_wake() was intentional ?
>
> Cheers.
>
> --
> Robert
>
> [1]
> rj at beldin:~/mio_linux/kernel$ git show v3.2:drivers/gpio/gpio-pxa.c | grep set_wake
> void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
> ? ? ? ?pxa_muxed_gpio_chip.irq_set_wake = fn;
> rj at beldin:~/mio_linux/kernel$ git show v3.3:drivers/gpio/gpio-pxa.c | grep set_wake
> rj at beldin:~/mio_linux/kernel$
>
> [2]
> rj at beldin:~/mio_linux/kernel$ git log v3.3 ^v3.2 --pretty=format:%an drivers/gpio/gpio-pxa.c | sort -u
> Haojian Zhuang

Yes, I need to fix this. The set_wake() function will be transfered to
gpio-pxa driver via platform data.

Thanks
Haojian
