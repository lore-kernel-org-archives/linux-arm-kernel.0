From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 16 Apr 2018 16:06:16 -0700
Subject: [PATCH v3 01/10] Documentations: dt-bindings: Add documents of
 generic PECI bus, adapter and client drivers
In-Reply-To: <20180416175936.4vcse73mrnyk242m@rob-hp-laptop>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
 <20180416175936.4vcse73mrnyk242m@rob-hp-laptop>
Message-ID: <2ce14097-e003-d59a-a05c-1cee55cb0929@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for sharing your time. Please see my answers inline.

On 4/16/2018 10:59 AM, Rob Herring wrote:
> On Tue, Apr 10, 2018 at 11:32:03AM -0700, Jae Hyun Yoo wrote:
>> This commit adds documents of generic PECI bus, adapter and client drivers.
> 
> "dt-bindings: ..." for the subject prefix please.
>

Sure, I'll change the subject.

>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> Reviewed-by: James Feist <james.feist@linux.intel.com>
>> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
>> Cc: Alan Cox <alan@linux.intel.com>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>> Cc: Greg KH <gregkh@linuxfoundation.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Cc: Julia Cartwright <juliac@eso.teric.us>
>> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> Cc: Milton Miller II <miltonm@us.ibm.com>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Stef van Os <stef.van.os@prodrive-technologies.com>
>> Cc: Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>
>> ---
>>   .../devicetree/bindings/peci/peci-adapter.txt      | 23 ++++++++++++++++++++
>>   .../devicetree/bindings/peci/peci-bus.txt          | 15 +++++++++++++
>>   .../devicetree/bindings/peci/peci-client.txt       | 25 ++++++++++++++++++++++
> 
> This should be all one document.
> 

Okay. I'll combine them into one document.

>>   3 files changed, 63 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-adapter.txt
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-bus.txt
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-client.txt
>>
>> diff --git a/Documentation/devicetree/bindings/peci/peci-adapter.txt b/Documentation/devicetree/bindings/peci/peci-adapter.txt
>> new file mode 100644
>> index 000000000000..9221374f6b11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-adapter.txt
>> @@ -0,0 +1,23 @@
>> +Generic device tree configuration for PECI adapters.
>> +
>> +Required properties:
>> +- compatible     : Should contain hardware specific definition strings that can
>> +		   match an adapter driver implementation.
>> +- reg            : Should contain PECI controller registers location and length.
> 
> No need for these 2 here.
> 

Will drop these 2.

>> +- #address-cells : Should be <1>.
>> +- #size-cells    : Should be <0>.
> 
> Some details on the addressing for PECI would be good.
> 

It is for the PECI client address. Will add details.

>> +
>> +Example:
>> +	peci: peci at 10000000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x10000000 0x1000>;
>> +
> 
> This part of the example is not relevant. Just start with the adapter
> node.
> 

Will remove that part. Thanks!

>> +		peci0: peci-bus at 0 {
>> +			compatible = "soc,soc-peci";
>> +			reg = <0x0 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +	};
>> diff --git a/Documentation/devicetree/bindings/peci/peci-bus.txt b/Documentation/devicetree/bindings/peci/peci-bus.txt
>> new file mode 100644
>> index 000000000000..90bcc791ccb0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-bus.txt
>> @@ -0,0 +1,15 @@
>> +Generic device tree configuration for PECI buses.
>> +
>> +Required properties:
>> +- compatible     : Should be "simple-bus".
> 
> I don't understand what this has to do with PECI? "simple-bus" already
> has a defined meaning.
> 

Maybe I'm wrong but I intended to show this node is an umbrella node of 
a PECI bus subsystem. What should I use then?

>> +- #address-cells : Should be <1>.
>> +- #size-cells    : Should be <1>.
>> +- ranges         : Should contain PECI controller registers ranges.
>> +
>> +Example:
>> +	peci: peci at 10000000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x10000000 0x1000>;
>> +	};
>> diff --git a/Documentation/devicetree/bindings/peci/peci-client.txt b/Documentation/devicetree/bindings/peci/peci-client.txt
>> new file mode 100644
>> index 000000000000..8e2bfd8532f6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-client.txt
>> @@ -0,0 +1,25 @@
>> +Generic device tree configuration for PECI clients.
>> +
>> +Required properties:
>> +- compatible : Should contain target device specific definition strings that can
>> +	       match a client driver implementation.
> 
> Bindings are for h/w, not client drivers.
> 
> How are PECI devices defined?
> 

Got it. I'll correct the description. PECI client device is Intel CPU 
which is connected through a PECI bus.

>> +- reg        : Should contain address of a client CPU. Address range of CPU
>> +	       clients is starting from 0x30 based on PECI specification.
>> +	       <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
> 
> 8 devices should be enough for anyone...
> 
> Where is PECI_OFFSET_MAX defined?
> 

PECI_OFFSET_MAX is defined in include/linux/peci.h based on the maximum 
CPU numbers of the current IA generation. I'll remove the unnecessary 
details. A setting out of range would be handled accordingly in kernel.

>> +
>> +Example:
>> +	peci-bus at 0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		< more properties >
>> +
>> +		function at cpu0 {
> 
> Not a valid node name. "function at 30" is what it probably should be. For
> a new bus you can define unit-address format you like, but it must be
> based on the contents of reg. However, it doesn't look like you should
> create anything special here.
> 

Got it. I'll fix these node name like function at 30 and function at 31.

Thanks a lot for your comments!

-Jae

>> +			compatible = "device,function";
>> +			reg = <0x30>;
>> +		};
>> +
>> +		function at cpu1 {
>> +			compatible = "device,function";
>> +			reg = <0x31>;
>> +		};
>> +	};
>> -- 
>> 2.16.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
