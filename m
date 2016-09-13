From: sf84@laposte.net (Sebastian Frias)
Date: Tue, 13 Sep 2016 12:04:07 +0200
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <20160912165637.GF14165@leverpostej>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net> <20160912165637.GF14165@leverpostej>
Message-ID: <57D7CF17.2050905@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/12/2016 06:56 PM, Mark Rutland wrote:
>> Exactly, that's why to I'm having trouble to understand why there is so much
>> insistence on "getting the DT 100% right", since a HW change could imply
>> that what made 100% sense yesterday, does not today.
>> Since that is a possibility we have to live with, then the "100% right" goal
>> is most likely unachievable.
>> That's different from "backwards compatibility" for which some technique,
>> like alternate descriptions, can be put in place.
> 
> I'm not on about "100% right", but more "a reasonable chance of being
> good enough". 

Ok.

> The latter is extremely difficult to judge when you just
> get a binding document with little or no additional context.

Exactly, that is why I was thinking it would take less "review" time.
Indeed, if there is no driver, why would it matter what those bindings
are?

> Backwards compatibility is with regards to new software supporting old
> bindings. If new HW comes out, we can create new bindings. Old bindings
> should remain supported regardless.

Indeed. So you agree that without a driver, there is no backward compatibility
to maintain (because nothing could break).
Could we then say that in that case, it should not matter that much (if at all)
if the bindings have "a reasonable chance of being good enough"?

Because I'm trying to understand why/how would the "open-source community" be
affected by some DT properties/nodes that are not used by upstream Linux drivers.

Warner proposed 'overlays' to deal with the "open-source community" reticence to
accept such bindings.
Whereas it may be simpler to just find a way to accommodate the integration of
such bindings in a way that everybody wins.
That could take the form of a "staging" DT area, so that the 'overlay' is public.
Just for the sake and benefit of everybody, 3rd parties and open-source community.

>> Could you be more precise on those two issues? Namely:
>> "the effort" and the "lack of benefit for the community"?
> 
> As above, reviewing is tricky. One has to spend the time gaining an
> understanding of a particular piece of hardware, the class of hardware
> it falls in, and also the bigger picture that it fits in. Once you have
> that, you have to review the binding in that context, and that takes
> time and effort.

Yes, but this is based on a binding for which there's a driver.
If there's no driver it should not take that much time, right?

> As things evolve, perhaps mistakes or inconsistencies are found, or new
> ways to generalise things. As that occurs, there is a maintenance burden
> for existing bindings.
> 
> All of that takes time and effort.

Only for bindings for which there is a driver.

Think about this:
- a binding with no driver is submitted and ends up in the tree
(it could be on a staging area if necessary)

- if at a later point somebody attempts to upstream a driver using those
'staging' bindings, the reviewers could say "you are using 'staging' bindings,
please add compatibility with 'staging' and 'standard' bindings", even if that
includes the discussion and review of newly created 'standard' bindings
corresponding to the 'staging' bindings.

- the submitter may even say "there's no need for compatibility for 'staging'
bindings, because they were never used (or other valid reasons)".

What would you think of something like that?

> If, at the end of that, a proprietary vendor driver is using a different
> version of the binding anyway, because "there's no backward
> compatibility to guarantee", then there is no benefit to the document.

No, it would not use a "different version of the binding", because the
binding would be public, i.e.: everything would be on the public DT.

> Even if that proprietary driver does remain stable, the Linux community
> will have done work that only benefits the authors of that driver. We
> would prefer that the results of our efforts are open, and benefit all.

Do you have an example of a binding *not used by Linux* that created enormous
amount of work for the Linux community?

>> I can understand the effort it takes to review a binding and some
>> driver, but if there's no driver, why would it matter if the DT binding is
>> 100% right? Hence, why would it take more effort?
>> Furthermore, if there's no driver, there's no backward compatibility to
>> guarantee. Shouldn't it require less effort?
> 
> I don't follow. If there's no compatibility to guarantee, why do you
> want a binding?

Let's make an abstraction of the word 'binding', 'create a binding', etc. and
just focus on this:
- Somebody submits a DT file that contains properties and nodes that are
*not used* by any Linux driver.
- Said properties and nodes serve as HW description for HW blocks for which
*there is no* Linux driver.

The goal of the above is to use the DT as the authoritative (and single)
source of HW definition.

An alternate solution, as proposed by Warner, is to use 'binary overlays' for
the DT.

> A binding is a form of contract -- if you describe the HW this way, then
> some software will understand it. You can extend a binding over time,
> certainly, but if the baseline of that binding is a moving target, that
> benefits nobody.
> 

The benefit is that in one case (the case where the whole SoC is described
in the DT, regardless of the existence of a Linux driver or not) there is more
information available publicly.

>> I see, although I don't understand how accepting such solution (i.e.: having the
>> information in a different DT) benefits the open-source community, since it
>> basically means that the open-source community settles for less information.
> 
> As with all things, it depends on context. If someone's using a DT to
> describe details of the secure world of a platform with trustzone to a
> secure OS, then not all of that information is relevant to Linux.
> Likewise if configuration details specific to FW are embedded.

Ok, so if the information is not relevant to Linux do you agree that it
should not affect it, and then we could imagine such details being present on
the DT anyway?

> If there's information relevant to a general purpose OS, then I would
> expect it to be described. By the same token, I would expect a general
> purpose OS to actually be making use of the information. In practice,
> we've used Linux as the benchmark for that. That needn't necessarily be
> the case if another OS can demonstrate that the binding is worthwhile --
> ideally we'd have multiple OSs using bindings so as to "keep us honest"
> and free from implementation details.

You mention the case of another OS.
What is the definition of OS in this case?
Because one could say that "FW" or "secure world" could fit that definition,
right?
Or when you talk about "another OS" you think only about other open-source
mainstream OSs, like FreeBSD?

> As I mentioned before, an example would help. The theoretical envelope
> is very large and likely far beyond what you envisage. We need something
> to focus on, or we're arguing about what we conceive differently.
> 

I think we've made progress :-)
Indeed, to me it is clear that what we conceive "differently", is that
"the effort", "lack of benefit for the community", "Old bindings should
remain supported regardless" and "backward compatibility" are considered
with respect to DT *plus* driver, yet the idea is to have DT describe
HW for which there's no upstream driver yet.
Hence most of those considerations should not apply, right?

Best regards,

Sebastian
