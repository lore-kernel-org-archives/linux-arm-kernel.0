From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Mar 2015 10:49:02 -0600
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <20150319160208.GF7657@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana> <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana>
Message-ID: <550AFDFE.8040005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 10:02 AM, Wolfram Sang wrote:
>>> -	/* Only register child devices if the adapter has a node pointer set */
>>> -	if (!adap->dev.of_node)
>>> +	/* Only register childs if adapter has a node pointer with enabled status */
>>> +	if (!adap->dev.of_node || !of_device_is_available(adap->dev.of_node))
>>>   		return;
>>
>> That feels a bit odd to me. For a regular non-mux I2C controller, that extra
>> case would never trigger if the controller node was disabled, since the
>> device core would never probe the controller device itself. So, we'd end up
>> with inconsistent paths through the I2C core for regular controllers and
>> muxes.
>
> I first thought the no-op for the non-mux case wouldn't hurt, but I
> agree about the consistent code path. I mentioned in my previous mail
> that i2c-mux might be a better place for this...
>
>> Perhaps better would be to have a mux-specific function to iterate over a
>> mux's child nodes and instantiate buses for those. That function would check
>> whether each bus node was disabled or not. That'd isolate the special case
>> into the place where it was relevant.
>
> ... so I wonder what you think about putting the
> of_device_is_available() check into i2c_add_mux_adapter() once the
> reg-property and chan_id have been matched?

I think that looks like a good place, yes.
