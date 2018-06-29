From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri, 29 Jun 2018 16:54:17 -0700
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
In-Reply-To: <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
References: <20180628210915.160893-1-mka@chromium.org>
 <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com>
 <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
Message-ID: <20180629235417.GY129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
> Hello Matthias,
> 
> On 06/29/2018 11:51 AM, Matthias Kaehlcke wrote:
> > On Thu, Jun 28, 2018 at 03:58:41PM -0700, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> >>> Add pm8998 thermal zone based on the examples in the spmi-temp-alarm
> >>> bindings.
> >>>
> >>> Note: devices with the pm8998 need to have a 'thermal-zones' node (which
> >>> may be empty) with a label 'thermal_zones'.
> >>>
> >>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++++++++++++++++++++++++++++
> >>>  1 file changed, 28 insertions(+)
> >>
> >> Do you know if this patch actually does anything since you didn't
> >> define a cooling-maps?  Hopefully at least the critical shuts things
> >> down?
> > 
> > I need to do some additional testing, currently waiting to get the
> > heat gun back ...
> > 
> > I would expect the critical trip point to shut the system down, though
> > I'm not sure whether the HW temperature watchdog wouldn't cut power
> > before that. The documentation I have access to contains some register
> > descriptions, but isn't very verbose about the overall behavior and
> > from the driver code that's also not really clear to me. The driver
> > "disables software override of stage 2 and 3 shutdowns" which make me
> > guess that a hardware shutdown kicks in at stage 2 (135?C ?). This
> > would be roughly in line with a system reset I observed in an earlier
> > test at a temperature > 125?C. If that's correct the trip points need
> > to be revisited.
> > 
> > Maybe David Collins who recently extended the driver to add support
> > for GEN2 PMIC peripherals can provide more details.
> 
> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> off peripherals within the PMIC that are expected to draw significant
> current.  The set of peripherals included varies between PMICs.  This
> partial shutdown will occur simultaneously with the triggering of an
> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> driver that an over-temperature threshold has been crossed.
> 
> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
> interrupt in this case because all power is cut.

This information is very useful, thanks David!

The (partial) hardware shutdown seems like a good measure of last
resort, however I suppose we prefer Linux to initiate a shutdown
before losing part of the peripherals (drivers might not be happy
about this and probably not revover even when the temperature goes
down again) or reach a full PMIC shutdown.

Please let me know if there are reasons to prefer to go the hardware
limits, it's also an option for device makers to overwrite these
settings if they want different behavior.

> If you are not specifying an ADC channel for the qcom-spmi-temp-alarm
> device (which would allow for polling of the real-time PMIC die
> temperature), then notifications about stage 0 -> 1 and 1 -> 0 transitions
> (105 C) are the only time that software could take meaningful corrective
> action to avoid a PMIC automatic partial or full shutdown.

Thanks, I already experimented a a bit with this. For the record, the
driver is https://patchwork.kernel.org/patch/10494771/ (this version
is broken though).

Cheers

Matthias
