From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 20 Mar 2014 00:16:14 +0100
Subject: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
In-Reply-To: <7e54f23f-1e11-4e17-ad29-13b497d7055a@TX2EHSMHS041.ehs.local>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
 <7e54f23f-1e11-4e17-ad29-13b497d7055a@TX2EHSMHS041.ehs.local>
Message-ID: <532A253E.2000106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

On 20.03.2014 00:13, S?ren Brinkmann wrote:
> On Mon, 2014-03-03 at 05:02PM +0100, Tomasz Figa wrote:
>> This patch introduces generic code to perform power domain look-up using
>> device tree and automatically bind devices to their power domains.
>> Generic device tree binding is introduced to specify power domains of
>> devices in their device tree nodes.
>>
>> Backwards compatibility with legacy Samsung-specific power domain
>> bindings is provided, but for now the new code is not compiled when
>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
>> will change as soon as Exynos power domain code gets converted to use
>> the generic framework in further patch.
>>
>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>> ---
>>   .../devicetree/bindings/power/power_domain.txt     |  51 ++++
>>   drivers/base/power/domain.c                        | 298 +++++++++++++++++++++
>>   include/linux/pm_domain.h                          |  46 ++++
>>   kernel/power/Kconfig                               |   4 +
>>   4 files changed, 399 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/power_domain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>> new file mode 100644
>> index 0000000..93be5d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -0,0 +1,51 @@
>> +* Generic power domains
>> +
>> +System on chip designs are often divided into multiple power domains that
>> +can be used for power gating of selected IP blocks for power saving by
>> +reduced leakage current.
>> +
>> +This device tree binding can be used to bind power domain consumer devices
>> +with their power domains provided by power domain providers. A power domain
>> +provider can be represented by any node in the device tree and can provide
>> +one or more power domains. A consumer node can refer to the provider by
>> +a phandle and a set of phandle arguments (so called power domain specifier)
>> +of length specified by #power-domain-cells property in the power domain
>> +provider node.
>> +
>> +==Power domain providers==
>> +
>> +Required properties:
>> + - #power-domain-cells : Number of cells in a power domain specifier;
>> +   Typically 0 for nodes representing a single power domain and 1 for nodes
>> +   providing multiple power domains (e.g. power controllers), but can be
>> +   any value as specified by device tree binding documentation of particular
>> +   provider.
>> +
>> +Example:
>> +
>> +	power: power-controller at 12340000 {
>> +		compatible = "foo,power-controller";
>> +		reg = <0x12340000 0x1000>;
>> +		#power-domain-cells = <1>;
>> +	};
>> +
>> +The node above defines a power controller that is a power domain provider
>> +and expects one cell as its phandle argument.
>> +
>> +==Power domain consumers==
>> +
>> +Required properties:
>> + - power-domain : A phandle and power domain specifier as defined by bindings
>> +                  of power controller specified by phandle.
>> +
>> +Example:
>> +
>> +	leaky-device at 12350000 {
>> +		compatible = "foo,i-leak-current";
>> +		reg = <0x12350000 0x1000>;
>> +		power-domain = <&power 0>;
>> +	};
>> +
>> +The node above defines a typical power domain consumer device, which is located
>> +inside power domain with index 0 of power controller represented by node with
>> +label "power".
>
> Does this allow nesting of power domains? E.g. you have a PD which is
> represented by some programmable power supply, and within this domain
> smaller islands/domains that can be gated independently.

These are client-side bindings only, i.e. power domain providers and 
consumers. Registering power domains and relations between them are up 
to platform-specific code, e.g. power controller driver.

Best regards,
Tomasz
