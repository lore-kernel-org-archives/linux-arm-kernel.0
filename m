From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Fri, 19 Nov 2010 08:22:10 -0600
Subject: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
In-Reply-To: <20101119083250.GH6446@legolas.emea.dhcp.ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
	<4CE5B68F.8000502@ti.com>
	<AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
	<20101119083250.GH6446@legolas.emea.dhcp.ti.com>
Message-ID: <AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Fri, Nov 19, 2010 at 2:32 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Nov 18, 2010 at 06:07:40PM -0600, Kanigeri, Hari wrote:
>>
>> Benoit,
>>
>> On Thu, Nov 18, 2010 at 5:28 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>>>
>>> On 11/18/2010 8:15 PM, Hari Kanigeri wrote:
>>>>
>>>> disabling rx interrupt on omap4 is different than its pre-decessors.
>>>> The bit in OMAP4_MAILBOX_IRQENABLE_CLR should be set to disable the
>>>> interrupts instead of clearing the bit.
>>>>
>>>> Signed-off-by: Hari Kanigeri<h-kanigeri2@ti.com>
>>>> ---
>>>> ?arch/arm/mach-omap2/mailbox.c | ? ?5 ++++-
>>>> ?1 files changed, 4 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/mailbox.c
>>>> b/arch/arm/mach-omap2/mailbox.c
>>>> index 42dbfa4..82b5ced 100644
>>>> --- a/arch/arm/mach-omap2/mailbox.c
>>>> +++ b/arch/arm/mach-omap2/mailbox.c
>>>> @@ -195,7 +195,10 @@ static void omap2_mbox_disable_irq(struct omap_mbox
>>>> *mbox,
>>>> ? ? ? ?struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
>>>> ? ? ? ?u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>>>> ? ? ? ?l = mbox_read_reg(p->irqdisable);
>>>> - ? ? ? l&= ~bit;
>>>> + ? ? ? if (cpu_is_omap44xx())
>>>
>>> Since it is not omap version specific but IP version specific, you should
>>> not use cpu_is_ to do that. Moreover cpu_is calls should be used during
>>> init
>>> only.
>>> You can use the rev field in hwmod_class in order to detect the IP
>>> version.
>>> Smartreflex series for 3630 is already using that kind of mechanism.
>>> You will have to copy that revision information into pdata struct and
>>> then
>>> use that here.
>>
>> I see your point, but since mailbox hwmod patches from Omar are still
>> under review I didn't find any other option than to enable this
>> This is critical functionality that I want to include in and not wait
>> till the hwmod patches are accepted.
>> Please let me know if there is any other way of approaching this problem ?
>
> how about you read the IP revision yourself during probe ? Or pass in a
> flag like I said on the other email ?
>

I like your proposal of reading the IP revision in probe. I will send
a revised patch for this.

Benoit, is this ok until we move to hwmod implemenation ?


Thank you,
Best regards,
Hari Kanigeri
