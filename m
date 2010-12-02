From: aric@sdgsystems.com (Aric D. Blumer)
Date: Wed, 01 Dec 2010 21:35:51 -0500
Subject: bad pmd
In-Reply-To: <20101201201440.GD29347@n2100.arm.linux.org.uk>
References: <4CF6A7F2.80206@sdgsystems.com>
	<20101201201440.GD29347@n2100.arm.linux.org.uk>
Message-ID: <4CF70607.1010905@sdgsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2010 03:14 PM, Russell King - ARM Linux wrote:
> On Wed, Dec 01, 2010 at 02:54:26PM -0500, Aric D. Blumer wrote:
>> Hi.  I'm using the long-term stable kernel 2.6.32 on a PXA320 platform,
>> and I'm seeing errors like the following:
>>
>> /home/aric/sdg/git/linux/mm/memory.c:144: bad pmd 8040542e.
>>
>> I have seen these messages on both the 2.6.32.15 and 2.6.32.24 kernels
>> (haven't tried others).  Can someone tell me what the message means?  I
>> suspect memory is being clobbered.  One interesting thing is that
>> whenever that message is printed, the 8040542e is always the same.  I
>> have not been able to establish any correlation yet with what causes it.
> A pmd value of 0x8040542e is a section mapping, which the generic MM
> code will not understand.
>
> It is for address 0x80400000, is read/writable from SVC mode, inaccessible
> from user mode, domain 1 (which is normally for 'user' memory), and has
> a memory type of TEXCB=10111.
>
> As standard mainline doesn't create mappings with TEX=101, and we don't
> create mappings with the 'user' domain using sections, the question this
> immediately raises is: have you modified this kernel?

Thanks for the info, Russell.  We have modified this kernel in two
ways:  1) We have added code to support the platform (GPIOs,
touchscreen, bluetooth UART, etc.).   2) It has the patches for Android
merged in.

It doesn't look like the Android patches do any mappings different from
mainline, but the bad entry looks very much like a real page table
entry.  But, supposing that memory is being trampled, can any driver
mess up the page tables, or is a special processor mode required?  Could
a rogue DMA trample page table memory?  Can you suggest how to determine
what the address of the bad page table entry is?

I'll start removing non-critical drivers to see if I can isolate the
cause, but I have a bit more information in the meantime:  I put
__backtrace() into pmd_clear_bad(), and I always see a read() system
call sequence like this when the error occurs:

[    8.894213] /home/aric/sdg/git/linux/mm/memory.c:144: bad pmd 8040542e.
[    8.901133] [<c0099d50>] (pmd_clear_bad+0x0/0x40) from [<c00a4b18>]
(walk_page_range+0x22c/0x230)
[    8.910128]  r4:80600000
[    8.912839] [<c00a48ec>] (walk_page_range+0x0/0x230) from
[<c00eecf8>] (show_smap+0x84/0x17c)
[    8.921589] [<c00eec74>] (show_smap+0x0/0x17c) from [<c00ca60c>]
(seq_read+0x314/0x48c)
[    8.929810] [<c00ca2f8>] (seq_read+0x0/0x48c) from [<c00b1348>]
(vfs_read+0xb8/0x16c)
[    8.937761] [<c00b1290>] (vfs_read+0x0/0x16c) from [<c00b16c8>]
(sys_read+0x44/0x74)
[    8.945603]  r8:c002e108 r7:00000000 r6:00012000 r5:fffffff7 r4:cf32bf80
[    8.952644] [<c00b1684>] (sys_read+0x0/0x74) from [<c002df60>]
(ret_fast_syscall+0x0/0x28)
[    8.961019]  r7:00000003 r6:5a5cbc68 r5:afe14cfd r4:afe3bdfc
[    8.968572] /home/aric/sdg/git/linux/mm/memory.c:144: bad pmd 8040542e.
[    8.975402] [<c0099d50>] (pmd_clear_bad+0x0/0x40) from [<c00a4b18>]
(walk_page_range+0x22c/0x230)
[    8.984386]  r4:80c00000
[    8.987062] [<c00a48ec>] (walk_page_range+0x0/0x230) from
[<c00eecf8>] (show_smap+0x84/0x17c)
[    8.995789] [<c00eec74>] (show_smap+0x0/0x17c) from [<c00ca60c>]
(seq_read+0x314/0x48c)
[    9.003994] [<c00ca2f8>] (seq_read+0x0/0x48c) from [<c00b1348>]
(vfs_read+0xb8/0x16c)
[    9.012013] [<c00b1290>] (vfs_read+0x0/0x16c) from [<c00b16c8>]
(sys_read+0x44/0x74)
[    9.019908]  r8:c002e108 r7:00000000 r6:00012800 r5:fffffff7 r4:cf32bf80
[    9.026846] [<c00b1684>] (sys_read+0x0/0x74) from [<c002df60>]
(ret_fast_syscall+0x0/0x28)
[    9.035224]  r7:00000003 r6:5a5cbc40 r5:afe14cfd r4:afe3bdfc
