From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 14 Dec 2015 10:56:04 -0500
Subject: [RFC] arm64: ftrace with regs for livepatch support
In-Reply-To: <566E7C35.3060705@huawei.com>
References: <564F0846.5000001@linaro.org>
	<566E7C35.3060705@huawei.com>
Message-ID: <20151214105604.7b606097@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Dec 2015 16:22:13 +0800
Li Bin <huawei.libin@huawei.com> wrote:

> I think the more appropriate way to implement the livepatch on arm64 is to
> directly modify the instruction with the help of the gcc "-fprolog-pad=N"option
> and the N only needs 1, rather than basing on ftrace.
> 
> func:
>     nop    <--->  b <(new_func1 - func)>  <--->   b <(new_func2 - func)>       
>     [prologue]
> 
> And that NOP and B are both safe instructions which called "concurrent modification
> and execution of instructions", that can be executed by one thread of execution as
> they are being modified by another thread of execution without requiring explicit
> synchronization.
> 
> On arm64, this method will improve performance significantly compared with the method
> based on ftrace, especially for the critical function being frequently called.

Yes there's a way to do this and I was against it because it can make
in very difficult to monitor what gets changed. ftrace just happens to
have the feature currently built in. I'm working on a way to make this
a bit better for live patching and still maintain some history of the
changes as well keeping the integrity of the ftrace infrastructure.

-- Steve


> 
> Can we modify the livepatch to allow the arch specific implementation? Such as that
> making the klp_enable_func/klp_disable_func as the weak function and allow their
> implementations be architecture sepcific that not use ftrace. I already have a prototype
> patchset and have test it and will post them soon.
> 
