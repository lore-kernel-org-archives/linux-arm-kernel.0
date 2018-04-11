From: joel@jms.id.au (Joel Stanley)
Date: Wed, 11 Apr 2018 21:22:00 +0930
Subject: [PATCH v3 01/10] Documentations: dt-bindings: Add documents of
 generic PECI bus, adapter and client drivers
In-Reply-To: <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8XfwVTKfOQSteY8-Dy2=YiC6qjd1qZ2f8n1hTv8w06DWRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jae,

On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> This commit adds documents of generic PECI bus, adapter and client drivers.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Julia Cartwright <juliac@eso.teric.us>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Milton Miller II <miltonm@us.ibm.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stef van Os <stef.van.os@prodrive-technologies.com>
> Cc: Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>

That's a hefty cc list. I can't see Rob Herring though, and he's
usually the person who you need to convince to get your bindings
accepted.

I recommend using ./scripts/get_maintainers.pl to build your CC list,
and then add others you think are relevant.

I'm not sure what the guidelines are for generic bindings, so I'll
defer to Rob for this patch.

Cheers,

Joel

> ---
>  .../devicetree/bindings/peci/peci-adapter.txt      | 23 ++++++++++++++++++++
>  .../devicetree/bindings/peci/peci-bus.txt          | 15 +++++++++++++
>  .../devicetree/bindings/peci/peci-client.txt       | 25 ++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-adapter.txt
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-bus.txt
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-client.txt
>
> diff --git a/Documentation/devicetree/bindings/peci/peci-adapter.txt b/Documentation/devicetree/bindings/peci/peci-adapter.txt
> new file mode 100644
> index 000000000000..9221374f6b11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-adapter.txt
> @@ -0,0 +1,23 @@
> +Generic device tree configuration for PECI adapters.
> +
> +Required properties:
> +- compatible     : Should contain hardware specific definition strings that can
> +                  match an adapter driver implementation.
> +- reg            : Should contain PECI controller registers location and length.
> +- #address-cells : Should be <1>.
> +- #size-cells    : Should be <0>.
> +
> +Example:
> +       peci: peci at 10000000 {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0x0 0x10000000 0x1000>;
> +
> +               peci0: peci-bus at 0 {
> +                       compatible = "soc,soc-peci";
> +                       reg = <0x0 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +       };
> diff --git a/Documentation/devicetree/bindings/peci/peci-bus.txt b/Documentation/devicetree/bindings/peci/peci-bus.txt
> new file mode 100644
> index 000000000000..90bcc791ccb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-bus.txt
> @@ -0,0 +1,15 @@
> +Generic device tree configuration for PECI buses.
> +
> +Required properties:
> +- compatible     : Should be "simple-bus".
> +- #address-cells : Should be <1>.
> +- #size-cells    : Should be <1>.
> +- ranges         : Should contain PECI controller registers ranges.
> +
> +Example:
> +       peci: peci at 10000000 {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0x0 0x10000000 0x1000>;
> +       };
> diff --git a/Documentation/devicetree/bindings/peci/peci-client.txt b/Documentation/devicetree/bindings/peci/peci-client.txt
> new file mode 100644
> index 000000000000..8e2bfd8532f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-client.txt
> @@ -0,0 +1,25 @@
> +Generic device tree configuration for PECI clients.
> +
> +Required properties:
> +- compatible : Should contain target device specific definition strings that can
> +              match a client driver implementation.
> +- reg        : Should contain address of a client CPU. Address range of CPU
> +              clients is starting from 0x30 based on PECI specification.
> +              <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
> +
> +Example:
> +       peci-bus at 0 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               < more properties >
> +
> +               function at cpu0 {
> +                       compatible = "device,function";
> +                       reg = <0x30>;
> +               };
> +
> +               function at cpu1 {
> +                       compatible = "device,function";
> +                       reg = <0x31>;
> +               };
> +       };
> --
> 2.16.2
>
