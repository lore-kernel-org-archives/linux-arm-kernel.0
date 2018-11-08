From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Nov 2018 10:16:34 +0000
Subject: [PATCH 1/7] arm64: Add static check for pt_regs alignment
In-Reply-To: <20181107215834.GB12248@brain-police>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <1537970184-44348-2-git-send-email-julien.thierry@arm.com>
 <20181107215834.GB12248@brain-police>
Message-ID: <20181108101633.fseoda3dcizrfqrp@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 09:58:35PM +0000, Will Deacon wrote:
> On Wed, Sep 26, 2018 at 02:56:18PM +0100, Julien Thierry wrote:
> > The pt_regs structure's size is required to be a multiple of 16 to maintain
> > the stack alignment upon kernel entries.
> > 
> > Add a static check to ensure this is the case.
> > 
> > Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> > ---
> >  arch/arm64/include/asm/ptrace.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > index 177b851..cc17fad 100644
> > --- a/arch/arm64/include/asm/ptrace.h
> > +++ b/arch/arm64/include/asm/ptrace.h
> > @@ -229,6 +229,8 @@ static inline u64 regs_get_register(struct pt_regs *regs, unsigned int offset)
> >  
> >  	WARN_ON(offset & 7);
> >  
> > +	BUILD_BUG_ON((sizeof (struct pt_regs) % 16 != 0));
> 
> This seems like a fairly random place to put this, and given that it's not
> dependent on context I reckon it would be better to put it in a C file
> rather than in a header that gets included multiple times. I still couldn't
> really find a good place though :/

Perhaps asm-offsets.c, when we define S_FRAME_SIZE?

Thanks,
Mark.
