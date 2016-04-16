From: jchandra@broadcom.com (Jayachandran C)
Date: Sat, 16 Apr 2016 20:06:03 +0530
Subject: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
In-Reply-To: <4240660.NqlPcXaV7N@wuerfel>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <5110401.mGEq6IVFz2@wuerfel>
 <CAKc_7PWFacFJZA2JpfM4RcRFVj0jyUE73HhhvmX0cKm07JGupg@mail.gmail.com>
 <4240660.NqlPcXaV7N@wuerfel>
Message-ID: <CAKc_7PWw5VaPxcOpWbonksx6k4W5fe9yO8wBfigXNRkFAYAYEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 16, 2016 at 1:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 16 April 2016 12:50:13 Jayachandran C wrote:
>> >
>> > I still think it would be better to keep the loadable PCI host drivers
>> > separate from the ACPI PCI infrastructure. There are a number of
>> > simplifications that we want to do to the DT based drivers in the long
>> > run, so it's better if that code is not shared at this level. Abstracting
>> > out the ECAM code is fine, but at that point you should be able to just
>> > call it from the ACPI layer.
>>
>> The issue is not with this patch (in my opinion). This patch is just
>> re-arranging how thunder specific data is maintained. Earlier it was
>> a container_of gen_pci, now it is ->priv of pci_config_window.
>>
>> I can see the issue in patches 12 and 13 of this patchset which adds
>> ACPI fixups into the thunder OF driver.
>
> Right, I commented on this one, because it seems to rearrange the code
> in order to do the later one.

Patches 11- 13 are not from me, and I am not completely on board
on the approach of adding the sections.We can look at reworking this.

>> The simple approach when doing modular PCI drivers would be to make
>> pci-thunder-*.c like pci-host-common.c, to be compiled in if configured.
>> The fie will contain all the Thunder quirks and can export
>> pci_thunder_ecam_ops.
>
> I would argue that we should not export anything from drivers/pci/host,
> those should really be standalone drivers that do not interact with other
> subsystems.

pci-host-common.c goes against being standalone. The files calling
pci_host_common_probe() are expected to have custom ECAM ops
the way it is written now. We need to have a reasonable way to share
those ECAM ops if needed by ACPI.

> How much code would you need to duplicate from thunder-ecam to have
> the same functionality available in ACPI? My expectation is that it's
> not really that much more compared to the code you need for sharing
> a single implementation, but you get a lower complexity here, which
> makes it easier to understand and to rework.

Like I wrote above, the sharing is really simple because both generic
ACPI and pci-host-common.c have been written for "ECAM with quirks".

The whole pci-thunder-*.c is to support thunder PCI quirks since the
generic OF is handled by pci-host-common.c and generic ECAM is now
separated -  duplicating the whole file for ACPI will be bad.

Any suggestions on how to do this better would be really welcome.

Thanks,
JC.
