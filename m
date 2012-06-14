From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 14 Jun 2012 16:55:16 +0530
Subject: [PATCH 15/17] i2c: omap: always return IRQ_HANDLED
In-Reply-To: <20120614112323.GD31187@n2100.arm.linux.org.uk>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-16-git-send-email-balbi@ti.com>
 <CAMQu2gzbK+ObetarwRiEz9A7=awEffAhrMMAqSMfiv4H6BZAuw@mail.gmail.com>
 <20120614112323.GD31187@n2100.arm.linux.org.uk>
Message-ID: <CAMQu2gywX81Qm+Y780XkuOyZKWKc6hmPpn2oKm97w=f_XXu9Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 4:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 14, 2012 at 04:48:56PM +0530, Shilimkar, Santosh wrote:
>> On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > otherwise we could get our IRQ line disabled due
>> > to many spurious IRQs.
>> >
>> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > ---
>> > ?drivers/i2c/busses/i2c-omap.c | ? ?2 +-
>> > ?1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> > index fc5b8bc..5b78a73 100644
>> > --- a/drivers/i2c/busses/i2c-omap.c
>> > +++ b/drivers/i2c/busses/i2c-omap.c
>> > @@ -1015,7 +1015,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
>> > ? ? ? ? ? ? ? ?}
>> > ? ? ? ?} while (stat);
>> >
>> > - ? ? ? return count ? IRQ_HANDLED : IRQ_NONE;
>> > + ? ? ? return IRQ_HANDLED;
>>
>> no sure if this is correct. if you have IRQ flood and instead of _actually_
>> handling it, if you return handled, you still have interrupt pending, right?
>
> The point of returning IRQ_NONE is to indicate to the interrupt layer that
> the interrupt you received was not processed by any interrupt handler, and
> therefore to provide a way of preventing the system being brought to a halt
> though a stuck interrupt line.
>
> So, if you do process an interrupt, you should always return IRQ_HANDLED
> even if you couldn't complete its processing (eg, because you've serviced
> it 100 times.)
That make sense. Thanks for explanation Russell.

Regards
santosh
