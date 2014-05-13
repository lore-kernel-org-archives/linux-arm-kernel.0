From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 13 May 2014 23:25:50 +0200
Subject: [PATCH 1/8] clk: add helper for unique DT clock names
In-Reply-To: <20140513205111.5943.12709@quantum>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1399839881-29895-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140513194922.5943.40228@quantum> <53727E6E.6050503@gmail.com>
 <20140513205111.5943.12709@quantum>
Message-ID: <53728DDE.60105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 10:51 PM, Mike Turquette wrote:
> Quoting Sebastian Hesselbarth (2014-05-13 13:19:58)
>> On 05/13/2014 09:49 PM, Mike Turquette wrote:
>>> Quoting Sebastian Hesselbarth (2014-05-11 13:24:34)
>>>> Currently, most DT clock drivers pick a unique node name to allow unique
>>>> clock names. As ePAPR recommends node names to be generic, we therefore
>>>> provide a helper to generate a unique clock name from the DT node name
>>>> plus reg property or a magic number instead. This is basically the same
>>>> we already do for proper devices and may vanish as soon as there is some
>>>> (early) device support for clocks available.
>>>>
>>>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> [...]
>>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>>> index dff0373f53c1..b449a635dbfa 100644
>>>> --- a/drivers/clk/clk.c
>>>> +++ b/drivers/clk/clk.c
>>>> @@ -17,6 +17,7 @@
>>>>  #include <linux/list.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/of.h>
>>>> +#include <linux/of_address.h>
>>>>  #include <linux/device.h>
>>>>  #include <linux/init.h>
>>>>  #include <linux/sched.h>
>>>> @@ -2543,6 +2544,34 @@ const char *of_clk_get_parent_name(struct device_node *np, int index)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
>>>>  
>>>> +/**
>>>> + * of_clk_create_name() - Allocate and create a unique clock name
>>>> + * @np: Device node pointer of the clock node
>>>> + *
>>>> + * This will allocate and create a unique clock name based on the
>>>> + * reg property value. As a last resort, it will use the node name
>>>> + * followed by a unique number. The caller has to deallocate the
>>>> + * buffer.
>>>> + */
>>>> +char *of_clk_create_name(struct device_node *np)
>>>> +{
>>>> +       static atomic_t clk_no_reg_magic;
>>>> +       const __be32 *reg;
>>>> +       u64 addr;
>>>> +       int magic;
>>>> +
>>>> +       reg = of_get_property(np, "reg", NULL);
>>>> +       if (reg) {
>>>> +               addr = of_translate_address(np, reg);
>>>> +               return kasprintf(GFP_KERNEL, "%llx.%s",
>>>> +                                (unsigned long long)addr, np->name);
>>>> +       }
>>>> +
>>>> +       magic = atomic_add_return(1, &clk_no_reg_magic);
>>>> +       return kasprintf(GFP_KERNEL, "%s.%d", np->name, magic);
>>>
>>> For the case where we the reg property is present we use reg.name, but
>>> for the case were the reg property is missing we use name.magic. Is it
>>> intentional to switch the string and integer pairs?
>>>
>>> Doing so avoids the case where magic might collide with a simple bus
>>> clock (e.g. 'clk at 1'), but I wanted to double check that it was
>>> intentional.
>>
>> Mike,
>>
>> yes it is intentional and copies what is done for platform_device names.
>>
>> Unfortunately, as much as I prefer this patch someday, it doesn't work
>> with the rest of the helpers as expected. While this can generate unique
>> and generic clock names, especially of_clk_get_parent_name() picks
>> either an clock-output-names named clock _or_ the node name ignoring the
>> above auto-generated name of course.
>>
>> If you agree with the general approach here, we should still postpone
>> this for the next cycle when I have more time to look at the details.
>> I prefer to rename the nodes and use clock-output-names where required
>> for the Berlin clock nodes now.
> 
> Yes, that sounds fine. I'd also like the DT maintainers to take a look
> at this and weigh in.

Ok, great! So, I drop the of_clk_create_name() for the Berlin clock
drivers now and send a v2 with some bugs fixed. I also received the
requested BG2Q dtsi changes and tests from Alexandre.

Will pick up the DT clock naming issues next cycle then. Would be good
to get some remarks from the DT maintainers in the meantime.

Sebastian

>>>> +}
>>>> +EXPORT_SYMBOL_GPL(of_clk_create_name);
>>>> +
>>>>  struct clock_provider {
>>>>         of_clk_init_cb_t clk_init_cb;
>>>>         struct device_node *np;
>>>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>>>> index 511917416fb0..c6f3ca1cd81c 100644
>>>> --- a/include/linux/clk-provider.h
>>>> +++ b/include/linux/clk-provider.h
>>>> @@ -514,6 +514,7 @@ struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
>>>>  struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
>>>>  int of_clk_get_parent_count(struct device_node *np);
>>>>  const char *of_clk_get_parent_name(struct device_node *np, int index);
>>>> +char *of_clk_create_name(struct device_node *np);
>>>>  
>>>>  void of_clk_init(const struct of_device_id *matches);
>>>>  
>>>> @@ -543,6 +544,10 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
>>>>  {
>>>>         return NULL;
>>>>  }
>>>> +static inline char *of_clk_create_name(struct device_node *np)
>>>> +{
>>>> +       return NULL;
>>>> +}
>>>>  #define of_clk_init(matches) \
>>>>         { while (0); }
>>>>  #endif /* CONFIG_OF */
>>>> -- 
>>>> 1.9.1
>>>>
>>
