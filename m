From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Wed, 24 Nov 2010 07:09:16 -0600
Subject: [PATCH v4 5/5] OMAP: mailbox: add notification support for
	multiple readers
In-Reply-To: <AANLkTi=tzuzOMa6kPp-a6+yn6xMLGtdVSvAxPFP5RU5q@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-6-git-send-email-h-kanigeri2@ti.com>
	<AANLkTi=tzuzOMa6kPp-a6+yn6xMLGtdVSvAxPFP5RU5q@mail.gmail.com>
Message-ID: <AANLkTin8kxk=R5xQyp-ZcKVr-0eiM82L=QcF1PC2g-5n@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 11:29 PM, Varadarajan, Charulatha <charu@ti.com> wrote:
> On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> wrote:
>> In the current mailbox driver, the mailbox internal pointer for
>> callback can be directly manipulated by the Users, so a second
>> User can easily corrupt the first user's callback pointer.
>> The initial effort to correct this issue can be referred here:
>> https://patchwork.kernel.org/patch/107520/
>>
>> Along with fixing the above stated issue, this patch ?adds the
>> flexibility option to register notifications from
>> multiple readers to the events received on a mailbox instance.
>> The discussion regarding this can be referred here.
>> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg30671.html
>>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
>> ---
>> ?arch/arm/plat-omap/include/plat/mailbox.h | ? ?7 +-
>> ?arch/arm/plat-omap/mailbox.c ? ? ? ? ? ? ?| ?104 ++++++++++++++++-------------
>> ?2 files changed, 62 insertions(+), 49 deletions(-)
>>
>
> <<snip>>
>
>> @@ -363,10 +372,13 @@ int omap_mbox_register(struct device *parent, struct omap_mbox **list)
>> ? ? ? ? ? ? ? ? ? ? ? ?ret = PTR_ERR(mbox->dev);
>> ? ? ? ? ? ? ? ? ? ? ? ?goto err_out;
>> ? ? ? ? ? ? ? ?}
>> +
>
> Do this change in the patch where the below code was added.

I am sorry I didn't get you. you mean BLOCKING_INIT_NOTIFIER_HEAD line
? yes, it is needed for this patch.
>
>> ? ? ? ? ? ? ? ?if (cpu_is_omap44xx())
>> ? ? ? ? ? ? ? ? ? ? ? ?mbox->rev = OMAP_MBOX_IP_VERSION_2;
>> ? ? ? ? ? ? ? ?else
>> ? ? ? ? ? ? ? ? ? ? ? ?mbox->rev = OMAP_MBOX_IP_LEGACY;
>> +
>> + ? ? ? ? ? ? ? BLOCKING_INIT_NOTIFIER_HEAD(&mbox->notifier);
>> ? ? ? ?}
>> ? ? ? ?return 0;
>>
>> --
>> 1.7.0
>>
>



-- 
Thank you,
Best regards,
Hari Kanigeri
