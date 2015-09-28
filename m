From: eric@anholt.net (Eric Anholt)
Date: Mon, 28 Sep 2015 14:19:43 -0700
Subject: [PATCH v2 3/4] clk: bcm2835: Add support for programming the
 audio domain clocks.
In-Reply-To: <5600B663.8000501@wwwdotorg.org>
References: <1441922305-2298-1-git-send-email-eric@anholt.net>
 <1441922305-2298-3-git-send-email-eric@anholt.net>
 <5600B663.8000501@wwwdotorg.org>
Message-ID: <87si5yutqo.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 09/10/2015 02:58 PM, Eric Anholt wrote:
>> This adds support for enabling, disabling, and setting the rate of the
>> audio domain clocks.  It will be necessary for setting the pixel clock
>> for HDMI in the VC4 driver and let us write a cpufreq driver.  It will
>> also improve compatibility with user changes to the firmware's
>> config.txt, since our previous fixed clocks are unaware of it.
>> 
>> The firmware also has support for configuring the clocks through the
>> mailbox channel, but the pixel clock setup by the firmware doesn't
>> work, and it's Raspberry Pi specific anyway.  The only conflicts we
>> should have with the firmware would be if we made firmware calls that
>> result in clock management (like opening firmware V3D or ISP access,
>> which we don't support in upstream), or on hardware over-thermal or
>> under-voltage (when the firmware would rewrite PLLB to take the ARM
>> out of overclock).  If that happens, our cached .recalc_rate() results
>> would be incorrect, but that's no worse than our current state where
>> we used fixed clocks.
>> 
>> The existing fixed clocks in the code are left in place to provide
>> backwards compatibility with old device tree files.
>
>> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c

>> +static const struct bcm2835_pll_ana_bits bcm2835_ana_default = {
>> +	0,
>> +	0,
>> +	~((7 << 19) | (15 << 15)),
>> +	(2 << 19) | (8 << 15),
>> +	~(7 << 7),
>> +	(6 << 1),
>> +
>> +	14
>
> Nit: Elide the blank line? In some other structs too.
>
> Are there #defines or names you can use for those initializers?

I've just used named initializers instad.  (These *are* the defines, so
another indirection wouldn't help anyone reading the driver).

>> +	clks[BCM2835_PLLA] = bcm2835_register_pll(cprman, &bcm2835_plla_data);
>> +	clks[BCM2835_PLLB] = bcm2835_register_pll(cprman, &bcm2835_pllb_data);
>
> These can fail; shouldn't there be error-checking? Or, does
> of_clk_add_provider() check for this?

When you get the clk from the of provider, the error gets passed
through, like it should.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150928/8775cabd/attachment.sig>
