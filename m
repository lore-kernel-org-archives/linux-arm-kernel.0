From: thrust73@gmail.com (Cheah Kok Cheong)
Date: Tue, 19 Jul 2016 14:52:47 +0800
Subject: lib/GCD.c regression on arm
In-Reply-To: <20160718201549.61f135c8@xhacker>
References: <20160715135109.GA2657@linux-Precision-WorkStation-T5500>
 <20160718201549.61f135c8@xhacker>
Message-ID: <20160719065247.GA3741@linux-Precision-WorkStation-T5500>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jisheng,
 Looks like you have found another kind of problem with arm64.
That's a big hit in 64bit.

On Mon, Jul 18, 2016 at 08:15:49PM +0800, Jisheng Zhang wrote:
> Dear Cheah,
> 
> Interesting, using the code in the commit, I get the following result
> on A CA53 platform
> 
> build with aarch64 toolchain, -O2 -mcpu=cortex-a53
> 
> ~ # /a53 -r 500000 -n 10
> gcd0: elapsed 10170
> gcd1: elapsed 11340
> gcd2: elapsed 13590
> gcd3: elapsed 11700
> gcd4: elapsed 14230
> PASS
> 
> build with armhf toolchain, -O2 -mcpu=cortex-a53
> 
> ~ # /a53_32 -r 500000 -n 10
> gcd0: elapsed 9490
> gcd1: elapsed 10220
> gcd2: elapsed 10790
> gcd3: elapsed 10270
> gcd4: elapsed 10850
> PASS
> 

> On Fri, 15 Jul 2016 21:51:10 +0800 Cheah Kok Cheong wrote:
> 
> > Commit fff7fb0b2d90 ("lib/GCD.c: use binary GCD algorithm instead of Euclidean")
> > replaced the Euclidean algorithm totally with the Binary algorithm.
> > Two variants were provided and selected via Kconfig depending on whether
> > a fast __ffs (find least significant set bit) instruction is available.
> > 
> > For arm v5 and above the fast __ffs version is used as evident in
> > arch/arm/mm/Kconfig.
> > 
> > I benchmarked the gcd performance using the code provided in the commit
> > with a Cortex-A9 based Mediatek MT6577. Three runs at different settings
> > were used.
> > 
> > The performance with fast __ffs Binary algo is slower than the Euclidean
> > algo. Using the non ffs version [even/odd variant] gives a comparable
> > performance as the Euclidean algo.
