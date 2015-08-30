From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Sun, 30 Aug 2015 23:47:20 +0200
Subject: [PATCH] lib: Make _find_next_bit helper function inline
In-Reply-To: <55E1CC83.1010007@gmail.com> (Yury's message of "Sat, 29 Aug 2015
 18:15:15 +0300")
References: <1438110564-19932-1-git-send-email-cburden@codeaurora.org>
 <55B7F2C6.9010000@gmail.com>
 <20150728144537.67d46b5714c99d25f0bb33fb@linux-foundation.org>
 <1438176656.18723.8.camel@ceres> <55B93A47.90107@codeaurora.org>
 <CALW4P+LU2iLkT7d=BiaC_=oSJ6K_g152VsVSjfcQGUKx_5q4tQ@mail.gmail.com>
 <55E1CC83.1010007@gmail.com>
Message-ID: <87si701maf.fsf@rasmusvillemoes.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've lost track of what's up and down in this, but now that I look at
this again let me throw in my two observations of stupid gcc behaviour:
For the current code, both debian's gcc (4.7) and 5.1 partially inlines
_find_next_bit, namely the "if (!nbits || start >= nbits)" test. I know it
does it to avoid a function call, but in this case the early return
condition is unlikely, so there's not much to gain. Moreover, it fails
to optimize the test to simply "if (start >= nbits)" - everything being
unsigned, these are obviously equivalent.

Rasmus
