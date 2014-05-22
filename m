From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 23 May 2014 01:18:31 +0200
Subject: [PATCH v3] clk: shmobile: Add R8A7740-specific clock support
In-Reply-To: <CANqRtoRKW=QyawwVoc31OdwkOowBXky4NtZgPVEW7CwuuR+M=g@mail.gmail.com>
References: <1400682086-5705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <2463693.SJ3Ug7SyHp@avalon>
 <CANqRtoRKW=QyawwVoc31OdwkOowBXky4NtZgPVEW7CwuuR+M=g@mail.gmail.com>
Message-ID: <27468705.y8ueFQY9JC@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Thursday 22 May 2014 20:16:06 Magnus Damm wrote:
> On Thu, May 22, 2014 at 7:22 PM, Laurent Pinchart wrote:
> > On Thursday 22 May 2014 09:37:40 Magnus Damm wrote:
> >> On Thu, May 22, 2014 at 12:41 AM, Laurent Pinchart wrote:
> >> > On Wednesday 21 May 2014 16:21:26 Ulrich Hecht wrote:
> >> >> Driver for the R8A7740's clocks that are too specific to be supported
> >> >> by a generic driver.
> >> >> 
> >> >> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >> > 
> >> > The implementation looks globally sane to me. There's still quite a few
> >> > missing clocks, but there's no hurry in adding support for them at the
> >> > moment. I'd like to get the bindings reviewed by someone outside of our
> >> > team, but that would require making the CPG documentation (or at least
> >> > the block diagram) available. Magnus, is there a chance for that to
> >> > happen ?
> >> 
> >> Regarding documentation, as much as I'd like to see this, in practice it
> >> feels highly unlikely since I'm not in control of the actual data sheet
> >> distribution policy. I believe Emma Mobile series data sheet are
> >> available for public download, but the rest of the SoCs are not
> >> unfortunately.
> >> 
> >> This issue with closed documentation is not specific to r8a7740 though,
> >> so earlier developed CCF implementations included in upstream like
> >> r8a7790, r8a7791, r7s72100 and r8a7779 are in the same state as r8a7740.
> > 
> > Yes they are, although the hardware is simpler in those cases, so there's
> > less potential issues. I don't have a specific concern here, just a
> > feeling of uneasiness coming from publishing DT bindings that can't be
> > properly reviewed by someone out of our team. We're too familiar with the
> > hardware to take a step back and see the bindings from an external point
> > of view, which is why I'd like an external review before committing to
> > any DT binding stability.
>
> I understand that you cannot vouch for the stability of this binding. =)
> 
> And I agree that external review would help in making it stabler quicker.
> 
> > There's of course no reason to delay this patch (well, except for all the
> > other small comments I've made :-)), but if it were me I would mark the
> > corresponding bindings with a big "EXPERIMENTAL" warning.
> 
> We can chose to treat it as relatively experimental if we want to. So
> your warning is fine!
> 
> How long stabilization time would you recommend for this kind of
> thing? I would guess half a year?

I see several main reasons why DT bindings need time to stabilize.

- When implementing support for currently unsupported features of the device 
we could realize that the bindings were designed in a way that makes support 
of new features difficult in a backward-compatible way.

- When a new SoC comes out we could realize that device features or SoC 
integration parameters that we thought were set in stone are actually not, and 
don't play well with the current bindings.

- When other vendors implement bindings for similar devices we could realize 
that common needs would benefit from common bindings.

At least the last reason advocates for experimental DT bindings being 
committed to the mainline kernel, to make it possible for developers to 
identify common needs between vendors.

In this specific case I'm mostly concerned about the first reason, as I don't 
expect our new SoCs to come out with a CPG nearly-but-not-quite-identical to 
the r8a7740's. The stabilization time would thus depend entirely on our effort 
to implement support for the currently missing features. Integration with MSTP 
is the main one (the overlapping register ranges problem I've mentioned before 
is a good example, even if it doesn't cause a real problem today), and support 
for at least some of the missing clocks would be good as well. If we actively 
maintain this driver I expect that one or two kernel releases should be enough 
for the bindings to stabilize.

Please feel free to also discuss the other reasons I've mentioned above and 
how you would like to see them being handled.

-- 
Regards,

Laurent Pinchart
