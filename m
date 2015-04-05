From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 5 Apr 2015 15:39:34 +0200
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
References: <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth> <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com> <551F186B.90608@gmail.com>
 <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
Message-ID: <20150405133934.GC9186@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Apr 05, 2015 at 06:13:47AM +0200, Matthijs van Duin wrote:
> On 4 April 2015 at 00:52, Tony Lindgren <tony@atomide.com> wrote:
> > Right, it affects n900 for sure. My point is that it also seems to
> > affect 37xx versions not listed to suffer from this issue.
> 
> They shouldn't... erratum 430973 only affected Cortex-A8 r1, and the
> dm37xx should have an r3p2 right?
> 
> A word of caution though: at least on the DM814x and AM335x, secure
> ROM sets bit 6 (IBE) in the Auxiliary Control Register, thereby
> enabling BTB invalidate instructions (which normally execute as nops).
> This is presumably a leftover of the erratum 430973 workaround, but it
> means there is a risk of running afoul of erratum 687067 if BTB
> invalidate by MVA instructions are actually used.
> 
> I would actually suggest clearing IBE if it set on Cortex-A8 r2 or
> later processors and a secure monitor call is available to do so
> (there is on the DM814x and AM335x, dunno about the 37xx), also for
> performance reasons: BTB invalidates are quite expensive instructions
> (when enabled).

So if I understand the issue correct, it would be ok to enable the
430973 workaround in cpu_v7_switch_mm for arm multiplatform kernels
(mcr p15, 0, r2, c7, c5, 6 @ flush BTAC/BTB). On unaffected
Cortex-A8 platforms the IBE bit should be unset (resulting in a nop
instead of the BTB flush).

So assuming, that the same is true for non Cortex-A8 platforms: Can
the workaround simply be enabled by default if CPU_V7 is selected?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150405/5a89f92c/attachment.sig>
