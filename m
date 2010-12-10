From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 10 Dec 2010 23:09:57 +0800
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <201012091016.54130.jeremy.kerr@canonical.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<201012080902.37859.jeremy.kerr@canonical.com>
	<4CFFB6DD.4000108@fluff.org>
	<201012091016.54130.jeremy.kerr@canonical.com>
Message-ID: <AANLkTinGHXNrL-KJiQBq8G7a_oz-gpp9-unxeS1-e5-x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 9, 2010 at 10:16 AM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> Hi Ben,
>
>> Why do they need atomic clocks?
>
> Some of the clocks need enabling/disabling at interrupt time, and apparently
> can't be deferred to a non-atomic context. You'd have to query them for more
> details though, this is all I know at this stage.
atomic clock make it easy to use, or we have to move many irq tasks to
kthread context. we may involves many kthreads. If we put tasks to
global work queue,  sometimes it conflicts each other, and causes dead
lock.
Cases to use atomic clock: when insert a sd card, we have to enable sd
host controller clock. when a dma call back tell you everything is
done, you may want to disable controller clock. ...
And what can cause clock not atomic? At least for freescale imx, it
won't sleep if you just operate clock. I mean no voltage change.

Thanks
Richard
>
>> This is starting to look like a real mess.
>
> The only external change this brings is that the clock driver uses
> INIT_CLK_ATOMIC rather than INIT_CLK.
>
> Cheers,
>
>
> Jeremy
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
