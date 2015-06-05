From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 04 Jun 2015 20:56:30 -0600
Subject: [PATCH 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <87h9qvcd1i.fsf@eliezer.anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-3-git-send-email-eric@anholt.net>
 <55679085.6040402@wwwdotorg.org> <87h9qvcd1i.fsf@eliezer.anholt.net>
Message-ID: <55710FDE.90609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2015 03:02 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> On 05/18/2015 01:43 PM, Eric Anholt wrote:

>>> +static struct clk *rpi_firmware_delayed_get_clk(struct 
>>> of_phandle_args *clkspec, + void *_data)
>> 
>>> +	rpi_clk = &rpi_clocks[clkspec->args[0]]; + +	firmware_node =
>>> of_parse_phandle(of_node, "firmware", 0); +	if (!firmware_node)
>>> { +		dev_err(dev, "%s: Missing firmware node\n",
>>> rpi_clk->name); +		return ERR_PTR(-ENODEV); +	} + +	/* Try a
>>> no-op transaction to see if the driver is loaded yet. */ +	ret
>>> = rpi_firmware_property_list(firmware_node, NULL, 0); +	if
>>> (ret) +		return ERR_PTR(ret);
>> 
>> I would move all that into this driver's probe().
> 
> We can't move all this into the driver's probe, because this is
> where we're returning -EPROBE_DEFER.  We could potentially do just
> the phandle parse up front and allocate some memory to pass it and
> our own device node to this function through the _data arg, but I
> don't see much point.

Well, once the clock core correctly supports deferred probe, that can
be moved.

Aside from that, I think all your other replies to my replies in this
thread/series make sense.
