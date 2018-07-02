From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Mon, 2 Jul 2018 12:34:00 +0200
Subject: question about arm64 exception handling
In-Reply-To: <e54b3d4c-dbd0-b39d-28a2-063f34068dfd@arm.com>
References: <5B34CD7D.5090002@broadcom.com>
 <e54b3d4c-dbd0-b39d-28a2-063f34068dfd@arm.com>
Message-ID: <5B39FF98.7010002@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/28/2018 6:13 PM, James Morse wrote:
> Hi Arend,
>
> On 28/06/18 12:58, Arend van Spriel wrote:
>> I am looking at some issues we are seeing on a custom arm platform and I had
>> some questions regarding exception handling and hope you can help me with that.
>>
>> The platform has 4 cortex a53 cores running 4.1.51 kernel.
>
> v4.1 is circa 2015, and chance you could try v4.17?

Hi James,

If it were up to me, sure. Unfortunately it is not :-(

>> On the platform upon
>> accessing our wifi devices over PCIe, we observe two issue intermittently.
>>
>> 1) synchronous external abort
>> 2) NMI watchdog
>>
>> With the latter I notice el1_irq in the exception stack trace. Is that due to
>> the NMI watchdog or is this caused by another issue like our crappy hardware ;-) ?
>
>
>> Regarding the SEA I noticed stuff has been added for that in 4.13. Is is worth
>> backporting that to obtain more info about that?
>
> Unlikely. Those changes are related to firmware-first RAS. You would see this on
> server platforms booting with ACPI and have a 'HEST' table.

I see. That is not really what I am working with here.

> Can you share the backtrace for the Synchronous External Abort? It should point
> at the instruction in the (probably) driver that causes the abort.

15:05:24.284  LOG   4908REF2   Unhandled fault: synchronous external 
abort (0x96000210) at 0xffffff80010a4154

So between brackets is the ESR. Looking in the TRM I can only conclude 
it is exception class 0x25 whatever that is. Need to dive in armv8a arch 
doc. So the address 0xffffff80010a4154 is the fault address. It is not 
in the range of my wireless driver, but it is probably in the PCIe host 
driver accessing the device.

Thanks for the pointers. Digging deeper.

Regards,
Arend
