From: james.morse@arm.com (James Morse)
Date: Mon, 2 Jul 2018 11:53:26 +0100
Subject: question about arm64 exception handling
In-Reply-To: <5B39FF98.7010002@broadcom.com>
References: <5B34CD7D.5090002@broadcom.com>
 <e54b3d4c-dbd0-b39d-28a2-063f34068dfd@arm.com>
 <5B39FF98.7010002@broadcom.com>
Message-ID: <815c6a58-2444-a050-421b-68c873337b67@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arend,

On 02/07/18 11:34, Arend van Spriel wrote:
> On 6/28/2018 6:13 PM, James Morse wrote:
>> On 28/06/18 12:58, Arend van Spriel wrote:
>>> I am looking at some issues we are seeing on a custom arm platform and I had
>>> some questions regarding exception handling and hope you can help me with that.
>>>
>>> The platform has 4 cortex a53 cores running 4.1.51 kernel.

>>> On the platform upon
>>> accessing our wifi devices over PCIe, we observe two issue intermittently.
>>>
>>> 1) synchronous external abort

>> Can you share the backtrace for the Synchronous External Abort? It should point
>> at the instruction in the (probably) driver that causes the abort.
> 
> 15:05:24.284? LOG?? 4908REF2?? Unhandled fault: synchronous external abort
> (0x96000210) at 0xffffff80010a4154

I'm not sure where this 'LOG 4908REF2' is coming from, but from the kernel you
should get a stack trace after the external abort message. Looks a bit like [0]
(also a v4.1 kernel).


> So between brackets is the ESR. Looking in the TRM I can only conclude it is
> exception class 0x25 whatever that is.

"Data abort taken without a change in exception level."
This happened because EL1 made a load/store that the device on the other end
rejected with an abort.

Your ISS decodes as a load, not on a translation table walk, with the 'EA' bit set.

(The EA bit is used by the CPU to classify some external aborts from some other
type. Its implementation-defined, and not likely to be helpful here).


> Need to dive in armv8a arch doc. So the address 0xffffff80010a4154 is the fault address. 

32bit aligned address. It may be the device on the other end wanted 64bit
alignment. (I'm guessing)


> It is not in the range of my
> wireless driver, but it is probably in the PCIe host driver accessing the device.

Another guess: whatever whatever mapped that address space used the wrong memory
attributes.


> Thanks for the pointers. Digging deeper.

Good luck!


Thanks,

James

[0] https://lists.gt.net/linux/kernel/2223260
