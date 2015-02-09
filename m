From: freddy77@gmail.com (Frediano Ziglio)
Date: Mon, 9 Feb 2015 15:51:48 +0000
Subject: Kexec and KVM not working gracefully together
In-Reply-To: <1423454089.4605.1.camel@infradead.org>
References: <CAHt6W4cuRi3bfj5mryFouhOLGAAWuNXKVvz4K-rAjQnwiegL-Q@mail.gmail.com>
 <54C7ADF0.8090102@arm.com> <54D30AE0.5050101@linaro.org>
 <20150205094317.43f8554a@arm.com> <54D34592.9010903@linaro.org>
 <CAHt6W4dS-fv0U+=ch1-=X36EpyE5FA89aY8LVqbFP0+R3GvLqw@mail.gmail.com>
 <54D37108.9020103@arm.com>
 <CAHt6W4cckuuK+=1ZHNUEEW5BuiyiGNc2CeuP9O7MaC0WpScZoA@mail.gmail.com>
 <CAHt6W4eQ3iC+sqWAn5LkkfC-XBgGWR0i6TXjWvzEsUqFh75fwQ@mail.gmail.com>
 <54D43F52.7030606@linaro.org>
 <CAHt6W4eQ1q+JxmB2o4MigDF+Li98iYhBfg2KXTTq3wGcNSCKMw@mail.gmail.com>
 <54D49DD5.3010202@linaro.org>
 <CAHt6W4f-maGM75toP1TJV8wCZpZC3+ER9KqAnASJPhK8f_+aqg@mail.gmail.com>
 <1423454089.4605.1.camel@infradead.org>
Message-ID: <CAHt6W4dWqQhEN5xPSJ5zMbiftO2GCfwfbF=qTksxFMh_RE-Q4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-09 3:54 GMT+00:00 Geoff Levand <geoff@infradead.org>:
> Hi Frediano,
>
> On Fri, 2015-02-06 at 12:14 +0000, Frediano Ziglio wrote:
>> 2015-02-06 10:56 GMT+00:00 AKASHI Takahiro <takahiro.akashi@linaro.org>:
>> >> Frediano Ziglio wrote:
>> >> The kernel code is supposed (at least in ARMv7) to run in SVC mode,
>> >> not on HYP mode. One reason is that code that change SCTLR executed at
>> >> HYP instead of SVC would not change current mode system control
>> >> register. The function does not revert to HYP for this reason.
>> >
>> > I need understand what you mentioned here, but for arm64, Geoff's kexec lets
>> > the boot cpu in hyp mode at soft_restart().
>>
>> Where's Geoff code? Note however that is not maintainable in this way
>> as people have to consider that future code could execute in either
>> HYP or SVC mode. Did you test that all code called from soft_restart
>> could do it?
>
> Basically, when a CPU is reset it needs to be put into the exception
> level it had when it first entered the kernel.
>
> I have my arm64 kernel patches here:
>
>   https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
>
> The patches related to CPU reset are:
>
>   arm64: Convert hcalls to use ISS field
>   arm64: Add new hcall HVC_CALL_FUNC
>   arm64: Add EL2 switch to soft_restart
>
> -Geoff
>
>

Thank you! This helps a lot.

There are some differences in our patches:
- your patches works only with kvm disabled (from
https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git/commit/?id=cdd634d6018d00cefc595f02c4341d3f7c1f0c47
you avoid EL2 switch if KVM is enabled);
- you started using immediate from ERS
(https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git/commit/?id=637faeaf6301208315c62be7a13713d50aa3a294).
I proposed (without knowing your patches) a similar solution.
Personally I think that function pointers can be removed and you could
use some indexing. The function you can call are very limited and
using indexes would be possibly in all vectors cases (stub,
initialization, kvm);
- you changed cpu_reset to accept an additional parameter and check if
calling the EL2 switch code while I added a kvm_cpu_reset which does
the switch or call the old cpu_reset. Well... here I think it's just a
question of style. I like both. In arm32 there is no cpu_soft_restart
so our code looks quite different;
- missing the kvm part you don't take into consideration flushing the
cache from EL2 mode. My tests confirm that not flushing cache cause
memory corruptions. My solution is to have an HYP call that turn off
caching and then one that jump to physical code after switching off
mmu. Perhaps a bit convoluted but works.

For paranoia check for functions (HVC_CALL_HYP,
https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git/commit/?id=a0a397cf6736b1ccfed7c8e9735a64dac1fb6304)
should be the first as in the fast path is the most likely.

I think HVC_CALL_FUNC can be misleading. At the end it will call a
function from EL2 but also with cache and MMU disabled.

Frediano
