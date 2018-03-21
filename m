From: dianders@chromium.org (Doug Anderson)
Date: Tue, 20 Mar 2018 19:16:12 -0700
Subject: [PATCH 2/2] dt-bindings: regulator: add QCOM RPMh regulator
 bindings
In-Reply-To: <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
Message-ID: <CAD=FV=VQQG423wVFMymFyp1XdvVEiM40Qm1AL4e3524_8bWPcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, Mar 16, 2018 at 6:09 PM, David Collins <collinsd@codeaurora.org> wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 246 +++++++++++++++++++++
>  1 file changed, 246 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
>
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
> new file mode 100644
> index 0000000..2d86306
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
> @@ -0,0 +1,246 @@
> +Qualcomm Technologies, Inc. RPMh Regulators
> +
> +rpmh-regulator devices support PMIC regulator management via the VRM and XOB
> +RPMh accelerators.  The APPS processor communicates with these hardware blocks
> +via an RSC using command packets.  The VRM allows changing four parameters for a
> +given regulator: enable state, output voltage, operating mode, and minimum
> +headroom voltage.  The XOB allows changing only a single parameter for a given
> +regulator: its enable state.

Somewhere in here can you give some context of what VRM and XOB stand
for.  From the other patch desc it's "voltage regulator manager (VRM)
and oscillator buffer (XOB)", but nice to sprinkle that around the
first time it's used in documents.

...and, ummmmm, what's an oscillator buffer?  Is this really a
regulator?  It sounds a lot more like a clock enable knob.  Are you
sure this shouldn't be exposed through the common clock framework?
Many other PMICs expose oscillator clocks through CCF.  MAX77686 comes
to mind.


> +- regulator-name
> +       Usage:      optional
> +       Value type: <string>
> +       Definition: Specifies the name for this RPMh regulator.  If not
> +                   specified, then the regulator's name is equal to its subnode
> +                   name.

Probably don't need to include "regulator-name" since you say below
"Other properties defined in regulator.txt may also be used" and this
isn't anything special for your regulator.


> +- regulator-min-microvolt
> +       Usage:      required
> +       Value type: <u32>
> +       Definition: For VRM resources, this is the minimum supported voltage in
> +                   microvolts.  For XOB resources, this is the fixed output
> +                   voltage.
> +
> +- regulator-max-microvolt
> +       Usage:      required
> +       Value type: <u32>
> +       Definition: For VRM resources, this is the maximum supported voltage in
> +                   microvolts.  For XOB resources, this is the fixed output
> +                   voltage.

regulator-min-microvolt / regulator-max-microvolt are really required?
 What happens if you leave them off?  In general the regulator
framework supports this concept--it just lets you enable/disable
without changing voltage.


> +- qcom,regulator-initial-voltage
> +       Usage:      optional; VRM regulators only
> +       Value type: <u32>
> +       Definition: Specifies the initial voltage in microvolts to request for a
> +                   VRM regulator.  Supported values are 0 to 8191000.

The "supported values" here is a strange statement to make.  Not all
regulators will support all those voltages, right?  Do you really need
to list this here?


> +- regulator-initial-mode
> +       Usage:      optional; VRM regulators only
> +       Value type: <u32>
> +       Definition: Specifies the initial mode to request for a VRM regulator.
> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
> +                   in [1] (i.e. 0 to 4).

Explicitly state whether this is allowed even if
"regulator-allow-set-load" is not set.


> +- regulator-allow-set-load
> +       Usage:      optional
> +       Value type: <empty>
> +       Definition: Boolean flag indicating that the the mode of this regulator
> +                   may be configured at runtime based upon consumer load needs.
> +
> +- qcom,allowed-modes

It would be up to Mark Brown, but my guess is that he will say "please
add this to the core".  The regulator core already has the concept of
modes and you're already using the standard core concepts in most
places.  Get rid of the special case code in your driver and add this
to the core.


> +       Usage:      required if regulator-allow-set-load is specified;
> +                   VRM regulators only
> +       Value type: <prop-encoded-array>
> +       Definition: A list of integers specifying the PMIC regulator modes which
> +                   can be configured at runtime based upon consumer load needs.
> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
> +                   in [1] (i.e. 0 to 4).  Elements must be specified in order
> +                   from lowest to highest value.

As far as I can tell this sorting constraint should be removed.
Really the constraints should be:

* qcom,mode-threshold-currents should be sorted from lowest to highest
* qcom,allowed-modes must match qcom,mode-threshold-currents

Sure, today it happens that the numbers are always lower for lower
currents, but it doesn't seem like something you'd have to encode into
the dt.


> +- qcom,headroom-voltage
> +       Usage:      optional; VRM regulators only
> +       Value type: <u32>
> +       Definition: Specifies the headroom voltage in microvolts to request for
> +                   a VRM regulator.  RPMh hardware automatically ensures that
> +                   the parent of this regulator outputs a voltage high enough
> +                   to satisfy the requested headroom.  Supported values are
> +                   0 to 511000.

Is this just "regulator-microvolt-offset", but supported in hardware?


> +- qcom,rpmh-resource-type
> +       Usage:      optional
> +       Value type: <string>
> +       Definition: RPMh accelerator type for this regulator.  If not specified,
> +                   then the default type associated with this regulator will be
> +                   used.  Supported values: "vrm" or "xob".

I still don't have the big picture I guess, but it seems weird that
you can override this.  You're saying that someone might stick an
oscillator buffer the place of something that's normally a regulator?
...or a regulator in the place of something that's usually an
oscillator buffer?  When would you use this?


-Doug
