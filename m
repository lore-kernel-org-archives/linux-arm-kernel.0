From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 29 Jun 2018 15:18:31 +0200
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180629112613.7i4xesjyxolc63gu@ltop.local>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110419.GC26019@e103592.cambridge.arm.com>
 <20180629112613.7i4xesjyxolc63gu@ltop.local>
Message-ID: <CAAeHK+zXzTEo_DJ5a7KaVDQa06Gx98Oj2O3jMFJo_tNgkq822g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 1:26 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Jun 29, 2018 at 12:04:22PM +0100, Dave Martin wrote:
>>
>> Can sparse be hacked to identify pointer subtractions where the pointers
>> are cannot be statically proved to point into the same allocation?

Re all the comments about finding all the places where we do pointer
subtraction/comparison:

I might be wrong, but I doubt you can easily do that with static analysis.

What we could do is to try to detect all such subtractions/comparisons
dynamically. The idea is to instrument all pointer/ulong
subtraction/comparison instructions and try to detect tags mismatch.
And then run some workload (e.g. syzkaller) to trigger more kernel
code. The question is how much false positives we would get, since I
imagine there would be a number of cases when we compare some random
ulongs.
