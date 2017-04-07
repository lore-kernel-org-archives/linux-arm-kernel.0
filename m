From: james.morse@arm.com (James Morse)
Date: Fri, 07 Apr 2017 16:56:45 +0100
Subject: [PATCH v3 8/8] arm64: exception: check shared writable page in
 SEI handler
In-Reply-To: <1490869877-118713-9-git-send-email-xiexiuqi@huawei.com>
References: <1490869877-118713-1-git-send-email-xiexiuqi@huawei.com>
 <1490869877-118713-9-git-send-email-xiexiuqi@huawei.com>
Message-ID: <58E7B6BD.3000401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xie XiuQi,

On 30/03/17 11:31, Xie XiuQi wrote:
> From: Wang Xiongfeng <wangxiongfeng2@huawei.com>
> 
> Since SEI is asynchronous, the error data has been consumed. So we must
> suppose that all the memory data current process can write are
> contaminated. If the process doesn't have shared writable pages, the
> process will be killed, and the system will continue running normally.
> Otherwise, the system must be terminated, because the error has been
> propagated to other processes running on other cores, and recursively
> the error may be propagated to several another processes.

This is pretty complicated. We can't guarantee that another CPU hasn't modified
the page tables while we do this, (so its racy). We can't guarantee that the
corrupt data hasn't been sent over the network or written to disk in the mean
time (so its not enough).

The scenario you have is a write of corrupt data to memory where another CPU
reading it doesn't know the value is corrupt.

The hardware gives us quite a lot of help containing errors. The RAS
specification (DDI 0587A) describes your scenario as error propagation in '2.1.2
Architectural error propagation', and then classifies it in '2.1.3
Architecturally infected, containable and uncontainable' as uncontained because
the value is no longer in the general-purpose registers. For uncontained errors
we should panic().

We shouldn't need to try to track errors after we get a notification as the
hardware has done this for us.


Firmware-first does complicate this if events like this are not delivered using
a synchronous external abort, as Linux may have PSTATE.A masked preventing
SError Interrupts from being taken. It looks like PSTATE.A is masked much more
often than is necessary. I will look into cleaning this up.


Thanks,

James
