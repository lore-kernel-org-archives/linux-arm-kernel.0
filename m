From: groeck@google.com (Guenter Roeck)
Date: Tue, 16 Aug 2016 17:26:40 -0700
Subject: Problem with atomic accesses in pstore on some ARM CPUs
In-Reply-To: <CAGXu5jL7nX8aS64QH1Eqo=yvsy_+ad+xQnYVDG_ge-oomAOOxg@mail.gmail.com>
References: <CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A@mail.gmail.com>
 <8f0c9ced-cdc3-ab9b-caee-06fe85e6c1e7@arm.com>
 <CABXOdTfg2T2tZrQOd2S5SjeySAMbfQX0weFuvRXBr2o8Of9nVQ@mail.gmail.com>
 <20160816132103.GD27088@arm.com>
 <CABXOdTfHX_ZB1CuM7hzU5LCZPYdHvBSatN9Nen=rb8r1rXhz-g@mail.gmail.com>
 <20160815221518.GD1120@svinekod>
 <CAMbhsRQiU-UyiCWqjaWNXbhDd0+=Tv_pWoeQkJKJaHC6y4=HwQ@mail.gmail.com>
 <CABXOdTfhXhq6pbqAqGQwHcsCXvyshS8JbDGQCBKxfd-2s=M-fw@mail.gmail.com>
 <CAGXu5jL7nX8aS64QH1Eqo=yvsy_+ad+xQnYVDG_ge-oomAOOxg@mail.gmail.com>
Message-ID: <CABXOdTfVVA-rU96DZvVHCqKB2NxL=zFHMG6dzJk_9RhFsOBCvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 1:50 PM, Kees Cook <keescook@chromium.org> wrote:

[ ... ]

>>> persistent_ram uses atomic ops in uncached memory to store the start
>>> and end positions in the ringbuffer so that the state of the
>>> ringbuffer will be valid if the kernel crashes at any time.  This was
>>> inherited from Android's ram_console implementation, and worked
>>> through armv7.  It has been causing more and more problems recently,
>>> see for example 027bc8b08242c59e19356b4b2c189f2d849ab660 (pstore-ram:
>>> Allow optional mapping with pgprot_noncached) and
>>> 7ae9cb81933515dc7db1aa3c47ef7653717e3090 (pstore-ram: Fix hangs by
>>> using write-combine mappings).
>>>
>>> Maybe it should be replaced with a spinlock in normal ram protecting
>>> writes to the uncached region.
>>
>> The necessary functions already exist, and are used for memory mapped
>> with ioremap() / ioremap_wc(). They were introduced with commit
>> 0405a5cec3 ("pstore/ram: avoid atomic accesses for ioremapped
>> regions"), and the description in that patch sounds quite similar to
>> the current problem. Given that, would it be acceptable to remove
>> buffer_start_add_atomic() and buffer_size_add_atomic(), and always use
>> buffer_start_add_locked() and buffer_size_add_locked() instead ? Those
>> functions still use atomic_set() and atomic_read(), which works fine
>> in my tests. The only difference is that a spinlock in main memory is
>> used instead of atomic_cmpxchg().
>
> I don't see much of a down side to this. ramoops isn't expected to be
> high-bandwidth so trading for a single global lock doesn't really
> bother me.
>

Sounds good. I'll submit a patch to address the problem as suggested above.

Guenter
