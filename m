From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Oct 2016 17:32:48 +0200
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <4333753.kxspqi1Miz@wuerfel> (Arnd Bergmann's message of "Wed, 19
 Oct 2016 17:11:40 +0200")
References: <20161017183806.GG5601@arm.com>
 <CAKv+Gu_ts83bKc4mYujf7NnzGVHoxP7TXgHbFxSgb9LkxH=wXQ@mail.gmail.com>
 <CAKv+Gu_wJWCtQGfQv2V_tNq+zygMzbassEa92c5sx90w0TW4vw@mail.gmail.com>
 <4333753.kxspqi1Miz@wuerfel>
Message-ID: <87pomwcq1r.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mer., oct. 19 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday, October 19, 2016 4:01:58 PM CEST Ard Biesheuvel wrote:
>> On 19 October 2016 at 15:59, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 19 October 2016 at 14:35, Will Deacon <will.deacon@arm.com> wrote:
>> >> On Mon, Oct 17, 2016 at 08:43:19PM +0100, Ard Biesheuvel wrote:
>> >>> On 17 October 2016 at 19:38, Will Deacon <will.deacon@arm.com> wrote:
>> >
>> > Yes, and that would be perfectly legal from a correctness point of
>> > view, and would likely help performance as well. By using
>> > __builtin_constant_p(), you are choosing to perform a build time
>> > evaluation of an expression that would ordinarily be evaluated only at
>> > runtime. This implies that you have to address undefined behavior at
>> > build time rather than at runtime as well.
>> >
>> >>> If order_base_2() is not defined for input 0, it should BUG() in that
>> >>> case, and the associated __builtin_unreachable() should prevent the
>> >>> special version from being emitted. If order_base_2() is defined for input
>> >>> 0, it should not invoke ilog2() with that argument, and the problem should
>> >>> go away as well.
>> >>
>> >> I don't necessarily think it should BUG() if it's not defined for input
>> >> 0; things like __ffs don't do that and we'd be introducing conditional
>> >> checks for cases that should not happen. The comment above order_base_2
>> >> does suggest that ob2(0) should return 0, but it can actually end up
>> >> invoking ilog2(-1), which is obviously wrong.
>> >>
>> >> I could update the comment, but that doesn't fix the build issue.
>> >>
>> >
>> > Fixing roundup_pow_of_two() [which is arguably incorrect]
>> 
>> I just spotted the comment that says it is undefined. But that means
>> it could legally return 1 for input 0, i suppose
>
> I think having the link error in roundup_pow_of_two() is safer than
> returning 1.
>
> Why not turn it into a runtime warning in this driver?
>
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index cecb0fdfaef6..711d1d9842cc 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -349,8 +349,10 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
>  			rate->reg = reg + (u64)rate->reg;
>  			for (clkt = rate->table; clkt->div; clkt++)
>  				table_size++;
> -			rate->width = order_base_2(table_size);
> -			rate->lock = lock;
> +			if (!WARN_ON(table_size == 0)) {
> +				rate->width = order_base_2(table_size);
> +				rate->lock = lock;
> +			}

With the way the data are constructed in the driver I don't see how the
table_size can be 0.

However I understand it is more something for the compiler.

In this case it is better to nullify the rate_hw as having width=0 will
lead to trouble in the clk_divider operations


If it is the needed solution for this build error I can submit this kind
of patch:
diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 45905fc0d75b..dbc49359406d 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -345,11 +345,16 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
                        const struct clk_div_table *clkt;
                        int table_size = 0;
 
-                       rate->reg = reg + (u64)rate->reg;
                        for (clkt = rate->table; clkt->div; clkt++)
                                table_size++;
-                       rate->width = order_base_2(table_size);
-                       rate->lock = lock;
+                       if (!WARN_ON(table_size == 0)) {
+                               rate->reg = reg + (u64)rate->reg;
+                               rate->width = order_base_2(table_size);
+                               rate->lock = lock;
+                       } else {
+                               rate_hw = NULL;
+                               rate_ops = NULL;
+                       }
                }
        }


Gregory

>  		}
>  	}
>  
>
> 	
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
