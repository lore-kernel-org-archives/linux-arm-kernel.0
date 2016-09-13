From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Sep 2016 14:12:08 +0100
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D7CF17.2050905@laposte.net>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net> <20160912165637.GF14165@leverpostej>
 <57D7CF17.2050905@laposte.net>
Message-ID: <20160913131208.GA23336@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 12:04:07PM +0200, Sebastian Frias wrote:
> Hi Mark,
> 
> On 09/12/2016 06:56 PM, Mark Rutland wrote:
> > The latter is extremely difficult to judge when you just
> > get a binding document with little or no additional context.
> 
> Exactly, that is why I was thinking it would take less "review" time.
> Indeed, if there is no driver, why would it matter what those bindings
> are?

If you believe that the bindings don't matter, then there is absolutely
no reason for them to exist in the first place.

If those binding matter to *anyone*, then those collating the bindings
have some responsibility of stewardship, and that includes
review/maintenance/etc.

Hence, the Linux community cares as stewards of those bindings, and
don't accept bindings they don't understand, for which there is no
obvious user, nor for which the authors claim stability does not matter.
Those go against the aims of DT, and against out responsiblities as
stewards.

I cannot put that any clearer. 

> >> Could you be more precise on those two issues? Namely:
> >> "the effort" and the "lack of benefit for the community"?
> > 
> > As above, reviewing is tricky. One has to spend the time gaining an
> > understanding of a particular piece of hardware, the class of hardware
> > it falls in, and also the bigger picture that it fits in. Once you have
> > that, you have to review the binding in that context, and that takes
> > time and effort.
> 
> Yes, but this is based on a binding for which there's a driver.
> If there's no driver it should not take that much time, right?
> 
> > As things evolve, perhaps mistakes or inconsistencies are found, or new
> > ways to generalise things. As that occurs, there is a maintenance burden
> > for existing bindings.
> > 
> > All of that takes time and effort.
> 
> Only for bindings for which there is a driver.

This is not true for all but the most trivial of hardware, as I stated
previously.

Go and take a look at all the effort that went into sorting out generic
IOMMU bindings, when driver support was written after a large amount of
review to sort out fundamental concepts. We had to sort out fundamentals
before prototype driver code could be written, and while we knew drivers
were coming, an awful lot of review effort came first.


> Think about this:
> - a binding with no driver is submitted and ends up in the tree
> (it could be on a staging area if necessary)
> 
> - if at a later point somebody attempts to upstream a driver using those
> 'staging' bindings, the reviewers could say "you are using 'staging' bindings,
> please add compatibility with 'staging' and 'standard' bindings", even if that
> includes the discussion and review of newly created 'standard' bindings
> corresponding to the 'staging' bindings.
> 
> - the submitter may even say "there's no need for compatibility for 'staging'
> bindings, because they were never used (or other valid reasons)".
> 
> What would you think of something like that?

As above, if they were never used, and potentially wrong, why did they
exist?

Trying to upstream a binding with no user comees with no immediate
benefit, and potentially creates longer-term pain, whereas you can defer
upstreaming a binding until the driver is ready.

Note that I've repeatedly pointed out that the user of the binding
doesn't necessarily have to be linux. However, there does need to be
some demonstration, and commitment to maintaining the principles DT aims
towards (e.g. stability).

> Let's make an abstraction of the word 'binding', 'create a binding', etc. and
> just focus on this:
> - Somebody submits a DT file that contains properties and nodes that are
> *not used* by any Linux driver.
> - Said properties and nodes serve as HW description for HW blocks for which
> *there is no* Linux driver.
> 
> The goal of the above is to use the DT as the authoritative (and single)
> source of HW definition.

I understand that goal, and I've asked for a specific example, as this
is not clear-cut. e.g. there has been work on describing secure devices
for QEMU, but this isn't necessarily something we want to expose Linux
to in general.

> > As with all things, it depends on context. If someone's using a DT to
> > describe details of the secure world of a platform with trustzone to a
> > secure OS, then not all of that information is relevant to Linux.
> > Likewise if configuration details specific to FW are embedded.
> 
> Ok, so if the information is not relevant to Linux do you agree that it
> should not affect it, and then we could imagine such details being present on
> the DT anyway?

Perhaps, or perhaps not. It depends on a number of details, and as I've
said previously I cannot give you a general answer, because there is
none. You must provide a specific case.

> You mention the case of another OS.
> What is the definition of OS in this case?

Generally, I am considering a general purpose OS (e.g. Linux, FreeBSD),
and not a secure-world trusted OS nor firmware (as typically these are
very strongly tied to the platform, and have very different strtuctures
and requirements when compared to a general purpose OS).

That's the conext in which bindings are developed.

> Because one could say that "FW" or "secure world" could fit that definition,
> right?

There's been work on describing things about the secure world in DT for
QEMU. Firmware is typically so device-specific that an upstream/common
DT doesn't really make sense.

Perhaps you have an example of the specific use-case you care about?

> Indeed, to me it is clear that what we conceive "differently", is that
> "the effort", "lack of benefit for the community", "Old bindings should
> remain supported regardless" and "backward compatibility" are considered
> with respect to DT *plus* driver, yet the idea is to have DT describe
> HW for which there's no upstream driver yet.
> Hence most of those considerations should not apply, right?

No.

Bindings themselves should remain stable over time in that they must be
evolved so as to allow software to handle them in a stable fashion,
supporting old and new DTBs.

While a lot of that effort is taken by code, care must also be taken wit
the bindings themselves, and those considerations apply.

Thanks,
Mark.
