From: tzeng@codeaurora.org (thomas zeng)
Date: Mon, 25 Dec 2017 13:22:18 -0800
Subject: [GIT PULL] tee dynamic shm for v4.16
In-Reply-To: <CAK8P3a09za3vGW5P5xDExurTtB=s8adcvz_m-czrE4cZcorGmg@mail.gmail.com>
References: <20171215132057.ang2xawtpzp5eb6o@jax>
 <CAK8P3a09za3vGW5P5xDExurTtB=s8adcvz_m-czrE4cZcorGmg@mail.gmail.com>
Message-ID: <6acdbda2-d1b1-127c-a6e4-df30dc5e200b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017?12?21? 08:30, Arnd Bergmann wrote:
> On Fri, Dec 15, 2017 at 2:21 PM, Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
>> Hello arm-soc maintainers,
>>
>> Please pull these tee driver changes. This implements support for dynamic
>> shared memory support in OP-TEE. More specifically is enables mapping of
>> user space memory in secure world to be used as shared memory.
>>
>> This has been reviewed and refined by the OP-TEE community at various
>> places on Github during the last year. An earlier version of this pull
>> request is used in the latest OP-TEE release (2.6.0). This has also been
>> reviewed recently at the kernel mailing lists, with all comments from
>> Mark Rutland <mark.rutland@arm.com> and Yury Norov
>> <ynorov@caviumnetworks.com> addressed as far as I can tell.
>>
>> This isn't a bugfix so I'm aiming for the next merge window.
> Given that Mark and Yury reviewed this, I'm assuming this is all
> good and have now merged it. However I missed the entire discussion
> about it, so I have one question about the implementation:
>
> What happens when user space passes a buffer that is not
> backed by regular memory but instead is something it has itself
> mapped from a device with special page attributes or physical
> properties? Could this be inconsistent when optee and user
> space disagree on the caching attributes? Can you get into
> trouble if you pass an area from a device that is read-only
> in user space but writable from secure world?

Just recently, we have started to kick the tires of these "shm" related 
Gen Tee Driver patches.? And we have in the past encountered real world 
scenarios requiring some of the shared memory regions to be marked as 
"normal IC=0 and OC=0" in EL2 or SEL1, or else HW would misbehave. We 
worked around by hacking the boot code but that works if the regions are 
pre-allocated. Since now these regions can also be managed dynamically, 
we definitely agree with Arnd Bergmann that the dynamic registration SMC 
commands, and potention the SHM IOCTL commands, must convey cache 
intentions. Is it possible to take this requirement into consideration, 
in this iteration or the follow on?

>
>        Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
