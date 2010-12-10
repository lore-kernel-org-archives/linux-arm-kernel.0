From: cl@linux.com (Christoph Lameter)
Date: Fri, 10 Dec 2010 13:51:23 -0600 (CST)
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1292006788.13513.43.camel@laptop>
References: <20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291851079-27061-1-git-send-email-venki@google.com>
	<1291899120.29292.7.camel@twins>
	<AANLkTikd3X4pLs5De-LO6=XD+JqUz3-Ku7YM8+0-oK8t@mail.gmail.com>
	<1291917330.6803.7.camel@twins>
	<AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
	<1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
	<AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
	<1291975704.6803.59.camel@twins> <1291987065.6803.151.camel@twins>
	<1291987635.6803.161.camel@twins> <1291988866.6803.171.camel@twins>
	<1292001500.3580.268.camel@edumazet-laptop>
	<1292003346.13513.30.camel@laptop>
	<1292004859.3580.387.camel@edumazet-laptop>
	<alpine.DEB.2.00.1012101236300.13986@router.home>
	<1292006788.13513.43.camel@laptop>
Message-ID: <alpine.DEB.2.00.1012101344570.13986@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Dec 2010, Peter Zijlstra wrote:

> > > gcc wont be able to do this yet (%fs/%gs selectors)
> >
> > The kernel can do that using the __percpu annotation.
>
> That's not true:
>
> # define __percpu
>
> Its a complete NOP.

The annotation serves for sparse checking. .... If you do not care about
those checks then you can simply pass a percpu pointer in the same form as
a regular pointer.

> > > But we can provide this_cpu_write_seqcount_{begin|end}()
> >
> > No we cannot do hat. this_cpu ops are for per cpu data and not for locking
> > values shared between processors. We have a mechanism for passing per cpu
> > pointers with a corresponding annotation.
>
> -enoparse, its not locking anything, is a per-cpu sequence count.

seqlocks are for synchronization of objects on different processors.

Seems that you do not have that use case in mind. So a seqlock restricted
to a single processor? If so then you wont need any of those smp write
barriers mentioned earlier. A simple compiler barrier() is sufficient.
