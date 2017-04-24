From: lersek@redhat.com (Laszlo Ersek)
Date: Mon, 24 Apr 2017 13:27:51 +0200
Subject: [PATCH] kvm: pass the virtual SEI syndrome to guest OS
In-Reply-To: <3fdc8c8c-1cd9-b609-c7af-52d40e6141c5@huawei.com>
References: <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
 <20170321113428.GC15920@cbox> <58D17AF0.2010802@arm.com>
 <20170321193933.GB31111@cbox> <58DA3F68.6090901@arm.com>
 <20170328112328.GA31156@cbox> <20170328115413.GJ23682@e104320-lin>
 <b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com> <58DA67BA.8070404@arm.com>
 <5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
 <20170329103658.GQ23682@e104320-lin>
 <2a427164-9b37-6711-3a56-906634ba7f12@redhat.com>
 <7c5c8ab7-8fcc-1c98-0bc1-cccb66c4c84d@huawei.com>
 <6ac1597a-2ed5-36b2-848d-5fd048b16d66@redhat.com>
 <3fdc8c8c-1cd9-b609-c7af-52d40e6141c5@huawei.com>
Message-ID: <2aa1180d-2d05-d898-e1f2-be56c342a170@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/17 15:27, gengdongjiu wrote:
> Hi all/Laszlo,
> 
>   sorry, I have a question to consult with you.
> 
> 
> On 2017/4/7 2:55, Laszlo Ersek wrote:
>> On 04/06/17 14:35, gengdongjiu wrote:
>>> Dear, Laszlo
>>>    Thanks for your detailed explanation.
>>>
>>> On 2017/3/29 19:58, Laszlo Ersek wrote:
>>>> (This ought to be one of the longest address lists I've ever seen :)
>>>> Thanks for the CC. I'm glad Shannon is already on the CC list. For good
>>>> measure, I'm adding MST and Igor.)
>>>>
>>>> On 03/29/17 12:36, Achin Gupta wrote:
>>>>> Hi gengdongjiu,
>>>>>
>>>>> On Wed, Mar 29, 2017 at 05:36:37PM +0800, gengdongjiu wrote:
>>>>>>
>>>>>> Hi Laszlo/Biesheuvel/Qemu developer,
>>>>>>
>>>>>>    Now I encounter a issue and want to consult with you in ARM64 platform? as described below:
>>>>>>
>>>>>> when guest OS happen synchronous or asynchronous abort, kvm needs
>>>>>> to send the error address to Qemu or UEFI through sigbus to
>>>>>> dynamically generate APEI table. from my investigation, there are
>>>>>> two ways:
>>>>>>
>>>>>> (1) Qemu get the error address, and generate the APEI table, then
>>>>>> notify UEFI to know this generation, then inject abort error to
>>>>>> guest OS, guest OS read the APEI table.
>>>>>> (2) Qemu get the error address, and let UEFI to generate the APEI
>>>>>> table, then inject abort error to guest OS, guest OS read the APEI
>>>>>> table.
>>>>>
>>>>> Just being pedantic! I don't think we are talking about creating the APEI table
>>>>> dynamically here. The issue is: Once KVM has received an error that is destined
>>>>> for a guest it will raise a SIGBUS to Qemu. Now before Qemu can inject the error
>>>>> into the guest OS, a CPER (Common Platform Error Record) has to be generated
>>>>> corresponding to the error source (GHES corresponding to memory subsystem,
>>>>> processor etc) to allow the guest OS to do anything meaningful with the
>>>>> error. So who should create the CPER is the question.
>>>>>
>>>>> At the EL3/EL2 interface (Secure Firmware and OS/Hypervisor), an error arrives
>>>>> at EL3 and secure firmware (at EL3 or a lower secure exception level) is
>>>>> responsible for creating the CPER. ARM is experimenting with using a Standalone
>>>>> MM EDK2 image in the secure world to do the CPER creation. This will avoid
>>>>> adding the same code in ARM TF in EL3 (better for security). The error will then
>>>>> be injected into the OS/Hypervisor (through SEA/SEI/SDEI) through ARM Trusted
>>>>> Firmware.
>>>>>
>>>>> Qemu is essentially fulfilling the role of secure firmware at the EL2/EL1
>>>>> interface (as discussed with Christoffer below). So it should generate the CPER
>>>>> before injecting the error.
>>>>>
>>>>> This is corresponds to (1) above apart from notifying UEFI (I am assuming you
>>>>> mean guest UEFI). At this time, the guest OS already knows where to pick up the
>>>>> CPER from through the HEST. Qemu has to create the CPER and populate its address
>>>>> at the address exported in the HEST. Guest UEFI should not be involved in this
>>>>> flow. Its job was to create the HEST at boot and that has been done by this
>>>>> stage.
>>>>>
>>>>> Qemu folk will be able to add but it looks like support for CPER generation will
>>>>> need to be added to Qemu. We need to resolve this.
>>>>>
>>>>> Do shout if I am missing anything above.
>>>>
>>>> After reading this email, the use case looks *very* similar to what
>>>> we've just done with VMGENID for QEMU 2.9.
>>>>
>>>> We have a facility between QEMU and the guest firmware, called "ACPI
>>>> linker/loader", with which QEMU instructs the firmware to
>>>>
>>>> - allocate and download blobs into guest RAM (AcpiNVS type memory) --
>>>> ALLOCATE command,
>>>>
>>>> - relocate pointers in those blobs, to fields in other (or the same)
>>>> blobs -- ADD_POINTER command,
>>>>
>>>> - set ACPI table checksums -- ADD_CHECKSUM command,
>>>>
>>>> - and send GPAs of fields within such blobs back to QEMU --
>>>> WRITE_POINTER command.
>>>>
>>>> This is how I imagine we can map the facility to the current use case
>>>> (note that this is the first time I read about HEST / GHES / CPER):
> 
> Laszlo lists a Qemu GHES table generation solution, Mainly use the
> four commands: "ALLOCATE/ADD_POINTER/ADD_CHECKSUM/WRITE_POINTER" to
> communicate with BIOS so whether the four commands needs to be
> supported by the guest firware/UEFI.  I found the  "WRITE_POINTER"
> always failed. so I suspect guest UEFI/firmware not support the
> "WRITE_POINTER" command. please help me confirm it, thanks so much.

That's incorrect, both OVMF and ArmVirtQemu support the WRITE_POINTER
command (see <https://bugzilla.tianocore.org/show_bug.cgi?id=359>.) A
number of OvmfPkg/ modules are included in ArmVirtPkg binaries as well.

In QEMU, the WRITE_POINTER command is currently generated for the
VMGENID device only. If you try to test VMGENID with qemu-system-aarch64
(for the purposes of WRITE_POINTER testing), that won't work, because
the VMGENID device is not available for aarch64. (The Microsoft spec
that describes the device lists Windows OS versions that are x86 only.)

In other words, no QEMU code exists at the moment that would allow you
to readily test WRITE_POINTER in aarch64 guests. However, the
firmware-side code is not architecture specific, and WRITE_POINTER
support is already being built into ArmVirtQemu.

Thanks,
Laszlo
