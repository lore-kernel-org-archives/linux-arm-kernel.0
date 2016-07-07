From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Jul 2016 13:41:30 -0400
Subject: [PATCH 1/9] mm: Hardened usercopy
In-Reply-To: <1467909317.13253.17.camel@redhat.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
 <1467909317.13253.17.camel@redhat.com>
Message-ID: <CAGXu5j+zxyPEfswD-03TDhuzxaG6itKsoc6-15rMuE+Sz3booA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 7, 2016 at 12:35 PM, Rik van Riel <riel@redhat.com> wrote:
> On Wed, 2016-07-06 at 15:25 -0700, Kees Cook wrote:
>>
>> +     /* Allow kernel rodata region (if not marked as Reserved).
>> */
>> +     if (ptr >= (const void *)__start_rodata &&
>> +         end <= (const void *)__end_rodata)
>> +             return NULL;
>>
> One comment here.
>
> __check_object_size gets "to_user" as an argument.
>
> It may make sense to pass that to check_heap_object, and
> only allow copy_to_user from rodata, never copy_from_user,
> since that section should be read only.

Well, that's two votes for this extra check, but I'm still not sure
since it may already be allowed by the Reserved check, but I can
reorder things to _reject_ on rodata writes before the Reserved check,
etc.

I'll see what could work here...

-Kees

>
>> +void __check_object_size(const void *ptr, unsigned long n, bool
>> to_user)
>> +{
>>
>
> --
>
> All Rights Reversed.



-- 
Kees Cook
Chrome OS & Brillo Security
