From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 10:09:52 +0200
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <57329320.1000500@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <4119683.coHZhzaE6c@wuerfel> <57329320.1000500@huawei.com>
Message-ID: <4876119.A8fbdncu9Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 May 2016 10:04:16 Zhangjian wrote:
> > I don't remember. It's probably not important whether we have the shift
> > in there, as long as it's independent of the actual kernel page size and
> > user space and kernel agree on the calling conventions.
> Well. I am ok with where to shift the pages size because we get the same
> result. I was just thinking if we should get rid of the name of mmap2 in our
> ILP32 porting. Actually, it is mmap but we name it as mmap2. User may confused
> if they do not know the implementations.

That is a good point: If the implementation matches the mmap() behavior rather than
mmap2(), we should rename the macro by doing

#undef __NR_mmap2
#define __NR_mmap 222

in the uapi/asm/unistd.h file for ilp32 mode. Alternatively we can keep the
__NR_mmap2 definition but then we need to pass the pgoff (value shifted by
12 bits) argument rather than the size in bytes.

	Arnd
