From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Dec 2013 14:27:19 +0100
Subject: [PATCH v4 2/4] Documentation: Add APM X-Gene SoC 15Gbps
 Multi-purpose PHY driver binding documentation
In-Reply-To: <1386833435-30498-3-git-send-email-lho@apm.com>
References: <1386833435-30498-1-git-send-email-lho@apm.com>
 <1386833435-30498-2-git-send-email-lho@apm.com>
 <1386833435-30498-3-git-send-email-lho@apm.com>
Message-ID: <201312121427.20040.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013, Loc Ho wrote:
> +- reg                  : First PHY memory resource is the SDS PHY access
> +                         resource.
> +                         Second PHY memory resoruce is the clock and reset
> +                         resources.
> +                         Third PHY memory resource is the SDS PHY access
> +                         resource outside of the IP if it is type
> +                         "apm,xgene-phy-ext".

Why do the "clock and reset" resources not use a clock driver and a reset
driver?

I would expect these to get replaced with

	clocks		: Reference to external clock input
	resets		: Reference to reset controller input

> +Optional properties:
> +- status		: Shall be "ok" if enabled or "disabled" if disabled.
> +			  Default is "ok".
> +- apm,tx-eye-tuning	: Manual control to fine tune the capture of the serial
> +			  bit lines from the automatic calibrated position.
> +			  Two set of 3-tuple setting for Gen1, Gen2, and Gen3.
> +			  Range from 0 to 0x7f in unit of one bit period.
> +			  Default is 0xa.

What does gen1, gen2 and gen3 refer to? Is this PCIe, SATA or serdes generations
or all of them?

Why are there two sets?

Will this have to change if you add PCIe support?

I would suggest using decimal notation here instead of hexadecimal since you
are dealing with numbers couting things. Same for the others.

> +- apm,tx-eye-direction	: Eye tuning manual control direction. 0 means sample
> +			  data earlier than the nominal sampling point. 1 means
> +			  sample data later than the nominal sampling point.
> +			  Two set of 3-tuple setting for Gen1, Gen2, and Gen3.
> +			  Default is 0x0.
> +
> +- apm,tx-boost-gain	: Frequency boost AC (LSB 3-bit) and DC (2-bit)
> +			  gain control. Two set of 3-tuple setting for Gen1,
> +			  Gen2, and Gen3. Range is between 0 to 0x1f in unit
> +			  of dB. Default is 0x3.
> +
> +- apm,tx-amplitude	: Amplitude control. Two set of 3-tuple setting for
> +			  Gen1, Gen2, and Gen3. Range is between 0 to 0xf in
> +			  unit of 13.3mV. Default is 0xf.

Units of 13.3mV don't seem to be useful as a generic measurement. I'd
recommend using milivolts or microvolts.

> +- apm,tx-pre-cursor1	: 1st pre-cursor emphasis taps control. Two set of
> +			  3-tuple setting for Gen1, Gen2, and Gen3. Range is
> +			  between 0 to 0xf in unit of 18.2mV. Default is 0x0.
> +- apm,tx-pre-cursor2	: 2st pre-cursor emphasis taps control. Two set of
> +			  3-tuple setting for Gen1, Gen2, and Gen3. Range is
> +			  between 0 to 0x7 in unit of 18.2mV. Default is 0x0.
> +- apm,tx-post-cursor	: Post-cursor emphasis taps control. Two set of
> +			  3-tuple setting for Gen1, Gen2, and Gen3. Range is
> +			  between 0 to 0x1f in unit of 18.2mV. Default is 0xf.

Same here.

> +- apm,tx-speed		: Tx operating speed. One set of 3-tuple for
> +			  Gen1 (0x1), Gen2 (0x3), and Gen3 (0x7). Default is
> +			  0x7.

I'm completely confused by this description. Can you rephrase this?
It sounds like the only possible values are <1 3 7> for this property.

	Arnd
