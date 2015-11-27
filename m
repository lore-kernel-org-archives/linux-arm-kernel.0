From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Fri, 27 Nov 2015 11:12:28 +0300
Subject: [PATCH RFT] arm64: kasan: Make KASAN work with 16K pages + 48 bit
 VA
In-Reply-To: <CAKv+Gu_L1shTWp_5KydCW97Z6TbeXEB9gjmb2oUSuCHfC29M9A@mail.gmail.com>
References: <1448543686-31869-1-git-send-email-aryabinin@virtuozzo.com>
 <CAKv+Gu_L1shTWp_5KydCW97Z6TbeXEB9gjmb2oUSuCHfC29M9A@mail.gmail.com>
Message-ID: <5658106C.10207@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2015 07:40 PM, Ard Biesheuvel wrote:
> On 26 November 2015 at 14:14, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>> Currently kasan assumes that shadow memory covers one or more entire PGDs.
>> That's not true for 16K pages + 48bit VA space, where PGDIR_SIZE is bigger
>> than the whole shadow memory.
>>
>> This patch tries to fix that case.
>> clear_page_tables() is a new replacement of clear_pgs(). Instead of always
>> clearing pgds it clears top level page table entries that entirely belongs
>> to shadow memory.
>> In addition to 'tmp_pg_dir' we now have 'tmp_pud' which is used to store
>> puds that now might be cleared by clear_page_tables.
>>
>> Reported-by: Suzuki K. Poulose <Suzuki.Poulose@arm.com>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> 
> I would argue that the Kasan code is complicated enough, and we should
> avoid complicating it even further for a configuration that is highly
> theoretical in nature.
> 
> In a 16k configuration, the 4th level only adds a single bit of VA
> space (which is, as I understand it, exactly the issue you need to
> address here since the top level page table has only 2 entries and
> hence does not divide by 8 cleanly), which means you are better off
> using 3 levels unless you *really* need more than 128 TB of VA space.
> 
> So can't we just live with the limitation, and keep the current code?
 

No objections from my side. Let's keep the current code.
