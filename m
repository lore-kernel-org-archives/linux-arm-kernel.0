From: james.morse@arm.com (James Morse)
Date: Wed, 24 Aug 2016 16:49:11 +0100
Subject: [PATCH v5 2/3] arm64: vmlinux.ld: Add mmuoff text and data
 sections
In-Reply-To: <CAKv+Gu9x38UjUY6HA2KwZDZssqCAxYE+OiU96eq_ppnVTG=ERA@mail.gmail.com>
References: <1471887319-26702-1-git-send-email-james.morse@arm.com>
 <1471887319-26702-3-git-send-email-james.morse@arm.com>
 <CAKv+Gu9x38UjUY6HA2KwZDZssqCAxYE+OiU96eq_ppnVTG=ERA@mail.gmail.com>
Message-ID: <57BDC1F7.2010306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 23/08/16 14:11, Ard Biesheuvel wrote:
> On 22 August 2016 at 19:35, James Morse <james.morse@arm.com> wrote:
>> Resume from hibernate needs to clean any text executed by the kernel with
>> the MMU off to the PoC. Collect these functions together into a new
>> .mmuoff.text section.
> 
> Wouldn't it be much simpler to move all of this into the .idmap.text
> section? It is not that much code, and they intersect anyway (i.e.,
> some .idmap.text code is only called with the MMU off)

That's an idea, it changes the meaning of the things in that section slightly
but saves multiplying linker sections like this.


>> Data is more complicated, secondary_holding_pen_release is written with
>> the MMU on, clean and invalidated, then read with the MMU off. In contrast
>> __boot_cpu_mode is written with the MMU off, the corresponding cache line
>> is invalidated, so when we read it with the MMU on we don't get stale data.
>> These cache maintenance operations conflict with each other if the values
>> are within a Cache Writeback Granule (CWG) of each other.
>> Collect the data into two sections .mmuoff.data.read and .mmuoff.data.write,
>> the linker script ensures mmuoff.data.write section is aligned to the
>> architectural maximum CWG of 2KB.

>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 659963d40bb4..97c3f36ce30b 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -120,6 +120,9 @@ SECTIONS
>>                         IRQENTRY_TEXT
>>                         SOFTIRQENTRY_TEXT
>>                         ENTRY_TEXT
>> +                       __mmuoff_text_start = .;
>> +                       *(.mmuoff.text)
>> +                       __mmuoff_text_end = .;
> 
> Could you add a define for this like we have for the other ones?

I should have thought of that. If its merged with the idmap this disappears
completely.


> 
>>                         TEXT_TEXT
>>                         SCHED_TEXT
>>                         LOCK_TEXT
>> @@ -185,6 +188,24 @@ SECTIONS
>>         _data = .;
>>         _sdata = .;
>>         RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
>> +
>> +       /*
>> +        * Data written with the MMU off but read with the MMU on requires
>> +        * cache lines to be invalidated, discarding up to a Cache Writeback
>> +        * Granule (CWG) of data from the cache. Keep the section that
>> +        * requires this type of maintenance to be in its own Cache Writeback
>> +        * Granule (CWG) area so the cache maintenance operations don't
>> +        * don't interfere with adjacent data.
>> +        */
>> +       .mmuoff.data.write : ALIGN(SZ_2K) {
>> +               __mmuoff_data_start = .;
>> +               *(.mmuoff.data.write)
>> +       }
>> +       .mmuoff.data.read : ALIGN(SZ_2K) {
>> +               *(.mmuoff.data.read)
>> +               __mmuoff_data_end = .;
>> +       }
>> +
> 
> This looks fine now, with the caveat that empty sections are dropped
> completely by the linker (including their alignment), and so the start
> and end markers may assume unexpected values.
> 
> For instance, if .mmuoff.data.read turns out empty in the build (and I
> am aware this is theoretical), the section will be dropped, and
> __mmuoff_data_end may assume a value that exceeds _edata.

Really?
/me tries it.
... okay that's weird ...


> This is
> actually fine, as long as you put a
> 
> . = ALIGN(SZ_2K);
> 
> before BSS_SECTION() to ensure that the cache invalidation does not
> affect .bss in case .mmuoff.data.read does turn out empty

This can happen because the ALIGN() is attached to a different section, that
could be removed. Is this sufficient?:
>???????.mmuoff.data.write : ALIGN(SZ_2K) {
>??????? ???????__mmuoff_data_start = .;
>??????? ???????*(.mmuoff.data.write)
>???????}
>???????. = ALIGN(SZ_2K);
>???????.mmuoff.data.read : {
>??????? ???????*(.mmuoff.data.read)
>??????? ???????__mmuoff_data_end = .;
>???????}


> (or
> alternatively, put the alignment inside the BSS_SECTION() invocation,
> as I did in my example before)

What worries me about that is the alignment has nothing to do with the BSS. It's
not even anything to do with the 'PECOFF_EDATA_PADDING/_edata' that appears
before it.


Thanks,

James
