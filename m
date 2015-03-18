From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 19 Mar 2015 00:10:29 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <20150318140037.GE3580@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana>
Message-ID: <550A05E5.3050100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.03.2015 15:00, Wolfram Sang wrote:
> On Wed, Mar 18, 2015 at 02:23:18PM +0100, Sebastian Hesselbarth wrote:
>> Possible. But this change just makes i2c-mux-pinctrl honor status
>> property at all. There is no functional change except it now allows
>> you to disable any of the sub-busses.
>
> Actually, this is the feature I like. However, I wonder if we shouldn't
> have that in the core, say in of_i2c_register_devices()?

Hmm, looking at of_i2c_register_devices():

	for_each_available_child_of_node(adap->dev.of_node, node)
		of_i2c_register_device(adap, node);

already honors status properties by using for_each_available_foo.
Therefore, i2c-core will also skip i2c device nodes disabled by
status property.

>> I agree that this driver still does not cope well with DYNAMIC_OF but
>> neither did the former implementation. How about we settle this driver
>> to this implementation now and wait for any maniac that wants to use it
>> the way you are suggesting above?
>
> Sure. I don't want you to make this driver OF_DYNAMIC compatible. I just
> thought it makes it harder, though, e.g. you allocate memory for the
> number of active busses not the number of possibilities, so that would
> have to be reverted by the "maniac". I am still at the glimpse level,
> but what if we let the mux-pinctrl parse all the data (even for disabled
> busses), but only the enabled ones will get a muxed adapter because this
> is handled in of_i2c_register_devices()?

I am not too deep into i2c-core, but AFAIKS i2c-mux-pinctrl is not an
i2c device but an i2c mux that is dealt with differently? It is not
probed with of_i2c_register_devices() but as a separate platform_device
with a reference to the parent i2c bus.

About the memory allocation for the maximum potential number of muxes:
We would need some way to distinguish disabled from enabled muxes in
i2c-mux-pinctrl's platform_data.

i2c_mux_pinctrl_probe() is basically DT-agnostic and it should
definitely stay that way. Currently, each mux within pd->bus_count
requires a non-NULL pd->pinctrl_states[i] otherwise _probe() will bail
out for all sub-busses.

We could rework it to

(a) deal with each sub-bus individually with respect to 
pinctrl_lookup_state() and i2c_add_mux_adapter()

and

(b) allow (and skip) muxes with pinctrl_states[i] == NULL for now and
let the "maniac" deal with storing/re-probing the corresponding
pinctrl_state name once it gets dynamically enabled.

I am still not too eager working on it but if you insist, I can see
what I can do as long as Stephen sticks with testing it on Tegra. ;)

Sebastian
