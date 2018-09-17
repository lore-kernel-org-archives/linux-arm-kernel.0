From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Sep 2018 10:35:09 +0100
Subject: Wsometimes-uninitialized warning
In-Reply-To: <137d09a45fb990ecf6f5a4af4cb04eaf@codeaurora.org>
References: <137d09a45fb990ecf6f5a4af4cb04eaf@codeaurora.org>
Message-ID: <20180917093508.GA19927@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2018 at 08:48:36AM -0700, Sodagudi Prasad wrote:
> Hi All,
> 
> I have observed compile time issues with modules incremental compilation
> using clang.
> I referred to following clang documentation about this warning.
> http://releases.llvm.org/3.2/tools/clang/docs/ReleaseNotes.html
> 
> But in kernel code, PERCPU_OP macro default case is not reachable to throw
> this  -Wsometimes-uninitialized warning.
> BUILD_BUG() is getting used for the default cases of the PERCPU_OP macro.
> Have you observed -Wsometimes-uninitialized  warnings with clang when
> compiling 4.14.6?
> 
> 
> /arch/arm64/include/asm/percpu.h:102:1: note: variable 'ret' is declared
> here
> /arch/arm64/include/asm/percpu.h:52:2: note: expanded from macro 'PERCPU_OP'
>         unsigned long loop, ret;                                        \
>         ^
> /arch/arm64/include/asm/percpu.h:103:1: error: variable 'ret' is used
> uninitialized whenever switch default is taken
> [-Werror,-Wsometimes-uninitialized]
> PERCPU_OP(and, and)
> ^~~~~~~~~~~~~~~~~~~
> /arch/arm64/include/asm/percpu.h:95:2: note: expanded from macro 'PERCPU_OP'
>         default:                                                        \
> 
> 
> Do you have any suggestions/comments?

FWIW, I had a go at rewriting that file last week:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=pcpu&id=126c36f538d494d0342ba8e95013936b85d7c5e2

With that, the switch statement disappears altogether.

Will
