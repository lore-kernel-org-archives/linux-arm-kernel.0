From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 30 Jan 2014 18:56:45 +0200
Subject: [PATCH] clk: keystone: gate: fix clk_init_data initialization
In-Reply-To: <52EA627E.8060801@ti.com>
References: <1391081821-13306-1-git-send-email-ivan.khoronzhuk@ti.com>
 <448912EABC71F84BBCADFD3C67C4BE52A0B4EB@DBDE04.ent.ti.com>
 <52EA5866.3090706@ti.com> <52EA627E.8060801@ti.com>
Message-ID: <52EA844D.2090403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok

On 01/30/2014 04:32 PM, Santosh Shilimkar wrote:
> On Thursday 30 January 2014 08:49 AM, Ivan Khoronzhuk wrote:
>> Yes. As result the clk->flag field contains garbage. In my case it leads
>> that flag CLK_IGNORE_UNUSED is set for most of clocks.  As result a bunch
>> of unused clocks cannot be disabled.
>>
> Can you please update the change log with above information.
>
>> On 01/30/2014 03:26 PM, Shilimkar, Santosh wrote:
>>> Can u capture the issue withiout this fix?
>>>
>>> Sent from my Android phone using TouchDown (www.nitrodesk.com)
>>>
>>> -----Original Message-----
>>> *From:* Khoronzhuk, Ivan [ivan.khoronzhuk at ti.com]
>>> *Received:* Thursday, 30 Jan 2014, 6:37am
>>> *To:* Shilimkar, Santosh [santosh.shilimkar at ti.com]
>>> *CC:* mturquette at linaro.org [mturquette at linaro.org];
>>> linux-arm-kernel at lists.infradead.org [linux-arm-kernel at lists.infradead.org];
>>> linux-kernel at vger.kernel.org [linux-kernel at vger.kernel.org]; Khoronzhuk, Ivan
>>> [ivan.khoronzhuk at ti.com]
>>> *Subject:* [PATCH] clk: keystone: gate: fix clk_init_data initialization
>>>
>>> In clk_register_psc() function clk_init_data struct is allocated
>>> in the stack. All members of this struct should be initialized
>>> before using otherwise it will contain garbage. So initialize flags
>>> in this structure too.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>> ---
>>>     drivers/clk/keystone/gate.c | 1 +
>>>     1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/clk/keystone/gate.c b/drivers/clk/keystone/gate.c
>>> index 17a5983..86f1e36 100644
>>> --- a/drivers/clk/keystone/gate.c
>>> +++ b/drivers/clk/keystone/gate.c
>>> @@ -179,6 +179,7 @@ static struct clk *clk_register_psc(struct device *dev,
>>>
>>>             init.name = name;
>>>             init.ops = &clk_psc_ops;
>>> +       init.flags = 0;
>>>             init.parent_names = (parent_name ? &parent_name : NULL);
>>>             init.num_parents = (parent_name ? 1 : 0);
>>>
>>> -- 
>>> 1.8.3.2
>>>
