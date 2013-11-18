From: jonathan@jonmasters.org (Jon Masters)
Date: Mon, 18 Nov 2013 00:19:18 -0500
Subject: ACPI vs DT at runtime
In-Reply-To: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
Message-ID: <5289A356.4060004@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, thanks for starting this thread. Mark, thanks for the followup.

Comments on both inline, below. But before I reply to the specific
points, let me add that this is clearly an emotional topic for many.
There are a great many companies involved in ARMv8 on servers, and a
great many have yet to say anything in public. I am trying to strike a
balance constantly by being fair to those who have announced and those
who have yet to do so. But regardless, we have one chance here to make a
good server platform that can challenge the incumbent architectures. If
I weren't utterly convinced of that, and of the need for such standards
as UEFI and ACPI, then I wouldn't be so vocal about it. Given who is
involved in this space, regardless of a decision to adopt ACPI now or
later, it is coming. It can be done right now, or not.

I (and others) pushed 3 years ago for the adoption of ACPI. Dong, and
others instigated the legal processes that resulted in the movement of
ACPI under UEFI Forum recently, to become a fully open standard that can
be shaped - both by the Linux community, and by others. ACPI.next will
benefit from the same development process that has shaped UEFI standards
over the past few years, and most people here can easily get involved in
shaping that standard - as they can on x86 as well now.

I am pushing for a few other things to become public that will help to
explain why ACPI is being adopted and provide a standardized description
of the ways in which it will be used/consumed.

On 11/15/2013 04:57 AM, Mark Rutland wrote:
> On Fri, Nov 15, 2013 at 01:44:10AM +0000, Olof Johansson wrote:
>> The more I start to see early UEFI/ACPI code, the more I am certain
>> that we want none of that crap in the kernel. It's making things
>> considerably messier, while we're already very busy trying to convert
>> everything over and enable DT -- we'll be preempting that effort just
>> to add even more boilerplate everywhere and total progress will be
>> hurt.

Firstly, I would note that I don't expect DeviceTree to go away. Only on
server class systems. I expect all server class ARMv8 systems in the
Enterprise/Cloud environment to boot using UEFI and ACPI. This is
certainly the case of most future design starts already underway. These
can either be supported properly, or not, but ignoring the impending
ACPI systems isn't practical. Translation won't work reliably either.

For the record, I did suggest to Applied that the first posting of that
SATA driver not have the ACPI bits in (since we know it needs cleaning
up to use the key/value approaches already discussed, and so on), but
after chatting with Loc about it, it seemed reasonable to use the
opportunity to start a discussion - which seems to be on cue here.

<snip>

> I'm of the opinion that the only way we should support ACPI is as a
> first-class citizen.

There really isn't another way to do it in my opinion.

> We don't need to modify every driver and subsystem
> to support ACPI, only those necessary to support the minimal set of
> platforms using ACPI. ACPI is new in the arm space, and we can enforce
> quality standards on ACPI _now_ above what we're allowing for DT, and
> avoid future problems.

This is key. It's not going to be ACPI everywhere. It's going to be ACPI
on server class systems. And later, maybe some client systems. But the
big push is from the server crowd. We need to build systems that in 5-10
years time can still boot an older kernel. This can't be done without a
standardized/versioned enumeration/discovery mechanism like ACPI that
has an API enshrined in stone as far as compatibility. Device Tree is
wonderful, anyone can make a binding and use it. Or change the binding
in the next kernel release. Or...this doesn't work in the server space.
Server platforms aren't vertically welded shut like in the embedded
space, where DeviceTree has brought all kinds of benefits for those
building with a single kernel for many different targets, but has also
seen a huge amount of churn from one kernel to the next. If I counted
the number of times I've been told "just update your dtb"...then I would
be shivering in the corner a sadden wreck. You can't "just update your
dtb" on a server class system. You shouldn't.

But anyway, emotional plea aside, a very large number of ACPI systems
are coming. Yes, I've been pushing to get existing players to switch,
but that's because I know what is coming. And if you want certain other
players to appear in this space, you'll need to have ACPI for them, too.

> There may even be things which we don't have to deal with at all on ACPI
> systems as used in servers (e.g. clock management), but perhaps we will
> if people see value in those elements.
> 
>> The server guys really want UEFI for their boot protocols,
>> installation managers, etc, etc. That's fine, let them do that, but
>> that doesn't mean we need to bring the same APIs all the way into the
>> kernel.
>>
>> So, I'm strongly urging that whatever the server guys try to do, it
>> will in the end result in the ACPI data being translated into DT
>> equivalents, such that the kernel _only_ needs to handle data via DT.
> 
> I'm not sure that translating ACPI tables to dt makes any sense. If AML
> is used (even sparingly), I do not believe that we can do any sensible
> conversion to device tree. My understanding is that AML includes
> functionality for modifying ACPI tables, and I don't see how we can
> possibly support that without having to add a lot of boilerplate to all
> the code handling AML to add a device tree backend...

AML includes code that is runtime interpreted, for things like power
button emulation and the like. You can't just translate this. This comes
up every few years - it's impractical. You'll end up having to ship both
DTB and ACPI tables for a system. Which means two tables for a platform
vendor to get right. You know what will happen - only one table with be
correct. Perhaps it seems that it will be the DTB that is more correct,
and this might be true this week, but by 2016 I *guarantee* you that the
ACPI table will be the one winning.

>> Just like PowerPC scrapes the OpenFirmware client interface to build a
>> flat device tree, we should add a pre-boot stage that scrapes
>> ACPI/UEFI data and constructs an appropriate device-tree. We can still
>> bring over ACPI methods and represent those in the DT, but we should
>> _not_ have two native interfaces.
> 
> I'm not sure the two cases are comparable. The format of the FDT was
> designed to encode the data structure used by OpenFirmware, and thus the
> two map to each other pretty well. I do not believe that mapping from
> ACPI tables to an FDT blob is anywhere near as simple, and as I mention
> above I do not believe that we can just copy over the ACPI methods in
> isolation.

Indeed. OpenFirmware and DeviceTree share an ancestry. I was pushing to
create DeviceTree back in '04 or '05 when I was working on a ppc4xx
Xilinx port and I thought there was a better way than their HAL, then
noticed that ppc64's boot protocol always created a blob and kexec'd
(for same code path regardless) itself during boot. True. So I love the
concept of DeviceTree on embedded platforms without real firmware. But
it smells a lot like OpenFirmware's tables for *very good reason*.
ACPI's DSDT is the equivalent in terms of description data, but ACPI
goes way, way beyond the level of just describing platform hardware.

<snip>

> I think that trying to shoe-horn ACPI-derived information into device
> tree is fundamentally the wrong approach. I don't think it encourages
> best practices, and I don't think it's beneficial to the long term
> health of Linux or the ecosystem as a whole.

It's going to be a messy thing to even attempt. Look, I wish we had a
time machine and could have done this whole thing years ago, but I'm not
sure it would have gone differently. ACPI is something a lot of people
emotionally hate. In the Enterprise space myself and others *need* it
(along with UEFI) to have a scalable solution that doesn't result in an
onslaught of customer support calls, which a non-standards body backed
moving target of DTB will do. And besides all of the big boys are going
to be using ACPI whether it's liked much or not.

Jon.
