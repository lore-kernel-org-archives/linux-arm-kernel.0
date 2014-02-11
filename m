From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 11 Feb 2014 10:23:38 -0600
Subject: [RFC/PATCH v2] ARM: vDSO gettimeofday using generic timer
 architecture
In-Reply-To: <20140211104553.GD8693@mudshark.cambridge.arm.com>
References: <1391814349-10706-1-git-send-email-nathan_lynch@mentor.com>
 <20140209102023.GL26684@n2100.arm.linux.org.uk> <52F9675F.1040403@mentor.com>
 <20140211104553.GD8693@mudshark.cambridge.arm.com>
Message-ID: <52FA4E8A.5010508@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2014 04:45 AM, Will Deacon wrote:
> On Mon, Feb 10, 2014 at 11:57:19PM +0000, Nathan Lynch wrote:
>>
>> Right, this stuff doesn't appear to be necessary.  Removed the vmap,
>> get_page, and ClearPageReserved calls for v3.
> 
> Can you make the corresponding change for arm64 too, please?

Yes, will do.


>>>> +static long clock_gettime_fallback(clockid_t _clkid, struct timespec *_ts)
>>>> +{
>>>> +	register struct timespec *ts asm("r1") = _ts;
>>>> +	register clockid_t clkid asm("r0") = _clkid;
>>>> +	register long ret asm ("r0");
>>>> +	register long nr asm("r7") = __NR_clock_gettime;
>>>> +
>>>> +	asm("swi #0" : "=r" (ret) : "r" (clkid), "r" (ts), "r" (nr) : "memory");
> 
> Might be worth making this volatile, rather than depend on the use of ret.

Okay.


> Also, placing both _clkid and ret into "r0" worries me slightly -- is GCC
> smart enough to realise that writing to ret kills _clkid?

I pretty much lifted this from an example in the GCC manual:

     register int *p1 asm ("r0") = ...;
     register int *p2 asm ("r1") = ...;
     register int *result asm ("r0");
     asm ("sysint" : "=r" (result) : "0" (p1), "r" (p2));

http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/Extended-Asm.html

I guess it doesn't directly answer your concern, but it's an indication
that GCC developers have this use case in mind.
