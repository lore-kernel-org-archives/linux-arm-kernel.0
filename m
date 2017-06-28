From: keescook@chromium.org (Kees Cook)
Date: Wed, 28 Jun 2017 10:52:55 -0700
Subject: [PATCH v10 1/3] x86/syscalls: Check address limit on user-mode
 return
In-Reply-To: <CAGXu5j+byHUn_rb9jOTZqMYrc4ngmDj=a3k8QRTYrZYNSjhCkw@mail.gmail.com>
References: <20170615011203.144108-1-thgarnie@google.com>
 <CAGXu5j+byHUn_rb9jOTZqMYrc4ngmDj=a3k8QRTYrZYNSjhCkw@mail.gmail.com>
Message-ID: <CAGXu5jKrJv0y70e5JiafKGcGzWoJPZM_HruZ=Y0rM1m0J4tZAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 1:24 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jun 14, 2017 at 6:12 PM, Thomas Garnier <thgarnie@google.com> wrote:
>> Ensure the address limit is a user-mode segment before returning to
>> user-mode. Otherwise a process can corrupt kernel-mode memory and elevate
>> privileges [1].
>>
>> The set_fs function sets the TIF_SETFS flag to force a slow path on
>> return. In the slow path, the address limit is checked to be USER_DS if
>> needed.
>>
>> The addr_limit_user_check function is added as a cross-architecture
>> function to check the address limit.
>>
>> [1] https://bugs.chromium.org/p/project-zero/issues/detail?id=990
>>
>> Signed-off-by: Thomas Garnier <thgarnie@google.com>
>
> Thanks for reworking this series!
>
> The bad state correctly BUGs under the LKDTM test:
>
> [   21.171586] lkdtm: Performing direct entry CORRUPT_USER_DS
> [   21.172791] lkdtm: setting bad task size limit
> [   21.173742] ------------[ cut here ]------------
> [   21.174641] kernel BUG at ./include/linux/syscalls.h:220!
> ...
> [   21.193166] Call Trace:
> [   21.193617]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> [   21.194443]  entry_SYSCALL64_slow_path+0x25/0x25
>
>
> Tested-by: Kees Cook <keescook@chromium.org>

Is everyone happy with this patch for x86? Does this need anything
more/different?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
