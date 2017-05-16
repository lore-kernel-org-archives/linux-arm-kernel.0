From: eric@anholt.net (Eric Anholt)
Date: Tue, 16 May 2017 15:19:51 -0700
Subject: [PATCH V2] ARM: dts: bcm283x: Reserve first page for firmware
In-Reply-To: <e2718c25-fdf1-ead1-cbfa-d23bf729a079@gmail.com>
References: <b6aef857-1454-7931-2c60-6d7b55b7a0a8@raspberrypi.org>
 <e2718c25-fdf1-ead1-cbfa-d23bf729a079@gmail.com>
Message-ID: <87pof8bg1k.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 05/09/2017 02:04 AM, Phil Elwell wrote:
>> The Raspberry Pi startup stub files for multi-core BCM27XX processors
>> make the secondary CPUs spin until the corresponding mailbox is
>> written. These stubs are loaded at physical address 0x00000xxx (as seen
>> by the ARMs), but this page will be reused by the kernel unless it is
>> explicitly reserved, causing the waiting cores to execute random code.
>> 
>> Use the /memreserve/ Device Tree directive to mark the first page as
>> off-limits to the kernel.
>
> This reserves a 4KB page here, is this good enough, or should we just go
> directly to the maximum page granule size possible on an ARM64/Linux
> system to be on the safe side?
>
>> 
>> See: https://github.com/raspberrypi/linux/issues/1989
>> 
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> ---
>> 
>> Changes in V2:
>> - Rebase against linux-next
>> - Drop downstream-only patch
>> 
>>  arch/arm/boot/dts/bcm283x.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
>> index a3106aa..6d12c3e8 100644
>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>> @@ -3,6 +3,8 @@
>>  #include <dt-bindings/clock/bcm2835-aux.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>  
>> +/memreserve/ 0x00000000 0x00001000;
>
> Can you put a comment above this /memreserve entry here to remind about
> what this is useful for?
>
> Thanks!

Phil, I chatted with Florian and added in:

+/* firmware-provided startup stubs live here, where the secondary CPUs are
+ * spinning.
+ */

and tagged and sent a PR for 4.12.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170516/13a30993/attachment-0001.sig>
