From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Sun, 16 Nov 2014 11:20:34 +0100
Subject: [PATCH v4 5/6] Documentation: dt-bindings: Add binding info for
 X-Gene QMTM UIO driver
In-Reply-To: <CAAhSdy2L5fPdk97wTVy++B4LcJP_s-r-BF18hg6J9Shfg_t1XQ@mail.gmail.com>
References: <1415864722-2800-1-git-send-email-ankit.jindal@linaro.org>
 <1415864722-2800-6-git-send-email-ankit.jindal@linaro.org>
 <CAAhSdy2L5fPdk97wTVy++B4LcJP_s-r-BF18hg6J9Shfg_t1XQ@mail.gmail.com>
Message-ID: <54687A72.6060208@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.11.2014 um 05:26 schrieb Anup Patel:
> On Thu, Nov 13, 2014 at 1:15 PM, Ankit Jindal <ankit.jindal@linaro.org> wrote:
>> This patch adds device tree binding documentation for
>> X-Gene QMTM UIO driver.
>>
>> Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
>> Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
>> ---
>>  .../devicetree/bindings/uio/uio_xgene_qmtm.txt     |   51 ++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
>>
>> diff --git a/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt b/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
>> new file mode 100644
>> index 0000000..ed85bc6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
>> @@ -0,0 +1,51 @@
>> +APM X-Gene QMTM nodes
>> +
>> +The Applied Micro X-Gene SOC has on-chip QMTM (Queue manager
>> +and Traffic manager). It is a device for managing hardware queues.
>> +It also implements QoS among hardware queues hence term "traffic"
>> +manager is present in its name.
>> +
>> +Required properties:
>> +- compatible: Should be "apm,xgene-qmtm"
>> +- reg: Address and length of the register set for the device. It contains the
>> +  information of registers in the same order as described by reg-names.
>> +- reg-names: Should contain the register set names
>> +  - "csr": QMTM control and status register address space.
>> +  - "fabric": QMTM memory mapped access to queue states.
>> +- qpool-memory: Points to the phandle of the node defining memory location for
>> +        creating QMTM queues. This must point to the reserved-memory node
>> +        (as-per reserved memory bindings). It is expected that size and
>> +        location of qpool memory will be configurable via bootloader.
>> +- clocks: Reference to the clock entry.
>> +- num-queues: Number of queues under this QMTM device.
>> +- devid: QMTM identification number for the system having multiple QMTM devices.
>> +        This is used to form a unique id (a tuple of queue number and
>> +        device id) for the queues belonging to this device.
>> +
>> +Example:
>> +       qmtm1_uio_qpool: qmtm1_uio_qpool {
>> +               reg = <0x0 0x0 0x0 0x0>

Trailing semicolon is missing.

>> +       };
>> +
>> +       qmtm1clk: qmtmclk at 1f20c000 {
>> +               compatible = "apm,xgene-device-clock";
>> +               clock-output-names = "qmtm1clk";
>> +               status = "ok"

"okay" and missing semicolon, but you could probably drop the status
property here.

>> +       };
>> +
>> +       qmtm1_uio: qmtm_uio at 1f200000 {
>> +               compatible = "apm,xgene-qmtm";
>> +               status = "disabled";
>> +               reg = <0x0 0x1f200000 0x0 0x10000>,
>> +                     <0x0 0x1b000000 0x0 0x400000>;
>> +               reg-names = "csr", "fabric";
>> +               qpool = <&qmtm1_uio_qpool>;
> 
> Small typo, this should be qpool-memory = <...>;
> 
>> +               clocks = <&qmtm1clk 0>;
>> +               num-queues = <0x400>;
>> +               devid = <1>;
>> +       };
>> +
>> +       /* Board-specific peripheral configurations */
>> +       &qmtm1_uio {
>> +               status = "ok";

"okay" as canonical spelling.

>> +       };

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
