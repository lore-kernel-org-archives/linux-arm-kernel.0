From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 2 Mar 2011 16:10:10 +0530
Subject: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
	requested pads
In-Reply-To: <AANLkTim8tTO5wDvzXxy8G35vYMBsXP2fJu=KHDHpw7aC@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
	<1298903958-6496-3-git-send-email-govindraj.raja@ti.com>
	<AANLkTim8tTO5wDvzXxy8G35vYMBsXP2fJu=KHDHpw7aC@mail.gmail.com>
Message-ID: <AANLkTimvDp_W8Kei=RreXtaBZ+879dBuTvj4K2j+Ve6W@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2011 at 10:19 AM, Varadarajan, Charulatha <charu@ti.com> wrote:
> Govind,
>
> Couple of minor comments.
>
> On Mon, Feb 28, 2011 at 20:09, Govindraj.R <govindraj.raja@ti.com> wrote:
>> For device pads which have OMAP_DEVICE_PAD_WAKEUP set (which means they
>> are wakeup capable) enable the IO-daisy wakeup capability.
>> During re-muxing avoid direct write with val as this can disturb if any
>> mux done at bootloader level so read the pad then write back.
>>
>> Also add a api to fetch the wake-up status bit is set for given omap-hwmod
>
> %s/a api/an API/
>
>> device using available mux info which is added during omap_hwmod_mux_init.
>> Wakeup status bit is needed for uart_resume_idle call from sram_idle path
>> based on wake-up event has occurred for given uart we can enable clocks back.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?arch/arm/mach-omap2/mux.c ? ? ? ? ? ? ? ? ? ?| ? 23 +++++++++++++++++++++++
>> ?arch/arm/mach-omap2/mux.h ? ? ? ? ? ? ? ? ? ?| ? 13 +++++++++++++
>> ?arch/arm/mach-omap2/omap_hwmod.c ? ? ? ? ? ? | ? 13 +++++++++++++
>> ?arch/arm/plat-omap/include/plat/omap_hwmod.h | ? ?1 +
>> ?4 files changed, 50 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>> index 98148b6..5338b93 100644
>> --- a/arch/arm/mach-omap2/mux.c
>> +++ b/arch/arm/mach-omap2/mux.c
>> @@ -317,6 +317,24 @@ err1:
>> ? ? ? ?return NULL;
>> ?}
>>
>> +/* Gets the wakeup status of given pad from omap-hwmod */
>> +int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
>> +{
>> + ? ? ? int i;
>> + ? ? ? unsigned int val = -EINVAL;
>> +
>> + ? ? ? for (i = 0; i < hmux->nr_pads; i++) {
>> + ? ? ? ? ? ? ? struct omap_device_pad *pad = &hmux->pads[i];
>> +
>> + ? ? ? ? ? ? ? val = omap_mux_read(pad->partition, pad->mux->reg_offset);
>> + ? ? ? }
>> +
>> + ? ? ? if (val > 0 && val & OMAP_WAKEUP_EVENT)
>> + ? ? ? ? ? ? ? return 1;
>> + ? ? ? else
>
> No need of else here.

Yes correct.

I am resending this patch with some more modifications
to fix one more issue in the above loop.

--
Thanks,
Govindraj.R



<<SNIP>>
