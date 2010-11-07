From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 09:07:45 -0600
Subject: [PATCH v2 3/7] OMAP4: hwmod data: add mailbox data
In-Reply-To: <4CD58DF6.6040600@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
	<1289006244-27147-4-git-send-email-omar.ramirez@ti.com>
	<4CD58DF6.6040600@ti.com>
Message-ID: <AANLkTi=mkBROke+4Yf25QndYB=0pE+k0tE2NKxUM5xU_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 6, 2010 at 12:18 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> I don't know why, but this patch has nothing to do with my original one.
> Can you stick to the original code?

no, apart from the ordering of structure members, that I will change,
since keeping the order of the original structure doesn't fly, I don't
see anything that needs to be changed.

- The magic numbers replaced for the defines, afaik it gives more clarity.
- mailbox irq has a name.
- overall defining block was improved:

        class
        ocp_if
        slave ports
        hwmod

If you see, each dependent reference is right before the structure
that is using it, which at least to me establishes some order, as of
today this ordering doesn't exists.

e.g. you are defining some hwmod and some how you are populating all
the members, if you are looking at your omap_hwmod struct and want to
see the irqs defined you need to scroll beyond the supposed first
reference in omap_hwmod (right now above ocp_if)

>
> On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
>> +/* mailbox */
>
> The original comment is missing.

<quote>
/*
 * 'mailbox' class
 * mailbox module allowing communication between the on-chip processors
 * useusing a queued mailbox-interrupt mechanism.
 */
</quote>

I don't think it adds anything to the patch, should we start
commenting on the functionality of the drivers for each hwmod?

>> +
>> +static struct omap_hwmod omap44xx_mailbox_hwmod;
>> +
>> +static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
>> + ? ? ? {
>> + ? ? ? ? ? ? ? .pa_start ? ? ? = OMAP44XX_MAILBOX_BASE,
>
> If that physical address is not used elsewhere, and it should be the case,
> there is no need to create a define for it. That's why the physical address
> was directly used here.
> There is no added value to create a define for that.

yes there is, apart from readability where '0x4a0f4000' doesn't say much

for me at least, if reviewing I need to open the TRM check if that is
the address and move on, with the define you know that someone have
checked the address before (when creating the define)

besides the define was already there

>> +static struct omap_hwmod omap44xx_mailbox_hwmod = {
>> + ? ? ? .name ? ? ? ? ? = "mailbox",
>> + ? ? ? .class ? ? ? ? ?=&omap44xx_mailbox_hwmod_class,
>> + ? ? ? .prcm ? ? ? ? ? = {
>> + ? ? ? ? ? ? ? .omap4 = {
>> + ? ? ? ? ? ? ? ? ? ? ? .clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
>> + ? ? ? ? ? ? ? },
>> + ? ? ? },
>> + ? ? ? .mpu_irqs ? ? ? = omap44xx_mailbox_irqs,
>> + ? ? ? .mpu_irqs_cnt ? = ARRAY_SIZE(omap44xx_mailbox_irqs),
>
> The order is different than the previous one.

as the order is given by omap4 data, and not the definition of the
structure, I'll keep the consistency with omap4 then.

Regards,

Omar
