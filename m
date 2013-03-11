From: gleb@redhat.com (Gleb Natapov)
Date: Mon, 11 Mar 2013 13:02:19 +0200
Subject: [kvmarm] [GIT PULL v2] KVM/ARM Fixes for 3.9-rc1
In-Reply-To: <513DB41F.1010904@arm.com>
References: <CAEDV+gLpqG0GxbCDoUqO2fdwpqLeEd_psaaFWzm2Xi829-zUTQ@mail.gmail.com>
 <f3db22097ee303991fccc64bbf863dd6@localhost>
 <CAEDV+g+ATCr3Hd+VjwLW7tgbJ9Cq4eaC49ZFO-1jB=grAVR49w@mail.gmail.com>
 <fd46d1c4746530d6c705dba843c848ea@localhost>
 <20130307190900.GB15854@amt.cnet>
 <600b4cf22f05ccd66c8f6e18eaaf75c4@localhost>
 <CAEDV+gL_nMCw-1JK+L0W_X=T9q8gEo6xhC9trXHv84YjJ7OiGA@mail.gmail.com>
 <513DB41F.1010904@arm.com>
Message-ID: <20130311110219.GF31619@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 10:38:23AM +0000, Marc Zyngier wrote:
> On 08/03/13 19:26, Christoffer Dall wrote:
> > On Thu, Mar 7, 2013 at 7:12 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >> On Thu, 7 Mar 2013 16:09:00 -0300, Marcelo Tosatti <mtosatti@redhat.com>
> >> wrote:
> >>> On Thu, Mar 07, 2013 at 07:57:23AM +0100, Marc Zyngier wrote:
> >>>> On Wed, 6 Mar 2013 20:40:00 -0800, Christoffer Dall
> >>>> <cdall@cs.columbia.edu>
> >>>> wrote:
> >>>>> On Wed, Mar 6, 2013 at 7:54 PM, Marc Zyngier <marc.zyngier@arm.com>
> >>>> wrote:
> >>>>>> On Wed, 6 Mar 2013 16:31:48 -0800, Christoffer Dall
> >>>>>> <cdall@cs.columbia.edu>
> >>>>>> wrote:
> >>>>>>
> >>>>>> Hi Christoffer,
> >>>>>>
> >>>>>>>
> >>>>>>> Please pull these KVM/ARM fixes mostly centered around preparation
> >>>>>>> for
> >>>>>>> Marc's ARMv8 KVM work.
> >>>>>>
> >>>>>> Can we please hold on that for a while? asm-offset.c is usually a
> >>>>>> candidate for merge conflicts as people start pushing patches post
> >>>> merge
> >>>>>> window, and it would make sense to see what is happening in that
> >>>>>> space.
> >>>>>>
> >>>>> Sure, when would you see this happen exactly?
> >>>>
> >>>> Usually, by -rc5 we have a pretty good idea of what is going in. Also,
> >>>> putting things into -next is a good way to detect potential problems.
> >>>>
> >>>> Oh, and keeping linux-arm-kernel into the loop. Most ARM developers
> >> don't
> >>>> follow the KVM lists.
> >>>>
> >>>>         M.
> >>>
> >>> Mark, can you please be more verbose on the reason for this request?
> >>
> >> arch/arm/kernel/asm-offset.c, being an ARM core file, is often the
> >> location of merge conflicts. And because arch/arm sees a lot more churn
> >> than any other architecture, we have the policy of dealing with conflicts
> >> before they hit Linus.
> >>
> >> We usually deal with that by providing stable branches that will contain
> >> the "offending" patches, and on which others can base their developments.
> >>
> >> This is why I suggested holding on this pull request until we got a better
> >> view of what potential merge conflicts we get with this patches. This
> >> shouldn't prevent the patches from entering -next though, as this would
> >> help detecting the above conflicts.
> >>
> > So I think you need to explain me a little more carefully how the
> > 'usually' applies in this case. This is just a pull request to the
> > kvm/master branch - it's not to Linus or ARM-specific. The only thing
> > is that we touch asm-offsets.c.
> 
> Yes, and that's the issue. Core changes to the ARM code usually goes
> through RMK in order to avoid conflicts. This is a long established
> policy. It could be another tree (arm-soc, for example), but that's the
> general idea.
> 
> At least getting an Ack from Russell so he knows about this patch seems
> to be the minimum we could do.
> 
Definitely.

Sometimes we have similar situation on x86 when some x86 KVM feature
requires non trivial change to core x86 code. We usually resolve it
in one of three ways. If KVM change is small and does not depend on
anything in kvm.git:next it can go through Ingo's tip tree along with
core change that it requires, or if core change is small it goes via KVM
tree with proper ACKs from x86 maintainers, or core changes go into Ingo's
non-rebase tree, the tree is merged into kvm.git:next and KVM changes are
applied on top. The disadvantage of the last approach is that we need to
wait before Linus pulls from Ingo before sending him KVM pull request,
but usually Ingo is the first to send pull requests anyway :) Of course
approach used is explicitly coordinated between KVM and x86 maintainers.

The point is that situation will not resolve itself by -rc5 magically,
so we need to solve it proactively. Can the patch series be separated
in such a way that changes to asm-offsets.c goes through rmk tree and
rest goes through kvm?

--
			Gleb.
