From: collinsd@codeaurora.org (David Collins)
Date: Tue, 10 Jul 2018 10:45:57 -0700
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
In-Reply-To: <20180629235417.GY129942@google.com>
References: <20180628210915.160893-1-mka@chromium.org>
 <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com>
 <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
 <20180629235417.GY129942@google.com>
Message-ID: <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Matthias,

On 06/29/2018 04:54 PM, Matthias Kaehlcke wrote:
> On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
...
>> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
>> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
>> off peripherals within the PMIC that are expected to draw significant
>> current.  The set of peripherals included varies between PMICs.  This
>> partial shutdown will occur simultaneously with the triggering of an
>> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
>> driver that an over-temperature threshold has been crossed.
>>
>> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
>> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
>> interrupt in this case because all power is cut.
> 
> This information is very useful, thanks David!
> 
> The (partial) hardware shutdown seems like a good measure of last
> resort, however I suppose we prefer Linux to initiate a shutdown
> before losing part of the peripherals (drivers might not be happy
> about this and probably not revover even when the temperature goes
> down again) or reach a full PMIC shutdown.
> 
> Please let me know if there are reasons to prefer to go the hardware
> limits, it's also an option for device makers to overwrite these
> settings if they want different behavior.

Disabling stage 3 automatic full PMIC shutdown at 145 C is definitely a
bad idea.  This exists as a last resort in order to save the hardware and
ensure end user safety in case of excessive temperature even if software
is locked up.

Disabling stage 2 automatic partial PMIC shutdown at 125 C is not
recommended as the PMIC is already outside of reasonable operating
conditions and needs to take corrective action quickly.  However, doing so
may be acceptable if software is taking action to shut down the system
immediately upon receiving the stage 2 over-temperature interrupt.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
