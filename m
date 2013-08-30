From: anup@brainfault.org (Anup Patel)
Date: Fri, 30 Aug 2013 20:22:25 +0530
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <20130830143052.GH12160@mudshark.cambridge.arm.com>
References: <CAAhSdy3W+q4yk992ajnHBb23SVDqmfe_4BiGfH9XTYkwfVmC-A@mail.gmail.com>
 <20130816171912.GB20246@cbox>
 <CAAhSdy2bk6Ou=326cYJW2wKvm9pffbRRmO2ABFwF9dmqwWdKqQ@mail.gmail.com>
 <20130816175034.GE20246@cbox>
 <CAAhSdy3B5JTcd7==u_QzS3V5k7pYkymtiLa7X=yZH+=eSBAw8w@mail.gmail.com>
 <20130830095215.GC62188@MacBook-Pro.local>
 <CAAhSdy0Hm1k+mWGGxUOzAA=5yVGNOERfo=36jcE1cvkUM=xtVg@mail.gmail.com>
 <bc23926cb9f202d8b63d729c584af791@www.loen.fr>
 <20130830140446.GA14125@darko.cambridge.arm.com>
 <ac8cf7fa4f4bced56856c58ef335d7a9@www.loen.fr>
 <20130830143052.GH12160@mudshark.cambridge.arm.com>
Message-ID: <CAAhSdy2KjyS2VZZ6ZQxLT1Q6n=8pept+RA00V3UNuXXrbWe3oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Aug 30, 2013 at 8:00 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Aug 30, 2013 at 03:22:11PM +0100, Marc Zyngier wrote:
>> On 2013-08-30 15:04, Catalin Marinas wrote:
>> > On Fri, Aug 30, 2013 at 02:21:57PM +0100, Marc Zyngier wrote:
>> >> On 2013-08-30 11:44, Anup Patel wrote:
>> >> > For KVM, we can avoid flushing d-cache to PoC every time in
>> >> > coherent_icache_guest_page() by only doing it when Guest MMU is
>> >> > turned-off. This may reduce the performance penalty.
>> >>
>> >> What about the I and C bits in SCTLR_EL1? Does L3 also honour these
>> >> bits?
>> >
>> > I would think so, it probably cares about how the transactions are
>> > presented at the bus level by the CPU.
>>
>> That'd make sense indeed. So we need to track both SCTLR_EL1.{I,C,M} in
>> order to find out whether or not we need to clean the cache.
>
> <horrible hack>
> Could you use a dummy ATS_* operation, then read the cacheability attributes
> out of the PAR?
> </horrible hack>

We will have to use ATS12xxx operation which can only be executed from EL2
or EL3. The host kernel runs at EL1 hence we will need to use HVC call to
execute ATS12xxx operation in EL2 mode which in-turn means a world-switch
overhead just to execute ATS12xxx operation.

>
> Will

--Anup
