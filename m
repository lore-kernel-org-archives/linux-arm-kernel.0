From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Mar 2014 18:30:14 +0100
Subject: [PATCH v11 17/27] iommu/exynos: remove calls to Runtime PM API
 functions
In-Reply-To: <CANEJEGuYz28dGT+264CYtG+Tk6htOq=u-t4PWMtsij32X0vJFA@mail.gmail.com>
References: <20140314140843.ba055f28dd7ed59c46088029@samsung.com>
 <5322FD14.5090602@samsung.com>
 <20140318185605.0380c8dfe6559c06183092e5@samsung.com>
 <532861BE.7020601@samsung.com>
 <20140319100304.5e26fa43ccdfc29178b058e1@samsung.com>
 <532997D7.6090608@samsung.com>
 <CANEJEGuYz28dGT+264CYtG+Tk6htOq=u-t4PWMtsij32X0vJFA@mail.gmail.com>
Message-ID: <5329D426.9020706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 19.03.2014 18:03, Grant Grundler wrote:
> On Wed, Mar 19, 2014 at 6:12 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> ...
>> No. Proper Linux drivers must support deferred probing mechanism and there
>> should be no assumptions about probing orders. Using other initcall level
>> than module_initcall for particular drivers is strongly discouraged.
>
> That's true for "end-point" devices. It's not true for
> "infrastructure": Memory, CPU, DMA, Interrupt handling, etc. Those
> need to be in place before "normal" drivers get called. This SysMMU
> driver provides DMA services for "normal" device drivers. Or do I see
> that wrong?

Of course using an early initcall level would give you some kind of 
guarantees, but it wouldn't guarantee that someone couldn't lower 
initcall level for some MMU client driver and break the ordering anyway.

As I said, AFAIK the trend is to get rid of ordering by initcalls and 
make sure that drivers can handle missing dependencies properly, even 
for "services" such as DMA, GPIO, clocks and so on, which after all are 
provided by normal drivers like other.

>
> thanks,
> grant
>
> ps. I've written IOMMU support for four different IOMMUs on three
> operating systems (See drivers/parisc for two linux examples). But I
> still feel like I at best have 80% understanding of how this one is
> organized/works. Abstract descriptions and convoluted code have been
> handicapping me (and lack of time to dig further).

Well, this is one of my concerns with this driver. It isn't easy to read 
(and so review, maintain, extend and debug found issues).

Best regards,
Tomasz
