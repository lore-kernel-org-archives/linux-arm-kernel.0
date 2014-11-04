From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Nov 2014 20:18:49 +0100
Subject: [PATCH v3 15/19] arm/arm64: KVM: add opaque private pointer to
 MMIO accessors
In-Reply-To: <5459155D.3070203@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-16-git-send-email-andre.przywara@arm.com>
 <20141104154414.GN16132@cbox> <54590BDA.3050609@arm.com>
 <5459155D.3070203@arm.com>
Message-ID: <20141104191849.GC16138@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 06:05:17PM +0000, Marc Zyngier wrote:
> On 04/11/14 17:24, Andre Przywara wrote:
> > Hi,
> > 
> > On 04/11/14 15:44, Christoffer Dall wrote:
> >> On Fri, Oct 31, 2014 at 05:26:50PM +0000, Andre Przywara wrote:
> >>> For a GICv2 there is always only one (v)CPU involved: the one that
> >>> does the access. On a GICv3 the access to a CPU redistributor is
> >>> memory-mapped, but not banked, so the (v)CPU affected is determined by
> >>> looking at the MMIO address region being accessed.
> >>> To allow passing the affected CPU into the accessors, extend them to
> >>> take an opaque private pointer parameter.
> >>> For the current GICv2 emulation we ignore it and simply pass NULL
> >>> on the call.
> >>>
> >>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >>
> >> Why does it have to be an opaque private pointer?  Would it not always
> >> be a struct vcpu * or a vcpu_id then?
> > 
> > IIRC Marc suggested this once be more future proof. Also a pointer makes
> > it easier to pass NULL in the GICv2 parts of the code, which makes it
> > more obvious that this value is not used in this case.
> > 
> > Marc, did I miss some more rationale?
> > Does that still hold?
> 
> The main idea was to have a general purpose pointer that you can
> associate with the decoded region. Some form of private context, just
> like we have for a lot of other kernel structures.
> 
> Now, I think having that as a explicit pointer looks truly awful. Can't
> that be folded into struct kvm_exit_mmio that is already passed around?
> It would make some sense that the private context is associated with the
> actual access... I haven't seen how that interacts with the GICv3 code
> though.
> 
Well, the idea with a (void *private) is to have something, which is
*generic* be reusable and extendable, no argument there.

So my question is, are we implementing some generic feature, where
having that extendability makes things better and clearer, or are we
just wrapping an int in a (void *) so we don't have to add another
parameter if sometime in the unknown future we need another additional
piece of information.

There are plenty of examples where you just pass NULL to a typed pointer
or 0 to an int parameter as well.

I'm not trying to fight the idea of a private pointer, I just want to
make sure we do what we can to keep this code somewhat sane, so if we
have a set of functions where we in 75% of the cases pass a vcpu * and
in the other cases don't, then I really think we want a vcpu *
parameter.

-Christoffer
