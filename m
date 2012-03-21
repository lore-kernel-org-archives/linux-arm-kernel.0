From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 21 Mar 2012 17:28:27 +0530
Subject: [PATCH v3] serial: PL011: clear pending interrupts
In-Reply-To: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOh2x=nh-aiJ1FQecm=5WsNw=Fph5osNh5C2YU6x9TGrKBoMmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 5:57 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> @@ -1927,6 +1930,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
> ? ? ? ? ? ? ? ?goto unmap;
> ? ? ? ?}
>
> + ? ? ? /* Ensure interrupts from this UART are masked and cleared */
> + ? ? ? writew(0, uap->port.membase + UART011_IMSC);
> + ? ? ? writew(0xffff, uap->port.membase + UART011_ICR);
> +


Hey Linus,

I was working on v3.3 and found a crash for my SoC. When i checked i got a crash
due to above changes.

There are two issues here
 - uap->port is uninitialized
 - clk is not enabled.

How is this working for you?

--
viresh
