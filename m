From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 7 Jul 2015 10:20:51 +0530
Subject: [PATCHv6 1/2] dts: Adding docs for Xilinx LogiCORE IP mailbox
 driver.
In-Reply-To: <20150706172727.GH6550@xsjsorenbubuntu>
References: <1436202963-16922-1-git-send-email-moritz.fischer@ettus.com>
 <1436202963-16922-2-git-send-email-moritz.fischer@ettus.com>
 <20150706172727.GH6550@xsjsorenbubuntu>
Message-ID: <CABb+yY0L1yFEhwHfRR553hFrK4v6=8p3q8w9ugwTdfrAre6OOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 6, 2015 at 10:57 PM, S?ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Mon, 2015-07-06 at 10:16AM -0700, Moritz Fischer wrote:
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>  .../devicetree/bindings/mailbox/xilinx-mailbox.txt | 44 ++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
>> new file mode 100644
>> index 0000000..97b81f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
>> @@ -0,0 +1,44 @@
>> +Xilinx Mailbox Driver
>> +=====================
>> +
>> +Required properties:
>> +- compatible       : "xlnx,mailbox-2.1".
>> +- reg              :  physical base address of the mailbox and length of
>> +                      memory mapped region.
>> +- #mbox-cells      :  common mailbox binding property to identify the number
>> +                      of cells required for the mailbox specifier, should be 0
>> +- clocks           :  phandle to clock provider
>> +- clock-names      :  must be 'mbox'
>> +
>> +Optional properties:
>> +- interrupt-parent : interrupt source phandle
>> +- interrupts       : interrupt number, The interrupt specifier format
>> +                     depends on the interrupt controller parent.
>> +
>> +Example:
>> +     mbox: mailbox at 40400000 {
>> +             compatible = "xlnx,mailbox-2.1";
>> +             reg = <0x40400000 0x100>;
>> +             interrupt-parent = <&intc>;
>> +             interrupts = <5>;
>> +             #mbox-cells = <0>;
>> +             clocks = <&clkc 15>;
>> +             clock-names = "mbox";
>> +     };
>> +
>> +Mailbox client
>> +===============
>> +"mboxes" and the optional "mbox-names" (please see
>> +Documentation/devicetree/bindings/mailbox/mailbox.txt for details). Each value
>> +of the mboxes property should contain a phandle to the mailbox controller
>> +device node and second argument is the channel index. It must be 0 (hardware
>> +support only one channel). The equivalent "mbox-names" property value can be
>> +used to give a name to the communication channel to be used by the client user.
>> +
>> +Example:
>> +     mclient0: mclient0 at 400 {
>> +             compatible = "client-1.0";
>> +             reg = <0x400 0x10>;
>> +             mbox-names = "mbox";
>> +             mboxes = <&mbox 0>;
>
> Sorry, to bring this up again, but I'm confused regarding the #mbox-cells
> thing. Above it says #mbox-cells is 0. In that case, shouldn't the
> 'mboxes' property not only be '<&mbox>'?
>
Yeah, this is inconsistent. Either provide your own of_xlate() for
#cells=0  or have #cells=1 to use stock of_xlate() and specify <&mbox
0> for the channel.
