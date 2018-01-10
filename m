From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Jan 2018 13:20:15 +0100
Subject: [PATCH linux dev-4.10 4/6] Documentation: dt-bindings: Add a
 generic PECI hwmon
In-Reply-To: <20180109223126.13093-5-jae.hyun.yoo@linux.intel.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180109223126.13093-5-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAK8P3a1qiD1sWj0oQ=WbvpEDhtcYbzCxjg7t1iPs45WamfUVgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 9, 2018 at 11:31 PM, Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
> This commit add a dt-bindings document for a generic PECI hwmon
> driver.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  .../devicetree/bindings/hwmon/peci-hwmon.txt       | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
>
> diff --git a/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt b/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
> new file mode 100644
> index 0000000..20b86f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
> @@ -0,0 +1,33 @@
> +* Generic PECI (Platform Environment Control Interface) hwmon driver.
> +
> +Dependency:
> +- This driver uses a PECI misc driver as a controller interface so one of PECI
> +  misc drivers which provides compatible ioctls has to be enabled.

The binding should only explain how we describe the hardware in an
operating-system
independent way, but not talk about how an OS is supposed to implement those
drivers.

Having multiple drivers each provide an exported function is not possible
in Linux: it immediately breaks building an 'allyesconfig' kernel, and prevents
you from running the same kernel across multiple implementations, so that
has to be redesigned anyway.

> +Required properties:
> +- compatible: "peci-hwmon"
> +- cpu-id: Should contain CPU socket ID
> +       - 0 ~ 7
> +
> +Optional properties:
> +- show-core: If this protperty is defined, core tmeperature attrubites will be

s/protperty/property/
s/tmeperature/temperature/
s/attrubites/attributes/

> +            enumerated.
> +- dimm-nums: Should contain the number of DIMM slots that attached to each CPU
> +            which is indicated by cpu-id.
> +       0 ~ 16 (default: 16)
> +            In case of 0, DIMM temperature attrubites will not be enumerated.

Is this only an initial list that you expect to be extended in the
future, or is this
a complete list of sensors that can ever be connected to PECI?

Should this be PECI version specific?

      Arnd
