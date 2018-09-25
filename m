From: dennis@kernel.org (Dennis Zhou)
Date: Tue, 25 Sep 2018 16:33:55 -0400
Subject: [PATCH] arm64: percpu: Initialize ret in the default case
In-Reply-To: <20180925194459.13088-1-natechancellor@gmail.com>
References: <20180925194459.13088-1-natechancellor@gmail.com>
Message-ID: <20180925203355.GA61443@dennisz-mbp.dhcp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

On Tue, Sep 25, 2018 at 12:44:59PM -0700, Nathan Chancellor wrote:
> Clang warns that if the default case is taken, ret will be
> uninitialized.
> 
> ./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
> uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
>         default:
>         ^~~~~~~
> ./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
> here
>         return ret;
>                ^~~
> ./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
> 'ret' to silence this warning
>         unsigned long ret, loop;
>                          ^
>                           = 0
> 
> This warning appears several times while building the erofs filesystem.
> While it's not strictly wrong, the BUILD_BUG will prevent this from
> becoming a true problem. Initialize ret to 0 in the default case right
> before the BUILD_BUG to silence all of these warnings.
> 
> Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I've applied this to percpu/for-4.20.

Thanks,
Dennis
