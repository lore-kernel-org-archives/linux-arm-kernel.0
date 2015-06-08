From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 8 Jun 2015 15:35:13 +0100
Subject: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI
 support on Juno
In-Reply-To: <1433771479.2882.44.camel@linaro.org>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-7-git-send-email-sudeep.holla@arm.com>
 <1433771479.2882.44.camel@linaro.org>
Message-ID: <20150608143513.GI12807@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 02:51:19PM +0100, Jon Medhurst (Tixy) wrote:
> On Mon, 2015-06-08 at 11:40 +0100, Sudeep Holla wrote:
> [...]
> > +
> > +	scpi {
> > +		compatible = "arm,scpi";
> > +		mboxes = <&mailbox 1>;
> > +		shmem = <&cpu_scp_hpri>;
> > +
> > +		clocks {
> > +			compatible = "arm,scpi-clocks";
> > +
> > +			scpi_dvfs: scpi_clocks at 0 {
> > +				compatible = "arm,scpi-dvfs-clocks";
> > +				#clock-cells = <1>;
> > +				clock-indices = <0>, <1>, <2>;
> > +				clock-output-names = "vbig", "vlittle", "vgpu";
> 
> From where do the clock names derive? They look more like names for
> voltage domains rather than clocks. My (admittedly very old) Juno docs,
> have the clocks as ATLCLK, APLCLK and GPUCLK.
> 
> > +			};
> > +			scpi_clk: scpi_clocks at 3 {
> > +				compatible = "arm,scpi-variable-clocks";
> > +				#clock-cells = <1>;
> > +				clock-indices = <3>, <4>;
> > +				clock-output-names = "pxlclk0", "pxlclk1";
> 
> Can we also have clock index 5, name 'i2s_clk', for used by audio?
> (I don't know what other clocks the SCP currently supports, but audio is
> one being currently used by the out-of-tree code).
> 
> Also, I believe that both display outputs share the same clock, and so
> pxlclk0 and pxlclk1 can't be controlled independently. But I guess these
> device-tree entries are for the interface to the SCP firmware, not the
> hardware, and if that pretends the clocks are independent...

Actually, they can be independent, but the other source for clock generation
can only be used to drive a VGA resolution.

We were just debating with Sudeep on how to expose this: at the moment the SCP
is configured so that the request for a clock frequency always succeeds even
if the other user of the clock is active. That means that if you have 2 monitors
connected that have different resolutions or pixel clocks then one of the
monitor will get out of sync (unless it is a VGA monitor). On the other hand the
HDLCD driver (or more corectly the DRM KMS one) will default to 640x480 if no
monitor is connected to an HDMI output, meaning the clock could already be used
but by a driver that should really be inactive. It is very hard to detect in
which situation we are, so the usual fix is "plug the monitor into the other
HDMI output if you have problems with single monitors".

Best regards,
Liviu

> 
> -- 
> Tixy
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
