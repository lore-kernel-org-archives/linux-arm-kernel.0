From: zonque@gmail.com (Daniel Mack)
Date: Wed, 21 Aug 2013 11:00:23 +0200
Subject: remove pxa ssp driver???
In-Reply-To: <CADApbej4bvSW7PVXnor4v3iFMcZ=ZHN9T_ST5-SYFJZM9sakDQ@mail.gmail.com>
References: <CADApbej4bvSW7PVXnor4v3iFMcZ=ZHN9T_ST5-SYFJZM9sakDQ@mail.gmail.com>
Message-ID: <521481A7.5030504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chao,

On 21.08.2013 05:19, Chao Xie wrote:
> In arch/arm/plat-pxa, there is a ssp driver named ssp.c.
> The ssp driver will probe all the ssp devices one by one, and linked
> them into a list.
> The driver also provides two APIs pxa_request_pxa() and pxa_ssp_free().
> 
> So why we will have ssp.c driver? The only thing the driver will do is
> linked all the ssp devices into a list, and then provides APIs to
> others to allocate and free the ssp ports.
> 
> The ssp connection is defined by board, and it is fixed. So for a
> single board, i do not think the port will be allocated or freed
> dynamically. Is there any case that will two drivers will share same
> port?

It's really just to simplify the ssp port users, so they don't have to
duplicate the resource allocation logic in their probe() implementation.

However, that code is quite old, and with new ideas like devres
allocation, probe functions can very small, so I agree with the idea of
getting rid of that extra layer.

However, I prepared some patches to provide device-tree functions to the
ssp driver, and they are queued by Mark in the for-next branch of his
ASoC tree:

  https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/

The approach there is now different, and the asoc ssp driver references
the 'upstream' ssp port by phandle. But that API can't yet be fully used
before the pxa-DMA bits go in, we can still change it I'd say.

> If the two APIs are not needed. Then we can remove the driver, and
> lets other drivers, for example, spi-pxa.c and sound/soc/pxa/pxa-ssp.c
> to directly handle the ssp resources(get irq number, iomap the
> register and etc.)

Yes, I agree, but I'd like to schedule that for after the 3.12 merge
window has settled. Is that ok for you?


Thanks,
Daniel
