From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 28 Nov 2010 00:56:13 +0900
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <1284522014.517347.33297989274.1.gpush@pororo>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<1284522014.517347.33297989274.1.gpush@pororo>
Message-ID: <AANLkTimuw=FfHn7KtbkNSgwqAkS-6CKA4Rx=-dac-dhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 15, 2010 at 12:40 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> We currently have 21 definitions of struct clk in the ARM architecture,
> each defined on a per-platform basis. This makes it difficult to define
> platform- (or architecture-) independent clock sources without making
> assumptions about struct clk, and impossible to compile two
> platforms with different struct clks into a single image.
>
> This change is an effort to unify struct clk where possible, by defining
> a common struct clk, containing a set of clock operations. Different
> clock implementations can set their own operations, and have a standard
> interface for generic code. The callback interface is exposed to the
> kernel proper, while the clock implementations only need to be seen by
> the platform internals.
>
> This allows us to share clock code among platforms, and makes it
> possible to dynamically create clock devices in platform-independent
> code.
>
> Platforms can enable the generic struct clock through
> CONFIG_USE_COMMON_STRUCT_CLK. In this case, the clock infrastructure
> consists of a common struct clk:
>
> struct clk {
> ? ? ? ?const struct clk_ops ? ?*ops;
> ? ? ? ?unsigned int ? ? ? ? ? ?enable_count;
> ? ? ? ?struct mutex ? ? ? ? ? ?mutex;
> };
>
> And a set of clock operations (defined per type of clock):
>
> struct clk_ops {
> ? ? ? int ? ? ? ? ? ? (*enable)(struct clk *);
> ? ? ? void ? ? ? ? ? ?(*disable)(struct clk *);
> ? ? ? unsigned long ? (*get_rate)(struct clk *);
> ? ? ? [...]
> };
>
> To define a hardware-specific clock, machine code can "subclass" the
> struct clock into a new struct (adding any device-specific data), and
> provide a set of operations:
>
> struct clk_foo {
> ? ? ? ?struct clk ? ? ?clk;
> ? ? ? ?void __iomem ? ?*some_register;
> };
>
> struct clk_ops clk_foo_ops = {
> ? ? ? ?.get_rate = clk_foo_get_rate,
> };
>
> The common clock definitions are based on a development patch from Ben
> Herrenschmidt <benh@kernel.crashing.org>.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

Hi Jeremy,

  Are you planning to revise the patch-set or just taking time to
resubmit as such?

Thanks.
