From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 19 Mar 2015 11:09:44 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <550A05E5.3050100@gmail.com>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana> <550A05E5.3050100@gmail.com>
Message-ID: <20150319100944.GA914@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>Possible. But this change just makes i2c-mux-pinctrl honor status
> >>property at all. There is no functional change except it now allows
> >>you to disable any of the sub-busses.
> >
> >Actually, this is the feature I like. However, I wonder if we shouldn't
> >have that in the core, say in of_i2c_register_devices()?
> 
> Hmm, looking at of_i2c_register_devices():
> 
> 	for_each_available_child_of_node(adap->dev.of_node, node)
> 		of_i2c_register_device(adap, node);
> 
> already honors status properties by using for_each_available_foo.
> Therefore, i2c-core will also skip i2c device nodes disabled by
> status property.

Yes, but only child nodes, not the complete bus. Here is an RFC of what
I mean:

From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC] i2c: of: always check if busses are enabled

Allow all busses to have a "status" property which allows busses to not
be probed when set to "disabled". Needed for DTS overlays with i2c mux
scenarios.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fe80f85896e267..d9a3ad2149332e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1305,8 +1305,8 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 {
 	struct device_node *node;
 
-	/* Only register child devices if the adapter has a node pointer set */
-	if (!adap->dev.of_node)
+	/* Only register childs if adapter has a node pointer with enabled status */
+	if (!adap->dev.of_node || !of_device_is_available(adap->dev.of_node))
 		return;
 
 	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");

> I am not too deep into i2c-core, but AFAIKS i2c-mux-pinctrl is not an
> i2c device but an i2c mux that is dealt with differently? It is not
> probed with of_i2c_register_devices() but as a separate platform_device
> with a reference to the parent i2c bus.

Yes, but the busses have seperate nodes. Those nodes with the 'reg =
<0>' properties. And those are matched with of_i2c_register_devices when
the reg-property and the chan_id match.

> About the memory allocation for the maximum potential number of muxes:
> We would need some way to distinguish disabled from enabled muxes in
> i2c-mux-pinctrl's platform_data.

Do we? Can't we claim that every described bus needs a pinctrl entry.
Still, the disabled busses won't be probed? So, we could also think
about putting the above code snippet into i2c-mux when registering
busses, so not only the childs will be skipped but also the whole
bus will not be created.

> i2c_mux_pinctrl_probe() is basically DT-agnostic and it should
> definitely stay that way. Currently, each mux within pd->bus_count

I agree.

> requires a non-NULL pd->pinctrl_states[i] otherwise _probe() will bail
> out for all sub-busses.

And I think that makes sense.

> (b) allow (and skip) muxes with pinctrl_states[i] == NULL for now and
> let the "maniac" deal with storing/re-probing the corresponding
> pinctrl_state name once it gets dynamically enabled.

Why do you need the NULL?

> I am still not too eager working on it but if you insist, I can see
> what I can do as long as Stephen sticks with testing it on Tegra. ;)

Please decide if you want to work on it. Remember, I am not short of
patches to deal with.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150319/81bc71e9/attachment.sig>
