From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Mar 2012 20:08:43 +0100
Subject: [PATCH v3] serial: PL011: clear pending interrupts
In-Reply-To: <CAOh2x=nh-aiJ1FQecm=5WsNw=Fph5osNh5C2YU6x9TGrKBoMmA@mail.gmail.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
 <CAOh2x=nh-aiJ1FQecm=5WsNw=Fph5osNh5C2YU6x9TGrKBoMmA@mail.gmail.com>
Message-ID: <CACRpkdZ-epTV8dAY4gT9HKgPifRS_wfooy0QqEGsSgCqZ98MYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 12:58 PM, viresh kumar <viresh.linux@gmail.com> wrote:
> On Tue, Mar 13, 2012 at 5:57 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> @@ -1927,6 +1930,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>> ? ? ? ? ? ? ? ?goto unmap;
>> ? ? ? ?}
>>
>> + ? ? ? /* Ensure interrupts from this UART are masked and cleared */
>> + ? ? ? writew(0, uap->port.membase + UART011_IMSC);
>> + ? ? ? writew(0xffff, uap->port.membase + UART011_ICR);
>> +
>
> I was working on v3.3 and found a crash for my SoC. When i checked i got a crash
> due to above changes.

Strange, because these changes are not even in 3.3. Did you mean 3.4
HEAD?

> There are two issues here
> ?- uap->port is uninitialized
> ?- clk is not enabled.
>
> How is this working for you?

The uap->port is likely the problem. The clock does not need to be
enabled for this, the clock that need to be enabled is the pclk and that
should be taken care of by the amba/primecell core.

It worked because I had some system which didn't scream when it wrote
into that NULL-address for some reason :-(

I'm sending a fixup patch to sort out my own screwing up.

Yours,
Linus Walleij
