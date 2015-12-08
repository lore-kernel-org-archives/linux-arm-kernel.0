From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Dec 2015 13:49:52 +0000
Subject: ARM64: kernel oops in 4.4-rc4+
In-Reply-To: <CACVXFVPgTPYzHj0E7cSx=X+=t=0Am_yBSk6FnTZHeG0hyY6ipg@mail.gmail.com>
References: <CACVXFVPnmKzv-mnDyjOnoQtxZ4kyWLtkymK1XhDThO8ibi7f7w@mail.gmail.com>
 <20151208103013.GA19612@arm.com>
 <CACVXFVPgTPYzHj0E7cSx=X+=t=0Am_yBSk6FnTZHeG0hyY6ipg@mail.gmail.com>
Message-ID: <20151208134951.GI19612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 09:08:32PM +0800, Ming Lei wrote:
> On Tue, Dec 8, 2015 at 6:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Dec 08, 2015 at 02:30:33PM +0800, Ming Lei wrote:
> >> The attached kernel oops can be triggered immediately after
> >> running the following command on APM Mustang:
> >>
> >>         $stress-ng --all 8 -t 10m
> >>
> >> [1] kernel oops log
> >> stress-ng: info:  [5220] 5 failures reached, aborting stress process
> >> [  265.782659] kernel BUG at ./arch/arm64/include/asm/pgtable.h:282!
> >
> > Yikes, this means we're replacing a writable pte with a clean pte, so
> > there's a potential race w/ hardware DBM.
> >
> > Could you dump pte and *ptep please?
> 
> They are dumped as so:
> 
> set_pte_at: addr 470000, ptep fffffe00bc870238, *ptep 680047348a0bd3,
> pte 680047348a0fd3

Thanks for dumping these.

It looks like we're trying to set the access flag in the pte, so its
got nothing to do with swp entries (although they may well be broken
anyway with these BUG_ONs). With H/W DBM enabled, we shouldn't be doing
software management of the access flag, so the BUG_ON looks like a red
herring in this case.

I'm not sure on the best fix for this, though. We can either make the
BUG_ON dependent on the hardware supporting DBM or we could override
ptep_set_access_flags to avoid the debug check.

Will
