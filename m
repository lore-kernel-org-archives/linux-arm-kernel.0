From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 2 Dec 2015 23:15:23 +0100
Subject: [PATCH 00/13] mvneta Buffer Management and enhancements
In-Reply-To: <87two0254c.fsf@free-electrons.com>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <87lh9f4dbt.fsf@free-electrons.com>
 <CAPv3WKc+HbirDxKy5n6W5O5BUTDEc3X5et5dTKdp81WOXjphGg@mail.gmail.com>
 <874mg248jf.fsf@free-electrons.com>
 <CAPv3WKc8VrgH+aAfHBMwvuOxP17SnXCajtzpxmXf4rt+WFcE-w@mail.gmail.com>
 <CAPv3WKdAhk71HW8nvMWXUApySE5_WNgx4PDrj4+R4Tv6FVGNqA@mail.gmail.com>
 <87si3l2kx5.fsf@free-electrons.com>
 <87two0254c.fsf@free-electrons.com>
Message-ID: <CAPv3WKdHu5O2KEHYpWBHbkA2hHd_QCUK12EBggMDsa8J8D5U2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

2015-12-02 17:21 GMT+01:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Hi,
>
>  On mer., d?c. 02 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>
>>>
>>> So far the issue may have been not noticed, because in every IO driver
>>> using mvebu_mbus_dram_info for configuring MBUS windows, there's
>>> following substraction:
>>> (cs->size - 1) & 0xfffff000
>>>
>>> I think there are two options:
>>> 1. Change size type to u64.
>>
>> If we switch to u64 we really must pay attention to be sure that it
>> won't be used to be written in a register, but the regsiter remains
>> 32bits.
>>
>>> 2. Change condition in mvebu_mbus_get_dram_win_info to:
>>> if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size -1))
>>
>> I think it would be the best solution.
>
> So I applied the following patch:
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -964,7 +964,7 @@ int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr)
>         for (i = 0; i < dram->num_cs; i++) {
>                 const struct mbus_dram_window *cs = dram->cs + i;
>
> -               if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size)) {
> +               if (cs->base <= phyaddr && phyaddr <= (cs->base + cs->size - 1)) {
>                         *target = dram->mbus_dram_target_id;
>                         *attr = cs->mbus_attr;
>                         return 0;
>
> I didn't get any errors during boot related to the BM. However I did not
> manage to use an ethernet interface. The udhcpc never managed to get an
> IP and if I set the IP manually I could not ping.
>
> But on Armada 388 GP I didn't have any issue.
>
> Do you have some idea about waht I could check?
>

I replaced 2GB with 8GB DIMM and after that, on the same kernel/board,
I can't ping either. Very strange, but as I can reproduce the issue,
don't debug it, I will.

Best regards,
Marcin
