From: eric@anholt.net (Eric Anholt)
Date: Thu, 10 Sep 2015 14:35:10 -0700
Subject: [PATCH 3/4] clk: bcm2835: Add support for programming the audio
 domain clocks.
In-Reply-To: <1441562263-19888-4-git-send-email-eric@anholt.net>
References: <1441562263-19888-1-git-send-email-eric@anholt.net>
 <1441562263-19888-4-git-send-email-eric@anholt.net>
Message-ID: <87vbbigdpt.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> This adds support for enabling, disabling, and setting the rate of the
> audio domain clocks.  It will be necessary for setting the pixel clock
> for HDMI in the VC4 driver and let us write a cpufreq driver.  It will
> also improve compatibility with user changes to the firmware's
> config.txt, since our previous fixed clocks are unaware of it.
>
> The firmware also has support for configuring the clocks through the
> mailbox channel, but the pixel clock setup by the firmware doesn't
> work, and it's Raspberry Pi specific anyway.  The only conflicts we
> should have with the firmware would be if we made firmware calls that
> result in clock management (like opening firmware V3D or ISP access,
> which we don't support in upstream), or on hardware over-thermal or
> under-voltage (when the firmware would rewrite PLLB to take the ARM
> out of overclock).  If that happens, our cached .recalc_rate() results
> would be incorrect, but that's no worse than our current state where
> we used fixed clocks.
>
> The existing fixed clocks in the code are left in place to provide
> backwards compatibility with old device tree files.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

> +	onecell->clk_num = BCM2835_CLOCK_COUNT;
> +	onecell->clks = kzalloc(sizeof(*onecell->clks), GFP_KERNEL);

Review of another clock driver I wrote pointed out that I missed the
multiply by BCM2835_CLOCK_COUNT here.  I'll send an updated version.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150910/904f40dd/attachment.sig>
