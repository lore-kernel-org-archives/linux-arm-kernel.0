From: roger.quadros@nokia.com (Roger Quadros)
Date: Thu, 08 Jul 2010 11:54:46 +0300
Subject: [PATCH 11/15] wireless: wl1271: introduce platform device support
In-Reply-To: <alpine.LFD.2.00.1007070937040.6020@xanadu.home>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-12-git-send-email-ohad@wizery.com>
	<4C32EF19.1000604@nokia.com>
	<AANLkTintIz-N7MwwtqhVq2LR3Ln5JTNYSbJUBSSClcA-@mail.gmail.com>
	<4C3306F4.8060907@nokia.com>
	<AANLkTin5W52fPzWToRrAzm56SLZI-taSuI16rCEhLWqH@mail.gmail.com>
	<4C333E0D.2070601@nokia.com>
	<alpine.LFD.2.00.1007061316010.6020@xanadu.home>
	<4C343135.1090101@nokia.com>
	<alpine.LFD.2.00.1007070937040.6020@xanadu.home>
Message-ID: <4C359256.3080704@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2010 04:52 PM, ext Nicolas Pitre wrote:
> On Wed, 7 Jul 2010, Roger Quadros wrote:
>
>> On 07/06/2010 08:42 PM, ext Nicolas Pitre wrote:
>>> On Tue, 6 Jul 2010, Roger Quadros wrote:
>>>
>>>> OK, this is how I see it.
>>>>
>>>> - Treat the non-removable card as non-removable. So no need to do card
>>>> detect
>>>> emulation.
>>>>
>>>> - Treat the GPIO power enable on wl1271 as VMMC supply. Use fixed
>>>> regulator
>>>> framework to define this regulator&   supply. Even though you mention that
>>>> it
>>>> is not actually a supply, it fits well in the fixed supply framework.
>>>>
>>>> - When the host controller is enumerated, the mmc core will power up the
>>>> slot,
>>>> find the sdio card, and probe the function driver (i.e. wl1271_sdio).
>>>>
>>>> - if interface is not in use, the function driver must release the sdio
>>>> host,
>>>> and this should eventually disable the vmmc supply.
>>>>
>>>> - Whenever the wlan interface must be brought up, wl1271_sdio, can claim
>>>> the
>>>> sdio host. this will cause the vmmc supply to be enabled, for as long as
>>>> the
>>>> interface is up.
>>>>
>>>> Does this address all issues?
>>>
>>> This is mostly all good, except that claiming/releasing the SDIO host is
>>> about access to the bus.  It must be claimed right before doing any IO,
>>> and released right after that, even when the card is expected to remain
>>> powered.  This is not the proper place to hook power control.
>>
>> Agreed, but is it so that SDIO power may be removed between a host_release and
>> claim? This appears so from omap_hsmmc host controller.
>
> No, it is not because a host is not claimed that power should be
> dropped.  The host claim/release is meant to provide exclusive access to
> the card that's all.
>
> If the OMAP controller is dropping power to the card upon
> host->disable() then it is wrong.  AFAICS only the OMAP controller is
> playing such games at the moment and I suspect the semantics might not
> be all right.  Shutting down the _controller_ when it is idle might be a
> good thing, but not power to the _card_.  Only the function driver might
> know when it is fine to lose power.
>
>
I completely agree with you Nicolas. omap_hsmmc needs to be fixed so that it 
does not control MMC/SDIO slot supply voltage. It should deal with only the mmc 
controller power savings and not the card/function power savings.

regards,
-roger
