From: rientjes@google.com (David Rientjes)
Date: Mon, 25 Jan 2016 18:34:07 -0800 (PST)
Subject: [PATCH 3/4] arm64: let set_memory_xx(addr, 0) succeed.
In-Reply-To: <56A66D28.1080204@redhat.com>
References: <1453561543-14756-1-git-send-email-mika.penttila@nextfour.com>
 <1453561543-14756-4-git-send-email-mika.penttila@nextfour.com>
 <56A66D28.1080204@redhat.com>
Message-ID: <alpine.DEB.2.10.1601251832420.10939@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jan 2016, Laura Abbott wrote:

> On 01/23/2016 07:05 AM, mika.penttila at nextfour.com wrote:
> > From: Mika Penttil? <mika.penttila@nextfour.com>
> > 
> > This makes set_memory_xx() consistent with x86.
> > 
> > Signed-off-by: Mika Penttil? mika.penttila at nextfour.com
> > 
> > ---
> >   arch/arm64/mm/pageattr.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > index 3571c73..52220dd 100644
> > --- a/arch/arm64/mm/pageattr.c
> > +++ b/arch/arm64/mm/pageattr.c
> > @@ -51,6 +51,9 @@ static int change_memory_common(unsigned long addr, int
> > numpages,
> >   		WARN_ON_ONCE(1);
> >   	}
> > 
> > +	if (!numpages)
> > +		return 0;
> > +
> >   	if (start < MODULES_VADDR || start >= MODULES_END)
> >   		return -EINVAL;
> > 
> > 
> 
> I think this is going to conflict with Ard's patch
> lkml.kernel.org/g/<1453125665-26627-1-git-send-email-ard.biesheuvel@linaro.org>
> 
> Can you rebase on top of that?
> 

Also, I think patch 2 and 3 can be folded together since the change is the 
same to both functions.

I think the changelog should be expanded to explain that 
charge_memory_common() with numpages == 0 should be a no-op.

When both of those are done, and it's rebased as requested, feel free to 
add my:

	Acked-by: David Rientjes <rientjes@google.com>
