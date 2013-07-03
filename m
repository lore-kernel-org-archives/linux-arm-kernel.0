From: dserrg@gmail.com (Sergey Dyasly)
Date: Wed, 3 Jul 2013 19:37:52 +0400
Subject: [PATCH v2] ARM: LPAE: don't reject mapping /dev/mem above 4GB
In-Reply-To: <20130702171530.GG24828@arm.com>
References: <1372780685-2528-1-git-send-email-dserrg@gmail.com>
 <20130702171530.GG24828@arm.com>
Message-ID: <20130703193752.f5b76b6f24bcebbdb7fec379@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Jul 2013 18:15:31 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:
> >  int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
> >  {
> > -	return !(pfn + (size >> PAGE_SHIFT) > 0x00100000);
> > +	return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);
> 
> I don't think that's what I suggested. For classic MMU ~PHYS_MASK is 0.
> 

Thanks for your comments!

Indeed, I did some testing today and v2 check doesn't work at all because of
32-bit overflow in case of using '<<' operator. Also, it turned out that v1
doesn't reject mappings > 40 bit in case of LPAE (the same overflow).

I didn't want to additionally define PHYS_MASK_SHIFT, so I came up with
something like:

	return (pfn + (size >> PAGE_SHIFT)) <= (1 + (PHYS_MASK >> PAGE_SHIFT))

I will post v3 tomorrow.

Best regards,
Sergey Dyasly
