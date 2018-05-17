From: dianders@chromium.org (Doug Anderson)
Date: Thu, 17 May 2018 14:23:15 -0700
Subject: [PATCH v3 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <3a4195365ab0d252fdf064d2300f45b9b777991c.1526088081.git.collinsd@codeaurora.org>
References: <cover.1526088081.git.collinsd@codeaurora.org>
 <3a4195365ab0d252fdf064d2300f45b9b777991c.1526088081.git.collinsd@codeaurora.org>
Message-ID: <CAD=FV=UiZEFTAtO9C0UbRO=ow5=dv6zNG-XMqhHm1Fmp2GwVcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 11, 2018 at 7:28 PM, David Collins <collinsd@codeaurora.org> wrote:
> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg,
> +                               struct device *dev, struct device_node *node)
> +{
> +       const char *prop;
> +       int i, len, ret, mode;
> +       u32 *buf;
> +
> +       /* qcom,allowed-drms-modes is optional */
> +       prop = "qcom,allowed-drms-modes";

As per comments in bindings patch: this is a duplicate of your new
attribute you added to the regulator core.  Makes no sense to have a
private attribute too with the same value.


> +       prop = "qcom,drms-mode-max-microamps";

As per comments in the bindings patch, I think we should move
"qcom,drms-mode-max-microamps" to the regulator core.


> +               prop = "qcom,regulator-initial-microvolt";

As per comments in bindings patch: seems like we should get rid of
"qcom,regulator-initial-microvolt" or move to the core.


> +                       /*
> +                        * Default the voltage selector to an error value in the
> +                        * case that qcom,regulator-initial-microvolt is not
> +                        * specified in device tree since the true voltage is
> +                        * not known.  Note that this value causes
> +                        * devm_regulator_register() to fail in the case that
> +                        * regulator-min-microvolt and regulator-max-microvolt
> +                        * are specified in device tree due to
> +                        * machine_constraints_voltage() bailing when the
> +                        * get_voltage_sel() callback returns this error value.
> +                        */
> +                       vreg->voltage_selector = -EINVAL;

As per comments in other threads, adjust this comment and use
-ENOTRECOVERABLE now.


NOTE: I think this driver is looking really good now.  Hopefully the
above things should be quick to spin (even getting "max-microamps" in
the core should be quick I think)  and we can get something landed!
:)

-Doug
