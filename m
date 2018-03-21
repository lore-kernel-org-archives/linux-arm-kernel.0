From: collinsd@codeaurora.org (David Collins)
Date: Wed, 21 Mar 2018 16:54:01 -0700
Subject: [PATCH 2/2] dt-bindings: regulator: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=VQQG423wVFMymFyp1XdvVEiM40Qm1AL4e3524_8bWPcw@mail.gmail.com>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
 <CAD=FV=VQQG423wVFMymFyp1XdvVEiM40Qm1AL4e3524_8bWPcw@mail.gmail.com>
Message-ID: <418c551d-6036-8a5d-cf82-df72614c3f64@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 03/20/2018 07:16 PM, Doug Anderson wrote:
>> +Qualcomm Technologies, Inc. RPMh Regulators
>> +
>> +rpmh-regulator devices support PMIC regulator management via the VRM and XOB
>> +RPMh accelerators.  The APPS processor communicates with these hardware blocks
>> +via an RSC using command packets.  The VRM allows changing four parameters for a
>> +given regulator: enable state, output voltage, operating mode, and minimum
>> +headroom voltage.  The XOB allows changing only a single parameter for a given
>> +regulator: its enable state.
> 
> Somewhere in here can you give some context of what VRM and XOB stand
> for.  From the other patch desc it's "voltage regulator manager (VRM)
> and oscillator buffer (XOB)", but nice to sprinkle that around the
> first time it's used in documents.

Sure, I'll added a more detailed description in the binding file.

> ...and, ummmmm, what's an oscillator buffer?  Is this really a
> regulator?  It sounds a lot more like a clock enable knob.  Are you
> sure this shouldn't be exposed through the common clock framework?
> Many other PMICs expose oscillator clocks through CCF.  MAX77686 comes
> to mind.

The XOB hardware naming is unfortunate as it leads to confusion.  I kept
the name in DT bindings and the driver so that it matches hardware
documentation.  Functionally, the XOB block in RPMh provides an interface
to enable and disable *any* PMIC peripheral, not just oscillator clock
buffers.

When this hardware feature was initially designed, it's primary use case
was PMIC clock buffer control so it was designated "XOB".  However, other
use cases have come up since that point.  One use case that is explicitly
described in the qcom_rpmh-regulator driver is control of PM8998
low-voltage switches (LVS) 1 and 2.  These switches physically only
support enabling and disabling so it is better to control them via XOB and
VRM.

A second regulator XOB use case is management of regulators which could be
controlled via VRM (as they support voltage and mode configuration) but
which must be handled via XOB as all VRM indices in RPMh hardware are
already used by other regulators.  This case is board specific (as opposed
to PMIC specific) which is why there needs to be a way to specify that a
given regulator is XOB controlled from device tree.  This case comes up on
later targets which use multiple PMICs.  When it does, the set of LDO/SMPS
regulators to be controlled via XOB is carefully chosen at a system level
to be sure that a single voltage and mode is acceptable for each regulator.

As a side note, there are several PMIC clock buffers which are controlled
via XOB.  A separate RPMh clock driver will soon be submitted for these.
The MSM register space and hardware control logic for each XOB (or VRM)
resource is independent so there is no concern about having multiple
software entities using XOB to control different resources (regulators vs
clocks).


>> +- regulator-name
>> +       Usage:      optional
>> +       Value type: <string>
>> +       Definition: Specifies the name for this RPMh regulator.  If not
>> +                   specified, then the regulator's name is equal to its subnode
>> +                   name.
> 
> Probably don't need to include "regulator-name" since you say below
> "Other properties defined in regulator.txt may also be used" and this
> isn't anything special for your regulator.

Sure, I'll remove this.


>> +- regulator-min-microvolt
>> +       Usage:      required
>> +       Value type: <u32>
>> +       Definition: For VRM resources, this is the minimum supported voltage in
>> +                   microvolts.  For XOB resources, this is the fixed output
>> +                   voltage.
>> +
>> +- regulator-max-microvolt
>> +       Usage:      required
>> +       Value type: <u32>
>> +       Definition: For VRM resources, this is the maximum supported voltage in
>> +                   microvolts.  For XOB resources, this is the fixed output
>> +                   voltage.
> 
> regulator-min-microvolt / regulator-max-microvolt are really required?
>  What happens if you leave them off?  In general the regulator
> framework supports this concept--it just lets you enable/disable
> without changing voltage.

I'll test with these properties not specified.  Assuming that nothing bad
happens, I'll remove mention of them in this file.


>> +- qcom,regulator-initial-voltage
>> +       Usage:      optional; VRM regulators only
>> +       Value type: <u32>
>> +       Definition: Specifies the initial voltage in microvolts to request for a
>> +                   VRM regulator.  Supported values are 0 to 8191000.
> 
> The "supported values" here is a strange statement to make.  Not all
> regulators will support all those voltages, right?  Do you really need
> to list this here?

My intention was to list the set of values that the VRM voltage control
register will physically accept.  As you said, the meaningful/useful range
for a given PMIC regulator will be a small subset of this range.  I'll
remove the "supported values" sentence.


>> +- regulator-initial-mode
>> +       Usage:      optional; VRM regulators only
>> +       Value type: <u32>
>> +       Definition: Specifies the initial mode to request for a VRM regulator.
>> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
>> +                   in [1] (i.e. 0 to 4).
> 
> Explicitly state whether this is allowed even if
> "regulator-allow-set-load" is not set.

Will do.  It is allowed without regulator-allow-set-load.  This allows a
mode to be selected for a regulator even if there isn't a meaningful way
to configure the mode dynamically at runtime based on load current.


>> +- regulator-allow-set-load
>> +       Usage:      optional
>> +       Value type: <empty>
>> +       Definition: Boolean flag indicating that the the mode of this regulator
>> +                   may be configured at runtime based upon consumer load needs.
>> +
>> +- qcom,allowed-modes
> 
> It would be up to Mark Brown, but my guess is that he will say "please
> add this to the core".  The regulator core already has the concept of
> modes and you're already using the standard core concepts in most
> places.  Get rid of the special case code in your driver and add this
> to the core.

I'd prefer to keep this specific to RPMh regulators unless there is a
major objection.


>> +       Usage:      required if regulator-allow-set-load is specified;
>> +                   VRM regulators only
>> +       Value type: <prop-encoded-array>
>> +       Definition: A list of integers specifying the PMIC regulator modes which
>> +                   can be configured at runtime based upon consumer load needs.
>> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
>> +                   in [1] (i.e. 0 to 4).  Elements must be specified in order
>> +                   from lowest to highest value.
> 
> As far as I can tell this sorting constraint should be removed.
> Really the constraints should be:
> 
> * qcom,mode-threshold-currents should be sorted from lowest to highest
> * qcom,allowed-modes must match qcom,mode-threshold-currents
> 
> Sure, today it happens that the numbers are always lower for lower
> currents, but it doesn't seem like something you'd have to encode into
> the dt.

I'll update the description.


>> +- qcom,headroom-voltage
>> +       Usage:      optional; VRM regulators only
>> +       Value type: <u32>
>> +       Definition: Specifies the headroom voltage in microvolts to request for
>> +                   a VRM regulator.  RPMh hardware automatically ensures that
>> +                   the parent of this regulator outputs a voltage high enough
>> +                   to satisfy the requested headroom.  Supported values are
>> +                   0 to 511000.
> 
> Is this just "regulator-microvolt-offset", but supported in hardware?

No, it is equivalent to struct regulator_desc.min_dropout_uV, but handled
in hardware.


>> +- qcom,rpmh-resource-type
>> +       Usage:      optional
>> +       Value type: <string>
>> +       Definition: RPMh accelerator type for this regulator.  If not specified,
>> +                   then the default type associated with this regulator will be
>> +                   used.  Supported values: "vrm" or "xob".
> 
> I still don't have the big picture I guess, but it seems weird that
> you can override this.  You're saying that someone might stick an
> oscillator buffer the place of something that's normally a regulator?
> ...or a regulator in the place of something that's usually an
> oscillator buffer?  When would you use this?

Yes, there are specific board level use cases requiring the use of XOB
instead of VRM for regulators which could be managed via VRM.  I explained
this in more detail above.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
