From: michal.wrobel@flytronic.pl (=?UTF-8?B?TWljaGHFgiBXcsOzYmVs?=)
Date: Tue, 14 Feb 2012 15:47:05 +0100
Subject: [PATCH RESEND] ixp4xx: clockevent set_next_event fix (TESTERS
 NEEDED)
In-Reply-To: <4F3A51DB.70000@flytronic.pl>
References: <4F394D3B.3080909@flytronic.pl> <4F3A2F79.6050806@flytronic.pl>
 <20120214120153.GA9808@localhost.localdomain> <4F3A51DB.70000@flytronic.pl>
Message-ID: <4F3A73E9.1020503@flytronic.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.02.2012 13:21, Micha? Wr?bel wrote:
> On 14.02.2012 13:01, Richard Cochran wrote:
>> On Tue, Feb 14, 2012 at 10:55:05AM +0100, Micha? Wr?bel wrote:
>>> IXP43x Developer's Manual [17.4.3] and IXP4[56]x Developer's Manual
>>> [18.4.3] say that (...)
>>>
>>> IXP42x Developer's Manual [14.3] says that (...)
>> Unless you test this out and confirm that it works for all IXP4xx, I
>> would prefer to see a specific timer function for the 43x instead.
>>
>> Thanks,
>> Richard
> I think I might have some IXP425-based boards available for testing.
I will have it available later.
> However, I certainly don't have any IXP45x- or IXP46x-based board.
> Maybe I'll prepare a small kernel module that will allow to easily test this
> issue
Done. See the attachments.

Results of my tests performed on IXP435-based board (667 MHz,
CONFIG_HZ=100) follow below.

Without the patch:

starting measurements: 10000 samples * 1000000 ns
measurements finished
min: 2500 ns
avg: 7894228 ns
max: 9970743 ns

With the patch:

starting measurements: 10000 samples * 1000000 ns
measurements finished
min: 1637 ns
avg: 4266 ns
max: 100182 ns

>  by other list members who have IXP45x- and IXP46x-based boards?
Does anyone have any IXP45x- and IXP46x-based board? If so, I would like
to ask to compile ixp4xx_set_next_event_bug_test.c as a module and run
it on such a board. Then, to apply the "ixp4xx: clockevent
set_next_event fix" patch and re-run the tests. Of course, finally
posting the results here.

Note that the kernel used for testing has to be configured with
CONFIG_HIGH_RES_TIMERS=y

Thank you in advance!

Best regards,
Micha?

>>> Signed-off-by: Micha? Wr?bel <michal.wrobel@flytronic.pl>
>>> ---
>>>  arch/arm/mach-ixp4xx/common.c |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>> (...)
>>> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
>>> index 3841ab4..fd37c83 100644
>>> --- a/arch/arm/mach-ixp4xx/common.c
>>> +++ b/arch/arm/mach-ixp4xx/common.c
>>> @@ -434,6 +434,7 @@ static int ixp4xx_set_next_event(unsigned long evt,
>>>  {
>>>  	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
>>>  
>>> +	*IXP4XX_OSRT1 = 0;
>>>  	*IXP4XX_OSRT1 = (evt & ~IXP4XX_OST_RELOAD_MASK) | opts;
>>>  
>>>  	return 0;
>>> -- 
>>> 1.7.5.4


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: Makefile
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/f5d2d392/attachment.ksh>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ixp4xx_set_next_event_bug_test.c
Type: text/x-csrc
Size: 1670 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/f5d2d392/attachment.bin>
