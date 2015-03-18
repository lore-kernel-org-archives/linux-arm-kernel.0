From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Mar 2015 14:23:18 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <20150318123012.GA3580@katana>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150318123012.GA3580@katana>
Message-ID: <55097C46.9010605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.03.2015 13:30, Wolfram Sang wrote:
> On Mon, Mar 09, 2015 at 01:21:05PM +0100, Sebastian Hesselbarth wrote:
>> I2C mux pinctrl driver currently determines the number of sub-busses by
>> counting available pinctrl-names. Unfortunately, this requires each
>> incarnation of the devicetree node with different available sub-busses
>> to be rewritten.
>>
>> This patch reworks i2c-mux-pinctrl driver to count the number of
>> available sub-nodes instead. The rework should be compatible to the old
>> way of probing for sub-busses and additionally allows to disable unused
>> sub-busses with standard DT property status = "disabled".
>
> Not sure about this change. With DYNAMIC_OF these days, you can't rely
> that 'disabled' stays disabled all the time. My gut feeling tells me
> that people will want to use this someday.

Possible. But this change just makes i2c-mux-pinctrl honor status
property at all. There is no functional change except it now allows
you to disable any of the sub-busses.

I agree that this driver still does not cope well with DYNAMIC_OF but
neither did the former implementation. How about we settle this driver
to this implementation now and wait for any maniac that wants to use it
the way you are suggesting above?

The other option would be to leave the driver as is - but at least on
Dove where the muxing-options are not used often, it will always create
4 i2c-busses (controller plus the three muxing options) on any board
even though the pins are not accessible at all. I think that will just
create massive confusion from the user point-of-view?

BTW, I have received a patchwork update notification - it may be
unrelated but I prefer the Dove dts/dtsi changes to go through mvebu
tree.

Sebastian
