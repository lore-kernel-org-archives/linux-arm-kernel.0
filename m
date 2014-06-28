From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Sat, 28 Jun 2014 16:35:12 -0500
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <20140628201120.GK32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <20140628152609.GH32514@n2100.arm.linux.org.uk> <53AEE9B6.7000609@mentor.com>
 <20140628181212.GJ32514@n2100.arm.linux.org.uk> <53AF1B65.5000904@mentor.com>
 <20140628201120.GK32514@n2100.arm.linux.org.uk>
Message-ID: <53AF3510.7030707@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2014 03:11 PM, Russell King - ARM Linux wrote:
> On Sat, Jun 28, 2014 at 02:45:41PM -0500, Nathan Lynch wrote:
>> On 06/28/2014 01:12 PM, Russell King - ARM Linux wrote:
>>> I know that I'm probably many years away from it, even if Ubuntu
>>> adopt it for something recent - I'm rather stuck with 12.04 due to
>>> the move towards requiring 3D GPU acceleration in later versions.
>>> It seems that the choices on ARM now are to either have a crippled
>>> distro through lack of open GPU support, or stick with an old distro
>>> that doesn't require GPUs.
>>
>> Based on other messages from you on the ML I'm assuming you have an
>> i.MX6 system in mind?  (Forgive me if I'm wrong.)  On any Cortex-A9 or
>> -A8 the VDSO isn't going to be any great benefit anyway.  Those CPUs
>> don't implement the generic timers extension, so only clock_gettime()
>> with low-resolution clock ids will see a speedup.  And few programs use
>> those, to my knowledge.
>>
>> A15, A7, and I'm pretty sure A12 and A17 all implement the timer
>> extension and will see full benefit.  Some Qualcomm CPUs too, I think.
> 
> Here's the results from vdsotest... yes on iMX6 as that's the most
> advanced bootable system I have:
> 
> clock-gettime-monotonic system calls per second: 1601780
> clock-gettime-monotonic vdso calls per second:   1600862 (1.00x speedup)
> clock-getres-monotonic system calls per second: 3001396
> clock-getres-monotonic vdso calls per second:   52163259 (17.38x speedup)
> clock-gettime-monotonic-coarse system calls per second: 2824631
> clock-gettime-monotonic-coarse vdso calls per second:   13760820 (4.87x speedup)
> clock-getres-monotonic-coarse system calls per second: 3166932
> clock-getres-monotonic-coarse vdso calls per second:   52111805 (16.45x speedup)
> clock-gettime-realtime system calls per second: 1596863
> clock-gettime-realtime vdso calls per second:   1590424 (1.00x speedup)
> clock-getres-realtime system calls per second: 2993748
> clock-getres-realtime vdso calls per second:   52123753 (17.41x speedup)
> clock-gettime-realtime-coarse system calls per second: 3007894
> clock-gettime-realtime-coarse vdso calls per second:   17081617 (5.68x speedup)
> clock-getres-realtime-coarse system calls per second: 3072073
> clock-getres-realtime-coarse vdso calls per second:   49401452 (16.08x speedup)
> Note: vDSO version of getcpu not found
> getcpu system calls per second: 4902323
> getcpu vdso calls per second:   4972290 (1.01x speedup)
> Note: vDSO version of getcpu not found
> Note: vDSO version of getcpu not found
> gettimeofday system calls per second: 1637099
> gettimeofday vdso calls per second:   1637573 (1.00x speedup)

That's consistent with my results on iMX6.  The reported 1.00x "speedup"
for clock-gettime-monotonic etc indicates the VDSO is falling back to
syscall.

Thanks for testing.
