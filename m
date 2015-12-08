From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Dec 2015 10:51:52 +0000
Subject: ARM64: kernel oops in 4.4-rc4+
In-Reply-To: <20151208103013.GA19612@arm.com>
References: <CACVXFVPnmKzv-mnDyjOnoQtxZ4kyWLtkymK1XhDThO8ibi7f7w@mail.gmail.com>
 <20151208103013.GA19612@arm.com>
Message-ID: <20151208105152.GB19612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 10:30:13AM +0000, Will Deacon wrote:
> On Tue, Dec 08, 2015 at 02:30:33PM +0800, Ming Lei wrote:
> > The attached kernel oops can be triggered immediately after
> > running the following command on APM Mustang:
> > 
> >         $stress-ng --all 8 -t 10m
> > 
> > [1] kernel oops log
> > stress-ng: info:  [5220] 5 failures reached, aborting stress process
> > [  265.782659] kernel BUG at ./arch/arm64/include/asm/pgtable.h:282!
> 
> Yikes, this means we're replacing a writable pte with a clean pte, so
> there's a potential race w/ hardware DBM.
> 
> Could you dump pte and *ptep please?

I tried running this on my Juno and pretty quickly saw the OOM killer
coming in. Perhaps, in your case, pte is a swap entry and its confusing
the checks (so pte_dirty/pte_young are looking at random bits of the
file offset)?

Anyway, I'll wait for you to dump those values.

Will
