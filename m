From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Aug 2015 13:14:48 +0200
Subject: [PATCH 7/7] ARM: redo TTBR setup code for LPAE
In-Reply-To: <20150805160112.GZ7557@n2100.arm.linux.org.uk>
References: <20150506103000.GF2067@n2100.arm.linux.org.uk>
 <E1YpwbQ-0000wm-Jx@rmk-PC.arm.linux.org.uk>
 <55C22B21.8000700@free-electrons.com>
 <20150805160112.GZ7557@n2100.arm.linux.org.uk>
Message-ID: <55C341A8.5040504@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2015 18:01, Russell King - ARM Linux wrote:
> On Wed, Aug 05, 2015 at 05:26:25PM +0200, Gregory CLEMENT wrote:
>> It seems that since the merge of this commit the secondary CPUs on
>> Armada XP failed to come online in Big Endian (my configuration is
>> mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y).
> 
> That's probably because I don't test big endian at all, never have done,
> and I suspect never will as I've never had systems using BE.  So, I regard
> BE as something of a troublesome untestable burden on kernel development.
> (And I've always regarded BE to be an abomination.)  In short, I loath
> big endian, which really doesn't bode well for me not constantly cocking
> it up...
> 
> My guess is that it all comes down to much of the new code expecting the
> value in r4/r5 to be the least significant 32bits in r4 and the most
> significant 32bits in r5.  However, in the secondary code, we load this
> using ldrd, which on BE probably reverses that.

Thanks for the explanation.

> 
>> Once I found that this commit introduced the regression I also tested
>> but with LPAE but I had the same result: only the first CPU boot.
> 
> Not surprising.  I guess BE would need the two registers to mcrr reversing
> if they were a 64-bit value loaded with ldrd.
> 
> The simple answer may just be to swap r4/r5 after the ldrd.  

I tried this and it fixed the issue.
I will send a patch shortly and if you agree I will submit it to your
patch system.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
