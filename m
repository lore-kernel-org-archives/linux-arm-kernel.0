From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 9 May 2017 08:56:19 +0200
Subject: [kernel-hardening] Re: [PATCH v9 1/4] syscalls: Verify address
 limit before returning to user-mode
In-Reply-To: <CAGXu5jL61K0bRSEg9a_LswNyrt3K1J57REbWVcvAXT54zWwtMA@mail.gmail.com>
References: <20170428153213.137279-1-thgarnie@google.com>
 <CAJcbSZGQsRVg3QZ9QfLn2HBC+RP-7fUTab0bYDJ455d8y8GyNw@mail.gmail.com>
 <20170508073352.caqe3fqf7nuxypgi@gmail.com>
 <20170508075209.7aluvpwildw325rf@gmail.com>
 <1494256932.1167.1.camel@gmail.com>
 <CAGXu5jL61K0bRSEg9a_LswNyrt3K1J57REbWVcvAXT54zWwtMA@mail.gmail.com>
Message-ID: <20170509065619.wmqa6z6w3n6xpvrw@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> > There's the option of using GCC plugins now that the infrastructure was 
> > upstreamed from grsecurity. It can be used as part of the regular build 
> > process and as long as the analysis is pretty simple it shouldn't hurt compile 
> > time much.
> 
> Well, and that the situation may arise due to memory corruption, not from 
> poorly-matched set_fs() calls, which static analysis won't help solve. We need 
> to catch this bad kernel state because it is a very bad state to run in.

If memory corruption corrupted the task state into having addr_limit set to 
KERNEL_DS then there's already a fair chance that it's game over: it could also 
have set *uid to 0, or changed a sensitive PF_ flag, or a number of other 
things...

Furthermore, think about it: there's literally an infinite amount of corrupted 
task states that could be a security problem and that could be checked after every 
system call. Do we want to check every one of them?

Thanks,

	Ingo
