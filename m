From: yegorslists@googlemail.com (Yegor Yefremov)
Date: Tue, 4 Jan 2011 12:56:05 +0100
Subject: zaurus bluetooth regression
In-Reply-To: <20110103141727.GA1536@ucw.cz>
References: <20110102204532.GA12860@elf.ucw.cz> <20110102203023.GA1545@ucw.cz>
	<AANLkTika7HAEc+BbqSnbo8viUt4nOqoeB69qWZs85-9s@mail.gmail.com>
	<20110103141727.GA1536@ucw.cz>
Message-ID: <AANLkTimFTzHjLy1zSURiOdcDJUSa9b-ZU1kxL_qK+7-T@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >> It seems this commit
>> >>
>> >> commit 7a56aa45982bb87bfca98a2832b5ae782c03364a
>> > ...
>> >> ...is responsible for my bluetooth problems on zaurus -- at least
>> >> bisect pointed to it, ?as I use 16C950-based bluetooth card, it seems
>> >> very logical. I'll try 2.6.37-rc8 with that patch reverted...
>> >>
>> >
>> > And yes, 37-rc8 with that reverted results in working bluetooth, so
>> > yrs, that patch is responsible.
>>
>> could you tell, what kind of problem you're encountering and if you
>> could tell, which flag UART_CAP_EFR or UART_CAP_SLEEP causes the
>> problem?
>
> Bluetooth will not work with 'tx command timeout', details should be
> in bugzilla.
>
> CAP_EFR seems to cause the problem.

Aside from sleep functions the only impact CAP_EFR makes is enabling
automatic CTS flow control. Below the cite from 16C950 data sheet:

"EFR[7]: Enable automatic CTS flow control.
logic 0 ?   CTS flow control is disabled (default).
logic 1 ?   CTS flow control is enabled in Enhanced mode
(i.e. EFR[4] = 1), where the data transmission is
prevented  whenever  the  CTS#  pin  is  held
inactive high. 650 and 950-mode drivers should
use  this  bit  to  enable  CTS  flow  control.    750
mode drivers should use MCR[5].

When automatic CTS flow control is enabled and the CTS#
input becomes active, the UART will disable transmission
as soon as any current character transmission is complete.
Transmission   is   resumed   whenever   the   CTS#   input
becomes inactive. "

I've tested with such an UART and transmitted some chunk of data with
and without RTS/CTS flow control enabled at 460800 b/s. The test
showed that in enabled state all data was transmitted correctly.
Without RTS/CTS flow control enabled there was massive data loss, as
expected. So the flow control function seems to work correctly.

Regards,
Yegor
