From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 20 Aug 2013 11:21:25 +0200
Subject: [PATCH 1/8] ARM: at91: move peripheral id definitions to
 dt-bindings include dir
In-Reply-To: <52124BD5.5060801@atmel.com>
References: <1375339733-3488-1-git-send-email-b.brezillon@overkiz.com>
 <1375339933-3643-1-git-send-email-b.brezillon@overkiz.com>
 <201308072224.30614.arnd@arndb.de> <520319DE.5090100@overkiz.com>
 <52124BD5.5060801@atmel.com>
Message-ID: <CACQ1gAj1Wf8t58s+msNha0L0SYs1LO9pq2QSuqUCMG=h+zTqJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/19 Nicolas Ferre <nicolas.ferre@atmel.com>:
> On 08/08/2013 06:09, boris brezillon :
>
>> Hello Arnd,
>>
>> On 07/08/2013 22:24, Arnd Bergmann wrote:
>>>
>>> On Thursday 01 August 2013, Boris BREZILLON wrote:
>>>>
>>>> This patch moves peripheral id definitions from machine specific include
>>>> dir (arch/arm/mach-at91/include/mach/'soc-name'.h) to dt-bindinds
>>>> include
>>>> dir (include/dt-bindings/at91/'soc-name'/peripherals.h).
>>>>
>>>> These definitions will be used inside dt to define interrupt ids and
>>>> peripheral clk ids.
>>>>
>>>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>>>
>>> This seems counterproductive, why would you do that?
>>
>>
>> This was requested by Jean-Christophe Plagniol-Villard (and proposed by
>> Richard Genoud)
>> for the 3rd version of the "ARM: at91: move to common clk framework"
>> patch series (see
>> https://lkml.org/lkml/2013/7/29/361) and thought it was a good idea too
>> (even if I didn't know
>> where to put the macro files as there are no soc specific macro files in
>> dt-bindings include
>> dir).
>>
>> Indeed I found it much easier to detect bugs in dt definition using
>> macros because
>> the macro names and dt node names are the same (it does not protect
>> against errors
>> in the macro definitions).
>>
>> If you think these macro definitions should be dropped, I won't argue
>> against this.
>> But please, have a talk with Jean-Christophe first.
>
>
> [..]
>
>
>>> There is no sharing of identifiers across SoCs here, you just move the
>>> data around, and changing the .dts files to use the abstract macros would
>>> just end up making them harder to understand, not easier, since you then
>>> have to look up the numbers in another file.
>
>
> Boris, Jean-Christophe and Richard,
>
> Well, I must say that I do agree with Arnd on this point.
>
> I think that a simple numeric field in a cell has to be represented as a
> number and even if this simple information is used twice (interrupt number
> and clock bit position in PMC). The possibility of error is very low
> compared to the big amount of unneeded definitions added by this solution.

Well, maybe the use of macro there is a bit overkill...
But after reviewing the patches (and found an error), I thought it was
useful to use macros, because verifying each number according to the
SoC manual is a pain !
It's way easier to check the header once for all, then there's no
possible error in the dtsi (or at least, we can see it from far far
away...)
On the downside, I agree, it adds a lot of defines. (and once it has
been validated, the dtsi should not change)

my 2 cents...
