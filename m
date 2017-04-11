From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Tue, 11 Apr 2017 20:13:19 +0000
Subject: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
 at91sam9x5
In-Reply-To: <20170411185924.6g4cgk4h6ogsmyd5@piout.net>
References: <DM5PR05MB2954D56C2E266AF16B250ACCBB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <20170404203249.GA4416@gradator.net>
 <DM5PR05MB295425DD88B5A8ADF88B81F8BB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <DM5PR05MB29548291A13C348889156EDDBB0C0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <DM5PR05MB2954F35F2EBB9EEE987F3401BB000@DM5PR05MB2954.namprd05.prod.outlook.com>
 <20170411185924.6g4cgk4h6ogsmyd5@piout.net>
Message-ID: <DM5PR05MB295463261205406FFF273D3BBB000@DM5PR05MB2954.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: Tuesday, April 11, 2017 2:59 PM
> To: Bryan Evenson <bevenson@melinkcorp.com>
> Cc: Sylvain Rochet <sylvain.rochet@finsecur.com>; Nicolas Ferre
> <nicolas.ferre@atmel.com>; linux-arm-kernel at lists.infradead.org
> Subject: Re: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
> at91sam9x5
> 
> Hi,
> 
> On 11/04/2017 at 18:32:20 +0000, Bryan Evenson wrote:
> > I narrowed my issues down to this commit:
> https://github.com/linux4sam/linux-
> at91/commit/0058f0871efe7b01c6f2b3046c68196ab73e96da
> >
> > 	tty/serial: atmel: fix RS485 half duplex with DMA
> >
> > 	When using DMA, half duplex doesn't work properly because rx is
> not stopped
> > 	before starting tx. Ensure we call atmel_stop_rx() in the DMA case.
> >
> > 	Signed-off-by: Alexandre Belloni <alexandre.belloni@free-
> electrons.com>
> > 	Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 	Cc: stable <stable@vger.kernel.org>
> > 	Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > If I revert this commit, I can use both TX and RX DMA on all three RS-485
> ports (USART0, USART1 and USART3) with the current head of linux-4.4-at91
> and linux-4.1-at91 on Atmel's fork.  I have not yet tried the mainline releases,
> but I see that atmel_start_tx() (the function modified by this commit) is
> identical in mainline so I'm assuming I'll have the same results.  In my case I
> am using my RS-485 ports in half-duplex mode, so the call to atmel_stop_rx()
> inside of atmel_start_tx() is the cause of my problems.
> >
> > Anyone know why this would be a problem?  The commit makes sense to
> me and I don't see a good reason why it would break things.  I'm willing to
> test things out to see why this is causing a problem.
> >
> 
> Do you have b389f173aaa1204d6dc1f299082a162eb0491545 in your tree ?
> 

No, I did not have that commit in my tree.  I cherry-picked from the linux-stable repository, tested and verified it fixed my DMA issues.

I checked the various branches on the linux-stable repository, and I see this commit in master and on 4.9, but I don't see it in any branches prior to that one.  Since this issue was introduced back in 4.1, I think this patch would be suitable for backporting to the 4.1 and 4.4 stable branches.  Is there something I can do to help make that happen?

Thanks,
Bryan

> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
