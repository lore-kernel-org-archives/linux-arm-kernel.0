From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Fri, 18 Mar 2016 18:28:29 +0800
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160225202855.GD16123@yury-N73SV>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de> <20160225202855.GD16123@yury-N73SV>
Message-ID: <56EBD84D.2060009@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yury

We are trying to test ilp32 in our arm64 board. But we got more
failure compare with you. So, I am wondering if we could align
the test environment with you. The source code we used:

1.  glibc: the new-api branch of glibc from
     git at code.huawei.com:gnu/norov_glibc.git.

2.  Kernel: rfc5 from https://github.com/norov/linux.git. Is the
     rc6 in your branch is the latest one? From the commit message, I
     do not find any difference. Is it just a rebase?

3.  Toolchain 4.9.3, could you provide the binary of toolchain(both
     cross and native, gcc, gdb...)? It may be very useful for me or
     other guys who interested build their own filesystem from
     buildroot or something.

4.  LTP: master.

For the glibc part, I found that there are 11 patches of ilp32 in top,
but the original 28 patches of ilp32 is not in the top, there are more
than 900 patches between them(referece the list below). Are you
willing rebase all the ilp32 relative patches. It is very useful for
reviewing and debugging.  I saw andrew request the account in glibc,
maybe it has already been in processs?).

Regards

Bamvor

ILP32 relative patch in norov's glibc:
       1 b5c4968 fix stat
       2 8332b7a fix3
       3 d16a202 fix statfs
       4 351b872 fix IPC_64 for msgctl semctl shmctl
       5 07f8ead fix readdir ????
       6 4be481a fix lseek
       7 4231518 fix getdents
       8 de55857 fstat fix
       9 5d42904 stat
      10 3f70665 mmap, stat syscalls
      11 574af33 Make ilp32 use the compat (old 32bit ABI).

     972 8addb06 [AARCH64] Make lp64 and ilp32 directories.
     973 bfe0619 [AARCH64] Add typesizes.h for ILP32
     974 916581b [AARCH64] Fix up ucontext for ILP32
     975 0f646ee [AARCH64] Add sigstack.h header for ILP32 reasons.
     976 68e11d8 [AARCH64] Add kernel_sigaction.h for AARCH64 ILP32
     977 a0087ba [AARCH64] Add ldd-rewrite.sed so that ilp32 ld.so can be found
     978 0f800d9 [AARCH64] Add ILP32 ld.so to the known interpreter names.
     979 45d74fd [AARCH64] Add support to ldconfig for ILP32 and libilp32
     980 9926da9 [AARCH64] Add ILP32 to makefiles
     981 987b522 [AARCH64] Set up wordsize for ILP32.
     982 5e34e4c [AARCH64] Add ILP32 support to elf_machine_load_address.
     983 1ff4dd9 [AARCH64] Reformat inline-asm in elf_machine_load_address.
     984 f7ff9aa [AARCH64] Syscalls for ILP32 are passed always via 64bit values.
     985 9316667 [AARCH64] Detect ILP32 in configure scripts.
     986 ff0dca1 [AARCH64] Use PTR_REG in getcontext.S.
     987 7c9f1b0 [AARCH64] Use PTR_* in start.S
     988 ed747ff [AARCH64] Use PTR_* macros in dl-trampoline.S
     989 71f6986 [AARCH64] Use PTR_REG/PTR_SIZE/PTR_SIZE_LOG in dl-tlsesc.S
     990 3294b6f [AARCH64] Use PTR_REG in crti.S.
     991 c8fef18 [AARCH64] Add PTR_REG, PTR_LOG_SIZE, and PTR_SIZE.  Use it in LDST_PCREL and LDST_GLOBAL.
     992 585197d Add dynamic ILP32 AARCH64 relocations to elf.h
     993 49f1345 [AARCH64] Add header guards to sysdep.h headers.
     994 2594068 Allow generic stat and statfs not have padding for 32bit targets
     995 86f0aa7 Allow some fields of siginfo to be different from the generic one
     996 fdffbc5 Allow fd_mask type not be an array of long.
     997 453987a Allow rusage work on a big-endian 32bit-on-64bit target
     998 70e6485 Add ability for the IPC structures (msqid_ds, semid_ds, shmid_ds, etc.) to have time_t being 64bit
     999 9ff1730 Allow sigset be an array of a different type
    1000 dc09040 [AARCH64] Fix utmp struct for compatibility reasons.


On 2016/2/26 4:28, Yury Norov wrote:
> On Thu, Feb 25, 2016 at 11:50:31AM +0100, Andreas Schwab wrote:
>> Yury Norov <ynorov@caviumnetworks.com> writes:
>>
>>> I have new glibc that follows new ABI:
>>> https://github.com/norov/glibc/tree/new-api
>>
>> sysdeps/unix/sysv/linux/aarch64/ilp32/getdents64.c is wrong, struct
>> dirent64 is not the same as struct dirent.  The file needs to be renamed
>> to sysdeps/unix/sysv/linux/aarch64/ilp32/getdents.c so that __getdents64
>> comes from sysdeps/unix/sysv/linux/generic/getdents64.c.
>>
>> sysdeps/unix/sysv/linux/aarch64/ilp32/*xstat*.c should not set errno,
>> INLINE_SYSCALL already does that, and returns -1 on error.
>>
>> Andreas.
>>
>
> Thank you. I'll fix it
>
>> --
>> Andreas Schwab, SUSE Labs, schwab at suse.de
>> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
>> "And now for something completely different."
