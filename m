From: sjg@chromium.org (Simon Glass)
Date: Tue, 16 Aug 2011 15:47:24 -0700
Subject: [PATCH v5] ARM: Use generic BUG() handler
In-Reply-To: <CAPnjgZ3x-nTVuoqO4xX5+kzuxZv21A7aAHpu7N4Xj4tCjsMkOA@mail.gmail.com>
References: <1311926200-24806-1-git-send-email-sjg@chromium.org>
	<4E41B19C.3040209@codeaurora.org>
	<CAPnjgZ3x-nTVuoqO4xX5+kzuxZv21A7aAHpu7N4Xj4tCjsMkOA@mail.gmail.com>
Message-ID: <CAPnjgZ1RRuEMNXRdFp=DxDjM6pCL_5R+eVhGnfxt5pybr20fgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Aug 9, 2011 at 3:15 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 07/29/2011 12:56 AM, Simon Glass wrote:
>>> From: Simon Glass <sjg@google.com>
>>>
>>> ARM uses its own BUG() handler which makes its output slightly different
>>> from other archtectures.
>>>
>>> One of the problems is that the ARM implementation doesn't report the function
>>> with the BUG() in it, but always reports the PC being in __bug(). The generic
>>> implementation doesn't have this problem.
>>>
>>> Currently we get something like:
>>>
>>> kernel BUG at fs/proc/breakme.c:35!
>>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>> ...
>>> PC is at __bug+0x20/0x2c
>>>
>>> With this patch it displays:
>>>
>>> kernel BUG at fs/proc/breakme.c:35!
>>> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
>>> ...
>>> PC is at write_breakme+0xd0/0x1b4
>>>
>>> This implementation uses an undefined instruction to implement BUG, and sets up
>>> a bug table containing the relevant information. Many versions of gcc do not
>>> support %c properly for ARM (inserting a # when they shouldn't) so we work
>>> around this using distasteful macro magic.
>>>
>>> v1: Initial version to replace existing ARM BUG() implementation with something
>>> more similar to other architectures.
>>>
>>> v2: Add Thumb support, remove backtrace whitespace output changes. Change to
>>> use macros instead of requiring the asm %d flag to work (thanks to
>>> Dave Martin <dave.martin@linaro.org>)
>>>
>>> v3: Remove old BUG() implementation in favor of this one.
>>> Remove the Backtrace: message (will submit this separately).
>>> Use ARM_EXIT_KEEP() so that some architectures can dump exit text at link time
>>> thanks to Stephen Boyd <sboyd@codeaurora.org> (although since we always
>>> define GENERIC_BUG this might be academic.)
>>> Rebase to linux-2.6.git master.
>>>
>>> v4: Allow BUGS in modules (these were not reported correctly in v3)
>>> (thanks to Stephen Boyd <sboyd@codeaurora.org> for suggesting that.)
>>> Remove __bug() as this is no longer needed.
>>>
>>> v5: Add %progbits as the section flags.
>>
>> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>
>> Can you update the patch in the patch tracker? It would be great to see
>> this in the next merge window.

Hi,

I have done this against 3.1-rc2 and it is here:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7017/1

Please let me know if there are any problems.

Regards,
Simon

>>
>> --
>> Sent by an employee of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>>
>>
>
