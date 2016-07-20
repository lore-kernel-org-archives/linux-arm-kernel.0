From: keescook@chromium.org (Kees Cook)
Date: Wed, 20 Jul 2016 08:31:37 -0700
Subject: [PATCH v3 00/11] mm: Hardened usercopy
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4FD6A3@AcuExch.aculab.com>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <063D6719AE5E284EB5DD2968C1650D6D5F4FD6A3@AcuExch.aculab.com>
Message-ID: <CAGXu5j+QH8Fdk7p6bZV_yMv1puHRxZRu5z45+tKrmLyGBTymFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 2:52 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Kees Cook
>> Sent: 15 July 2016 22:44
>> This is a start of the mainline port of PAX_USERCOPY[1].
> ...
>> - if address range is in the current process stack, it must be within the
>>   current stack frame (if such checking is possible) or at least entirely
>>   within the current process's stack.
> ...
>
> That description doesn't seem quite right to me.
> I presume the check is:
>   Within the current process's stack and not crossing the ends of the
>   current stack frame.

Actually, it's a bad description all around. :) The check is that the
range is within a valid stack frame (current or any prior caller's
frame). i.e. it does not cross a frame or touch the saved frame
pointer nor instruction pointer.

> The 'current' stack frame is likely to be that of copy_to/from_user().
> Even if you use the stack of the caller, any problematic buffers
> are likely to have been passed in from a calling function.
> So unless you are going to walk the stack (good luck on that)
> I'm not sure checking the stack frames is worth it.

Yup: that's exactly what it's doing: walking up the stack. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
