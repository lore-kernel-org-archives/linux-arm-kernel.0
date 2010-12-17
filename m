From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Fri, 17 Dec 2010 12:43:12 -0600
Subject: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc
	handling
In-Reply-To: <4D0B8FBB.5000906@ti.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
	<AANLkTi=RE3ZEuoe=jMRLiFZ7iVgvuXMrgqfXMAYa92=z@mail.gmail.com>
	<AANLkTinPpj5Po4yPjc8hG1Kjs2wM3b62-hRGMY+U_UjN@mail.gmail.com>
	<4D0B8FBB.5000906@ti.com>
Message-ID: <AANLkTimo=_hm7Atps8E0zkYUbP_kZtpz40FJbbMb0FVL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 10:28 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
>>>> ?/* SYSCONFIG: register bit definition */
>>>> -#define AUTOIDLE ? ? ? (1<< ?0)
>>>> ?#define SOFTRESET ? ? ?(1<< ?1)
>>>> -#define SMARTIDLE ? ? ?(2<< ?3)
>>>> ?#define OMAP4_SOFTRESET ? ? ? ?(1<< ?0)
>>>> -#define OMAP4_NOIDLE ? (1<< ?2)
>>>> -#define OMAP4_SMARTIDLE ? ? ? ?(2<< ?2)
>>>>
>>>> ?/* SYSSTATUS: register bit definition */
>>>> ?#define RESETDONE ? ? ?(1<< ?0)
>>>
>>> Is this still required?
>>
>> Yes, mailbox uses the softreset every time it is requested (and that
>> it has no current users at the time), it does it before configuring
>> sysc, as opossed to what this patch does (where clk is enabled, sysc
>> configured, and then softreset), but no harm was seen with this
>> sequence.
>>
>> AFAIK, enabling/disabling hwmod handles prm reset but not softreset
>> bit, that's why I left it there.
>
> In fact both are handled now. hardreset is managed for IVA, DSP and IPU, and
> softreset for most the other IPs.
> The only slight difference, is that softreset for the moment is just done
> once at setup time. The idea being that we do not know the state the
> bootloader configured IP, so we reset it by default.

Yes, I noticed that softreset was handled on setup only.

> I thought I did it for every enable from disable state, but in fact this is
> not the case, because AFAIK there is not use-case for that yet.
>
> Why do you have to softreset the mailbox? That sounds like some old HW bugs
> from the past that we solve using the softreset.

It is adviced in the TRM that before initialization of the module, you
should do a softreset and set sysc register, I found this explanation
too (with git blame):

    omap: mailbox: Execute softreset at startup

    The softreset at startup is introduced as TRM describes and also some
    register bit definitions are added instead of magic number

But mailbox doesn't execute this on init, but on every first user
request, it doesn't sound like there was a bug solved with this.

Also related (these were the quickest I could check):

- The DSI protocol engine can be reset by software. This reset can be
done for debug purposes or after a protocol error.
- UART needs it too, but in this case it was executed one time at
init, so hwmod was the perfect match to remove it.

> Could you elaborate on that use case? If there is a need, I'd rather update
> the hwmod core than letting you playing directly with the sysconfig. At
> least we can expose the API we did for that purpose but didn't merge due to
> the lack of any strong need.

I also thought of this, but then driver would need:

pm_runtime_get_sync()    // to enable the clock
pdata->device_reset()         // to set the softreset
pm_runtime_put_sync()    // to disable the clock
pm_runtime_get_sync()    // to enable again and reconfigure sysc lost
with softreset

If needed I think softreset should be handled in the device enable
path rather than a new API.

Regards,

Omar
