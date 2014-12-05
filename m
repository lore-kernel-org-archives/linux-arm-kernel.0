From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 5 Dec 2014 13:39:56 +0000
Subject: [PATCH 1/2] arm64: mm: dump: fix shift warning
In-Reply-To: <1417782895-13657-2-git-send-email-mark.rutland@arm.com>
References: <1417782895-13657-1-git-send-email-mark.rutland@arm.com>
 <1417782895-13657-2-git-send-email-mark.rutland@arm.com>
Message-ID: <CAPvkgC023qJ8w9vEFXq63_LrF20Eqs_MeSnJF+VdPyHm1DUUww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2014 at 12:34, Mark Rutland <mark.rutland@arm.com> wrote:
> When building with 48-bit VAs, it's possible to get the following
> warning when building the arm64 page table dumping code:
>
> arch/arm64/mm/dump.c: In function ?walk_pgd?:
> arch/arm64/mm/dump.c:266:2: warning: right shift count >= width of type
>   pgd_t *pgd = pgd_offset(mm, 0);
>   ^
>
> As pgd_offset is a macro and the second argument is not cast to any
> particular type, the zero will be given integer type by the compiler.
> As pgd_offset passes the pargument to pgd_index, we then try to shift
> the 32-bit integer by at least 39 bits (for 4k pages).
>
> Elsewhere the pgd_offset is passed a second argument of unsigned long
> type, so let's do the same here by passing '0UL' rather than '0'.
>

Hi Mark,
Thanks, I must not have spotted that warning earlier.

Acked-by: Steve Capper <steve.capper@linaro.org>
