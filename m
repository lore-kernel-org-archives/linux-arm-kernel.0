From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Dec 2016 11:54:21 +0000
Subject: [PATCH 2/2] arm64: alternatives: Work around NOP generation with
 broken assembler
In-Reply-To: <c7de1968-7d50-a435-56ea-a7f3e9cb52da@arm.com>
References: <20161203140538.23525-1-marc.zyngier@arm.com>
 <20161203140538.23525-3-marc.zyngier@arm.com>
 <20161205100545.GA14058@arm.com>
 <c7de1968-7d50-a435-56ea-a7f3e9cb52da@arm.com>
Message-ID: <56b48421-8b97-16e2-526a-01ee0bb8bf53@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/16 10:58, Marc Zyngier wrote:
> On 05/12/16 10:05, Will Deacon wrote:
>> On Sat, Dec 03, 2016 at 02:05:38PM +0000, Marc Zyngier wrote:
>>> When compiling a .inst directive in an alternative clause with
>>> a rather old version of gas (circa 2.24), and when used with
>>> the alternative_else_nop_endif feature, the compilation fails
>>> with a rather cryptic message such as:
>>>
>>> arch/arm64/lib/clear_user.S:33: Error: bad or irreducible absolute expression
>>>
>>> which is caused by the bug described in eb7c11ee3c5c ("arm64:
>>> alternative: Work around .inst assembler bugs").
>>>
>>> This effectively prevents the use of the "nops" macro, which
>>> requires the number of instruction as a parameter (the assembler
>>> is confused and unable to compute the difference between two labels).
>>>
>>> As an alternative(!), use the .fill directive to output the number
>>> of required NOPs (.fill has the good idea to output the fill pattern
>>> in the endianness of the instruction stream).
>>
>> Are you sure about that? The gas docs say:
>>
>> `The contents of each repeat bytes is taken from an 8-byte number. The
>>  highest order 4 bytes are zero. The lowest order 4 bytes are value rendered
>>  in the byte-order of an integer on the computer as is assembling for.'
>>
>> and I'd expect "integer" to refer to data values, rather than instructions.
> 
> My tests on 2.24 and 2.25 seem to show that the output is always LE,
> which could be another GAS issue. I've asked the binutils people for
> information.

Well, my testing was wrong, as objdump -d was lying to me by displaying
something in little-endian form. Time for some more head scratching.

	M.
-- 
Jazz is not dead. It just smells funny...
