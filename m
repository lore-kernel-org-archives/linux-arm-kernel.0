From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 07 Jan 2014 14:14:54 +0100
Subject: [PATCH] clk: Correct handling of NULL clk in __clk_{get, put}
In-Reply-To: <20140107140019.7220eed6@ipc1.ka-ro>
References: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
 <20140107140019.7220eed6@ipc1.ka-ro>
Message-ID: <52CBFDCE.7060206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/01/14 14:00, Lothar Wa?mann wrote:
> Sylwester Nawrocki wrote:
>> Ensure clk->kref is dereferenced only when clk is not NULL.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>> Hi Sachin,
>>
>> please try if this patch fixes the exyno5420 boot crash.
>>
>> Thanks,
>> Sylwester
>>
>>  drivers/clk/clk.c |   13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index e3e0327..a1fe86f 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -2179,24 +2179,25 @@ EXPORT_SYMBOL_GPL(devm_clk_unregister);
>>   */
>>  int __clk_get(struct clk *clk)
>>  {
>> -	if (clk && !try_module_get(clk->owner))
>> -		return 0;
>> +	if (clk) {
>> +		if (!try_module_get(clk->owner))
>> +			return 0;
>>
> This change is unnecessary! The part after the && is only evaluated
> when clk is not NULL.

It is, but to ensure there is no NULL clk passed at the kref_get(&clk->ref)
line everything got moved under a common "if (clk) { }".

The code will look like this:

-----------
	if (clk) {
		if (!try_module_get(clk->owner))
			return 0;

		kref_get(&clk->ref);
	}
------------

If preferred I could make it:

------------
if (clk && !try_module_get(clk->owner))
	return 0;

if (clk)
	kref_get(&clk->ref);
------------

--
Regards,
Sylwester
