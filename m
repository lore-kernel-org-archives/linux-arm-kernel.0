From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 11 Oct 2010 22:05:38 +0300
Subject: [PATCH 2/3] omap: dsp: fix ioremap() usage
In-Reply-To: <496565EC904933469F292DDA3F1663E602F47B2BCD@dlee06.ent.ti.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
	<1286732440-28644-3-git-send-email-felipe.contreras@gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B2BCD@dlee06.ent.ti.com>
Message-ID: <AANLkTinMhMJhTYoG7TRPUtb8DkTc8hCyH+GWEfKFD80d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 6:15 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>> +#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)
>> +
>> +static phys_addr_t omap_dsp_mempool_base;
>> +
>> +static void __init omap_dsp_reserve_mem(struct meminfo *mi) {
>> + ? ? phys_addr_t size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
>> + ? ? phys_addr_t addr = ~0;
>> + ? ? int i;
>> +
>> + ? ? if (!size)
>> + ? ? ? ? ? ? return;
>> +
>> + ? ? for (i = mi->nr_banks - 1; i >= 0; i--)
>> + ? ? ? ? ? ? if (mi->bank[i].size >= size) {
>> + ? ? ? ? ? ? ? ? ? ? mi->bank[i].size -= size;
>> + ? ? ? ? ? ? ? ? ? ? addr = mi->bank[i].start + mi->bank[i].size;
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? }
>
> Missing {} in "for" lopp. Even tough you are checking for success inside
> For loop why check again outside? And also not need to define addr.
> What do you think about this:

It comes directly from Russell's code:
http://article.gmane.org/gmane.linux.kernel/1046606

But I do prefer to add the braces. Your proposed patch is ok, although
I prefer to have the important code at the end of the function, and
the error check before that.

Anyway, Russell has come with a different approach, so I have to try
that instead.

Cheers.

-- 
Felipe Contreras
