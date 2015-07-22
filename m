From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jul 2015 20:05:24 +0100
Subject: [PATCH v5 1/6] drm: bridge/dw_hdmi: add audio support for more
 display resolutions
In-Reply-To: <1434730752-10829-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434730752-10829-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20150722190524.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 20, 2015 at 12:19:12AM +0800, Yakir Yang wrote:
> The exact relationship between the two clocks will be:
> 	128 * SampleRate = TmdsClock * N / CTS.
> So this patch would generate the correct N/CTS values, add audio support
> for the below  tmds clocks:
> 25.175MHz, 40MHz, 54MHz, 65MHz, 74.25MHz, 83.5MHz, 106.5MHz, 108Mhz

Having played around with the iMX6 devices, I can now say that the
statement in the iMX6 manuals is basically wrong.  There's two things
which leads me to that conclusion.

1. They list the standard values for CTS/N at standard TMDS frequencies
   as listed in the HDMI specification (with the /1.001 and *1.001 omitted.)
   In other words, there is nothing non-standard about these values.

2. The dw_hdmi driver as from Freescale as N values for all standard
   TMDS frequencies given in the HDMI specification, including the
   /1.001 and *1.001 frequencies.  However, the CTS calculation errors
   these out.  (Note that under DRM, these can never match, because DRM
   uses frequencies of kHz resolution, not 10kHz.)

3. They then say that when using deep colour modes, the CTS values have
   to be scaled with the TMDS clock.  So, from that we can ascertain that
   other CTS values which are not listed in the table are permissible.
   This statement implies that *1.25, *1.5, *2 factors on the listed
   TMDS clock and CTS value must also be supported.

4. Practical experimentation on iMX6 Solo and Quad hardware (which have
   two different revisions of the Designware IP) show that the use of any
   CTS/N values derived from the standard ones work.  By that, I mean
   using the "other" N value and calculating CTS for non-listed TMDS
   clocks does indeed work.  Relaxing the restriction in the driver (as
   below) and running through all modes which my TV supports results in
   audio playback working, from 1080p at 60 down to 640x480 at 59.94Hz.

So, I'm now of the opinion that the statement in iMX6 manuals concerning
restrictions on N/CTS values is incorrect, and no such restriction on
these exists.

In light of that, I now have code which removes this restriction from
dw_hdmi - we generate a standard-specified N value for standard clocks,
and then calculate the CTS value from that via:

        unsigned long ftdms = pixel_clk;
        u64 tmp;

        /*
         * Compute the CTS value from the N value.  Note that CTS and N
         * can be up to 20 bits in total, so we need 64-bit math.  Also
         * note that our TDMS clock is not fully accurate; it is accurate
         * to kHz.  This can introduce an unnecessary remainder in the
         * calculation below, so we don't try to warn about that.
         */
        tmp = (u64)ftdms * n;
        do_div(tmp, 128 * sample_rate);
        cts = tmp;

Note: I've removed all the deep colour and pixel repetition support here
because that's basically broken - the "ratio" was always 100.  If we need
pixel repetition (which is unsupported right now) it should be a matter of
scaling the ftmds appropriately which then scales the CTS value by the
same ratio.  "ftmds" above should be as close as possible to the _real_
TMDS clock rate, not the pixel clock.  In the case of deep colour, that
may influence the N value too (as 1.25x doesn't end up producing an
integer CTS value every time) so that would need to be re-addressed.

As for this specific patch, the part which remains relevant:

> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index dc0aed1..f717a2a 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -222,8 +222,24 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk,
>  	case 44100:
>  		if (pixel_clk == 25170000)
>  			n = 7007;
> +		else if (pixel_clk == 25175000)
> +			n = 28224;

That value is wrong.  HDMI requires:

	128 * fs / 1500Hz <= n <= 128 * fs / 300Hz

For 44.1kHz, that gives a range of 3763.2 to 18816.  Presumably this
restriction is to limit the range of the feedback path in the clock
regenerator in the sink so that designers have some parameters to work
with.  Going outside these limits is unwise, and while it may work with
some sinks, it's definitely outside of the HDMI spec.

> +		else if (pixel_clk == 40000000)
> +			n = 7056;
> +		else if (pixel_clk == 54000000)
> +			n = 6272;
> +		else if (pixel_clk == 65000000)
> +			n = 7056;

Rather than a big if () else if () else if (), can't we have:

		if (pixel_clk == 25175000)
			n = 7007;
		else if (pixel_clk == 40000000 || pixel_clk == 65000000 ||
			 pixel_clk == 83500000)
			n = 7056;
		else ...

etc?

I'm also thinking that these values are pretty standard, and they
should not be internal to anyone's driver - maybe they should live
in drivers/video/hdmi.c.

I'll be posting my patch set which lifts the restriction later this
evening.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
