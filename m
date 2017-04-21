From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Apr 2017 00:12:39 +0200
Subject: [PATCH v3 6/7] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class
 cpus
In-Reply-To: <7eb9a87f-9b61-1367-311c-bc37430291e5@arm.com>
References: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
 <1489137839-549-7-git-send-email-vladimir.murzin@arm.com>
 <CAK8P3a1UH1qfCi5FC0aKxJvG=CNKOGSKbiU6Nz=0GA6Jit5Cpg@mail.gmail.com>
 <7eb9a87f-9b61-1367-311c-bc37430291e5@arm.com>
Message-ID: <CAK8P3a0zu5q4wY-BDk4B8UAs83bSoo=gvDruW0tVZhCZjq7M7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 4:10 PM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> On 19/04/17 11:02, Arnd Bergmann wrote:

>> Can you either modify the description to explain why we now need this on
>> all ARMv7M, or add a '|| CPU_V7M' for the 'bool' line to make it optional?
>>
>> Would it be better to leave the default as disabled on CPU_V7M and
>> require users to enable it manually? That way we don't regress the
>> performance of readl/writel on platforms that don't need this.
>>
>
> It is architectural vs implementation differences. Even though existing
> implementations rarely need this sticking with architecture (it permits memory
> re-ordering to happen in many cases) makes code more robust and save some
> debugging time when more sophisticated implementations go wild (see, for
> instance, 8e02676ffa69 "ARM: 8610/1: V7M: Add dsb before jumping in handler
> mode"). We can consider making it user selectable if performance regressions
> are reported.

I would expect the performance difference to be noticeable, even though
MMIO tends to be a rather slow operation, having tons of barriers in drivers
that don't do DMA but transfer data through a series of writel() can be
significant.

      Arnd
