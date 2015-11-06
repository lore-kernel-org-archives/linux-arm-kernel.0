From: keescook@chromium.org (Kees Cook)
Date: Fri, 6 Nov 2015 15:47:29 -0800
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <7hmvuqg3f1.fsf@deeprootsystems.com>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
 <20151105094615.GP8644@n2100.arm.linux.org.uk>
 <563B81DA.2080409@redhat.com>
 <20151105162719.GQ8644@n2100.arm.linux.org.uk>
 <563BFCC4.8050705@redhat.com>
 <CAGXu5jLS8GPxmMQwd9qw+w+fkMqU-GYyME5WUuKZZ4qTesVzCQ@mail.gmail.com>
 <563CF510.9080506@redhat.com>
 <CAGXu5jKLgL0Kt5xCWv-3ZUX94m1DNXLqsEDQKHoq7T=m6P7tvQ@mail.gmail.com>
 <CAGXu5j+Jeg-Cwc7Tr8UeY9vkJLudw07+b=m0h-d9GuSyKiO4QA@mail.gmail.com>
 <CAMAWPa9XvdS+dF78c7Fgs4ekRy7wVnfFT=0A5NLpu0UYaqV7fA@mail.gmail.com>
 <CAGXu5j+U-Q2R1Hw4qSPpFUKz3xyYrASGc5buMJTSy0K-3mWHBA@mail.gmail.com>
 <7h8u6ahm7d.fsf@deeprootsystems.com>
 <CAGXu5jJnjHkkX3y31y5LJFhNrP=A8_BASg2MUR5rwA5MLPeVQg@mail.gmail.com>
 <7hmvuqg3f1.fsf@deeprootsystems.com>
Message-ID: <CAGXu5jLQV9DgUYm6rRzDK9YxxQH1jNuYtDVT+9KK+exXSaYKGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 2:37 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Fri, Nov 6, 2015 at 1:06 PM, Kevin Hilman <khilman@kernel.org> wrote:
>
> [...]
>
>> Well, all the stuff I wrote tests for in lkdtm expect the kernel to
>> entirely Oops, and examining the Oops from outside is needed to verify
>> it was the correct type of Oops. I don't think testing via lkdtm can
>> be done from kselftest sensibly.
>
> Well, at least on arm32, it's definitely oops'ing, but it's not a full
> panic, so the oops could be grabbed from dmesg.

Ah, true, I'm so used to setting "panic on oops" and "reboot on
panic". (But as you mention, some aren't recoverable, or fail
ungracefully.)

> FWIW, below is a log from and arm32 board running mainline v4.3 that
> runs through all the non-panic/lockup tests one after the other without
> a reboot.

This is great, thanks! Comment below, snipping quotes...

> Performing test: CORRUPT_STACK
> [ 1015.817949] lkdtm: Performing direct entry CORRUPT_STACK
> [ 1015.818247] Unable to handle kernel NULL pointer dereference at virtual address 00000000

Successful test! (I should perhaps add some verbosity to the test.)

> Performing test: WRITE_AFTER_FREE
> [ 1018.850276] lkdtm: Performing direct entry WRITE_AFTER_FREE

I wonder if a KASan build would freak out here.

> Performing test: EXEC_DATA
> [ 1020.870248] lkdtm: Performing direct entry EXEC_DATA
> [ 1020.870298] lkdtm: attempting ok execution at c0655294
> [ 1020.875446] lkdtm: attempting bad execution at c0fdc084
> [ 1020.880390] Unable to handle kernel paging request at virtual address c0fdc084
> ...
> Performing test: EXEC_STACK
> [ 1021.879876] lkdtm: Performing direct entry EXEC_STACK
> [ 1021.880043] lkdtm: attempting ok execution at c0655294
> [ 1021.885074] lkdtm: attempting bad execution at ede8fe98
> [ 1021.890110] Unable to handle kernel paging request at virtual address ede8fe98
> ...
> Performing test: EXEC_KMALLOC
> [ 1022.888138] lkdtm: Performing direct entry EXEC_KMALLOC
> [ 1022.888452] lkdtm: attempting ok execution at c0655294
> [ 1022.893675] lkdtm: attempting bad execution at edf06c00
> [ 1022.898853] Unable to handle kernel paging request at virtual address edf06c00
> ...
> Performing test: EXEC_VMALLOC
> [ 1023.898810] lkdtm: Performing direct entry EXEC_VMALLOC
> [ 1023.899173] lkdtm: attempting ok execution at c0655294
> [ 1023.904301] lkdtm: attempting bad execution at f00bb000
> [ 1023.909493] Unable to handle kernel paging request at virtual address f00bb000

Successful tests of the NX memory markings (ARM_KERNMEM_PERMS=y)!

> Performing test: EXEC_USERSPACE
> [ 1024.909068] lkdtm: Performing direct entry EXEC_USERSPACE
> [ 1024.909529] lkdtm: attempting ok execution at c0655294
> [ 1024.914930] lkdtm: attempting bad execution at b6fa3000
> [ 1024.919918] Unhandled prefetch abort: page domain fault (0x00b) at 0xb6fa3000
> ...
> Performing test: ACCESS_USERSPACE
> [ 1025.919130] lkdtm: Performing direct entry ACCESS_USERSPACE
> [ 1025.919586] lkdtm: attempting bad read at b6fa3000
> [ 1025.925131] Unhandled fault: page domain fault (0x01b) at 0xb6fa3000

Successful tests of the PXN/PAN emulation (CPU_SW_DOMAIN_PAN=y)!

> Performing test: WRITE_RO
> [ 1026.929067] lkdtm: Performing direct entry WRITE_RO
> [ 1026.929108] lkdtm: attempting bad write at c0ab0dd0
> Performing test: WRITE_KERN
> [ 1027.939245] lkdtm: Performing direct entry WRITE_KERN
> [ 1027.939398] lkdtm: attempting bad 12 byte write at c06552a0
> [ 1027.944430] lkdtm: do_overwritten wasn't overwritten!

Oops, both failed. I assume CONFIG_DEBUG_RODATA wasn't set.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
