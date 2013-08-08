From: grundler@chromium.org (Grant Grundler)
Date: Thu, 8 Aug 2013 11:28:44 -0700
Subject: [PATCH v9 03/16] iommu/exynos: fix page table maintenance
In-Reply-To: <1516548.d7oQuzQS7g@amdc1227>
References: <002701ce941a$eecebdb0$cc6c3910$@samsung.com>
 <1516548.d7oQuzQS7g@amdc1227>
Message-ID: <CANEJEGu1ponghpfvyUsQX16+TZWUV+0KXJ7AehjXpju2N_H+Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Thu, Aug 8, 2013 at 6:54 AM, Tomasz Figa <t.figa@samsung.com> wrote:
...
>> +     BUG_ON(lv1ent_section(sent));
>
> Is this condition really a critical one, to the point that the system
> should not continue execution?
>
...
>>       if (lv1ent_page(sent)) {
>> -             if (*pgcnt != NUM_LV2ENTRIES)
>> -                     return -EADDRINUSE;
>> -
>> +             BUG_ON(*pgcnt != NUM_LV2ENTRIES);
>
> Ditto.

I can't speak to the previous BUG_ON(). I believe the EADDRESSINUSE
failures could be either WARN_ON or BUG_ON.   This condition is
clearly a bug in the generic IOMMU allocator and I think that's why
KyongHo Cho used BUG_ON.

Handing out duplicate addresses will generally lead to some sort of
data corruption or other fault depending on how robust the underlying
device drivers are written.  So my preference is a BUG_ON to
immediately flag this condition instead of hoping a device driver will
correctly handling the dma mapping failure (Some do, most currently
don't).

WARN_ON() + return -EADDRESSINUSE would be a good alternative.

thanks,
grant
