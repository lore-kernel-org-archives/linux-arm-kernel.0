From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 14:54:31 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <mvmziyeukxx.fsf@hawking.suse.de>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <4164423.46Jfedud5Y@wuerfel> <mvmziyeukxx.fsf@hawking.suse.de>
Message-ID: <13567088.yUyVvkDQhR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 November 2015 14:34:50 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > ino_t seems to be the only other type in 'struct stat' that depends
> > on _FILE_OFFSET_BITS in glibc.
> 
> There is also blkcnt_t, and then there is fsblkcnt_t, fsfilcnt_t and
> fsword_t in struct statfs.

Ok, got it.

Again these are just internal to glibc, the kernel just uses fixed width
types in

typedef struct {
        int     val[2];
} __kernel_fsid_t;

struct statfs64 {
        __u32 f_type;
        __u32 f_bsize;
        __u64 f_blocks; 
        __u64 f_bfree;  
        __u64 f_bavail;
        __u64 f_files;
        __u64 f_ffree;
        __kernel_fsid_t f_fsid;
        __u32 f_namelen;
        __u32 f_frsize;
        __u32 f_flags;
        __u32 f_spare[4];
};

so we need to be careful to define them in glibc to match the kernel
types, but the kernel definition doesn't need changes.

	Arnd
