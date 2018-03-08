From: eric@anholt.net (Eric Anholt)
Date: Thu, 08 Mar 2018 12:15:45 -0800
Subject: [PATCH v2 3/6] dt-bindings: soc: Add a binding for the Broadcom
 VCHIQ services.
In-Reply-To: <CAL_Jsq+1-9-RGfzPimYwCokEZx1vef_PX5rkp-c8s6fUchg=ag@mail.gmail.com>
References: <20180307185716.17449-1-eric@anholt.net>
 <20180307185716.17449-3-eric@anholt.net>
 <CAL_Jsq+1-9-RGfzPimYwCokEZx1vef_PX5rkp-c8s6fUchg=ag@mail.gmail.com>
Message-ID: <87lgf2fhn2.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh+dt@kernel.org> writes:

> On Wed, Mar 7, 2018 at 12:57 PM, Eric Anholt <eric@anholt.net> wrote:
>> The VCHIQ communication channel can be provided by BCM283x and Capri
>> SoCs, to communicate with the VPU-side OS services.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
>> v2: dropped firmware property, added cache-line-size.
>>
>>  .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>> new file mode 100644
>> index 000000000000..cdef4abc5e47
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>> @@ -0,0 +1,28 @@
>> +Broadcom VCHIQ firmware services
>> +
>> +Required properties:
>> +
>> +- compatible:  Should be "brcm,bcm2835-vchiq"
>> +- reg:         Physical base address and length of the doorbell register pair
>> +- interrupts:  The interrupt number
>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>> +
>> +Optional properties:
>> +
>> +- cache-line-size:
>> +               Size of L2 cache lines.  The VPU firmware detects
>> +                 this property and overrides it with the actual L2
>> +                 cache line size it's using when loading the
>> +                 device-tree.  Determines the required alignment of
>> +                 offsets/sizes of VCHIQ pagelists.  If missing, the
>> +                 firmware assumes an older kernel using 32-byte
>> +                 alignment.
>
> How is this a VCHIQ property? This is a standard property for cache
> nodes, but this is not a cache node.

Because the existing firmware code is choosing a value based on the
property's presence in this node.  This is the DT ABI for the firmware
that's been shipping for a long time (at least since the 4.9 era).

> Is it really a problem to just use a fixed maximum alignment? That
> seems to be good enough for all the rest of the kernel.

If we can't have this DT property, then it looks like we need the
upstream kernel to just use 32, since that's what the firmware will
assume in its absence.  Maybe the firmware maintainers can give us a new
arg to the mailbox call for setup where we could pass in the value to
use (or flag for them to pass their preferred value back to us) so we
can avoid DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/cd299c33/attachment.sig>
