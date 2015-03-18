From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Mar 2015 15:00:37 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <55097C46.9010605@gmail.com>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana> <55097C46.9010605@gmail.com>
Message-ID: <20150318140037.GE3580@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 02:23:18PM +0100, Sebastian Hesselbarth wrote:
> On 18.03.2015 13:30, Wolfram Sang wrote:
> >On Mon, Mar 09, 2015 at 01:21:05PM +0100, Sebastian Hesselbarth wrote:
> >>I2C mux pinctrl driver currently determines the number of sub-busses by
> >>counting available pinctrl-names. Unfortunately, this requires each
> >>incarnation of the devicetree node with different available sub-busses
> >>to be rewritten.
> >>
> >>This patch reworks i2c-mux-pinctrl driver to count the number of
> >>available sub-nodes instead. The rework should be compatible to the old
> >>way of probing for sub-busses and additionally allows to disable unused
> >>sub-busses with standard DT property status = "disabled".
> >
> >Not sure about this change. With DYNAMIC_OF these days, you can't rely
> >that 'disabled' stays disabled all the time. My gut feeling tells me
> >that people will want to use this someday.
> 
> Possible. But this change just makes i2c-mux-pinctrl honor status
> property at all. There is no functional change except it now allows
> you to disable any of the sub-busses.

Actually, this is the feature I like. However, I wonder if we shouldn't
have that in the core, say in of_i2c_register_devices()?

> I agree that this driver still does not cope well with DYNAMIC_OF but
> neither did the former implementation. How about we settle this driver
> to this implementation now and wait for any maniac that wants to use it
> the way you are suggesting above?

Sure. I don't want you to make this driver OF_DYNAMIC compatible. I just
thought it makes it harder, though, e.g. you allocate memory for the
number of active busses not the number of possibilities, so that would
have to be reverted by the "maniac". I am still at the glimpse level,
but what if we let the mux-pinctrl parse all the data (even for disabled
busses), but only the enabled ones will get a muxed adapter because this
is handled in of_i2c_register_devices()?

> BTW, I have received a patchwork update notification - it may be
> unrelated but I prefer the Dove dts/dtsi changes to go through mvebu
> tree.

Yes, I only take dts patches in rare cases.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/bdb39c5f/attachment.sig>
