From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Wed, 24 Nov 2010 07:01:57 -0600
Subject: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
In-Reply-To: <AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
	<AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
	<20101124082245.GF2468@legolas.emea.dhcp.ti.com>
	<AANLkTimevr4qgRZQW+DOEBND15VxA0MjkW3pkwND92JL@mail.gmail.com>
Message-ID: <AANLkTimzufujCiF6focs1KLCgsDYpr9v9_9w1Hj=3aet@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 2:50 AM, Varadarajan, Charulatha <charu@ti.com> wrote:
> On Wed, Nov 24, 2010 at 13:52, Felipe Balbi <balbi@ti.com> wrote:
>> On Wed, Nov 24, 2010 at 10:46:04AM +0530, Varadarajan, Charulatha wrote:
>>>>
>>>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>>>> index 48e161c..a1c6bd9 100644
>>>> --- a/arch/arm/plat-omap/mailbox.c
>>>> +++ b/arch/arm/plat-omap/mailbox.c
>>>> @@ -358,6 +358,10 @@ int omap_mbox_register(struct device *parent, struct
>>>> omap_mbox **list)
>>>> ? ? ? ? ? ? ? ? ? ? ? ?ret = PTR_ERR(mbox->dev);
>>>> ? ? ? ? ? ? ? ? ? ? ? ?goto err_out;
>>>> ? ? ? ? ? ? ? ?}
>>>> + ? ? ? ? ? ? ? if (cpu_is_omap44xx())
>>>
>>> Do not use cpu_is* checks in plat-omap/*
>>
>> see the previous thread.
>
> Referring to [1], I do not find why cpu_is* checks is used in plat-omap and
> why it can't be avoided.
>
> In [1], it was suggested to create the pdata field that will be
> populated at init
> time using the cpu_is* check. But in this version, I am finding that
> this is done
> in plat-omap. This can be handled in mach-omap layer itself and can be passed
> as a pdata field which can be extracted during probe.
>
> [1] https://patchwork.kernel.org/patch/337131/
>

Here are these  reasons why I did this way.

- The function omap_mbox_register is called only once during probe
time, and I thought it was ok to call cpu check once during probe
time. Since each mbox instance needs to be aware of the rev field this
was the right place to add since this function iterates through the
list during probe time. There are already calls to cpu_is_omap44xx in
mailbox probe function.

- platform data is not present for mailbox module. I could add it for
revision sake but I would prefer not to do that since this will be a
throw away code once the hwmod infrastructure is ready (note: mailbox
hwmod patches are under review), and amount of mailbox driver rework
might be considerable.

- I could wait till the hwmod patches are ready to include this
change, but don't want to put the dependency with hwmod since this is
a critical fix and want to make it available in the mainline kernel.

Please let me know what you suggest.

Thank you,
Best regards,
Hari Kanigeri
