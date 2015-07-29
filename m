From: cburden@codeaurora.org (Cassidy Burden)
Date: Wed, 29 Jul 2015 13:40:39 -0700
Subject: [PATCH] lib: Make _find_next_bit helper function inline
In-Reply-To: <1438176656.18723.8.camel@ceres>
References: <1438110564-19932-1-git-send-email-cburden@codeaurora.org>
 <55B7F2C6.9010000@gmail.com>
 <20150728144537.67d46b5714c99d25f0bb33fb@linux-foundation.org>
 <1438176656.18723.8.camel@ceres>
Message-ID: <55B93A47.90107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I changed the test module to now set the entire array to all 0/1s and
only flip a few bits. There appears to be a performance benefit, but
it's only 2-3% better (if that). If the main benefit of the original
patch was to save space then inlining definitely doesn't seem worth the
small gains in real use cases.

find_next_zero_bit (us)
old      new     inline
14440    17080   17086
4779     5181    5069
10844    12720   12746
9642     11312   11253
3858     3818    3668
10540    12349   12307
12470    14716   14697
5403     6002    5942
2282     1820    1418
13632    16056   15998
11048    13019   13030
6025     6790    6706
13255    15586   15605
3038     2744    2539
10353    12219   12239
10498    12251   12322
14767    17452   17454
12785    15048   15052
1655     1034    691
9924     11611   11558

find_next_bit (us)
old      new     inline
8535     9936    9667
14666    17372   16880
2315     1799    1355
6578     9092    8806
6548     7558    7274
9448     11213   10821
3467     3497    3449
2719     3079    2911
6115     7989    7796
13582    16113   15643
4643     4946    4766
3406     3728    3536
7118     9045    8805
3174     3011    2701
13300    16780   16252
14285    16848   16330
11583    13669   13207
13063    15455   14989
12661    14955   14500
12068    14166   13790

On 7/29/2015 6:30 AM, Alexey Klimov wrote:
> I will re-check on another machine. It's really interesting if
> __always_inline makes things better for aarch64 and worse for x86_64. It
> will be nice if someone will check it on x86_64 too.

Very odd, this may be related to the other compiler optimizations Yuri
mentioned?
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
