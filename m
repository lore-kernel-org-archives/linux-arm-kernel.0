From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 12 Apr 2016 07:04:21 +0200
Subject: [PATCH v1] clk: Add clk_composite_set_rate_and_parent
In-Reply-To: <1460339652-63498-1-git-send-email-finley.xiao@rock-chips.com>
References: <1460339652-63498-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <3986787.PS6VzOpSAJ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Finley,

Am Montag, 11. April 2016, 09:54:12 schrieb Finlye Xiao:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Some of Rockchip's clocks should consider the priority of .set_parent
> and .set_rate to prevent a too large temporary clock rate.
> 
> For example, the gpu clock can be parented to cpll(750MHz) and
> usbphy_480m(480MHz), 375MHz comes from cpll and the div is set
> to 2, 480MHz comes from usbphy_480m and the div is set to 1.
> 
> From the code, when change rate from 480MHz to 375MHz, it changes
> the gpu's parent from USBPHY_480M to cpll first(.set_parent), but the
> div value is still 1 and the gpu's rate will be 750MHz at the moment,
> then it changes the div value from 1 to 2(.set_rate) and the gpu's
> rate will be changed to 375MHz(480MHZ->750MHz->375MHz), here temporary
> rate is 750MHz, the voltage which supply for 480MHz certainly can not
> supply for 750MHz, so the gpu will crash.

We did talk about this internally and while we refined the actual code 
change, it seems I forgot to look at the commit message itself.

This behaviour (and the wish to not overflow a target clock rate) should be 
the same on all socs, so the commit message is quite a bit to Rockchip 
specific. I think I would go with something like:

----------- 8< ------------
When changing the clock-rate, currently a new parent is set first and a 
divider adapted thereafter. This may result in the clock-rate overflowing
its target rate for a short time if the new parent has a higher rate than
the old parent.

While this often doesn't produce negative effects, it can affect components
in a voltage-scaling environment, like the GPU on the rk3399 socs, where the
voltage than simply is to low for the temporarily to high clock rate.

For general clock hirarchies this may need more extensive adaptions to
the common clock-framework, but@least for composite clocks having
both parent and rate settings it is easy to create a short-term solution to
make sure the clock-rate does not overflow the target.
----------- 8< ------------

But of course feel free to extend or change that as you wish ;-) .


> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

I remember having clocks not overflow their target rate came up in some ELC 
talk last week (probably in Stephens Qualcomm-kernel-talk) and a general 
solution might need some changes closer to the core.

But at least for composite clocks where we can control the rate+parent 
process easily, Finley's change is a nice low-hanging fruit which at least 
improves behaviour for those clock-types in the short term, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko
