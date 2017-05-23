From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 May 2017 09:54:38 +0200
Subject: [PATCH] clk: sunxi-ng: select SUNXI_CCU_MULT for sun8i-a83t
In-Reply-To: <20170523071940.xbnahikb4d5dge7v@wens.csie.org>
References: <20170522202951.2896280-1-arnd@arndb.de>
 <20170523005553.GH20170@codeaurora.org>
 <20170523071940.xbnahikb4d5dge7v@wens.csie.org>
Message-ID: <CAK8P3a37CT0tzdy4V8Hj=-Mu=JrdR08zv2fqVH5Y+hzT7OK4Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 9:19 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, May 22, 2017 at 05:55:53PM -0700, Stephen Boyd wrote:
>> On 05/22, Arnd Bergmann wrote:
>> > We get a link error when CCU_MULT is not set with the
>> > newly added driver:
>> >
>> > drivers/clk/sunxi-ng/ccu-sun8i-a83t.o:(.data.__compound_literal.1+0x4): undefined reference to `ccu_mult_ops'
>> > drivers/clk/sunxi-ng/ccu-sun8i-a83t.o:(.data.__compound_literal.3+0x4): undefined reference to `ccu_mult_ops'
>> >
>> > Fixes: 46b492116666 ("clk: sunxi-ng: Add driver for A83T CCU")
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
>> Is there any way we can automate finding these build errors and
>> prevent them from creeping into the tree? It may be asking too
>> much, but it seems like we should be able to find these
>> particular problems with some script that greps for ccu_*_ops and
>> checks that any file's Kconfig symbol also has that selected.
>>
>> Anyway, I'm just tired of seeing these sorts of things in my
>> inbox.

Definitely, I'm also tired of writing the patches ;-)

> The (ugly) script below does the trick, though it does give results
> for some symbols that are indirectly selected:
>
> SUN5I_CCU uses SUNXI_CCU_GATE but does not select it
> SUN5I_CCU uses SUNXI_CCU_MUX but does not select it

I think they are all caught implicitly, otherwise I would have run
into them.

> SUN5I_CCU uses SUNXI_CCU_NKMP but does not select it

I sent a patch for this on Feb 14 and again March 13, but haven't
gotten around to resubmit again.

An alternative would be to remove all the dependencies as 'lib-y'
in the Makefile and remove the individual Kconfig symbols. That
way, we would always build all of them when CONFIG_SUNXI_CCU
is enabled, but the linker would drop the ones that do not get
referenced.

         Arnd
