From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 13 Oct 2016 17:58:06 +0100
Subject: [PATCH v3 1/5] arm64: mm: BUG on unsupported manipulations of
 live kernel mappings
In-Reply-To: <20161013165112.GI21592@e104818-lin.cambridge.arm.com>
References: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
 <1476271425-19401-2-git-send-email-ard.biesheuvel@linaro.org>
 <20161012150428.s4gajqlnnivo6bld@localhost>
 <CAKv+Gu8p06DBaDgmJ3KSSfNVDox=wOTav48kti+Y0gYtQhEC_g@mail.gmail.com>
 <20161013144450.GG21592@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9E27mrC3k37nbGAxo_C6D7_svRFZXXzoP2Rzc+XATm0A@mail.gmail.com>
 <20161013165112.GI21592@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9iakPzFAz0uut4D2upXdpTgodOBW9T40djRgzWOLgO_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 October 2016 at 17:51, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Oct 13, 2016 at 03:48:04PM +0100, Ard Biesheuvel wrote:
>> On 13 October 2016 at 15:44, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Thu, Oct 13, 2016 at 01:25:53PM +0100, Ard Biesheuvel wrote:
>> >
>> > (fixing up alignment to make it readable)
>> >
>>
>> I apologise on Gmail's behalf
>>
>> >> """
>> >> /*
>> >>  * Returns whether updating a live page table entry is safe:
>> >>  * - if the old and new values are identical,
>> >>  * - if an invalid mapping is turned into a valid one (or vice versa),
>> >>  * - if the entry is a block or page mapping, and the old and new values
>> >>  *   only differ in the PXN/RDONLY/WRITE bits.
>> >>  *
>> >>  * NOTE: 'safe' does not imply that no TLB maintenance is required, it only
>> >>  *       means that no TLB conflicts should occur as a result of the update.
>> >>  */
>> >> #define __set_pgattr_is_safe(type, old, new, blocktype) \
>> >>       (type ## _val(old) == type ## _val(new) || \
>> >>        ((type ## _val(old) ^ type ## _val(new)) & PTE_VALID) != 0 || \
>> >>        (((type ## _val(old) & PTE_TYPE_MASK) == blocktype) && \
>> >>         (((type ## _val(old) ^ type ## _val(new)) & \
>> >>        ~(PTE_PXN | PTE_RDONLY | PTE_WRITE)) == 0)))
>> >>
>> >> static inline bool set_live_pte_is_safe(pte_t old, pte_t new)
>> >> {
>> >>       return __set_pgattr_is_safe(pte, old, new, PTE_TYPE_PAGE);
>> >> }
>> >>
>> >> static inline bool set_live_pmd_is_safe(pmd_t old, pmd_t new)
>> >> {
>> >>       return __set_pgattr_is_safe(pmd, old, new, PMD_TYPE_SECT);
>> >> }
>> >>
>> >> static inline bool set_live_pud_is_safe(pud_t old, pud_t new)
>> >> {
>> >>       return __set_pgattr_is_safe(pud, old, new, PUD_TYPE_SECT);
>> >> }
>> >
>> > The set_ prefix is slightly confusing as it suggests (to me) having a
>> > side effect. Maybe pgattr_set_is_safe()?
>> >
>> > But it looks like we make it more complicated needed by using pte_t
>> > instead of pteval_t as argument. How about just using the pteval_t as
>> > argument (and it's fine to call it with pmdval_t, pudval_t as well):
>> >
>> > #define pgattr_set_is_safe(oldval, newval) \
>> >         ...
>>
>> Well, the only problem there is that the permission bit check should
>> only apply to level 3 page mappings (bit[1] == 1) and level 1/2 block
>> mappings (bit[1] == 0), so we would still need two versions
>
> I was suggesting that you only replace the "... & ~modifiable_attr_mask"
> check in your patch to avoid writing it three times. The macro that you
> proposed above does more but it is also more unreadable.
>

Ah ok, fair enough
