From: dja@axtens.net (Daniel Axtens)
Date: Fri, 21 Jul 2017 09:52:22 +1000
Subject: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
In-Reply-To: <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
References: <20170719012839.20124-1-dja@axtens.net>
 <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
Message-ID: <87pocusm2x.fsf@linkitivity.dja.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

> (+ Laszlo)
>
> On 19 July 2017 at 02:28, Daniel Axtens <dja@axtens.net> wrote:
>> Hi all,
>>
>> Previously I posted a patch that provided a quirk for a hibmc card
>> behind a particular Huawei bridge that allowed it to be marked as the
>> default device in the VGA arbiter.[0] This lead to some discussion.[1]
>> It was broadly suggested that a more generic solution would be better,
>> something in the style of powerpc's fixup_vga() quirk.
>>
>> Here is my suggested solution:
>>
>>  - Create a Kconfig option ARCH_WANT_VGA_ARB_FALLBACK
>>
>>  - if an arch selects that option, install PCI_FIXUP_CLASS_ENABLE
>>    hook. This hook fires when a card is enabled, which will require
>>    that a driver has been bound.
>>
>>  - if there is no default device when the hook fires, and the device
>>    can control memory and I/O, mark it as default.
>>
>> The patches are as follows:
>>
>>  (1) powerpc: simplify and fix VGA default device behaviour
>>
>>      This cleans up some quirks in the powerpc implementation of the
>>      vga_fixup. It should make the behaviour match the original
>>      intention.
>>
>>  (2) vgaarb: allow non-legacy cards to be marked as default
>>
>>      Add the Kconfig option, and create the fixup in vgaarb.c gated
>>      behind the option. Nothing happens at this stage because no arch
>>      has selected the option yet.
>>
>>  (3) powerpc: replace vga_fixup() with generic code
>>
>>      Select the option on powerpc and remove the old code. The only
>>      change is that it moves from being a final fixup to an enable
>>      fixup.
>>
>>  (4) arm64: allow non-legacy VGA devices to be default
>>
>>      Select the option on arm64. This solves my problem with the D05,
>>      but may cause other cards to be marked as default on other
>>      boards. This shouldn't cause any real issues but is worth being
>>      aware of.
>>
>
> Hi Daniel,
>
> Given that the whole point of the VGA arbiter is the ability to share
> the legacy mem+io ranges between different cards, why do we care about
> the VGA arbiter in the first place on arm64?
>
> AFAIK, there have been some recent changes in Xorg to address the
> auto-detection problem. I don't remember the exact details, but I have
> added Laszlo, who was involved with this at the time.

I haven't been able to locate those changes - I remember that the call
to pci_device_is_boot_vga() in xf86pciBus.c [0] was critical and that is
still there in the latest git.

Indeed, the reason we care about the vga arbiter at all is because of
that Xorg dependency on the boot VGA card. pci_device_is_boot_vga()
reads a sysfs file, and that sysfs file is populated based on the
vga_default_driver(), so it's very difficult to extricate ourselves from
the vga arbiter and its concept of the default device.

We could make this method an 'either/or' rather than a fallback - so
platforms who didn't care about legacy resources didn't bother with
those tests, but I'm not sure what benefit that would give and I find it
harder to be confident of an absence of unexpected consequences.

Regards,
Daniel

[0] https://cgit.freedesktop.org/xorg/xserver/tree/hw/xfree86/common/xf86pciBus.c#n113

>
> -- 
> Ard.
