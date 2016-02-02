From: qnguyen@apm.com (Quan Nguyen)
Date: Tue, 2 Feb 2016 08:46:25 +0700
Subject: [PATCH v5 2/3] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <20160201153502.GA19725@rob-hp-laptop>
References: <1454041735-8434-1-git-send-email-qnguyen@apm.com>
 <1454041735-8434-3-git-send-email-qnguyen@apm.com>
 <20160201153502.GA19725@rob-hp-laptop>
Message-ID: <CAFopSPQBjXQZwG-Phfc+xJ5Kn6dXPakT6Hg5qT-ByXG06p8wgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 10:35 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jan 29, 2016 at 11:28:54AM +0700, Quan Nguyen wrote:
>> Update description for X-Gene standby GPIO controller DTS binding to
>> support GPIO line configuration as input, output or external IRQ pin.
>>
>> Signed-off-by: Y Vo <yvo@apm.com>
>> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
>> ---
>>  .../devicetree/bindings/gpio/gpio-xgene-sb.txt     | 47 ++++++++++++++++++----
>>  1 file changed, 40 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
>> index dae1300..7b8b4cb 100644
>> --- a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
>> @@ -1,10 +1,20 @@
>>  APM X-Gene Standby GPIO controller bindings
>>
>> -This is a gpio controller in the standby domain.
>> -
>> -There are 20 GPIO pins from 0..21. There is no GPIO_DS14 or GPIO_DS15,
>> -only GPIO_DS8..GPIO_DS13 support interrupts. The IRQ mapping
>> -is currently 1-to-1 on interrupts 0x28 thru 0x2d.
>> +This is a gpio controller in the standby domain. It also supports interrupt in
>> +some particular pins which are sourced to its parent interrupt controller
>> +as diagram below:
>> +                           +-----------------+
>> +                           | X-Gene standby  |
>> +                           | GPIO controller +--------- GPIO_0
>> ++------------+             |                 | ...
>> +| Parent IRQ |             |                 +--------- GPIO_8/EXT_INT_0
>> +| controller |  EXT_INT_0  |                 | ...
>> +| (GICv2)    +-------------+                 +--------- GPIO_[N+8]/EXT_INT_N
>> +|            |  ...        |                 |
>> +|            |  EXT_INT_N  |                 +--------- GPIO_[N+9]
>> +|            +-------------+                 | ...
>> +|            |             |                 +--------- GPIO_MAX
>> ++------------+             +-----------------+
>>
>>  Required properties:
>>  - compatible: "apm,xgene-gpio-sb" for the X-Gene Standby GPIO controller
>> @@ -15,10 +25,18 @@ Required properties:
>>               0 = active high
>>               1 = active low
>>  - gpio-controller: Marks the device node as a GPIO controller.
>> -- interrupts: Shall contain exactly 6 interrupts.
>> +- interrupts: The EXT_INT_0 parent interrupt resource must be listed first.
>> +- interrupt-parent: Phandle of the parent interrupt controller.
>> +- interrupt-cells: Should be two.
>> +       - first cell is 0-N coresponding for EXT_INT_0 to EXT_INT_N.
>> +       - second cell is used to specify flags.
>> +- interrupt-controller: Marks the device node as an interrupt controller.
>> +- apm,nr-gpios: Optional, specify number of gpios pin.
>> +- apm,nr-irqs: Optional, specify number of interrupt pins.
>
> When is this not 6?
>
Hi Rob,  by default, this should be 6, but I think this property can
help in cases:
+ Used only 5(or less) first pin as interrupt.
+ For similar device which has different interrupt pins (8 for example).
My idea is to make it a bit more generic by using this optional property.

>> +- apm,irq-start: Optional, specify lowest gpio pin support interrupt.
>
> What determines this value? What value is assumed if not present?
>
This value will tell interrupt is support from which gpio pin, as in
this case interrupt support from pin 8 (ie: only pin 8, 9,10 ...
supports interrupt) as default.
If not specify the default (ie: 8) will be used.

Thanks,
-- Quan Nguyen
