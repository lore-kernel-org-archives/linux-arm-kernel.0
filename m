From: slash.tmp@free.fr (Mason)
Date: Fri, 1 Jan 2016 13:03:05 +0100
Subject: [PATCH RFC] ARM: tango4: Fix build issues
In-Reply-To: <56865A5C.5050601@free.fr>
References: <567DBA04.4060709@free.fr> <20151231132116.GB1547@localhost>
 <CAOesGMhBkacNRxQaBKG8f5Bv2FXH504YCj_O0eL=FwGzY03H-Q@mail.gmail.com>
 <56865A5C.5050601@free.fr>
Message-ID: <56866AF9.5000601@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/01/2016 11:52, Mason wrote:
> On 31/12/2015 17:31, Olof Johansson wrote:
>> On Thu, Dec 31, 2015 at 2:21 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Fri, Dec 25, 2015 at 10:49:56PM +0100, Mason wrote:
>>>> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>>>
>>>> Move SMP setup to platsmp.c
>>>> Specify the CPU type to the assembler, and only for smc.S
>>>>
>>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>>> ---
>>>
>>> Applied, thanks.
>>
>> Actually, I just noticed that the smc.c Makefile part isn't done as it
>> should, so I'll drop this again.
> 
> <grumble>
> 
> This is probably a bike-shed issue that I should let slide...
> 
> But can someone explain to me: in what circumstances
> 
> plus_sec := $(call as-instr,.arch_extension sec,+sec)
> AFLAGS_smc.o :=-Wa,-march=armv7-a$(plus_sec)
> 
> is preferable over
> 
> AFLAGS_smc.o := -Wa,-mcpu=cortex-a9
> 
> in a machine-specific Makefile?
> 
> 
> Arnd mentioned consistency with other machines; ISTM that
> simplicity and obviousness are also desirable characteristics.

For the sake of completeness, the +sec shenanigans are required
because of this 2010 binutils patch:

https://sourceware.org/ml/binutils/2010-09/msg00412.html

Specifying the CPU instead of an ISA (plus extensions) leaves
the instruction set selection up to the assembler, so the same
flag works for both old and new binutils.

Regards.
