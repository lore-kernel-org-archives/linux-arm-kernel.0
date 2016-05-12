From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 May 2016 11:19:21 +0200
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160512002000.GA30997@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160512002000.GA30997@yury-N73SV>
Message-ID: <4326765.8HKKkI07Zs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 May 2016 03:20:00 Yury Norov wrote:
> 
> I debugged preadv02 and pwritev02 failures and found very weird bug.
> Test passes {iovec_base = 0xffffffff, iovec_len = 64} as one element
> of vector, and kernel reports successful read/write.
> 
> There are 2 problems:
> 1. How kernel allows such address to be passed to fs subsystem;
> 2. How fs successes to read/write at non-mapped, and in fact non-user
> address.
> 
> I don't know the answer on 2'nd question, and it might be something
> generic. But I investigated first problem.
> 
> The problem is that compat_rw_copy_check_uvector() uses access_ok() to
> validate user address, and on arm64 it ends up with checking buffer
> end against current_thread_info()->addr_limit.
> 
> current_thread_info()->addr_limit for ilp32, and most probably for
> aarch32 is equal to aarch64 one, and so adress_ok() doesn't fail.
> It happens because on thread creation we call flush_old_exec() to set 
> addr_limit, and completely ignore compat mode there.
> 
> This patch fixes it. It also fixes USER_DS macro to return different
> values depending on compat.
> 
> This patch is enough to handle preadv02 and pwritev02, but problem #2
> is still there.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 

Good catch!

Can you do a version of this patch that works on the current
mainline kernel and can be backported to fix aarch32 emulation?

For ilp32 mode, I think we can better fix arch/arm64/kernel/binfmt_ilp32.c
as it is introduced.

	Arnd
