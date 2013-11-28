From: jonathan@jonmasters.org (Jon Masters)
Date: Thu, 28 Nov 2013 01:21:11 -0500
Subject: ACPI
In-Reply-To: <CAHCPf3tXN=Vt9q=G7G4yQaAQ+B=eFN5YKV1QguGp13OzEHqGCA@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
 <20131125154110.GB3243@srcf.ucam.org>
 <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
 <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
 <20131126183344.GA16074@srcf.ucam.org>
 <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
 <20131126233224.GA21189@srcf.ucam.org>
 <CAHCPf3tXN=Vt9q=G7G4yQaAQ+B=eFN5YKV1QguGp13OzEHqGCA@mail.gmail.com>
Message-ID: <5296E0D7.1090609@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2013 03:21 PM, Matt Sealey wrote:
> On Tue, Nov 26, 2013 at 5:32 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> On Tue, Nov 26, 2013 at 05:11:23PM -0600, Matt Sealey wrote:
>>
>>> Before stabbing around adding ACPI and then having DT-in-ACPI isn't
>>> there a use case for an an ARM Linux kernel actually being a good
>>> citizen of UEFI?
>>
>> That's work in progress. Patches have been posted and are getting pretty
>> close to being mergeable. You can already run VExpress with UEFI.

Indeed. Mark Salter has done some great work porting Roy Franz's initial
UEFI shim to AArch64, and we have Fedora 19 Remix images that boot using
UEFI (a custom EDK2 build with the mmio virtio patches that are
currently in revision 4 for review upstream in the Ovmf package) today
that you can download from the Fedora wiki for the FVP model:

http://fedoraproject.org/wiki/Architectures/ARM/AArch64/QuickStart

UEFI specifies passing the ACPI root pointers in as part of the standard
interface and this will be the means through which the tables are
provided on AArch64 systems - per the UEFI 2.4 specification.

<snip>

> Right now the best way of doing that - if you're in a server
> environment anyway and dictate UEFI - is the ACPI configuration table
> off the System Table.

Indeed, this is indeed a feature of the EFI system table.

<snip>

>>> 3) Because there seems to be an absolutely moronic assumption

^^^ Is of course opinion. There are a large and growing number of
corporations who have already committed billions of dollars to this
"assumption". I think ARM is a very versatile (pun intended) and capable
architecture with many different use cases. One of them is in server
designs that look a lot like other architectures, but with an
alternative CPU in place. This leverages huge amounts of existing
capability and expertise. Perhaps it is not the ideal way given a blank
sheet of paper but there *isn't* a blank sheet. Not when you factor in
vendors having existing tooling, development teams, management software,
and an entire industry that is built the "traditional" way.

<snip>

> It could be made to work; it's a stupid, stupid idea that throws any
> of the benefits of using ARM in the first place out of the window. Why
> would anyone do that?

Because a lot of these vendors are used to doing things the existing
way. It's not a purely technical decision (if it were, we'd probably
have a global electrical system on a single frequency and voltage, all
drive on the same side of the road, etc.) but it's based on vendors
entering the ARM space and seeking to make it fit into what they know.
It doesn't "throw any of the benefits of using ARM out of the window".
That's hyperbole. It "throws *some* of the benefits of using ARM out of
the window" in the spirit of a platform these folks will work with.

Think about it in the same way that many other things in life are
horrible compromises. It's seldom about having the best technology.
Ultimately the DeviceTree vs. DSDT thing is just data (yes, ACPI will
need new bindings, revisions, and so on). Some folks will go one way,
others (many server folks) will go the other. But beyond the data piece,
the runtime power management and PSCI discussion is very important.
Nobody thinks ACPI's notion of power states adequately reflects the full
potential for the platform, but this is one reason the governance of
ACPI was adjusted to allow for changes to be made.

>>> But I can't think of a reason why an extension or companion to PSCI
>>> couldn't do it, and why you WOULDN'T want to do this as an API
>>> implemented via a secure monitor interface which is architecturally
>>> defined on ARM where security extensions are present. I can't imagine
>>> a reason why it couldn't be done over IPMI to some microcontroller or
>>> dedicated external component, for the case of fans and chassis
>>> components and tedious other stuff.
>>
>> Primarily because people want solutions that aren't tied to having an
>> entirely separate computer running its own embedded OS.
> 
> Even though it is almost an absolutely hard requirement for a
> production server environment to have some kind of out of band,
> lights-out management implementation?

Most v8 server systems will have a full TEE running underneath, or
separate management controller cores that do the management. Or both.
There are many of us with an interest in seeing a strong Open Source TEE
available that can be consumed by those wanting to implement various
Secure World features on server systems using FLOSS.

Btw, for the record, I have (once again) had many calls with many folks
over the last week, impressing upon them the need to (once again) get
the standardization stuff more openly accessible to everyone. All I can
say is that I am "happy" to be typecast (if really necessary) as some
Dr. Evil character, if that makes people feel better about life, but I
am trying to get those involved in these pieces to be more public. My
monocle wearing white cat (Mr. Bigglesworth) sends greetings.

Jon.
