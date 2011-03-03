From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Wed, 2 Mar 2011 20:51:41 -0600
Subject: [PATCHv2] omap:mailbox: resolve hang issue
In-Reply-To: <20110303014416.GL20560@atomide.com>
References: <1299104058-28565-1-git-send-email-x0095078@ti.com>
	<20110303014416.GL20560@atomide.com>
Message-ID: <AANLkTin4LUkC=bARTaAweJ96FnVHy9dLqto=yjD=ovaL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2011 at 7:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Armando Uribe <x0095078@ti.com> [110302 13:54]:
>> From: Hari Kanigeri <h-kanigeri2@ti.com>
>>
>> omap4 interrupt disable bits is different. On rx kfifo full, the mbox rx
>> interrupts wasn't getting disabled, and this is causing the rcm stress tests
>> to hang.
>>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> Signed-off-by: Armando Uribe <x0095078@ti.com>
>> Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
>
> Should we merge this as a fix for the 2.6.38 still?

yeah, if it can still be merged in 2.6.38 because it is a fix it would be great.

Regards,
Fernando.

>
> Tony
>
>> ---
>> ?arch/arm/mach-omap2/mailbox.c | ? 10 ++++++----
>> ?1 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
>> index 394413d..011ca50 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -193,10 +193,12 @@ static void omap2_mbox_disable_irq(struct omap_mbox *mbox,
>> ? ? ? ? ? ? ? omap_mbox_type_t irq)
>> ?{
>> ? ? ? struct omap_mbox2_priv *p = mbox->priv;
>> - ? ? u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>> - ? ? l = mbox_read_reg(p->irqdisable);
>> - ? ? l &= ~bit;
>> - ? ? mbox_write_reg(l, p->irqdisable);
>> + ? ? u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>> +
>> + ? ? if (!cpu_is_omap44xx())
>> + ? ? ? ? ? ? bit = mbox_read_reg(p->irqdisable) & ~bit;
>> +
>> + ? ? mbox_write_reg(bit, p->irqdisable);
>> ?}
>>
>> ?static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
>> --
>> 1.7.0.4
>>
>
