From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 17 Jul 2012 18:49:04 +0530
Subject: [PATCH] clk: fix compile for OF && !COMMON_CLK
In-Reply-To: <5004C935.4050707@gmail.com>
References: <1342475161-20402-1-git-send-email-robherring2@gmail.com>
 <20120717001228.GA28886@gmail.com> <5004C935.4050707@gmail.com>
Message-ID: <50056648.6000906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob, Mike,

On Tuesday 17 July 2012 07:38 AM, Rob Herring wrote:
> On 07/16/2012 07:12 PM, Mike Turquette wrote:
>> On 20120716-16:46, Rob Herring wrote:
>>> From: Rob Herring<rob.herring@calxeda.com>
>>>
>>> With commit 766e6a4ec602d0c107 (clk: add DT clock binding support),
>>> compiling with OF&&  !COMMON_CLK is broken.
>>>
>>
>> Hi Rob,
>>
>> Thanks for sending this quickly.
>>
>> <snip>
>>> @@ -313,19 +314,19 @@ int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
>>>   struct device_node;
>>>   struct of_phandle_args;
>>>
>>> -#ifdef CONFIG_OF
>>> +#if defined(CONFIG_OF)&&  defined(CONFIG_COMMON_CLK)
>>>   struct clk *of_clk_get(struct device_node *np, int index);
>>>   struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
>>>   struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>>>   #else
>>>   static inline struct clk *of_clk_get(struct device_node *np, int index)
>>>   {
>>> -	return NULL;
>>> +	return ERR_PTR(-EINVAL);

So how is this expected to work on platforms (like OMAP) which have 
CONFIG_OF enabled but not CONFIG_COMMON_CLK?

Archit has been seeing issues with failed clk_get's in the omap dss
driver on linux-next.
The clk_gets pass a valid dev pointer and an alias/con-id.

With the $Subject patch, the of_clk_get_by_name() for our builds always
returns a ERR_PTR(-EINVAL).

Even if we do get the right of_clk_get_by_name() built in,
there is another issue on OMAP where in we have CONFIG_OF
enabled/selected by default for all OMAP2+ builds, even when we
*do not* pass a dt blob to the kernel.

So would the below code fail in such cases because it expects a
valid of_node to be populated for a device (which also has clock
information in it)? if CONFIG_OF is set.

struct clk *clk_get(struct device *dev, const char *con_id)
{
         const char *dev_id = dev ? dev_name(dev) : NULL;
         struct clk *clk;

         if (dev) {
---->
	Any reason why this isn't
	if (dev->of_node) {
---->
                 clk = of_clk_get_by_name(dev->of_node, con_id);
                 if (clk && __clk_get(clk))
                         return clk;
         }

         return clk_get_sys(dev_id, con_id);
}

regards,
Rajendra
