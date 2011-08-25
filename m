From: robherring2@gmail.com (Rob Herring)
Date: Wed, 24 Aug 2011 21:19:19 -0500
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <20110816221945.GA4066@gallagher>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
	<20110816221945.GA4066@gallagher>
Message-ID: <4E55B127.9090103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie,

On 08/16/2011 05:19 PM, Jamie Iles wrote:
> Hi Rob,
> 
> On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This adds basic support for the Calxeda Highbank platform.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
> [...]
>> +static void __init highbank_timer_init(void)
>> +{
>> +	int irq;
>> +	struct device_node *np;
>> +	void __iomem *timer_base;
>> +
>> +	/* Map system registers */
>> +	np = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
>> +	sregs_base = of_iomap(np, 0);
> 
> Should the return values be checked here?  I know that all valid device trees 
> should have these nodes and valid a reg property, but I don't know if the 
> error handling needs to be a bit more explicit.  For my platform I have put 
> these checks and panics() if they fail, but I'm not sure if that's the right 
> thing!
> 
A panic will stop the boot at a point the console is not up unless
DEBUG_LL is enabled. If you continue, you may be able to continue long
enough to get a console and then fail when something that depends on
this is used. For this case, it would be when the clocks are not setup
correctly (once real clock setup is implemented). As it is now, these
registers aren't accessed until you do suspend, hotplug, or poweroff.

So probably just a WARN_ON would be better here.

Rob
