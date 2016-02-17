From: david.brown@linaro.org (David Brown)
Date: Wed, 17 Feb 2016 16:43:06 -0700
Subject: [PATCH] ARM: vdso: Mark vDSO code as read-only
In-Reply-To: <CAGXu5jK22LfvLdMfWz_vbQsJ3bbjSdJrYAp=5yWzD4yRNTTGFQ@mail.gmail.com>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
 <20160216213659.GA47194@davidb.org>
 <CAGXu5j+H63jhcDpHpXK5aWvgUBz=5vB0FK_zRoc+wZEk32B2fg@mail.gmail.com>
 <20160217052010.GA49233@davidb.org>
 <CAGXu5jK22LfvLdMfWz_vbQsJ3bbjSdJrYAp=5yWzD4yRNTTGFQ@mail.gmail.com>
Message-ID: <20160217234306.GA59532@davidb.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 03:00:52PM -0800, Kees Cook wrote:
>On Tue, Feb 16, 2016 at 9:20 PM, David Brown <david.brown@linaro.org> wrote:
>> On Tue, Feb 16, 2016 at 01:52:33PM -0800, Kees Cook wrote:
>>>
>>> On Tue, Feb 16, 2016 at 1:36 PM, David Brown <david.brown@linaro.org>
>>> wrote:
>>>>
>>>> Although the arm vDSO is cleanly separated by code/data with the code
>>>> being read-only in userspace mappings, the code page is still writable
>>>> from the kernel.  There have been exploits (such as
>>>> http://itszn.com/blog/?p=21) that take advantage of this on x86 to go
>>>> from a bad kernel write to full root.
>>>>
>>>> Prevent this specific exploit on arm by putting the vDSO code page in
>>>> post-init read-only memory as well.
>>>
>>>
>>> Is the vdso dynamically built at init time like on x86, or can this
>>> just use .rodata directly?
>>
>>
>> On ARM, it is patched during init.  Arm64's is just plain read-only.
>
>Okay, great. I've added this to my postinit-readonly series (which I
>just refreshed and sent out again...)

However, this distinction between .rodata and .data..ro_after_init is
kind of fuzzy, anyway, since they both get made actually read-only at
the same time (post init).  The patch actually does work fine with the
vDSO page in .rodata, since the patching happens during init.

Is there a possible future consideration to perhaps make .rodata read
only much earlier?

David
