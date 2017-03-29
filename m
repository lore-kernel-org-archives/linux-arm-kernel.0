From: achin.gupta@arm.com (Achin Gupta)
Date: Wed, 29 Mar 2017 11:36:59 +0100
Subject: [PATCH] kvm: pass the virtual SEI syndrome to guest OS
In-Reply-To: <5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
References: <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
 <20170321113428.GC15920@cbox> <58D17AF0.2010802@arm.com>
 <20170321193933.GB31111@cbox> <58DA3F68.6090901@arm.com>
 <20170328112328.GA31156@cbox> <20170328115413.GJ23682@e104320-lin>
 <b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
 <58DA67BA.8070404@arm.com>
 <5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
Message-ID: <20170329103658.GQ23682@e104320-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On Wed, Mar 29, 2017 at 05:36:37PM +0800, gengdongjiu wrote:
>
> Hi Laszlo/Biesheuvel/Qemu developer,
>
>    Now I encounter a issue and want to consult with you in ARM64 platform? as described below:
>
>    when guest OS happen synchronous or asynchronous abort, kvm needs to send the error address to Qemu or UEFI through sigbus to dynamically generate APEI table. from my investigation, there are two ways:
>
>    (1) Qemu get the error address, and generate the APEI table, then notify UEFI to know this generation, then inject abort error to guest OS, guest OS read the APEI table.
>    (2) Qemu get the error address, and let UEFI to generate the APEI table, then inject abort error to guest OS, guest OS read the APEI table.

Just being pedantic! I don't think we are talking about creating the APEI table
dynamically here. The issue is: Once KVM has received an error that is destined
for a guest it will raise a SIGBUS to Qemu. Now before Qemu can inject the error
into the guest OS, a CPER (Common Platform Error Record) has to be generated
corresponding to the error source (GHES corresponding to memory subsystem,
processor etc) to allow the guest OS to do anything meaningful with the
error. So who should create the CPER is the question.

At the EL3/EL2 interface (Secure Firmware and OS/Hypervisor), an error arrives
at EL3 and secure firmware (at EL3 or a lower secure exception level) is
responsible for creating the CPER. ARM is experimenting with using a Standalone
MM EDK2 image in the secure world to do the CPER creation. This will avoid
adding the same code in ARM TF in EL3 (better for security). The error will then
be injected into the OS/Hypervisor (through SEA/SEI/SDEI) through ARM Trusted
Firmware.

Qemu is essentially fulfilling the role of secure firmware at the EL2/EL1
interface (as discussed with Christoffer below). So it should generate the CPER
before injecting the error.

This is corresponds to (1) above apart from notifying UEFI (I am assuming you
mean guest UEFI). At this time, the guest OS already knows where to pick up the
CPER from through the HEST. Qemu has to create the CPER and populate its address
at the address exported in the HEST. Guest UEFI should not be involved in this
flow. Its job was to create the HEST at boot and that has been done by this
stage.

Qemu folk will be able to add but it looks like support for CPER generation will
need to be added to Qemu. We need to resolve this.

Do shout if I am missing anything above.

cheers,
Achin


>
>
>    Do you think which modules generates the APEI table is better? UEFI or Qemu?
>
>
>
>
> On 2017/3/28 21:40, James Morse wrote:
> > Hi gengdongjiu,
> >
> > On 28/03/17 13:16, gengdongjiu wrote:
> >> On 2017/3/28 19:54, Achin Gupta wrote:
> >>> On Tue, Mar 28, 2017 at 01:23:28PM +0200, Christoffer Dall wrote:
> >>>> On Tue, Mar 28, 2017 at 11:48:08AM +0100, James Morse wrote:
> >>>>> On the host, part of UEFI is involved to generate the CPER records.
> >>>>> In a guest?, I don't know.
> >>>>> Qemu could generate the records, or drive some other component to do it.
> >>>>
> >>>> I think I am beginning to understand this a bit.  Since the guet UEFI
> >>>> instance is specifically built for the machine it runs on, QEMU's virt
> >>>> machine in this case, they could simply agree (by some contract) to
> >>>> place the records at some specific location in memory, and if the guest
> >>>> kernel asks its guest UEFI for that location, things should just work by
> >>>> having logic in QEMU to process error reports and populate guest memory.
> >>>>
> >>>> Is this how others see the world too?
> >>>
> >>> I think so!
> >>>
> >>> AFAIU, the memory where CPERs will reside should be specified in a GHES entry in
> >>> the HEST. Is this not the case with a guest kernel i.e. the guest UEFI creates a
> >>> HEST for the guest Kernel?
> >>>
> >>> If so, then the question is how the guest UEFI finds out where QEMU (acting as
> >>> EL3 firmware) will populate the CPERs. This could either be a contract between
> >>> the two or a guest DXE driver uses the MM_COMMUNICATE call (see [1]) to ask QEMU
> >>> where the memory is.
> >>
> >> whether invoke the guest UEFI will be complex? not see the advantage. it seems x86 Qemu
> >> directly generate the ACPI table, but I am not sure, we are checking the qemu
> > logical.
> >> let Qemu generate CPER record may be clear.
> >
> > At boot UEFI in the guest will need to make sure the areas of memory that may be
> > used for CPER records are reserved. Whether UEFI or Qemu decides where these are
> > needs deciding, (but probably not here)...
> >
> > At runtime, when an error has occurred, I agree it would be simpler (fewer
> > components involved) if Qemu generates the CPER records. But if UEFI made the
> > memory choice above they need to interact and it gets complicated again. The
> > CPER records are defined in the UEFI spec, so I would expect UEFI to contain
> > code to generate/parse them.
> >
> >
> > Thanks,
> >
> > James
> >
> >
> > .
> >
>
