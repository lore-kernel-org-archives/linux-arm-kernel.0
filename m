From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 23 Jan 2012 20:06:57 +0530
Subject: omap-serial RX DMA polling?
In-Reply-To: <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com>
 <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com>
 <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com>
Message-ID: <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 4:17 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 23 Jan 2012, Govindraj wrote:
>
>> On Mon, Jan 23, 2012 at 6:03 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > while trying to track down some of the serial-related PM issues in
>> > v3.3-rc1, I noticed that the omap-serial.c driver sets a 1 microsecond
>> > polling timer when DMA is enabled (uart_dma.rx_timer) (!) ?This seems
>> > quite broken from both the DMA and PM points of view.
>>
>> Poll rate is used for doing tty_insert_flip_string for pushing data to
>> user space to keep faster response to any client device over uart, some
>> Bt chips expect faster response when data on uart arrives and packet
>> should be pushed out immediately.
>
> Hmm. ?Let's say that the BT transceiver uses the fastest transmission rate
> supported by the OMAP UARTs -- 3,686,400 bits per second, according to
> Table 17-1 in the 34xx TRM vZR. ?So the RX poll timer would go off about
> ~2.7 times per input character[1]. ?That seems like overkill...
>

Yes correct, Looks like the poll rate is to aggressive
it should be calculated based on baud rate provided from user apace
in termios function.

I had a patch to do the same in termios but,
if you have something similar you can post out as I am currently busy with
some other activities and may take more time.


> For minimum receive latency, how about calling tty_insert_flip_string()
> from the RX DMA callback, and using a smaller transfer count? ?Or even
> better, use PIO for the receive path and set the RX FIFO threshold to 1?
>
> No poll timer should be needed in either case.

I remember doing similar excercise with BT + uart on zoom board
but performance numbers where impacted.

I made buffer size as 1 byte and removed polling function and got rx_callback
for every byte completion and pushed same to tty layer.

BT FTP throughput got impacted a lot.

--
Thanks,
Govindraj.R

note: I little busy currently and replies might be delayed.
         sorry for any inconvenience.


>
>
> - Paul
>
> 1. At 10 line bits per character (start + byte + stop), each character
> should take about 2.7 microseconds to transfer (the reciprocal of (3 686
> 400 line bits per second / 10 line bits per character / 1 000 000
> microseconds per second)).
