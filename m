From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Mar 2015 09:47:41 -0600
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <20150319100944.GA914@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana>
Message-ID: <550AEF9D.6090307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 04:09 AM, Wolfram Sang wrote:
>
>>>> Possible. But this change just makes i2c-mux-pinctrl honor status
>>>> property at all. There is no functional change except it now allows
>>>> you to disable any of the sub-busses.
>>>
>>> Actually, this is the feature I like. However, I wonder if we shouldn't
>>> have that in the core, say in of_i2c_register_devices()?
>>
>> Hmm, looking at of_i2c_register_devices():
>>
>> 	for_each_available_child_of_node(adap->dev.of_node, node)
>> 		of_i2c_register_device(adap, node);
>>
>> already honors status properties by using for_each_available_foo.
>> Therefore, i2c-core will also skip i2c device nodes disabled by
>> status property.
>
> Yes, but only child nodes, not the complete bus. Here is an RFC of what
> I mean:
>
> From: Wolfram Sang <wsa@the-dreams.de>
> Subject: [RFC] i2c: of: always check if busses are enabled
>
> Allow all busses to have a "status" property which allows busses to not
> be probed when set to "disabled". Needed for DTS overlays with i2c mux
> scenarios.

> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c

> @@ -1305,8 +1305,8 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
>   {
>   	struct device_node *node;
>
> -	/* Only register child devices if the adapter has a node pointer set */
> -	if (!adap->dev.of_node)
> +	/* Only register childs if adapter has a node pointer with enabled status */
> +	if (!adap->dev.of_node || !of_device_is_available(adap->dev.of_node))
>   		return;

That feels a bit odd to me. For a regular non-mux I2C controller, that 
extra case would never trigger if the controller node was disabled, 
since the device core would never probe the controller device itself. 
So, we'd end up with inconsistent paths through the I2C core for regular 
controllers and muxes.

Perhaps better would be to have a mux-specific function to iterate over 
a mux's child nodes and instantiate buses for those. That function would 
check whether each bus node was disabled or not. That'd isolate the 
special case into the place where it was relevant.
