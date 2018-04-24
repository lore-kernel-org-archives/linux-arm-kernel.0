From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 24 Apr 2018 17:56:39 +0200
Subject: [PATCH] arm64: export tishift functions to modules
In-Reply-To: <20180424154055.GC25964@arm.com>
References: <CAHmME9oO_5X6M3NLe2tWp=ZY5EQY17GQ6BUomHLBscMejiXTvw@mail.gmail.com>
 <20180424154055.GC25964@arm.com>
Message-ID: <CAHmME9oa-DX721K_yRe14AbLk5-raOXEji2SWsf41UtUTP=guQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 5:40 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Apr 24, 2018 at 03:43:04PM +0200, Jason A. Donenfeld wrote:
>> On Tue, Apr 24, 2018 at 3:34 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > I've not run into any build issues here -- is this specifically with some
>> > out-of-tree module?
>>
>> I received a bug report email about this. I'm not sure which specific
>> module, and I assumed from the email that it was actually a result of
>> in-tree configuration options rather than an out-of-tree module, but
>> I'm not sure exactly. Either way, I was able to reproduce the problem
>> by coding up a little PoC out-of-tree module, so it is certainly a
>> real problem.
>
> Any chance you could share the module, please? I tried to write one but
> the compiler just inlines the __in128 arithmetic.

Sure. I didn't save my original but just cooked a new one up and
verified it errors out. The below will get these errors on mainline
when compiled as a module, even as an in-tree module:

ERROR: "__lshrti3" [uhohspehgettio.ko] undefined!
ERROR: "__ashlti3" [uhohspehgettio.ko.ko] undefined!


#include <linux/module.h>

__uint128_t global1, global2;
__uint128_t addrs[8];

void do_something(__uint128_t a, unsigned int idx)
{
        addrs[idx] = a;
}

static int __init mod_init(void)
{
        do_something(global1 >> global2, (global2 << global1) & 7);
        return 0;
}

module_init(mod_init);
MODULE_LICENSE("GPL v2");
