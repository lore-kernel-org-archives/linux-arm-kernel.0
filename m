From: Linux.HWI@garmin.com (J.D. Schroeder)
Date: Wed, 27 Apr 2016 09:20:13 -0500
Subject: [PATCH 3/3] ARM: DRA7x: dts: Update the OSC_32K_CLK frequency
In-Reply-To: <5720A73B.6050408@ti.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
 <1461693269-19436-4-git-send-email-Linux.HWI@garmin.com>
 <5720A73B.6050408@ti.com>
Message-ID: <5720CA9D.4010103@garmin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 06:49 AM, Tero Kristo wrote:
> On 26/04/16 20:54, J.D. Schroeder wrote:
>> From: "J.D. Schroeder" <jay.schroeder@garmin.com>
>>
>> This commit updates the OSC_32K_CLK (secure_32k_clk_src_ck) frequency
>> from the precise 32kHz frequency (i.e., 32.768 kHz) to the more
>> accurate frequency of ~34.6 kHz. Actual measured frequencies of the
>> clock vary from board to board anywhere from 34.4 kHz up to 34.8 kHz.
> 
> Uhm, if you have a board specific, accurate value for this clock, you should
> update it in the board file itself. This definition is going to be used across
> all the DRA7 / AM57xx boards, which can very likely have different crystal
> accuracies.
> 
> So, NAK.

The source of this clock is internal to the processor and not specific to how
the processor is configured or what clocks are coming in. The approximate
frequency of 34.4-34.8 kHz is generated internal to the processor through some
type of oscillator, not external. The problem is that the clock tree gives the
impression that this is a 32.768 kHz clock source, when in fact it is *not*
that. Both the name and the frequency are misleading. My change is an attempt
to clarify the actual behavior of the clock and keep someone else from using
the clock as a true 32.768 kHz clock when it is more than 5% off that
particular frequency. I would even consider changing the name of the clock as
that too is misleading, but opted not to since that would be more disruptive.

If you are seeing 32.768 kHz come out of this clock source then I must have an
issue with my silicon and we can discuss off line. However, if you configure
this as one of the clock out sources and see something in the range of ~34
kHz, I still think the change is a valid change as it clarifies the true
behavior of the hardware. Am I missing something?
