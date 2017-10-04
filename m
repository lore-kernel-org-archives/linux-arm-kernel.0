From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 13:06:20 +0200
Subject: [PATCH v3 10/22] firmware: arm_scmi: probe and initialise all the
 supported protocols
In-Reply-To: <1506604306-20739-11-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-11-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a15DxNYzaYmAbxEqAm2FCJS9KQFk8vBDqmSn9QUiw64=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> +static const struct scmi_protocol_match scmi_protocols[] = {
> +       {
> +               .protocol_id = SCMI_PROTOCOL_PERF,
> +               .fn = scmi_perf_protocol_init,
> +               .name = "scmi-cpufreq",
> +       }, {
> +               .protocol_id = SCMI_PROTOCOL_CLOCK,
> +               .fn = scmi_clock_protocol_init,
> +               .name = "scmi-clocks",
> +       }, {
> +               .protocol_id = SCMI_PROTOCOL_POWER,
> +               .fn = scmi_power_protocol_init,
> +               .name = "scmi-power-domain",
> +       }, {
> +               .protocol_id = SCMI_PROTOCOL_SENSOR,
> +               .fn = scmi_sensors_protocol_init,
> +               .name = "scmi-hwmon",
> +       },
> +       {}
> +};

This looks backwards from what we do elsewhere in the kernel,
and could be considered a layering violation: it requires a generic
part of of the driver to know about all the more specific ones,
and it means that we have to modify the global table here each
time we add another protocol.

Can you rewrite this to allow dynamic registration of the protocols?

       Arnd
