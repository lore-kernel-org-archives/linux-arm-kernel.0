From: keescook@chromium.org (Kees Cook)
Date: Tue, 19 Jul 2016 15:55:54 -0700
Subject: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <CAGXu5jJqo55G0tHzbdobEg_rjKvFONQRk7mkPq1JXOd-Hneipw@mail.gmail.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
 <ea4cdd53-7336-63b5-25ed-a397859eca4d@redhat.com>
 <CAGXu5jJqo55G0tHzbdobEg_rjKvFONQRk7mkPq1JXOd-Hneipw@mail.gmail.com>
Message-ID: <CAGXu5j+0RryPNbSeEYcn6o9zTqz4DKZV3XCuRVuus_X9oUfmww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 12:12 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 18, 2016 at 6:52 PM, Laura Abbott <labbott@redhat.com> wrote:
>> On 07/15/2016 02:44 PM, Kees Cook wrote:
>>> +static inline const char *check_heap_object(const void *ptr, unsigned
>>> long n,
>>> +                                           bool to_user)
>>> +{
>>> +       struct page *page, *endpage;
>>> +       const void *end = ptr + n - 1;
>>> +
>>> +       if (!virt_addr_valid(ptr))
>>> +               return NULL;
>>> +
>>
>>
>> virt_addr_valid returns true on vmalloc addresses on arm64 which causes some
>> intermittent false positives (tab completion in a qemu buildroot environment
>> was showing it fairly reliably). I think this is an arm64 bug because
>> virt_addr_valid should return true if and only if virt_to_page returns the
>> corresponding page. We can work around this for now by explicitly
>> checking against is_vmalloc_addr.
>
> Hrm, that's weird. Sounds like a bug too, but I'll add a check for
> is_vmalloc_addr() to catch it for now.

BTW, if you were testing against -next, KASAN moved things around in
copy_*_user() in a way I wasn't expecting (__copy* and copy* now both
call __arch_copy* instead of copy* calling __copy*). I'll have this
fixed in the next version.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
