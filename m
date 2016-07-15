From: thrust73@gmail.com (Cheah Kok Cheong)
Date: Fri, 15 Jul 2016 21:51:10 +0800
Subject: lib/GCD.c regression on arm
Message-ID: <20160715135109.GA2657@linux-Precision-WorkStation-T5500>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fff7fb0b2d90 ("lib/GCD.c: use binary GCD algorithm instead of Euclidean")
replaced the Euclidean algorithm totally with the Binary algorithm.
Two variants were provided and selected via Kconfig depending on whether
a fast __ffs (find least significant set bit) instruction is available.

For arm v5 and above the fast __ffs version is used as evident in
arch/arm/mm/Kconfig.

I benchmarked the gcd performance using the code provided in the commit
with a Cortex-A9 based Mediatek MT6577. Three runs at different settings
were used.

The performance with fast __ffs Binary algo is slower than the Euclidean
algo. Using the non ffs version [even/odd variant] gives a comparable
performance as the Euclidean algo.

Will be interesting to see whether this is also true for other platforms
with arm v5 and above? Hopefully others will do some testing.
If this is the case then we should "select CPU_NO_EFFICIENT_FFS" in our
Kconfig.

Thanks.
Best Regards,
Cheah

cross compiled with '-O2'

Euclidean                 Binary with ffs           Binary no ffs


gcd -r 50000 -n 10        

gcd0: elapsed 25766       gcd0: elapsed 25766       gcd0: elapsed 25765
gcd1: elapsed 19994       gcd1: elapsed 20224       gcd1: elapsed 19843
gcd2: elapsed 20071       gcd2: elapsed 20533       gcd2: elapsed 20151
gcd3: elapsed 20070       gcd3: elapsed 20380       gcd3: elapsed 19919
gcd4: elapsed 20148       gcd4: elapsed 20610       gcd4: elapsed 20151
PASS                      PASS                      PASS
           
gcd0: elapsed 26690       gcd0: elapsed 26612       gcd0: elapsed 24381
gcd1: elapsed 20224       gcd1: elapsed 20379       gcd1: elapsed 19765
gcd2: elapsed 20224       gcd2: elapsed 20304       gcd2: elapsed 19842
gcd3: elapsed 20148       gcd3: elapsed 20302       gcd3: elapsed 19919
gcd4: elapsed 20301       gcd4: elapsed 20302       gcd4: elapsed 19919
PASS                      PASS                      PASS
                                         
gcd0: elapsed 25842       gcd0: elapsed 26459       gcd0: elapsed 25457
gcd1: elapsed 20454       gcd1: elapsed 20532       gcd1: elapsed 20225
gcd2: elapsed 20378       gcd2: elapsed 20762       gcd2: elapsed 20226
gcd3: elapsed 20378       gcd3: elapsed 20378       gcd3: elapsed 20148
gcd4: elapsed 20532       gcd4: elapsed 20918       gcd4: elapsed 20301
PASS                      PASS                      PASS


gcd -r 1000 -n 100
                                            
gcd0: elapsed 245873      gcd0: elapsed 252957      gcd0: elapsed 245571
gcd1: elapsed 191290      gcd1: elapsed 198345      gcd1: elapsed 192513
gcd2: elapsed 192672      gcd2: elapsed 199579      gcd2: elapsed 192978
gcd3: elapsed 191366      gcd3: elapsed 198728      gcd3: elapsed 192283
gcd4: elapsed 193134      gcd4: elapsed 200884      gcd4: elapsed 193669
PASS                      PASS                      PASS

gcd0: elapsed 245180      gcd0: elapsed 251113      gcd0: elapsed 250573
gcd1: elapsed 191755      gcd1: elapsed 196800      gcd1: elapsed 194729
gcd2: elapsed 192286      gcd2: elapsed 198654      gcd2: elapsed 195574
gcd3: elapsed 191601      gcd3: elapsed 197344      gcd3: elapsed 194965
gcd4: elapsed 193135      gcd4: elapsed 200268      gcd4: elapsed 197037
PASS                      PASS                      PASS

gcd0: elapsed 243412      gcd0: elapsed 252189      gcd0: elapsed 247876
gcd1: elapsed 190447      gcd1: elapsed 197192      gcd1: elapsed 193355
gcd2: elapsed 192288      gcd2: elapsed 199042      gcd2: elapsed 193437
gcd3: elapsed 190755      gcd3: elapsed 198957      gcd3: elapsed 193660
gcd4: elapsed 192672      gcd4: elapsed 200346      gcd4: elapsed 194586
PASS                      PASS                      PASS


gcd -n 1000

gcd0: elapsed 2636655     gcd0: elapsed 2701340     gcd0: elapsed 2622109
gcd1: elapsed 2055411     gcd1: elapsed 2153446     gcd1: elapsed 2053342
gcd2: elapsed 2064420     gcd2: elapsed 2162496     gcd2: elapsed 2066503
gcd3: elapsed 2055151     gcd3: elapsed 2163201     gcd3: elapsed 2055161
gcd4: elapsed 2071591     gcd4: elapsed 2171636     gcd4: elapsed 2074488
PASS                      PASS                      PASS

gcd0: elapsed 2636512     gcd0: elapsed 2719436     gcd0: elapsed 2613575
gcd1: elapsed 2060157     gcd1: elapsed 2159284     gcd1: elapsed 2046187
gcd2: elapsed 2069242     gcd2: elapsed 2163944     gcd2: elapsed 2056430
gcd3: elapsed 2060436     gcd3: elapsed 2166796     gcd3: elapsed 2046933
gcd4: elapsed 2074188     gcd4: elapsed 2176243     gcd4: elapsed 2065170
PASS                      PASS                      PASS

gcd0: elapsed 2614949     gcd0: elapsed 2708342     gcd0: elapsed 2632962
gcd1: elapsed 2044957     gcd1: elapsed 2157985     gcd1: elapsed 2055475
gcd2: elapsed 2054496     gcd2: elapsed 2170720     gcd2: elapsed 2068926
gcd3: elapsed 2044838     gcd3: elapsed 2167954     gcd3: elapsed 2055305
gcd4: elapsed 2059033     gcd4: elapsed 2176002     gcd4: elapsed 2079856
PASS                      PASS                      PASS
