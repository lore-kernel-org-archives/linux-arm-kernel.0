From: alex.elder@linaro.org (Alex Elder)
Date: Wed, 04 Dec 2013 07:19:21 -0600
Subject: [PATCH 3/3] ARM: dts: bcm281xx: define real clocks
In-Reply-To: <20131204111906.GG16025@e106331-lin.cambridge.arm.com>
References: <529EA78E.7060904@linaro.org> <529EA813.2070208@linaro.org>
 <20131204111906.GG16025@e106331-lin.cambridge.arm.com>
Message-ID: <529F2BD9.5080808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 05:19 AM, Mark Rutland wrote:
> On Wed, Dec 04, 2013 at 03:57:07AM +0000, Alex Elder wrote:
>> Replace the "fake" clocks defined in the "bcm11351.dtsi" device tree
>> file with real definitions backed by the new BCM281xx clock driver..
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
>> ---
>>  arch/arm/boot/dts/bcm11351.dtsi |  222
>> ++++++++++++++++++++++++++++-----------
>>  1 file changed, 161 insertions(+), 61 deletions(-)
> 
> [...]
> 
>> +		/*
>> +		    * This is a place-holder clock for peripheral
>> +		    * clocks that set their parent clock to an
>> +		    * out-of-range value to explicitly select
>> +		    * "no clock" as a parent.
>> +		    */
>> +		not_selected_clk: not_selected {
>>  			#clock-cells = <0>;
>> -		};
> 
> Huh? This doesn't seem to be used at all in this series. Why is this
> here?

This has been the source of confusion before.

You're right, it's not used in the current patch.  And
because of this, I'll delete it, and add it back once
we have a clock supported that requires it.

But while we're on the subject, here's what it's for.

Each clock has a defined set of parent clocks, and
each has a small integer value that represents it in
a register that controls their selection.  In some
cases the reset value of that register field is a
(specific) value that has no defined clock associated
with it.

Here's an example.  There's a clock "hub_clk_ssp3_audio",
which has three parent clocks:  "ref_crystal" (selector
value 0),  "ref_312m" (selector value 1), and "cx40"
(selector value 2).  But on reset, the value in that
selector field is 3.

This clock is used to represent that "none selected" value.

> Thanks,
> Mark.
> 

Thank you.  I really appreciate the reviews Mark.

					-Alex
