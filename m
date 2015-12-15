From: graeme.gregory@linaro.org (G Gregory)
Date: Tue, 15 Dec 2015 19:22:09 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <CAGCh1+kc1X6Crhes0C+bh_8YjrFs=0c8SxYW3VmxmZRSaA+xvQ@mail.gmail.com>
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com>
 <CAGCh1+nb-H-B28crGuTPUKXZrBN_XDn7fNHf4q8LZZOgyhtDmQ@mail.gmail.com>
 <566DEED6.3010704@redhat.com>
 <CAGCh1+k8jHzMK+pLbtBgg5=VdT=+3W+OjTGJLMDGjLqLvmQXnw@mail.gmail.com>
 <5670339A.7060307@redhat.com>
 <CAGCh1+=eyBstwL7aPTvmRDDEn0GDrf9gTkCKLDBwoNT916vUpg@mail.gmail.com>
 <CAGCh1+=+SkaunFL1JE-d8jTb6-Xi+sjUEYoF5ZgcwV7GTj7ECQ@mail.gmail.com>
 <56704054.7080506@redhat.com>
 <CAGCh1+kc1X6Crhes0C+bh_8YjrFs=0c8SxYW3VmxmZRSaA+xvQ@mail.gmail.com>
Message-ID: <CAGCh1+kc-1izXxvWw17ggz6XciuCEqOh10AHNGRK1de1vgDQVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 December 2015 at 17:08, G Gregory <graeme.gregory@linaro.org> wrote:
> On 15 December 2015 at 16:31, Jon Masters <jcm@redhat.com> wrote:
>> On 12/15/2015 11:28 AM, G Gregory wrote:
>>> On 15 December 2015 at 16:13, G Gregory <graeme.gregory@linaro.org> wrote:
>>>> On 15 December 2015 at 15:36, Jon Masters <jcm@redhat.com> wrote:
>>>>> On 12/15/2015 06:19 AM, G Gregory wrote:
>>>>>
>>>>> <below refers to the GRUB-based approach not the initrd override>
>>>>>
>>>>>> Tried it, results were not great :-(
>>>>>>
>>>>>> set root='hd0,gpt2'
>>>>>> insmod acpi
>>>>>> acpi /DSDT.aml
>>>>>> linux /Image-leg earlycon=pl011,0xe1010000 console=ttyAMA0 acpi=force root
>>>>>> =/dev/sda2
>>>>>
>>>>> <snip>
>>>>>
>>>>>> [    0.000000] PC is at setup_arch+0xfc/0x564
>>>>>> [    0.000000] LR is at setup_arch+0xf8/0x564
>>>>>
>>>>> <snip>
>>>>>
>>>>> So we unmask SError in setup_arch, which happens now later enough that
>>>>> it'll come out of the UART where you can see it. However there are still
>>>>> occasions on some of these early platforms where an unhandled SError can
>>>>> exist as GRUB exits. I have seen that a number of times on Seattle if
>>>>> there's a pending error from one of the IO IP blocks on the SoC You
>>>>> might need a firmware update, but can you also confirm that this
>>>>> happened reproducibly?
>>>>>
>>>> It is Seattle RevB I am using and it is repeatable. I have pre-release
>>>> firmware on there!
>>>>
>>> Repeatable on ROD0084E as well.
>>
>> I'll try it on a couple of other platforms later this week. I've
>> pondered before whether GRUB should unmask SError and report this prior
>> to entering the kernel, because today Linux always gets the blame ;)
>>
> Well IMO it almost certainly should not pass control of a "broken"
> machine. But I do not know anything about SError.
>
Tested on QEMU and command works as expected

[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000B69F732A 000024 (v02 BOCHS )
[    0.000000] ACPI: XSDT 0x00000000B69F72DE 00004C (v01 BOCHS  BXPCFACP 0000000
1 BXPC 00000001)
[    0.000000] ACPI: SPCR 0x00000000B69F6FBA 000050 (v02 BOCHS  BXPCSPCR 0000000
1 BXPC 00000001)
[    0.000000] ACPI: MCFG 0x00000000B69F700A 00003C (v01 BOCHS  BXPCMCFG 0000000
1 BXPC 00000001)
[    0.000000] ACPI: GTDT 0x00000000B69F7046 000060 (v02 BOCHS  BXPCGTDT 0000000
1 BXPC 00000001)
[    0.000000] ACPI: APIC 0x00000000B69F70A6 0000F4 (v03 BOCHS  BXPCAPIC 0000000
1 BXPC 00000001)
[    0.000000] ACPI: FACP 0x00000000B69F719A 00010C (v05 BOCHS  BXPCFACP 0000000
1 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x00000000B69F6000 000FBA (v02 XORAS  XORAXORA 0000000
1 INTL 20140926)

Can see DSDT is not the one generated from QEMU

Graeme
