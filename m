From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Feb 2015 10:44:15 +0800
Subject: [PATCH v8 08/21] dt / chosen: Add linux,
 uefi-stub-generated-dtb property
In-Reply-To: <20150209114624.GD4250@leverpostej>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>
 <20150202134033.GR4278@bivouac.eciton.net>
 <20150202135051.GA3825@xora-haswell.xora.org.uk>
 <20150202163253.GG21175@leverpostej>
 <CAGCh1+nL7YMXYp42ekWAqmw_m5cy=s_7NszLDAXj=bUr2aZVig@mail.gmail.com>
 <54D5884A.6050009@linaro.org>
 <CAKv+Gu-oDRjYPC3SxSDVZ7rV7eG9DCct=kNS0xBVd28YoV5fSg@mail.gmail.com>
 <20150209114624.GD4250@leverpostej>
Message-ID: <CAKv+Gu-fnpxr-3T9RPuf4de2DGVE6xkDEcfFyzYp5KJCJH_fzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 February 2015 at 19:46, Mark Rutland <mark.rutland@arm.com> wrote:
> On Sat, Feb 07, 2015 at 05:03:44AM +0000, Ard Biesheuvel wrote:
>> On 7 February 2015 at 03:36, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> > On 2015?02?06? 18:34, G Gregory wrote:
>> > [...]
>> >
>> >>>>>>
>> >>>>>> --------------------------------------------------------------------------------
>> >>>>>>   linux,uefi-stub-kern-ver  | string | Copy of linux_banner from
>> >>>>>> build.
>> >>>>>>
>> >>>>>> --------------------------------------------------------------------------------
>> >>>>>> +linux,uefi-stub-generated-dtb  | bool | Indication for no DTB
>> >>>>>> provided by
>> >>>>>> +                        |      | firmware.
>> >>>>>>
>> >>>>>> +--------------------------------------------------------------------------------
>> >>>>>
>> >>>>>
>> >>>>> Apologies for the late bikeshedding, but the discussion on this topic
>> >>>>> previsously was lively enough that I thought I'd let it die down a bit
>> >>>>> before seeing if I had anything to add.
>> >>>>>
>> >>>>> That, and I just realised something:
>> >>>>> One alternative to this added DT entry is that we could treat the
>> >>>>> absence of a registered UEFI configuration table as the indication
>> >>>>> that no HW description was provided from firmware, since the stub does
>> >>>>> not call InstallConfigurationTable() on the DT it generates. This does
>> >>>>> move the ability to detect to after efi_init(), but this should be
>> >>>>> fine for ACPI-purposes.
>> >>>>>
>> >>>> That would not work as expected in the kexec/Xen use case though as they
>> >>>> may genuinely boot with DT from an ACPI host without UEFI.
>> >>>
>> >>>
>> >>> I'm a little concerned by this case. How do we intend to pass stuff from
>> >>> Xen to the kernel in this case? When we initially discussed the stub
>> >>> prior to merging, we weren't quite sure if ACPI without UEFI was
>> >>> entirely safe.
>> >>>
>> >>> The linux,uefi-stub-kern-ver property was originally intended as a
>> >>> sanity-check feature to ensure nothing (including Xen) masqueraded as
>> >>> the stub, but for some reason the actual sanity check was never
>> >>> implemented.
>> >>>
>> >>>>> If that is deemed undesirable, I would still prefer Catalin's
>> >>>>> suggested name ("linux,bare-dtb"), which describes the state rather
>> >>>>> than the route we took to get there.
>> >>>>>
>> >>>> I agree.
>> >>>
>> >>>
>> >>> I guess this would be ok, though it would be nice to know which agent
>> >>> generated the DTB.
>> >>>
>> >>
>> >> The most obvious scheme then is
>> >>
>> >> linux,bare-dtb = "uefi-stub";
>> >>
>> >> otherwise we generate a new binding for every component in the boot path.
>> >
>> >
>> > Leif, Mark, any comments on this?
>> >
>>
>> As far as I remember, we did not finalize the decision to go with a
>> stub generated property instead of some other means to infer that the
>> device tree is not suitable for booting and ACPI should be preferred.
>>
>> We will be discussing the 'stub<->kernel interface as a boot protocol'
>> topic this week at Connect, so let's discuss it in that context before
>> signing off on patches like these.
>
> As some of us (at least myself) aren't at connect, it would be nice if
> those discussions could be at least mirrored on the mailing list. I have
> some concerns regarding how this is going to work long-term, and I'd
> like to make sure we don't get stuck with something that limits what we
> can do long-term.
>
> Is there a session set aside for this, or is this a hallway track topic?
>

Hello all,

(added team-Xen to cc)

We had our meeting yesterday: allow me to summarize what we discussed,
and we can proceed with the discussion on-list if desired.

Present:
Grant Likely
Al Stone
Hanjun Guo
Leif Lindholm
Roy Franz
Ard Biesheuvel

Topic #1: booting the arm64 kernel with ACPI but no UEFI

We have identified Xen as the only use case: there is a need to boot
dom0 using the host's ACPI tables but without allowing the dom0 kernel
to interface directly with the UEFI firmware. There may be other valid
use cases, though, so this use case should be addressed generically
regardless.

First, it was proposed to allow the ACPI root pointer to be added to a
/chosen node property, and the kernel would use this property instead
of going through the UEFI tables.
However, there is a similar case that could be made for SMBIOS: unlike
x86, where there is a 'legacy' method to locate either table by
scanning some special physical memory regions, the respective
specifications only provide a single method to perform table
discovery, which is through UEFI. This means that passing the ACPI
root pointer to the kernel using a property in the /chosen node
doesn't scale well, as we would need to do the same for SMBIOS at
least, and potentially other tables in the future.

There are two other concerns related to passing the ACPI root pointer directly:
- the actual discovery occurs in core code, and we are reluctant to
change it to accommodate arm64 specific behavior
- it would create separate paths through the early boot code which
complicates testing and validation

So instead, we think it is reasonable to mandate a minimal subset of
the UEFI environment to be present, either natively or emulated/mocked
up by Xen, kexec etc.

- an EFI system table (and a /chosen/linux,uefi-system-table that
points to it) containing at least
  * a fully populated header with version >= 2.0 and correct CRC
  * populated fw_vendor string
  * configuration table pointer and count, pointing to the ACPI and
SMBIOS configuration tables with their respective GUIDs
  * NULL runtime services function table pointer

- an EFI format memory map (and the /chosen/linux,uefi-mmap-*
properties that go with it) covering all of system RAM, with ACPI and
SMBIOS reserved regions marked as appropriate

As this basically promotes the stub<->kernel interface to an external
ABI, the current documentation about the /chosen node properties
should also be promoted to a proper binding, with the above mandated
minimal subset added as well.

There are some minimal changes required to the current kernel code to
adhere to the above: primarlly to deal with a NULL runtime services
pointer, which is arguably an improvement anyway.

Topic #2: how to identify an 'empty' DTB

The proposed policy regarding whether DT or ACPI should be preferred
if both methods are available hinges on being able to identify a DTB
as containing a platform description or not. One suggested way of
doing this is to make the stub add a /chosen node property that
indicates that it didn't receive a DTB from the firmware, nor loaded
one from the file system, but created an empty one from scratch.

Considering the previous topic, i.e., the promotion of the
stub<->kernel interface to external ABI, we should not be frivolous
about adding new properties, and adding a 'stub-generated-dtb'
property should be avoided if there is a better way to deal with this.
Also, e.g., when booting via GRUB, it may in fact be GRUB and not the
stub that creates the DTB (when booting with an initrd, for instance)
so GRUB would have to be modified as well. (If not, simply adding a
initrd= property to the command line would result in the kernel
preferring DT over ACPI all of a sudden, which surely, we all agree is
undesirable behavior)

So instead, we propose to use a heuristic to decide whether a DTB
should be considered empty or not:
If /chosen is the only level 1 node in the tree, the DTB is empty,
otherwise it is not.

This can be trivially implemented into the existing EFI early FDT
discovery code, and does not require any other changes to the stub or
GRUB.

Please, could those affected by this comment whether this is feasible
or not? Other comments/remarks also highly appreciated, of course,

Regards,
Ard.
