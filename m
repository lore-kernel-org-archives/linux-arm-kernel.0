From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 12:56:19 +0200
Subject: [PATCH 00/20] ARM: pxa: move core and drivers to dmaengine
In-Reply-To: <87zjsqzdg8.fsf@free.fr>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <87zjsqzdg8.fsf@free.fr>
Message-ID: <52061C53.4050905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 10.08.2013 00:50, Robert Jarzmik wrote:
> Daniel Mack <zonque@gmail.com> writes:
> 
>>  * camera driver:
>>      I started the transition, but I'm not sure how much sense that
>>      makes without access to the hardware. I'd much appreciate if
>>      anyone could volunteer for this piece; I'll happily share what
>>      I got so far. Sascha, Sachin, Guennadi?
> Hi Daniel,
> 
> Do you mean this driver ? :
> drivers/media/platform/soc_camera/pxa_camera.c

Yes, exactly.

> In that case I might help. But before I can do that, I have to be convinced that
> dmaengine can deal with this driver. I'm thinking in particular of :
>  - "hot running DMA" queuing
>  - multiple DMA channel synchronization (ie. 3 channel sync)
> 
> All that is described in there :
>   Documentation/video4linux/pxa_camera.txt

Yes, I've seen that, and while the documentation about all that is
excellent, I lack an explanation why things are so complicated for this
application, and why a simple cyclic DMA approach does not suffice here.
I'm sure there's a reason though.

There might be need to teach the dmaengine core more functionality, but
in order to do that, we first need to understand the exact requirements.

> If someone with dmaengine knowledge could have a look at pxa_camera.txt (maybe
> Vinod ?) and tell me that dma_engine framework fullfills the 2 requirements,
> then I'll be happy to help.

Yes, Vinod and and Dan are certainly the best ones to comment on that I
think.

> One minor point though is that I'm working on pxa27x. If the serie is not
> compatible in a way with pxa27x, I won't be able to do anything.

No, it should work just fine on pxa27x.

> Another point I'd like to know, is what is the performance penalty in using
> dmaengine, and do you have any figures ?

The DMA transfers themselves certainly perform equally well, and the
framework is just a thin layer. Where would you expect performance penalty?

> Lastly, they was debug information to debug descriptors chaining, channel
> statuses, requestors. I didn't see where these had gone, could you point me to
> the right file ?

Such a debug interface is not part of the mmp-pdma implementation at
this point, and the core doesn't have a generic debugfs feature either.
If you need that, we'd have to add it back.

FWIW, I attached my work-in-progress patch for this driver which just
does some basic dmaengine preparations. Be aware that this does not even
compile, it's really just a snapshot.


Thanks,
Daniel

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-drivers-media-platform-soc_camera-pxa_camera.c-DMAEN.patch
Type: text/x-patch
Size: 13827 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130810/d527dc67/attachment-0001.bin>
