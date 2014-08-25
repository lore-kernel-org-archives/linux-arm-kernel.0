From: lho@apm.com (Loc Ho)
Date: Mon, 25 Aug 2014 15:40:21 -0700
Subject: [PATCH v5 2/4] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAL_JsqKHV=yY9K3e4cQ4+vSvvVwM56hBuEc5OFXHqAmQZkp3Gw@mail.gmail.com>
References: <1408778588-3215-1-git-send-email-lho@apm.com>
 <1408778588-3215-2-git-send-email-lho@apm.com>
 <1408778588-3215-3-git-send-email-lho@apm.com>
 <CAL_JsqKHV=yY9K3e4cQ4+vSvvVwM56hBuEc5OFXHqAmQZkp3Gw@mail.gmail.com>
Message-ID: <CAPw-ZTn+uDZpw+bEy7EH7czu8ZMoCbzk=xn7ygHAe+iYbb5kzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

>> This patch adds documentation for the APM X-Gene SoC EDAC DTS binding.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> ---
>>  .../devicetree/bindings/edac/apm-xgene-edac.txt    |   83 ++++++++++++++++++++
>>  1 files changed, 83 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>>
>> diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>> new file mode 100644
>> index 0000000..ce8c30e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>> @@ -0,0 +1,83 @@
>> +* APM X-Gene SoC EDAC nodes
>> +
>> +EDAC nodes are defined to describe on-chip error detection and correction.
>> +There are four types of EDAC:
>
> EDAC is somewhat a Linux term which makes me suspicious. Is this
> really how the h/w is defined (i.e. I would find "EDAC" blocks in the
> h/w reference manual?)?

For memory controller and logically, there is such HW block in the
hardware. Physical, the designer just arrange them in sequential order
with other memory controller registers. For example, from offset 0x0
to 0xdc for controller registers and from 0xe0 to 0x118 for error
enable and status registers, and etc. From the memory controller
register used by error detection and correction, it is 0x110, 0x114,
0x314, 0x318, 0x31c, 0x320, and 0x324. All the 0x3xx repeated by an
stride for 8 ranks.

For the CPU L1/L2, it has an dedicate region for error configuration and status.

For the L3, it is similar to the memory controller. it is arranged in
sequential order.

For the SoC error, it has its own page (region).

>
>> +
>> +  memory controller    - Memory controller
>> +  PMD (L1/L2)          - Processor module unit (PMD) L1/L2 cache
>> +  L3                   - CPU L3 cache
>> +  SoC                  - SoC IP such as SATA, Ethernet, and etc
>> +
>> +The following section describes the memory controller DT node binding.
>> +
>> +Required properties:
>> +- compatible           : Shall be "apm,xgene-edac-mc".
>
> This is only EDAC registers or the entire memory controller?

I explained them above comment. It span two segments and interleave
with some controller registers.

> If they
> are truly separate and only for EDAC, then it is fine.

For CPU L1/L2, yes. For other, they are arranged sequentially span two segments.

> Otherwise, you
> should define the actual h/w block in DT and if a block needs to hook
> up to multiple drivers, then that is a Linux problem in which you
> should use drivers/mfd or drivers/soc.

At this point, there is no other driver that accesses them. Memory
controllers are only access by FW. L1/l2 controller has it own region.
L3 is only configured by FW. And SoC has its own page.

I hope this provide enough info for suggestion if this still need to be changed.

-Loc
