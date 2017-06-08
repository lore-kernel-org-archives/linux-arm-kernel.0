From: dave.hansen@intel.com (Dave Hansen)
Date: Thu, 8 Jun 2017 10:19:52 -0700
Subject: [PATCH v3] mm: huge-vmap: fail gracefully on unexpected huge vmap
 mappings
In-Reply-To: <CAKv+Gu9Wp06Nk33CVFr5W51gnsjaRsf0fQJOS4RWbHfRP+KEcg@mail.gmail.com>
References: <20170608113548.24905-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9Wp06Nk33CVFr5W51gnsjaRsf0fQJOS4RWbHfRP+KEcg@mail.gmail.com>
Message-ID: <2f5358b4-b1a7-f51d-ae47-5faa93e1e1d7@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2017 04:36 AM, Ard Biesheuvel wrote:
> @@ -287,10 +288,10 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
>         if (p4d_none(*p4d))
>                 return NULL;
>         pud = pud_offset(p4d, addr);
> -       if (pud_none(*pud))
> +       if (pud_none(*pud) || WARN_ON_ONCE(pud_huge(*pud)))
>                 return NULL;
>         pmd = pmd_offset(pud, addr);
> -       if (pmd_none(*pmd))
> +       if (pmd_none(*pmd) || WARN_ON_ONCE(pmd_huge(*pmd)))
>                 return NULL;

Seems sane to me.  It might be nice to actually comment this, though, on
why huge vmalloc_to_page() is unsupported.

Also, not a big deal, but I tend to filter out the contents of
WARN_ON_ONCE() when trying to figure out what code does, so I think I'd
rather this be:

	WARN_ON_ONCE(pmd_huge(*pmd));
	if (pmd_none(*pmd) || pmd_huge(*pmd))
		...

But, again, not a big deal.
