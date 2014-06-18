From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 18 Jun 2014 10:32:49 +0200
Subject: [linux-sunxi] Re: [PATCH v4 4/7] regulator: axp20x: reset probe
 data before each probe
In-Reply-To: <53A13BBF.7090202@free-electrons.com>
References: <1402990723-28138-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402990723-28138-5-git-send-email-boris.brezillon@free-electrons.com>
 <20140617204449.GD19730@lukather> <53A13BBF.7090202@free-electrons.com>
Message-ID: <53A14EB1.9090600@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/18/2014 09:11 AM, Boris BREZILLON wrote:
> 
> On 17/06/2014 22:44, Maxime Ripard wrote:
>> On Tue, Jun 17, 2014 at 09:38:40AM +0200, Boris BREZILLON wrote:
>>> The init_data and of_node fields of the axp2xx_matches tables are filled
>>> at each device probe by the axp20x_regulator_parse_dt function (which then
>>> calls the of_regulator_match function).
>>> This means we can probe a new device and consider data initialized during
>>> the probe of another device as valid.
>>>
>>> Reset init_data and of_node field to NULL before each probe in order to
>>> avoid this kind of issue.
>>>
>>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>>> ---
>>>  drivers/regulator/axp20x-regulator.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
>>> index 7a30f49..d42bf6d 100644
>>> --- a/drivers/regulator/axp20x-regulator.c
>>> +++ b/drivers/regulator/axp20x-regulator.c
>>> @@ -324,6 +324,15 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>>>  		nregulators = AXP20X_REG_ID_MAX;
>>>  	}
>>>  
>>> +	/*
>>> +	 * Reset matches table (this table might have been modified by a
>>> +	 * previous AXP2xx device probe).
>>> +	 */
>>> +	for (i = 0; i < nmatches; i++) {
>>> +		matches[i].init_data = NULL;
>>> +		matches[i].of_node = NULL;
>>> +	}
>>> +
>> That looks rather hackish, especially since we've never been in such a
>> case yet, since we have a single PMIC in our system.
> 
> Even if something is unlikely to happen, it doesn't mean it's impossible.
> I'm pretty sure there are (or will be) some systems containing several
> identical PMICs in the wild, and fixing this possible bug now prevents
> us (or other developers) from having a big headache debugging this in
> the future.

If you're really worried about this, you should also be worried
about 2 probes running at the same time racing against each other
(I know the bus level code will not do that now, but what about the
 future).

If you cannot treat / use the global struct as const, then you really should
have a local copy, and const-ify the global version and use it as a template
to initialize the local copy.

> BTW, what is hackish in this code ?

See above, changing a global struct, and then re-initializing it on the
next probe just is not pretty. TBH this raised my eyebrows the first time
you posted it already, but I decided to let it be. But since we're discussing
this now anyways I have to agree with Maxime.

Regards,

Hans
