From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 2 Feb 2012 15:47:07 +0530
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <alpine.DEB.2.00.1202020302400.586@utopia.booyaka.com>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk>
 <878vkopw2o.fsf@ti.com> <87mx93ok5y.fsf@ti.com>
 <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com>
 <CAMQu2gzVt3K6cuZcbvfNZegimyXz8F4N__A6vDBSyL4QfSnbTw@mail.gmail.com>
 <alpine.DEB.2.00.1202020041220.10541@utopia.booyaka.com>
 <CAMQu2gw5uU4kXRWtuUuYAAUcrTJvS_nQhJ42-_hEmHM2NO8ZZg@mail.gmail.com>
 <alpine.DEB.2.00.1202020302400.586@utopia.booyaka.com>
Message-ID: <CAMQu2gxQHyoH-AC4ut2EGVs6wBvAJqUJ8tzXUm2hH_gZqMGE6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2012 at 3:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 2 Feb 2012, Shilimkar, Santosh wrote:
>
>> Yes, we do have issue with below APIs for OMAP4 and onwards design
>> because of the PRCM change.
>>
>> pwrdm_clear_all_prev_pwrst
>> pwrdm_*_mem_*
>>
>> There use to be a single power state and memory state register till OMAP3
>> at power domain level which can give you the logic and memory last test
>> which is needed for OSWR.
>>
>> On OMAP4, we have registers per modules and it becomes difficult to model
>> this difference in APIs. Initially we tried to fix that with [1] and
>> then later realized
>> that's not going to work on OMAP4 + devices because of mentioned issue.
>
> If the registers are per-module, it seems like the best place for those
> would be the hwmod layer. ?Do you think that makes sense? ?So, something
> like omap_hwmod_clear_all_prev_pwrst(), etc.? ?Seems like that should be
> pretty efficient.
>
But all these are power domain registers after all. Rajendra did one version of
" pwrdm_clear_all_prev_pwrst"  API and inside used hwmod. But then there he
has iterate over all the modules belongs to that power domain.

And if you use hwmod or omap_device kind of API, then  you need to
build those devices in init or some where.

All of that was not looking so elegant and hence the other path was chosen.
The mess is, the registers are still part of power domains though they
are specific
to module. And Fundamentally power domain is stil the central entity
decides the fate of all the modules within that PD, in terms of context
loss/ret etc.

Regards
santosh
