From: andreyknvl@google.com (Andrey Konovalov)
Date: Tue, 31 Jul 2018 15:23:21 +0200
Subject: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
In-Reply-To: <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
 <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
Message-ID: <CAAeHK+y95YJZ6yEw0icsz7ScFYP=x5V+__8J0BG9T3vyB1J1xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 1:25 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> So the checker reports ~100 different places where a __user pointer
> being casted. I've looked through them and found 3 places where we
> need to add untagging. Source code lines below come from 4.18-rc2+
> (6f0d349d).
>
> Place 1:
>
> arch/arm64/mm/fault.c:302:34: warning: user pointer cast
> current->thread.fault_address = (unsigned long)info->si_addr;
>
> Compare a pointer with TASK_SIZE (1 << 48) to check whether it lies in
> the kernel or in user space. Need to untag the address before
> performing a comparison.
>
> Place 2:
>
> fs/namespace.c:2736:21: warning: user pointer cast
> size = TASK_SIZE - (unsigned long)data;
>
> A similar check performed by subtracting a pointer from TASK_SIZE.
> Need to untag before subtracting.
>
> Place 3:
>
> drivers/usb/core/devio.c:1407:29: warning: user pointer cast
> unsigned long uurb_start = (unsigned long)uurb->buffer;
> drivers/usb/core/devio.c:1636:31: warning: user pointer cast
> unsigned long uurb_start = (unsigned long)uurb->buffer;
> drivers/usb/core/devio.c:1715:30: warning: user pointer cast
> unsigned long uurb_start = (unsigned long)uurb->buffer;
>
> The device keeps list of mmapped areas and searches them for provided
> __user pointer. Need to untag before searching.
>
> There are also a few cases of memory syscalls operating on __user
> pointers instead of unsigned longs like mmap:
>
> ipc/shm.c:1355:23: warning: user pointer cast
> unsigned long addr = (unsigned long)shmaddr;
> ipc/shm.c:1566:23: warning: user pointer cast
> unsigned long addr = (unsigned long)shmaddr;
> mm/migrate.c:1586:10: warning: user pointer cast
> addr = (unsigned long)p;
> mm/migrate.c:1660:24: warning: user pointer cast
> unsigned long addr = (unsigned long)(*pages);
>
> If we don't add untagging to mmap, we probably don't need it here.
>
> The rest of reported places look fine as is. Full annotated results of
> running the checker are here [2].
>
> I'll add the 3 patches with fixes to v5 of this patchset.
>
> Catalin, WDYT?

ping
