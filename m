From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 31 May 2017 15:47:37 +0800
Subject: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
In-Reply-To: <CAHp75VdL=rGHuupGmgmAVonEQgpyPRgoMQrZK0yQiaM=1Vac-g@mail.gmail.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <fb9fe0cd-5ca7-74e6-33dc-7638e205b2e3@cogentembedded.com>
 <20170517033927.GC9913@b29396-OptiPlex-7040>
 <8f4cf45e-45ab-e6e6-d95c-f3d4243697f4@cogentembedded.com>
 <20170517054356.GE9913@b29396-OptiPlex-7040>
 <CAHp75VdL=rGHuupGmgmAVonEQgpyPRgoMQrZK0yQiaM=1Vac-g@mail.gmail.com>
Message-ID: <20170531074737.GC16812@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Wed, May 17, 2017 at 12:55:59PM +0300, Andy Shevchenko wrote:
> On Wed, May 17, 2017 at 8:43 AM, Dong Aisheng <dongas86@gmail.com> wrote:
> > On Wed, May 17, 2017 at 08:37:41AM +0300, Nikita Yushchenko wrote:
> >>
> >>
> >> 17.05.2017 06:39, Dong Aisheng wrote:
> >> > On Tue, May 16, 2017 at 02:15:08PM +0300, Nikita Yushchenko wrote:
> >> >>>  static u32 lpuart32_read(void __iomem *addr)
> >> >>>  {
> >> >>> - return ioread32be(addr);
> >> >>> + return lpuart_is_be ? ioread32be(addr) : readl(addr);
> >> >>>  }
> >> >>>
> >> >>>  static void lpuart32_write(u32 val, void __iomem *addr)
> >> >>>  {
> >> >>> - iowrite32be(val, addr);
> >> >>> + if (lpuart_is_be)
> >> >>> +         iowrite32be(val, addr);
> >> >>> + else
> >> >>> +         writel(val, addr);
> >> >>>  }
> >> >>
> >> >> What if this is ever executed on big endian system?
> >> >>
> >> >
> >> > Sorry, not catching the point...
> >> >
> >> > What issues will meet?
> >>
> >> Isn't writel() in host endian?
> >
> > On big endian systems, it is supposed to run iowrite32be.
> 
> It looks like you substituting *bus* side with CPU *side* of communication.
> 
> If you are talking about CPU side
> __raw_readl() / __raw_writel() will do the trick.
> 

Yes, you're right.
To be more accurate, for bus side, if it's BE lpuart it should use
ioread32be/iowrite32be. If it's LE lpuart, it should use readl/writel.

And for CPU side, endian is transparent to driver users as they're
hided in io accessors implementation.

Regards
Dong Aisheng
