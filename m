From: rafael.j.wysocki@intel.com (Rafael J. Wysocki)
Date: Thu, 8 Oct 2015 02:11:38 +0200
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <1444129723.4674.236.camel@infradead.org>
References: <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <1443033714.74600.18.camel@infradead.org> <560310EA.2070805@intel.com>
 <1443042212.74600.30.camel@infradead.org> <56033C10.2040708@linaro.org>
 <1443082579.74600.48.camel@infradead.org>
 <20150924103152.GG13823@e104818-lin.cambridge.arm.com>
 <1443095558.74600.84.camel@infradead.org>
 <20150924151546.GJ13823@e104818-lin.cambridge.arm.com>
 <1443118238.74600.117.camel@infradead.org>
 <20150925152848.GQ13823@e104818-lin.cambridge.arm.com>
 <560C993D.8090308@redhat.com> <D23813FF.33566%charles.garcia-tobin@arm.com>
 <1444129723.4674.236.camel@infradead.org>
Message-ID: <5615B4BA.2060002@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/6/2015 1:08 PM, David Woodhouse wrote:
> On Mon, 2015-10-05 at 17:20 -0700, Charles Garcia-Tobin wrote:
>> it in ACPI circles
>> unless we had wider agreement among OSs to use it. AFAIK PRP00001 has not
>> actually been approved yet in the specification forum, and that it in
>> itself is more of a concern for me,as the code has been pushed upstream.
> Why would that be a concern? In that context it's just one device ID.
> Individual devices don't *need* to be approved. OK, the 'PRP' vendor
> prefix is not officially assigned but that's really a trivial piece of
> bureaucracy.
>
>> I guess it?s up to Catalin, but disabling for ARM seems like a good idea
>> right now, another option is to add tests to FWTS.
> I understand the motivation to avoid embracing a whole bunch of crappy
> bindings. But I think that eschewing PRP0001 is the wrong technical
> approach to achieving that.
>
> It has false negatives ? as soon as you have a *single* existing DT
> binding, perhaps something as simple as the serial port bindings from
> the CHRP days, you'll be in a situation where you can't use that.
> I've *got* hardware where I need to advertise a serial port with a
> clock-frequency property because it *isn't* compatible with PNP0501.
>
> And it has false positives ? there's nothing to prevent people from
> doing ACPI-style bindings with crappy device bindings which also aren't
> approved.
>
> I think it's utterly na?ve to believe that simply avoiding the use of
> PRP0001 + compatible for matching is going to have *any* significant
> beneficial effect whatsoever. It only makes life harder for all
> concerned.
>
> Perhaps a better approach would be to introduce something like
> CONFIG_UNAPPROVED_BINDINGS (which can't be set on ARM64), and those
> drivers which use bindings that *aren't* approved by Catalin's crack
> team of reviewers need to depend on !UNAPPROVED_BINDINGS. To be honest,
> I still think even *that* is somewhat na?ve, but it's still a better
> way of implementing what you're actually trying to achieve, however
> optimistic you have to be to think it'll ever work in practice.
>

Also, let me mention one case PRP0001 is intended for that seems to be real.

Say there is a piece of hardware that becomes so popular that the 
majority of vendors include it in their SoCs.  Now all of them have to 
allocate ACPI/PNP device IDs for that and (without PRP0001) all of those 
device IDs need to go into the driver for that thing to make it work on 
all of the SoCs in question.  As a result, the mainline kernel doesn't 
work on new SoCs with ACPI without modifications, although it works on 
all of them with DT in principle.  Moreover, unmodified binary distro 
kernels don't work on new SoCs with ACPI, although they may work just 
fine on them with DT (that sort of seems to be a case that Red Hat may 
be interested in for one example, but I may be wrong here).

In theory, that may be addressed by allocating a "master" ACPI/PNP 
device ID for that device and listing it in the device's _CID on all of 
the SoCs in question, but then it isn't particularly clear who's going 
to be responsible for allocating that device ID and "propagating" the 
knowledge of it to everybody interested to make things consistent.  
[Side note: Using a different vendor's device ID in a _CID is quite 
questionable, so the "master" one would need to be something "vendor 
agnostic" if that makes sense at all ...]

Let alone the fact that PRP0001 is actually quite useful at the 
prototyping stage when it is premature to allocate a new device ID just 
yet.  Taking that to the extreme, if someone whittles a board in his or 
her garage and wants to use it to drive their homemade grass watering 
system, having to invent a new device ID and put it into the existing 
driver that otherwise doesn't require any modifications is ... you know 
what I mean.

All in all, I'd recommend some caution to ensure that the baby is not 
going away along with the bath water here.

Thanks,
Rafael
