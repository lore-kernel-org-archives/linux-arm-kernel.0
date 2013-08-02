From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 02 Aug 2013 19:48:34 +0200
Subject: [PATCH] clk: clk-divider: Export clk_register_divider()
In-Reply-To: <20987.58025.296592.412693@ipc1.ka-ro>
References: <1375460047-27160-1-git-send-email-festevam@gmail.com>
 <20987.58025.296592.412693@ipc1.ka-ro>
Message-ID: <51FBF0F2.1030904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/02/2013 06:47 PM, Lothar Wa?mann wrote:
> Fabio Estevam writes:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> clk_register_divider() needs to be exported so that it could be used
>> in a module driver, otherwise we get the following error:
>>
>> ERROR: "clk_register_divider" [sound/soc/mxs/snd-soc-mxs.ko] undefined!
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>  drivers/clk/clk-divider.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index 6d55eb2..98ee97f 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -317,6 +317,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
>>  	return _register_divider(dev, name, parent_name, flags, reg, shift,
>>  			width, clk_divider_flags, NULL, lock);
>>  }
>> +EXPORT_SYMBOL_GPL(clk_register_divider);
>>  
>>  /**
>>   * clk_register_divider_table - register a table based divider clock with
>> -- 
> Did you try unloading and reloading the module with this patch?
> 
> The registered clock divider will not be deregistered, but will be
> reused upon reload, still using the old (now unmapped) address to
> access the clk registers. Thus the whole approach used in snd-soc-mxs
> is broken by design (at least for modules).
> 
> You would need to keep the mapping of the base registers established
> upon the first module load to let the clock divider registered from
> the first module load stay operational across module unload/load.

Not sure this is a good idea, clock supplier should unregister its
clocks upon module removal. 

> I already considered creating a patch for this, but the whole approach
> seemed me too crappy to submit it to mainline.

I have been working on adding support for the clocks unregistration,
currently only clk_unregister(), following discussion [1] and based 
a little on patch [2]. I'll try to post what I currently have as an 
RFC on Monday.

I've added __clk_get(), __clk_put() for the common clock API
implementation. These functions take reference on the clock supplier
module, but there is also plain reference counting so memory allocated 
for the clock object is freed when last consumer calls clk_put() on 
the clock. This is mainly to avoid a disaster in cases when driver is 
unbound through "unbind" sysfs attribute, the module is not unloaded
but the driver's remove() callback is invoked - which causes the clock
to be unregistered.

My use case is that an SoC camera host interface provides clock for 
external image sensor driver, and since the host interface driver 
is a LKM this can't work without proper clock unregistration support.

[1] http://www.spinics.net/lists/arm-kernel/msg258387.html
[2] http://www.spinics.net/lists/arm-kernel/msg247548.html

Thanks,
Sylwester
