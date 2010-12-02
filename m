From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 2 Dec 2010 13:45:49 +0800
Subject: [PATCH] add clock debug information for imx51 babbage
In-Reply-To: <871v61tzps.fsf@lechat.rtp-net.org>
References: <AANLkTi=cTYjaDh0Zd-7joLCycMcLoPW+Ekws=46QMoDc@mail.gmail.com>
	<871v61tzps.fsf@lechat.rtp-net.org>
Message-ID: <AANLkTi=EBEen1MHvx7So0xEnrQ8ouSYQXWkKMRy24anH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 1, 2010 at 9:00 PM, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> Yong Shen <yong.shen@linaro.org> writes:
>
>> Hi there,
>>
>> This patch makes BSP development easier, since it displays the whole
>> clock information in tree-like manner. The final goal is to make it a
>> part of common clock framework, but so far this goal depends on other
>> unfinished work.
>>
>> PS: Due to the firewall problem, I send out patch this way. Please
>> give comments inline and use attached patch for testing.
>>
>>>From a856d68c53cf91b3fa30a7742057f7afdaf77482 Mon Sep 17 00:00:00 2001
>> From: Yong Shen <yong.shen@linaro.org>
>> Date: Wed, 1 Dec 2010 19:18:34 +0800
>> Subject: [PATCH] add clock debug information for imx51 babbage
>
> why "imx51 babbage" ? I guess it should be working for all imx51/53
> boards
>
I meant to enable it for babbage (since my task is mainly on it), and
I only have babbage for test. If someone wants to enable it for other
boards, they need to add few lines of code themselves.
>>
>> Add code to expose a tree-like clock debug information in sysfs.
>>
>> Signed-off-by: Yong Shen <yong.shen@linaro.org>
>
> [...]
>
>
>> @@ -842,8 +871,10 @@ static struct clk emi_slow_clk = {
>> ? ? ? .get_rate = clk_emi_slow_get_rate,
>> ?};
>>
>> +
>> ?#define DEFINE_CLOCK_CCGR(name, i, er, es, pfx, p, s) ? ? ? ?\
>> ? ? ? static struct clk name = { ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? ? ? ? __INIT_CLK_DEBUG(name) ? ? ? ? ? ? ? ? ?\
>
> why not ".name = name," no matter of CONFIG_CLK_DEBUG value ?
it is all about that 'shall we include name as a common field in the
clk struct'? I will explain later.
>
>> ? ? ? ? ? ? ? .id ? ? ? ? ? ? = i, ? ? ? ? ? ? ? ? ? ?\
>> ? ? ? ? ? ? ? .enable_reg ? ? = er, ? ? ? ? ? ? ? ? ? \
>> ? ? ? ? ? ? ? .enable_shift ? = es, ? ? ? ? ? ? ? ? ? \
>> @@ -859,6 +890,7 @@ static struct clk emi_slow_clk = {
>>
>> ?#define DEFINE_CLOCK_MAX(name, i, er, es, pfx, p, s) \
>> ? ? ? static struct clk name = { ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? ? ? ? __INIT_CLK_DEBUG(name) ? ? ? ? ? ? ? ? ?\
>> ? ? ? ? ? ? ? .id ? ? ? ? ? ? = i, ? ? ? ? ? ? ? ? ? ?\
>> ? ? ? ? ? ? ? .enable_reg ? ? = er, ? ? ? ? ? ? ? ? ? \
>> ? ? ? ? ? ? ? .enable_shift ? = es, ? ? ? ? ? ? ? ? ? \
>> @@ -937,6 +969,7 @@ CLK_GET_RATE(uart, 1, UART)
>
> [...]
>
>> +struct preinit_clk {
>> + ? ? struct list_head list;
>> + ? ? struct clk *clk;
>> +};
>> +static LIST_HEAD(preinit_clks);
>> +static DEFINE_MUTEX(preinit_lock);
>> +static int init_done;
>> +
>> +void clk_debug_register(struct clk *clk)
>> +{
>> + ? ? int err;
>> + ? ? struct clk *pa;
>> +
>> + ? ? if (init_done) {
>
> is there a reason for not using debugfs_initialized() directly ?
clk_debug_register will be called many times, so the cost of a
variable could be less than a function call.
>
>> + ? ? ? ? ? ? pa = clk_get_parent(clk);
>> +
>> + ? ? ? ? ? ? if (pa && !IS_ERR(pa) && !pa->dentry)
>> + ? ? ? ? ? ? ? ? ? ? clk_debug_register(pa);
>> +
>> + ? ? ? ? ? ? if (!clk->dentry) {
>> + ? ? ? ? ? ? ? ? ? ? err = clk_debug_register_one(clk);
>> + ? ? ? ? ? ? ? ? ? ? if (err)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? return;
>> + ? ? ? ? ? ? }
>> + ? ? } else {
>> + ? ? ? ? ? ? struct preinit_clk *p;
>> + ? ? ? ? ? ? mutex_lock(&preinit_lock);
>> + ? ? ? ? ? ? p = kmalloc(sizeof(*p), GFP_KERNEL);
>> + ? ? ? ? ? ? if (!p)
>> + ? ? ? ? ? ? ? ? ? ? goto unlock;
>> + ? ? ? ? ? ? p->clk = clk;
>> + ? ? ? ? ? ? list_add(&p->list, &preinit_clks);
>> +unlock:
>> + ? ? ? ? ? ? mutex_unlock(&preinit_lock);
>> + ? ? }
>> +}
>> +EXPORT_SYMBOL_GPL(clk_debug_register);
>> +
>> +static int __init clk_debugfs_init(void)
>> +{
>> + ? ? struct preinit_clk *pclk, *tmp;
>> +
>> + ? ? if (debugfs_initialized())
>> + ? ? ? ? ? ? init_done = 1;
>> +
>> + ? ? list_for_each_entry(pclk, &preinit_clks, list) {
>> + ? ? ? ? ? ? clk_debug_register(pclk->clk);
>> + ? ? }
>> +
>> + ? ? list_for_each_entry_safe(pclk, tmp, &preinit_clks, list) {
>> + ? ? ? ? ? ? list_del(&pclk->list);
>> + ? ? ? ? ? ? kfree(pclk);
>> + ? ? }
>> + ? ? return 0;
>> +}
>> +late_initcall(clk_debugfs_init);
>> +#endif
>> diff --git a/arch/arm/plat-mxc/include/mach/clock.h
>> b/arch/arm/plat-mxc/include/mach/clock.h
>> index 753a598..fb0e0bd 100644
>> --- a/arch/arm/plat-mxc/include/mach/clock.h
>> +++ b/arch/arm/plat-mxc/include/mach/clock.h
>> @@ -23,9 +23,14 @@
>> ?#ifndef __ASSEMBLY__
>> ?#include <linux/list.h>
>>
>> +#define CLK_NAME_LEN 32
>> ?struct module;
>>
>> ?struct clk {
>> +#ifdef CONFIG_CLK_DEBUG
>> + ? ? char name[CLK_NAME_LEN];
>> + ? ? struct dentry ? ? ? ? ? *dentry;
>> +#endif
>
> Do we really need the #ifdef here ?
In the formal release, these debug informations are not needed. It
doesn't make sense to keep them in the clk struct which will consume
some memery, like 32+4 bytes more (depends on the compiler).
>
> Arnaud
>
