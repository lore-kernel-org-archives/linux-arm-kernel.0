From: keescook@chromium.org (Kees Cook)
Date: Wed, 4 Nov 2015 17:13:59 -0800
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <CAGXu5jLdZ_xFyokoXW5ZhUdTXf-O1MBLk83cG_AM_51PxXbH5A@mail.gmail.com>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
 <CAGXu5jLdZ_xFyokoXW5ZhUdTXf-O1MBLk83cG_AM_51PxXbH5A@mail.gmail.com>
Message-ID: <CAGXu5jK69kytOxp1xaojsGO2JXcZ+u0iHuKWD9sis_LFaCUC9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2015 at 5:06 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Nov 4, 2015 at 5:00 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>> Currently, read only permissions are not being applied even
>> when CONFIG_DEBUG_RODATA is set. This is because section_update
>> uses current->mm for adjusting the page tables. current->mm
>> need not be equivalent to the kernel version. Use pgd_offset_k
>> to get the proper page directory for updating.
>>
>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>> ---
>> I found this while trying to convince myself of something.
>> Dumping the page table via debugfs and writing to kernel text were both
>> showing the lack of mappings. This was observed on QEMU. Maybe it's just a
>> QEMUism but if not it probably should go to stable.
>
> Well that's weird! debugfs showed the actual permissions that lacked
> RO? I wonder what changed. I tested this both with debugfs and lkdtm's
> KERN_WRITE test when the patches originally landed.

The comment will need adjusting too. I have a memory of needing to use
current->mm to deal with some crazy errata and handling TLB flushes...

-Kees

-- 
Kees Cook
Chrome OS Security
