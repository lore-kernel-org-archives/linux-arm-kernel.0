From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 Oct 2012 17:59:49 +0100
Subject: alignment faults in 3.6
In-Reply-To: <20121011103257.GO4625@n2100.arm.linux.org.uk>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <506ED18C.3010009@gmail.com>
 <20121005140556.GQ4625@n2100.arm.linux.org.uk> <506EEFBB.3060705@gmail.com>
 <507619FA.6080001@jonmasters.org> <yw1xtxu1pwtv.fsf@unicorn.mansr.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7038@saturn3.aculab.com>
 <yw1xpq4ppcju.fsf@unicorn.mansr.com>
 <1349949638.21172.8445.camel@edumazet-glaptop>
 <1349950926.21172.8521.camel@edumazet-glaptop>
 <20121011103257.GO4625@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk70TNGA29AFq=oogx=UOVsS9dJOr0vLyx-di0STpoUHuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2012 11:32, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 11, 2012 at 12:22:06PM +0200, Eric Dumazet wrote:
>> I took a look, and I dont see why/how gcc could use a ldm instruction
>>
>> Doing so assumed the alignment of the structure was 8 bytes, but its
>> not.
>>
>> Networking stack mandates that IP headers are aligned on 4 bytes
>> boundaries, not 8 bytes.
>
> Err, no.  ldm is "load multiple" not "load double".  It loads multiple
> 32-bit registers, and its requirement for non-faulting behaviour is for
> the pointer to be 4 byte aligned.  However, "load double" requires 8
> byte alignment.

It got better with ARMv6 where LDRD/STRD only require 4 byte alignment
(the only 8 byte alignment is required by LDREXD/STREXD). But on ARMv5
LDRD/STRD 8 byte alignment is indeed required (otherwise
unpredictable).

-- 
Catalin
