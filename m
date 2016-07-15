From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Fri, 15 Jul 2016 10:31:09 -0700
Subject: [PATCH v9 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <20160715094541.GE4655@leverpostej>
References: <1468517266-1642-1-git-send-email-ttnguyen@apm.com>
 <1468517266-1642-4-git-send-email-ttnguyen@apm.com>
 <1468518428.8745.43.camel@perches.com>
 <CACgAJHwzWG_6iWG4OcL3v5QcUF892DwBcJxayqbH4f2kd7=kQQ@mail.gmail.com>
 <CACgAJHw7UMFKY=j8UBKUi=hNHfyzVoNMr_A5qOahhbgM+14KBQ@mail.gmail.com>
 <20160715094541.GE4655@leverpostej>
Message-ID: <CACgAJHyaoEJqyeXNsy2HbfxQo2m-Ljm61nDKOtL-Vqbv=NVhKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark and Joe,

On Fri, Jul 15, 2016 at 2:45 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jul 14, 2016 at 11:05:48AM -0700, Tai Tri Nguyen wrote:
>> Hi Joe,
>>
>> On Thu, Jul 14, 2016 at 10:54 AM, Tai Tri Nguyen <ttnguyen@apm.com> wrote:
>> > Hi Joe,
>> >
>> > On Thu, Jul 14, 2016 at 10:47 AM, Joe Perches <joe@perches.com> wrote:
>> >> On Thu, 2016-07-14 at 10:27 -0700, Tai Nguyen wrote:
>> >>> This patch adds a driver for the SoC-wide (AKA uncore) PMU hardware
>> >>> found in APM X-Gene SoCs.
>> >>
>> >> trivia:
>> >>
>> >>> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
>> >> []
>> >>> +struct xgene_pmu_dev_ctx {
>> >>> +     char *name;
>> >>> +     struct list_head next;
>> >>> +     struct xgene_pmu_dev *pmu_dev;
>> >>> +     struct hw_pmu_info inf;
>> >>> +};
>> >>
>> >> Probably better to use something like
>> >>         char    name[20];
>> >> as the kasprintf can fail and this doesn't
>> >> seem to be freed anywhere.
>> >
>> > Okay. I'll fix it shortly.
>> >
>>
>> I take it back.
>> I refer many other drivers using kasprintf and they do the same way I do.
>> Can you please check it again?
>
> Joe is correct that you allocate a string with kasprintf, and this never
> gets freed, even if the driver is removed. Thus, memory may be leaked.
>
> If other drivers do the same, they are similarly wrong.
>
> Even if this is a rare case, it's not good practice to leave allocations
> unbalanced. So please fix this.
>
> If you don't want to change the struct, another option is to use
> devm_kasprintf. However, I suspect with all the accounting data
> structures that will take up more space.
>

Thanks, I will change to use devm_kasprintf because I don't want to
change the struct.

Regards,
-- 
Tai
