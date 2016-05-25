From: davem@davemloft.net (David Miller)
Date: Wed, 25 May 2016 14:28:21 -0700 (PDT)
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <6407614.fdv5XFSBue@wuerfel>
References: <6293194.tGy03QJ9ME@wuerfel>
 <20160525.135039.244098606649448826.davem@davemloft.net>
 <6407614.fdv5XFSBue@wuerfel>
Message-ID: <20160525.142821.1719403997976778673.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 May 2016 23:01:06 +0200

> On Wednesday, May 25, 2016 1:50:39 PM CEST David Miller wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Wed, 25 May 2016 22:47:33 +0200
>> 
>> > If we use the normal calling conventions, we could remove these overrides
>> > along with the respective special-case handling in glibc. None of them
>> > look particularly performance-sensitive, but I could be wrong there.
>> 
>> You could set the lowest bit in the system call entry pointer to indicate
>> the upper-half clears should be elided.
> 
> Right, but that would introduce an extra conditional branch in the syscall
> hotpath, and likely eliminate the gains from passing the loff_t arguments
> in a single register instead of a pair.

Ok, then, how much are you really gaining from avoiding a 'shift' and
an 'or' to build the full 64-bit value?  3 cycles?  Maybe 4?

And the executing the wrappers, those have a non-trivial cost too.

Cost wise, this seems like it all cancels out in the end, but what
do I know?
