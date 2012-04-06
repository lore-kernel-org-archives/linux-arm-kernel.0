From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Fri, 6 Apr 2012 11:35:27 +0530
Subject: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default pads
In-Reply-To: <20120405165811.GB3785@atomide.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com>
 <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
 <20120405165811.GB3785@atomide.com>
Message-ID: <CAMrsUdJEY2o2CWjzSg5dabVEkpk48O5njtDU55Z3Jq2vViNJgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 10:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Raja, Govindraj <govindraj.raja@ti.com> [120403 23:18]:
>> On Tue, Apr 3, 2012 at 11:49 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Govindraj.R <govindraj.raja@ti.com> [120321 03:06]:
>> >> From: "Govindraj.R" <govindraj.raja@ti.com>
>> >>
>> >> The following commit:
>> >> (7496ba3 ?ARM: OMAP2+: UART: Add default mux for all uarts)
>> >> added default pads for all uarts. But not all boards tend to
>> >> use all uarts and most of unused uart pins are muxed for
>> >> other purpose. This commit breaks the modules which where trying
>> >> to use unused uart pins on their boards.
>> >>
>> >> So remove all default pads except uart1/3 as most boards
>> >> tend to use either uart1/3 as console port and use only tx/rx
>> >> lines, declare only those pads for uart1/3.
>> >> If any boards tend to use any other uart other uart1/3
>> >> the mux data should to passed from board file and init individual
>> >> uart port using omap_serial_init_port api.
>> >
>> > This is still wrong. We can't mux any serial pins unless specifically
>> > requested from the board-*.c files. So please do a fix to get back to
>> > v3.2 behaviour where you basically revert 7496ba3.
>>
>> How to do we fix the rx pin wakeup capability?
>> The mux data has the info about the rx pin wakeup
>>
>> Without rx pin wakeup PM will be broken.
>
> Let's first make things work reliably before even getting started
> about PM being broken.
>

okay.

>> Fix all board files with duplicated data for uart3 or
>> uart1 having rx pin marked as wakeup capable?
>
> And how do you know which pins to mux? You don't, unless you look
> at the schematics for all the boards.
>

agree even I am not sure of uarts used for console on all boards


> The only safe option without looking at the schematics is to
> make omap_serial_init not do any muxing. If you want muxing and
> PM wake-up events, then use omap_serial_init_port for those ports
> with board specific pins.

okay.

>
>> Behavior in v3.2 was raw_write to all uarts rx_pin to enable wakeup
>> enable bit.
>
> Hmm I don't think any muxing was done automatically unless
> omap_serial_init_port was being called with pins.

Muxing was happening even if we don't call omap_serial_init_port
rx pin was muxed for wakeup capability for all uart pins

omap_uart_idle_init => was populating padconf offset value for ech uart
which was used in omap_uart_enable/disable_wakeup functions.
This mechanism was keeping PM happening for all boards.

--
Thanks,
Govindraj.R
