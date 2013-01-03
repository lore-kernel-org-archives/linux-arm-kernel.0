From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 3 Jan 2013 18:20:54 +0800
Subject: [PATCH 3/9] ARM: PRIMA2: initialize l2x0 according to mach from DT
In-Reply-To: <20130102134353.GD25907@e106331-lin.cambridge.arm.com>
References: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
 <1356005639-23466-4-git-send-email-Barry.Song@csr.com>
 <20130102134353.GD25907@e106331-lin.cambridge.arm.com>
Message-ID: <CAGsJ_4y-DggJNJFROUy-1UtXRDYZ+otiq1pJDw-_Sx+3z=JwtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/2, Mark Rutland <mark.rutland@arm.com>:
> On Thu, Dec 20, 2012 at 12:13:53PM +0000, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> prima2 and marco have diffetent l2 cache configuration, so
>> we initialize l2x0 cache based on dtb given to kernel.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  arch/arm/mach-prima2/l2x0.c |   14 ++++++++++++++
>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
>> index c998377..909cc6f 100644
>> --- a/arch/arm/mach-prima2/l2x0.c
>> +++ b/arch/arm/mach-prima2/l2x0.c
>> @@ -16,6 +16,11 @@ static struct of_device_id prima2_l2x0_ids[]  = {
>>  	{},
>>  };
>>
>> +static struct of_device_id marco_l2x0_ids[]  = {
>> +	{ .compatible = "sirf,marco-pl310-cache" },
>> +	{},
>> +};
>> +
>>  static int __init sirfsoc_l2x0_init(void)
>>  {
>>  	struct device_node *np;
>> @@ -26,6 +31,15 @@ static int __init sirfsoc_l2x0_init(void)
>>  		return l2x0_of_init(0x40000, 0);
>>  	}
>>
>> +	np = of_find_matching_node(NULL, marco_l2x0_ids);
>> +	if (np) {
>> +		pr_info("Initializing marco L2 cache\n");
>> +		/* Way size: 32KB Associativity: 16-way */
>> +		return l2x0_of_init((2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
>> +			(1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
>> +			L2X0_AUX_CTRL_MASK);
>> +	}
>> +
>>  	return 0;
>>  }
>>  early_initcall(sirfsoc_l2x0_init);
>
> Rather than individually testing each match against the table, could you
> not
> place the configuration values in a struct, and map to this with
> of_device_id::data?

ok. good idea.

>
> Thanks,
> Mark.
>
-barry
