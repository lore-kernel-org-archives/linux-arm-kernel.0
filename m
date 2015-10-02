From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Oct 2015 10:37:12 +0100
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <F6B719D8-1FC0-4B26-A926-40FB6953AAE3@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
 <20151001191520.GA25295@yury-N73SV> <1708349.DFbfvHcnCR@wuerfel>
 <F6B719D8-1FC0-4B26-A926-40FB6953AAE3@caviumnetworks.com>
Message-ID: <20151002093711.GA15803@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 09:49:46PM +0000, Pinski, Andrew wrote:
> Ok, we will rewrite these patches using 32bit time_t and 32bit off_t
> and redo the toolchain support for them.  Note this is going back to
> the abi I had originally done when I submitted my original version
> when it was asked to change time_t to be 64bit. 

One of the key aspects of kernel development is the ability to adapt
quickly to new requests/insights. This implies releasing early and often
rather than a new version roughly twice a year (IIRC, v1 was posted
September 2013). Moreover, the success of the kernel is partly based on
not getting stuck on old decisions (well, unless it breaks accepted user
ABI).

So, at the time, following x32 discussions, we thought of using the
native ABI as much as possible. However, two important things happened
since:

1. libc community didn't like breaking the POSIX compliance
2. No-one seems desperate for ILP32 on AArch64

(1) is a fair point and I would rather be careful as we don't know the
extent of the code affected. In the meantime, we've also had ongoing
work for addressing the 2038 issue on 32-bit architectures.

The second point is equally important. The benchmarks I've seen didn't
show a significant improvement and the messages I got on various
channels pretty much labeled ILP32 as a transitional stage to full LP64.
In this case, we need to balance the benefits of a close to native ABI
(future proof, slightly higher performance) vs. the cost of maintaining
such ABI in the kernel on the long term, especially if it's not widely
used/tested.

We've seen the kernel patches and, following discussions on the lists,
decided to change the original recommendation. IIRC, the main ideas (but
you need to read various threads as I can't remember the details from
6-7 months ago):

a) separate syscall table for ILP32
b) close to compat ABI with 32-bit time_t, off_t
c) asm-generic/unistd.h rather than asm/unistd32.h (that's where it
   would differ from compat, together with places where pointers are
   passed)

As I said previously, I'm not going to pay any attention to the patches
in this series, it's nothing more than a rebase of a version I already
reviewed.

-- 
Catalin
