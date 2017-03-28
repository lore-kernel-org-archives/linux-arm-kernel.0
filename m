From: james.morse@arm.com (James Morse)
Date: Tue, 28 Mar 2017 14:27:19 +0100
Subject: [PATCH] kvm: pass the virtual SEI syndrome to guest OS
In-Reply-To: <CAFEAcA9O_mUbO=RChLwpj=qr0ZDg6iEsYwzWLTbHMRV-9z-1vQ@mail.gmail.com>
References: <1489996534-8270-1-git-send-email-gengdongjiu@huawei.com>
 <7055772d-2a20-6e0c-2bf8-204bc9ef52a5@arm.com>
 <b912c293-4314-7c90-30a4-2f986feb1670@huawei.com>
 <22fb583f-a33e-15f8-a059-fb112b27dd4f@arm.com> <58CFF058.8020205@arm.com>
 <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
 <20170321113428.GC15920@cbox> <58D17AF0.2010802@arm.com>
 <20170321193933.GB31111@cbox> <58DA3F68.6090901@arm.com>
 <20170328112328.GA31156@cbox>
 <CAFEAcA9O_mUbO=RChLwpj=qr0ZDg6iEsYwzWLTbHMRV-9z-1vQ@mail.gmail.com>
Message-ID: <58DA64B7.9090608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 28/03/17 12:33, Peter Maydell wrote:
> On 28 March 2017 at 12:23, Christoffer Dall <cdall@linaro.org> wrote:
>> On Tue, Mar 28, 2017 at 11:48:08AM +0100, James Morse wrote:
>>> On the host, part of UEFI is involved to generate the CPER records.
>>> In a guest?, I don't know.
>>> Qemu could generate the records, or drive some other component to do it.
>>
>> I think I am beginning to understand this a bit.  Since the guet UEFI
>> instance is specifically built for the machine it runs on, QEMU's virt
>> machine in this case, they could simply agree (by some contract) to
>> place the records at some specific location in memory, and if the guest
>> kernel asks its guest UEFI for that location, things should just work by
>> having logic in QEMU to process error reports and populate guest memory.
> 
> Is "write direct to guest memory" the best ABI here or would
> it be preferable to use the fw_cfg interface for the guest UEFI
> to retrieve the data items on demand?

As far as I understand the interaction between Qemu and UEFI isn't defined. The
eventual aim is to emulate ACPI's firmware first error handling for a guest.
This way the RAS behaviour for a host and the guest is the same.

The ABI is the guest OS gets a 'notification' (there is a list in acpi: 18.3.2.9
Hardware Error Notification), and then finds a pointer to the CPER records
(defined in the UEFI Spec Appendix N) at the address advertised by one of the
Generic Hardware Error Source (GHES) entries of the ACPI Hardware Error Source
Table (HEST).

How Qemu and UEFI conspire to make this happen is up for discussion.
My suggestion would be to try and closely mirror whatever happens on a physical
system so that UEFI only needs to test one set of code.


> Is there a pre-existing "this is how it works on x86" implementation?

I found [0], which on page 16 talks about Qemu injecting a Pseudo 'Software
Recoverable Action Required', which I assume is a flavour of NMI.

The ACPI/CPER stuff is arch agnostic and given Qemu is only ever likely to have
to handle memory errors it should be possible to use the same code for both x86
and arm64.


Thanks,

James

[0] https://events.linuxfoundation.org/images/stories/slides/lfcs2013_tanino.pdf
