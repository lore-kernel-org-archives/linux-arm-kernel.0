From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 15:27:03 +0200
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <56FA816D.60101@huawei.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <20160329120147.GA3551@yury-N73SV> <56FA816D.60101@huawei.com>
Message-ID: <3298847.t7vI4YM3gJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 21:21:49 Zhangjian wrote:
> >>>
> >>> Then we could remove the __USE_FILE_OFFSET64 in stat.h and fcnt.h in
> >>> aarch64. And truncate and ftruncate is same as truncate64 and
> >>> ftruncate64.
> >>
> >> I don't know what the glibc developers prefer, but I think the
> >> result needs to be something like that: either __OFF_T_TYPE is
> >> defined as you write above as a 64-bit type, or the user-visible
> >> off_t typedef unconditionally uses __OFF64_T_TYPE rather than
> >> __OFF_T_TYPE.
> >>
> >
> > I'm not the glibc developer as well, but I think it's OK.
> IIUC, it is usually what glibc does.
> If we want to define off_t to 64bit in ilp32, the follow syscall may
> need to define as non-compat too:
> sys_fadvise64
> sys_sendfile
> sys_sendfile64
> sys_lseek
> sys_splice
> sys_sync_file_range2
> sys_truncate
> sys_ftruncate

I'm not following here. Do you mean in the kernel or in glibc?

In the kernel, the list of syscalls is fine, because we already only
provide syscalls passing loff_t as I said, and that is 64-bit.

In glibc, I think we need to define fewer entry points, not more.
Instead of having both lseek and lseek64, only one of them should
be provided, and that should always take a 64-bit offset, calling
into the kernel with the _llseek syscall entry.

	Arnd
