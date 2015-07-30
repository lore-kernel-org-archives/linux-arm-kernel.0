From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 30 Jul 2015 16:37:30 +0200
Subject: [RFCv2 1/3] docs: dts: Added documentation for Xilinx Zynq Reset
 Controller bindings.
In-Reply-To: <20150729173802.GO2650@xsjsorenbubuntu>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
 <20150728025833.GQ2650@xsjsorenbubuntu>
 <CAAtXAHejK2vL2qSdhqrtHmkV_RBfkLzQNM8ZbDvREvienNqzXw@mail.gmail.com>
 <20150728225337.GF2650@xsjsorenbubuntu>
 <CAAtXAHd8kG_FtKTW-2T2KToXesWgsgxkZ3vpXZ_oRjGCSfpFgw@mail.gmail.com>
 <20150729173802.GO2650@xsjsorenbubuntu>
Message-ID: <55BA36AA.2030601@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2015 07:38 PM, S?ren Brinkmann wrote:
> On Tue, 2015-07-28 at 11:14PM -0700, Moritz Fischer wrote:
>> Hi S?ren,
>>
>> On Tue, Jul 28, 2015 at 3:53 PM, S?ren Brinkmann
>> <soren.brinkmann@xilinx.com> wrote:
>>> On Mon, 2015-07-27 at 09:52PM -0700, Moritz Fischer wrote:
>>>> Hi S?ren,
>>>>
>>>> thanks for your feedback.
>>>>
>>>> On Mon, Jul 27, 2015 at 7:58 PM, S?ren Brinkmann
>>>> <soren.brinkmann@xilinx.com> wrote:
>>>>> Hi Moritz,
>>>>>
>>>>> On Fri, 2015-07-24 at 05:21PM -0700, Moritz Fischer wrote:
>>>>>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/reset/zynq-reset-pl.txt | 13 +++++++++++++
>>>>>>  1 file changed, 13 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..ac4499e
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/reset/zynq-reset-pl.txt
>>>>>> @@ -0,0 +1,13 @@
>>>>>> +Xilinx Zynq PL Reset Manager
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible: "xlnx,zynq-reset-pl"
>>>>>> +- syscon <&slcr>;
>>>>>> +- #reset-cells: 1
>>>>>> +
>>>>>> +Example:
>>>>>> +     rstc: rstc at 240 {
>>>>>> +             #reset-cells = <1>;
>>>>>> +             compatible = "xlnx,zynq-reset-pl";
>>>>>> +             syscon = <&slcr>;
>>>>>> +     };
>>>>>
>>>>> I think you also have to add the outputs and make them part of the
>>>>> binding. Otherwise you'd have to read the implementation to find
>>>>> out what device should be hooked up to which output of the reset-controller.
>>>>
>>>> Is something like this what you had in mind? I had that prepared for
>>>> the next round of patches:
>>>>
>>>> Reset outputs:
>>>>  0  : soft reset
>>>>  32 : ddr reset
>>>>  64 : topsw reset
>>>>  96 : dmac reset
>>>>  128: usb0 reset
>>>>  129: usb1 reset
>>>>  160: gem0 reset
>>>>  161: gem1 reset
>>>>  164: gem0 rx reset
>>>>  165: gem1 rx reset
>>>>  166: gem0 ref reset
>>>>  167: gem1 ref reset
>>>>  192: sdio0 reset
>>>>  193: sdio1 reset
>>>>  196: sdio0 ref reset
>>>>  197: sdio1 ref reset
>>>>  224: spi0 reset
>>>>  225: spi1 reset
>>>>  226: spi0 ref reset
>>>>  227: spi1 ref reset
>>>>  256: can0 reset
>>>>  257: can1 reset
>>>>  258: can0 ref reset
>>>>  259: can1 ref reset
>>>>  288: i2c0 reset
>>>>  289: i2c1 reset
>>>>  320: uart0 reset
>>>>  321: uart1 reset
>>>>  322: uart0 ref reset
>>>>  323: uart1 ref reset
>>>>  352: gpio reset
>>>>  384: lqspi reset
>>>>  385: qspi ref reset
>>>>  416: smc reset
>>>>  417: smc ref reset
>>>>  448: ocm reset
>>>>  512: fpga0 out reset
>>>>  513: fpga1 out reset
>>>>  514: fpga2 out reset
>>>>  515: fpga3 out reset
>>>>  544: a9 reset 0
>>>>  545: a9 reset 1
>>>>  552: peri reset
>>>
>>> Basically, yes. I guess the gaps are due to directly mapping this number
>>> to bank and bit instead of doing some more complex mapping in between?
>>> I'm not sure whether I like this :) I guess if a number is off the
>>> driver would still toggle the addressed bit?
>>
>> My assumption was that people would use a #include
>> <dt-bindings/xlnx,zynq-reset.h> in their dts. Assuming I got the
>> numbers in there right this makes it hard to misuse by accident.
>> I'm not saying it's perfect ...
> 
> Michal always turned down the #include patches with the argument of
> re-using the dts files outside of the Linux sources where those includes
> etc may not be available in this form.

yes. All these includes end up in more work when you want to generate
them or move to any other project.
I don't think that make sense to caused another problem just because of
that. Simple add these values to reset binding doc and then you <&rstc
number> in nodes.
Because we agreed that it has to be done on driver basis this is just
copy that macros from one file to another.

Thanks,
Michal
