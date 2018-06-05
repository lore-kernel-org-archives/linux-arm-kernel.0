From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 5 Jun 2018 11:57:02 +0200
Subject: [PATCH V3] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <20180605092151.57ezynjgf23yunkf@ninjato>
References: <20180604175911.799-1-marek.vasut+renesas@gmail.com>
 <20180605080727.ygh25rmjsrs3dmlq@verge.net.au>
 <20180605092151.57ezynjgf23yunkf@ninjato>
Message-ID: <3b06b61c-4527-9f0a-d397-5076513e196a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2018 11:21 AM, Wolfram Sang wrote:
> Hi Marek,
> 
> On Tue, Jun 05, 2018 at 10:07:28AM +0200, Simon Horman wrote:
>> On Mon, Jun 04, 2018 at 07:59:11PM +0200, Marek Vasut wrote:
>>> Rather than hard-coding the quirk topology, which stopped scaling,
>>> parse the information from DT. The code looks for all compatible
>>> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied
>>> to the same pin. If so, the code sends a matching sequence to the
>>> PMIC to deassert the IRQ.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> From an I2C point of view:
> 
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Minor nits:
> 
>>> @@ -122,7 +143,13 @@ static struct notifier_block regulator_quirk_nb = {
>>>  
>>>  static int __init rcar_gen2_regulator_quirk(void)
>>>  {
>>> -	u32 mon;
>>> +	struct device_node *np;
>>> +	const struct of_device_id *id;
>>> +	struct regulator_quirk *quirk;
>>> +	struct regulator_quirk *pos;
> 
> Merge the last two lines into one?
> 
>>> +	struct of_phandle_args *argsa, *argsb;
>>> +	u32 mon, addr;
>>> +	int ret;
>>>  
>>>  	if (!of_machine_is_compatible("renesas,koelsch") &&
>>>  	    !of_machine_is_compatible("renesas,lager") &&
>>> @@ -130,6 +157,45 @@ static int __init rcar_gen2_regulator_quirk(void)
>>>  	    !of_machine_is_compatible("renesas,gose"))
>>>  		return -ENODEV;
>>>  
>>> +	for_each_matching_node_and_match(np, rcar_gen2_quirk_match, &id) {
>>> +		if (!np || !of_device_is_available(np))
> 
> Can '!np' actually happen? This is the exit condition of the for-loop,
> or am I overlooking something?

I had to take a look again, no, it's not needed.

-- 
Best regards,
Marek Vasut
