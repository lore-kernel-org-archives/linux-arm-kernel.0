From: sophian.yoma@gmail.com (yoma sophian)
Date: Wed, 27 May 2015 20:24:04 +0800
Subject: some question about arm64 smp_spin_table.c
In-Reply-To: <20150527103644.GE8439@leverpostej>
References: <CADUS3o=4b9zfKtyiZ2CKgC2AA9ntkFLo91pJug17t1Xz2jM34w@mail.gmail.com>
 <20150527103644.GE8439@leverpostej>
Message-ID: <CADUS3okgaMGYfKkY7eBWjVvdKyfGjyp5hx0uaRWj5a1Y98+ocQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Mark:

2015-05-27 18:36 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> On Wed, May 27, 2015 at 10:47:09AM +0100, yoma sophian wrote:
>> hi all:
>
> Hi,
>
>> in arm64/kernel/smp_spin_table.c
>>     --> smp_spin_table_prepare_cpu,
>> we suppose the cpu_release_addr[cpu] is located in kernel logical memory.
>>
>> in Arm plarform, this part is implement by each platform driver, since
>> they register its own smp_operations.
>>
>> And in Arm64, once other platform use different area, such as register
>> or device memory, to put cpu_release_addr[cpu], shall we use ioremap
>> to get the va like below patch?
>
> Platforms need to place the release address in memory which can be
> mapped with cacheable attributes. That is required by the semantics of
> memreserve (which implies a cacheable mapping is fine).
>
> Since commit 113954c6463d1d80 ("arm64: spin-table: handle unmapped
> cpu-release-addrs") we allowed for cpu-release-addrs which did not fall
> in the linear mapping, by using ioremap_cache. This still requires that
> the memory can be mapped cacheable.
Oops, I use kernel 3.10 and that is why I didn't see your patch before :)

BTW, as I explained to Arnd, in booting.txt, it didn't mentioned the
cpu-release-addrs has to be cacheable.
why we need the address mapped as cacheable?

> As Arnd says, if the cpu-release-addr is not in memory which can be
> mapped as cacheable, then you're arguably not implementing spin-table.
> There are a whole slew of coherency issues that the current
> implementation avoids by being very simple, and I'm not keen about
> prospect of changing that.
is there any special requirement we need to follow when using spin-table mode?
>
> Is there any particular reason that you do not wish to place your
> cpu-release-addrs in memory?
for not make address with a hole to put spin address and put that area
as seperate power domain.
we use registers for other core spin jumping address.

Appreciate your kind help,
