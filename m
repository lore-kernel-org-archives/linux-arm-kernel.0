From: anup@brainfault.org (Anup Patel)
Date: Wed, 14 Aug 2013 22:06:23 +0530
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <394887c7adffc3a3df0733329a9b5fb3@www.loen.fr>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
 <CAAhSdy2TctgKk7m48S7jUCMr2dkDoeyT-r=-SMX+_Ce-sUimYA@mail.gmail.com>
 <38A6DD0E-5639-43BB-8318-32D59923E309@suse.de>
 <19553bad1c8427526f6e9a87d605ade3@www.loen.fr>
 <CAFEAcA_Sexa36nq8r2YsuPptcKFcKytfwGEYi+xm-DO+3j1iSw@mail.gmail.com>
 <394887c7adffc3a3df0733329a9b5fb3@www.loen.fr>
Message-ID: <CAAhSdy3oqDQ5ZrbXMpasFMVgseo-Rt6yFd07Hz7MU-0oD1JV3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 9:27 PM, Marc Zyngier <maz@misterjones.org> wrote:
> On 2013-08-14 16:41, Peter Maydell wrote:
>> On 14 August 2013 16:34, Marc Zyngier <maz@misterjones.org> wrote:
>>> When userspace loads the kernel into memory, the kernel is not
>>> flushed
>>> to RAM, and may sit in the L3 cache if the cache is big enough. You
>>> end-up executing garbage... My proposed fix is to let kvmtool do the
>>> flushing, as we have userspace cache management operations for this
>>> exact purpose.
>>
>> Why does this issue only apply to the loaded kernel and not to
>> the zero bytes in the rest of RAM? I know executing zeroes
>> isn't a very useful thing to do but it should be a well defined
>> thing.
>
> Good point, and not quite sure just yet. Probably we get a zeroed,
> clean page?

This would apply to zeroed pages too if some Guest OS expects
zeroed-out portions in Guest RAM.

>
> Anup, can you elaborate on how your L3 cache behaves?

The L3-cache is transparent to Aarch64 CPUs. It is only bypassed
when caching is disabled or when accessing non-cacheable pages.
Currently, we cannot disclose more details about line allocation and
replacement policy because APM X-Gene specs are not released.

The issue pointed out by this patch would also apply to L2-cache
(i.e. L3-cache disabled) but it usually does not manifest because
L2-cache is not too big (few hundred KBs) and so dirty lines don't
stay for long time in L2-cache.

>
> Thanks,
>
>          M.
> --
> Who you jivin' with that Cosmik Debris?
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

Regards,
Anup
