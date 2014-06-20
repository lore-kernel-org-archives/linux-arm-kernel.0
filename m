From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 20 Jun 2014 14:57:25 -0400
Subject: [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <CAJ5Y-ebp1rrRwDWCWSqkSpFg0jr4JktzKpBhWQv9jrwxhqndQQ@mail.gmail.com>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
 <4476889.LvjMyVbGZ8@wuerfel>
 <CAJ5Y-eZ0z-SPSn9oxced2GOAw+OA5rC+uq4pCSXh5H2JujPm1g@mail.gmail.com>
 <CAJ5Y-ebp1rrRwDWCWSqkSpFg0jr4JktzKpBhWQv9jrwxhqndQQ@mail.gmail.com>
Message-ID: <CAJ5Y-eZkTwc-uc+fcHH+1WwBhP=wOrCBrPOKH-gQpqQ9AnTAFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 June 2014 14:55, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hello,
>
> On 12 June 2014 13:14, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> On 12 June 2014 13:02, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thursday 12 June 2014 12:48:10 Ashwin Chaugule wrote:
>>>>
>>>> +#ifndef CONFIG_ACPI
>>>>         if (!mbox->of_xlate)
>>>>                 mbox->of_xlate = of_mbox_index_xlate;
>>>> -
>>>> +#endif
>>>>         mutex_lock(&con_mutex);
>>>>         list_add_tail(&mbox->node, &mbox_cons);
>>>>         mutex_unlock(&con_mutex);
>>>>
>>>
>>> You can't do #ifndef here, the driver must still work if
>>> both OF and ACPI are enabled.
>>
>> Ok. Here we could skip the macro altogether, since of_xlate wont be
>> called with ACPI anyway.
>>
>> Will need to look into using/faking mbox->dev to remove the other ifndefs.
>
>
> So, in order to get an mbox->dev for ACPI platforms, we'd need an
> entry in the DSDT table. That seems rather pointless, since the DSDT
> is reserved for devices and is supposed to be OS agnostic. Since the
> mailbox controller itself is not really a "device" with a resource
> descriptor, I dont see the point in adding a dummy DSDT entry for the
> sake of getting this `struct device`. Also, I'm told adding new
> entries to this table requires registering a unique 4 character
> identifier and approval from some committees. If there are other ways
> to get this structure I'd like to hear about it.
>
> The other alternative would be to piggy back on the ACPI CPU detection
> code, which looks for the ACPI0007 device node in the DSDT and use
> that as the mbox controller device. This node is already registered
> and is an established method to detect CPUs. But I'm not sure what
> happens when CPUs are hotplugged off, we surely dont want mailbox
> clients such as PCC to break.
>
> The third alternative is to ignore the dev refcounts for ACPI as shown
> in this totally untested patch:
>
> ----------------8<----------------------------------------
>
>
> From 6fe6e583f0b23b08643a4a85545a9a5338b9b1a0 Mon Sep 17 00:00:00 2001
> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Date: Wed, 11 Jun 2014 16:09:35 -0400
> Subject: [PATCH] Mailbox: Add support for ACPI
>
> The current mailbox framework only supports DT based bindings.
> Add another mechanism for mailbox clients to register with mailbox
> controllers and request for specific mailbox channels. This enables
> usage of the mailbox framework on kernels with ACPI support.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/mailbox/mailbox.c          | 177 ++++++++++++++++++++++++++-----------
>  include/linux/mailbox_client.h     |   2 +-
>  include/linux/mailbox_controller.h |   1 +
>  3 files changed, 129 insertions(+), 51 deletions(-)
>

> -------------------------8<-------------------------------
>
> Btw I havent rebased to v7 of the mailbox patchwork yet, since I'd
> like to hear feedback on the direction I'm taking with ACPI before I
> rebase.
>
>

That probably messed up the formatting.. Attaching the patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Mailbox-Add-support-for-ACPI.patch
Type: text/x-patch
Size: 8409 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140620/4018cce4/attachment.bin>
