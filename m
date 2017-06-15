From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 15 Jun 2017 14:24:39 -0700
Subject: [PATCH v5] mm: huge-vmap: fail gracefully on unexpected huge
 vmap mappings
In-Reply-To: <20170609082226.26152-1-ard.biesheuvel@linaro.org>
References: <20170609082226.26152-1-ard.biesheuvel@linaro.org>
Message-ID: <20170615142439.7a431065465c5b4691aed1cc@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Jun 2017 08:22:26 +0000 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Existing code that uses vmalloc_to_page() may assume that any
> address for which is_vmalloc_addr() returns true may be passed
> into vmalloc_to_page() to retrieve the associated struct page.
> 
> This is not un unreasonable assumption to make, but on architectures
> that have CONFIG_HAVE_ARCH_HUGE_VMAP=y, it no longer holds, and we
> need to ensure that vmalloc_to_page() does not go off into the weeds
> trying to dereference huge PUDs or PMDs as table entries.
> 
> Given that vmalloc() and vmap() themselves never create huge
> mappings or deal with compound pages at all, there is no correct
> answer in this case, so return NULL instead, and issue a warning.

Is this patch known to fix any current user-visible problem?
