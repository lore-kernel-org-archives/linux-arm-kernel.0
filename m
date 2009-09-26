From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 26 Sep 2009 23:58:11 +0200
Subject: About ARM TCM patch
In-Reply-To: <63386a3d0909250215k50f10a44qae55da31f97f99c0@mail.gmail.com>
References: <4ABC1D1D.6050506@gmail.com>
	<63386a3d0909250215k50f10a44qae55da31f97f99c0@mail.gmail.com>
Message-ID: <63386a3d0909261458kda21ae0q5af3b07bfc0c4e87@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/25 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2009/9/25 Peter Chen <hzpeterchen@gmail.com>:

>> 1. After MMU open, the code running at ITCM can't see physical address for
>> register.
>>
>> 2. After MMU open, the code can't run at physical addressed ITCM.
>
> Could this be different between ARM9 (which I use) and ARM11?

Thinking about it this rings a bell. I know it behaves like described on ARM9,
so code executing in TCM can only "see" physical memory.

But one difference between the ARM9 and ARM11 families is that the cache
is mapped to virtual (MMU:ed) address space in ARM9 and to physical address
space in ARM11 is it not? (Is this so already in ARM10 BTW?)

So just thinking intuitively about it, as a TCM memory is very close to what
a cache is to the CPU I think it's something like this on ARM9:

     CPU
     / \
Cache   TCM
  |      |
 MMU     |
  |      |
External memory interface

But on ARM11 (ARM10?):

     CPU
      |
     MMU
     / \
Cache   TCM
  |
External memory interface

Is that correct more or less? Catalin would you happen to know this?

Anyway the code should still work actually, since we make a 1-1 memory
map anyway. But you cannot place the TCM in the memory locations I
chose for U300 since these are occupied on ARM11.

Linus Walleij
