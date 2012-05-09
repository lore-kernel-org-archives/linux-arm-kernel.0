From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 May 2012 22:40:40 +0100
Subject: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
 address space.
In-Reply-To: <CAG_NtY_qv-cv=Yd8CBcP4TrNCXJbTgz5WXvAsmCdQFWEotVhrg@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508124116.GE17798@arm.com>
 <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
 <20120508215554.GA18980@n2100.arm.linux.org.uk>
 <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
 <20120509122348.GA30632@n2100.arm.linux.org.uk>
 <CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com>
 <20120509154849.GA10375@n2100.arm.linux.org.uk>
 <CAG_NtY_qv-cv=Yd8CBcP4TrNCXJbTgz5WXvAsmCdQFWEotVhrg@mail.gmail.com>
Message-ID: <20120509214040.GB10375@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 03:44:08PM -0500, Buckley, Bryan wrote:
> On Wed, May 9, 2012 at 10:48 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > On Wed, May 09, 2012 at 06:00:10PM +0530, Shilimkar, Santosh wrote:
> > > On Wed, May 9, 2012 at 5:53 PM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh wrote:
> > > >> The only change done common code is ?clearing 'XN' bit for DRAM
> > > >> region in page table entries. The other change of setting the DACR
> > > >> register is done in ARMv7 specific code.
> > > >
> > > > Yes, XN is an ARMv6+ thing. ?Before ARMv5, it was implementation defined.
> > > >
> > > > Some implementations used the bit to mean "allow writes to update the
> > > > cache". ?Other implementations labelled this bit as "should be zero"
> > > > while others labelled it as "should be one".
> > > >
> > > Good to know.
> > >
> > > > The upshot of this is, we know that having this bit as '1' means that
> > > > all the CPUs we support today work. ?I would be _very_ concerned to
> > > > change this bit to zero as we _really_ don't know how the pre-ARMv6
> > > > CPUs would react.
> > > >
> > > I agree.
> > >
> > > > The solution to this is pretty simple - if ARMv6+ needs a different
> > > > base section mapping value, then we need to extract that from the code
> > > > and pass in the base section mapping value.
> > > >
> > > > I'll sort out a patch later today for this.
> > > Great.
> >
> > This works for my 4430SDP board. ?I haven't booted it on anything else yet.
> > Please can you check that this solves the issue for you? ?Thanks.
> >
> 
> Solves the issue for OMAP5. Thanks Russel and company.

Can I add this attributation for this patch:

Tested-by: Bryan Buckley <bryan.buckley@ti.com>

?
