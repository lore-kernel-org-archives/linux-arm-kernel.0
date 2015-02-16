From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Feb 2015 17:54:15 +0100
Subject: [PATCH RFC 2/2] ARM: pxa: transition to dmaengine phase 1
In-Reply-To: <CA+E=qVfP=JY5ccUyCat5Thtk6waVng-PsnL7Y4c7_Hj+s8==nw@mail.gmail.com>
 (Vasily Khoruzhick's message of "Mon, 16 Feb 2015 14:14:18 +0300")
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
 <1423954053-21760-3-git-send-email-robert.jarzmik@free.fr>
 <CA+E=qVfP=JY5ccUyCat5Thtk6waVng-PsnL7Y4c7_Hj+s8==nw@mail.gmail.com>
Message-ID: <87wq3hajbc.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick <anarsoul@gmail.com> writes:

> On Sun, Feb 15, 2015 at 1:47 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> In order to slowly transition pxa to dmaengine, the legacy code will now
>> rely on dmaengine to request a channel.
>
> Hi Robert,
>
> What about dropping old PXA DMA code completely? Daniel Mack did port
> for most of PXA drivers to dma engine,
> I've rebased his patches against 3.17 several months ago and fixed
> oopses in pxamci and asoc drivers, but I didn't resubmit whole series
> due to lack of time.

Well, it's the last step, yes.
But I want a "smooth transition" : if amongst the ported drivers one starts to
bug, I want to be able to revert _only_ that driver port to dmaengine, and not
_all_ the drivers.

That's the rationale of this patch :
 - phase 1 : enable peacefull coexistence of legacy pxa_request_dma() and
             dmaengine for pxa, for both devicetree and legacy platforms
 - phase 2 : port the drivers, and ensure the work correctly
             This might take a couple of cycles
             Note that phase 1 ensures that submissions can go through each
             maintainer's tree without need for strong consistence.
 - phase 3 : revert the mmp_pdma patch, and drop arch/arm/plat-pxa/dma.c

> My 3.17 tree is at [1], I've tested it on pxa270 machine (Zipit Z2),
> and everything works fine so far. I guess it won't be too much work to
> rebase it against linux-3.20.
Oh, do you volunteer ? That would indeed ease up my burden. I only rebased
pxa3xx_nand, so any help to submit and push is welcome. At least I can commit to
review, and I would concentrate on pxa_camera.c in the meantime.

Cheers.

-- 
Robert
