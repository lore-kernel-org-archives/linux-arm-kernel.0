From: eric@anholt.net (Eric Anholt)
Date: Wed, 11 May 2016 18:45:48 -0700
Subject: [PATCH 3/3] clk: bcm2835: Skip PLLC clocks when deciding on a new
 clock parent
In-Reply-To: <20160511225854.GI3492@codeaurora.org>
References: <1462842090-2017-1-git-send-email-eric@anholt.net>
 <1462842090-2017-4-git-send-email-eric@anholt.net>
 <20160511225854.GI3492@codeaurora.org>
Message-ID: <87mvnw82wj.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 05/09, Eric Anholt wrote:
>> If the firmware had set up a clock to source from PLLC, go along with
>> it.  But if we're looking for a new parent, we don't want to switch it
>> to PLLC because the firmware will force PLLC (and thus the AXI bus
>> clock) to different frequencies during over-temp/under-voltage,
>> without notification to Linux.
>> 
>> On my system, this moves the Linux-enabled HDMI state machine and DSI1
>> escape clock over to plld_per from pllc_per.  EMMC still ends up on
>> pllc_per, because the firmware had set it up to use that.
>
> Is it ok for EMMC rate to change with over-temp/under-voltage?
> The description makes it sound like PLLC is for clks that want to
> run at some system bus rate and they don't care about exact
> frequencies.

I'm surprised it's OK for it to change, but the firmware is very
intentionally putting it on PLLC (there's this #define for where most
peripherals go, and EMMC doesn't use it and goes for PLLC instead).  If
we do decide we want to override the firmware, I suspect we'll use
assigned-clock-parents for that.

>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
>> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
>> index 1091012ecec6..1d8f29ea9f69 100644
>> --- a/drivers/clk/bcm/clk-bcm2835.c
>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>> @@ -1008,16 +1008,28 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
>>  	return 0;
>>  }
>>  
>> +static bool
>> +bcm2835_clk_is_pllc(struct clk_hw *hw)
>> +{
>> +	if (!hw)
>> +		return false;
>> +
>> +	return strncmp(clk_hw_get_name(hw), "pllc", 4) == 0;
>
> This strcmp is not great. Any chance we could look for the parent
> by reading the hardware and knowing what bit corresponds to pllc
> as a parent? That would be much nicer so that we don't rely on
> string comparisons for something the hardware can tell us.

We just have the parent index, but which indices are pllc dividers is
different between bcm2835_clock_per_parents and
bcm2835_clock_vpu_parents.  So, I guess it's possible, but seems more
error-prone than the strncmp.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160511/cd7e6df2/attachment-0001.sig>
