From: keescook@chromium.org (Kees Cook)
Date: Mon, 30 Nov 2015 16:04:36 -0800
Subject: [PATCH v4 1/4] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <20151130160118.e43a2e53a59e347a95a94d5c@linux-foundation.org>
References: <1448578785-17656-1-git-send-email-dcashman@android.com>
 <1448578785-17656-2-git-send-email-dcashman@android.com>
 <20151130155412.b1a087f4f6f4d4180ab4472d@linux-foundation.org>
 <20151130160118.e43a2e53a59e347a95a94d5c@linux-foundation.org>
Message-ID: <CAGXu5jK7UzjBxXKQajxhLv-uLk_xQXR_FHOsmW6RLJNeK_-dZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 4:01 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 30 Nov 2015 15:54:12 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> On Thu, 26 Nov 2015 14:59:42 -0800 Daniel Cashman <dcashman@android.com> wrote:
>>
>> > ASLR  only uses as few as 8 bits to generate the random offset for the
>> > mmap base address on 32 bit architectures. This value was chosen to
>> > prevent a poorly chosen value from dividing the address space in such
>> > a way as to prevent large allocations. This may not be an issue on all
>> > platforms. Allow the specification of a minimum number of bits so that
>> > platforms desiring greater ASLR protection may determine where to place
>> > the trade-off.
>> >
>> > --- a/kernel/sysctl.c
>> > +++ b/kernel/sysctl.c
>> > @@ -1568,6 +1568,28 @@ static struct ctl_table vm_table[] = {
>> >             .mode           = 0644,
>> >             .proc_handler   = proc_doulongvec_minmax,
>> >     },
>> > +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
>> > +   {
>> > +           .procname       = "mmap_rnd_bits",
>> > +           .data           = &mmap_rnd_bits,
>> > +           .maxlen         = sizeof(mmap_rnd_bits),
>> > +           .mode           = 0600,
>> > +           .proc_handler   = proc_dointvec_minmax,
>> > +           .extra1         = (void *) &mmap_rnd_bits_min,
>> > +           .extra2         = (void *) &mmap_rnd_bits_max,
>>
>> hm, why the typecasts?  They're unneeded and are omitted everywhere(?)
>> else in kernel/sysctl.c.
>
> Oh.  Casting away constness.
>
> What's the thinking here?  They can change at any time so they aren't
> const so we shouldn't declare them to be const?

The _min and _max values shouldn't be changing: they're decided based
on the various CONFIG options that calculate the valid min/maxes. Only
mmap_rnd_bits itself should be changing.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
