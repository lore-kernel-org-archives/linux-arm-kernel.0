From: leif.lindholm@arm.com (Leif Lindholm)
Date: Mon, 21 Nov 2011 18:35:34 +0000
Subject: [PATCH] arm: Add condition code check to SWP emulator
In-Reply-To: <CAHkRjk4QZxoVmCsB1A3DVb5_WCUvN5NfbYz8PNL_7np7+wHGzQ@mail.gmail.com>
References: <CAHkRjk6Ynfh9+UbTuAtyiXCOF-yDbTNxi0ikF5ttwHViisZRZA@mail.gmail.com>
 <1321751070-7932-1-git-send-email-stepanm@codeaurora.org>
 <20111120084111.GM9581@n2100.arm.linux.org.uk>
 <CAHkRjk4QZxoVmCsB1A3DVb5_WCUvN5NfbYz8PNL_7np7+wHGzQ@mail.gmail.com>
Message-ID: <4ECA99F6.4080207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stepan, thank you for spotting this.

On 11/20/11 10:55, Catalin Marinas wrote:
> On 20 November 2011 08:41, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> There's a much better algorithm to check this.  See the bottom of
>> arch/arm/nwfpe/fpopcode.c.
>>
>> It would probably be best for there to be a common function for doing
>> this kind of check, rather than having several implementations of it
>> scattered around the kernel.
>
> That's what Leif started doing.

Yes, I put together an RFC patch set based on that.
But rather than duplicating code, I was looking to break it out for 
generic use. And then it was pointed out to me that we also have an 
additional implementation in kernel/kprobes-test.c (test_check_cc()).

I forgot to add the cover message on the set I just submitted to the 
linux-arm-kernel list, but it was meant to say:
---
There are several locations in the kernel where software needs to
inspect the condition codes of trapped instructions. The original
bitmask implementation in the nwfpe code does this in an efficient
manner. This series breaks this code out of nwfpe/fpopcode.{ch} into
a standalone file for opcode operations, and contains additional
patches to kprobes and SWP eumlation to use this interface.
---

/
     Leif
