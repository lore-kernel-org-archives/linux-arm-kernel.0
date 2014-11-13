From: geoff@infradead.org (Geoff Levand)
Date: Thu, 13 Nov 2014 11:42:40 -0800
Subject: [PATCH] efi: Fix free_end build warning
In-Reply-To: <20141113114420.GF13350@arm.com>
References: <1415824050.15847.9.camel@smoke> <20141113114420.GF13350@arm.com>
Message-ID: <1415907760.15847.93.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, 2014-11-13 at 11:44 +0000, Will Deacon wrote:
> Do you have any idea how GCC arrives at this conclusion? I can't see a
> path through that function where we use free_end without initialising it.

I've seen it warn like this before, when it shouldn't. I guess
-Wmaybe-uninitialized makes it more conservative.

Using:

  aarch64-linux-gnu-gcc (Ubuntu/Linaro 4.8.2-13ubuntu1) 4.8.2 20140110 (prerelease) [ibm/gcc-4_8-branch merged from gcc-4_8-branch, revision 205847]

> Does something like the patch below help?

Here is the full output, for-next/core gives:

/home/geoff/projects/linaro/git/linux-kexec/arch/arm64/kernel/efi.c:281:31: warning: ?free_end? may be used uninitialized in this function [-Wmaybe-uninitialized]
     total_freed += free_region(free_start, free_end);
                               ^
/home/geoff/projects/linaro/git/linux-kexec/arch/arm64/kernel/efi.c:225:28: note: ?free_end? was declared here
  u64 keep_end, free_start, free_end;
                            ^
Your mod gives:

/home/geoff/projects/linaro/git/linux-kexec/arch/arm64/kernel/efi.c:279:31: warning: ?free_end? may be used uninitialized in this function [-Wmaybe-uninitialized]
     total_freed += free_region(free_start, free_end);
                               ^
/home/geoff/projects/linaro/git/linux-kexec/arch/arm64/kernel/efi.c:225:28: note: ?free_end? was declared here
  u64 keep_end, free_start, free_end;
                            ^
So about the same.

-Geoff
