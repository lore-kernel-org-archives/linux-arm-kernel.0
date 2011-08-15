From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Aug 2011 09:20:27 +0100
Subject: [RFC PATCH 2/2] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <CAGsJ_4yigTt40g0-9jrz5qAbdrQdsXuQ65MhX+x1AZ1M4Ztr=w@mail.gmail.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<1312512888-25070-3-git-send-email-bs14@csr.com>
	<20110814075927.GB4986@n2100.arm.linux.org.uk>
	<CAGsJ_4yigTt40g0-9jrz5qAbdrQdsXuQ65MhX+x1AZ1M4Ztr=w@mail.gmail.com>
Message-ID: <20110815082027.GA26827@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 03:43:13PM +0800, Barry Song wrote:
> Sorry, my fault. i simply picked these lines which have been verified
> to be working in local old 2.6.38.8 kernel and really didn't think and
> refine more carefully.
> in deep sleep mode, SiRFprimaII will powerdown CPU core.

... just like everyone else.

> due to this,
> i just ignored to delete the codes saving registers of all kinds of
> CPU modes. but it is not the real situation in kernel. For example,
> IRQ mode used the stack of corrupted thread, and kernel was not in
> interrupt while going to pm_ops->enter(), then it is unnecessary to
> enter IRQ and save sp of IRQ:

No.  There is _no_ need to save and restore these registers.  They
can simply be re-setup.  The generic cpu_suspend stuff already
takes care of that.

> Ok. agree. then the work flow for SiRFprimaII suspend can be:
> pm.enter()->
>     sirfsoc_cpu_sleep(v:p offset)
>     1. save registers on stack
>     2. load sirfsoc_cpu_resume to r3
>     3. bl cpu_suspend
>     4. make sdram self-refresh
>     5. write force DEEPSLEEP by rtciobrg
> 
> One issue is L2

That's why I did not include it in the list of code which could be
eliminated.
