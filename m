From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 10 Nov 2014 19:38:14 +0200
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <5331397.OQCQmJO78C@wuerfel>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <1415631557-22897-2-git-send-email-grygorii.strashko@ti.com>
 <5331397.OQCQmJO78C@wuerfel>
Message-ID: <5460F806.3040305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 11/10/2014 05:06 PM, Arnd Bergmann wrote:
> On Monday 10 November 2014 16:59:16 Grygorii Strashko wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/ti,keystone-powerdomain.txt
>> @@ -0,0 +1,31 @@
>> +* TI Keystone 2 Generic PM Controller
>> +
>> +The TI Keystone 2 Generic PM Controller is responsible for Clock gating
>> +for each controlled IP module.
>> +
>> +Required properties:
>> +- compatible: Should be "ti,keystone-powerdomain"
>> +- #power-domain-cells: Should be 0, see below:
>> +
>> +The PM Controller node is a PM domain as documented in
>> +Documentation/devicetree/bindings/power/power_domain.txt.
>> +
>> +Example:
>> +
>> +       pm_controller: pm-controller {
>> +               compatible = "ti,keystone-powerdomain";
>> +               #power-domain-cells = <0>;
>> +       };
>> +
>> +       netcp: netcp at 2090000 {
>> +               reg = <0x2620110 0x8>;
>> +               reg-names = "efuse";
>> +               ...
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges;
>> +               power-domains = <&pm_controller>;
>> +
>> +               clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
>> +               dma-coherent;
>> +       }
> 
> I don't get it. What keystone specific about a "ti,keystone-powerdomain"
> device? It seems that the device has no registers whatsoever and the
> driver doesn't really do anything that relates to the platform.

That's true. but it was the only one acceptable way  to enable
Generic clock manipulation PM callbacks for the DT-boot case.
After several unsuccessful attempts the idea to use GPD
was introduced by Kevin there:
  https://lkml.org/lkml/2014/9/8/643

So, The Keystone 2 Generic PM Controller is just a proxy PM layer here between
device and Generic clock manipulation PM callbacks.
It fills per-device clock list when device is attached to GPD and
ensures that all clocks from that list enabled/disabled when device is
started/stopped.

Regards,
-grygorii
