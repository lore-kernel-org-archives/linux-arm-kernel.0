From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Dec 2016 15:42:14 +0000
Subject: [PATCH 0/2] Hibernate fixes for 'Fix memmap to be initialized for
 the entire section'
In-Reply-To: <20161202144909.18405-1-james.morse@arm.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <20161202144909.18405-1-james.morse@arm.com>
Message-ID: <CAKv+Gu9AVVPp+UM5pCeYCt4HE-Azijp0iUf0QZv6YKFgAuckYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2016 at 14:49, James Morse <james.morse@arm.com> wrote:
> Patch "arm64: mm: Fix memmap to be initialized for the entire section"
> changes pfn_valid() in a way that breaks hibernate. These patches fix
> hibernate, and provided struct page's are allocated for nomap pages,
> can be applied before [0].
>
> Hibernate core code belives 'valid' to mean "I can access this". It
> uses pfn_valid() to test the page if the page is 'valid'.
>
> pfn_valid() needs to be changed so that all struct pages in a numa
> node have the same node-id. Currently 'nomap' pages are skipped, and
> retain their pre-numa node-ids, which leads to a later BUG_ON().
>
> These patches make hibernate's savable_page() take its escape route
> via 'if (PageReserved(page) && pfn_is_nosave(pfn))'.
>

This makes me feel slightly uneasy. Robert makes a convincing point,
but I wonder if we can expect more fallout from the ambiguity of
pfn_valid(). Now we are not only forced to assign non-existing (as far
as the OS is concerned) pages to the correct NUMA node, we also need
to set certain page flags.
