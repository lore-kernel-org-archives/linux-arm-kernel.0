From: mattwood2000@gmail.com (Matt Wood)
Date: Mon, 23 Apr 2012 11:20:38 -0400
Subject: SPI subsystem delays
In-Reply-To: <CAJe_ZheQZFA_wuCPa+reHU3HOGku-iiQh-GjJOy6Xr=c+ExGiQ@mail.gmail.com>
References: <CADjezmaB7yo6W1dW11JKtH7JNSsgXQvOQy5BMqtAUfe6sy2igA@mail.gmail.com>
 <CAJe_ZheQZFA_wuCPa+reHU3HOGku-iiQh-GjJOy6Xr=c+ExGiQ@mail.gmail.com>
Message-ID: <CADjezmabm9t3kwWCbLMBjdH2uf3+7J6Y_v3QXqs=dvrhAnc_ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 4:35 AM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 23 April 2012 02:37, Matt Wood <mattwood2000@gmail.com> wrote:
>>
>> has some specific delay requirements - specifically
>> the delay between bytes in a single transfer
>>
> Sounds like your chip specific quirk. Apparently throughput would
> be the last of your concerns :D
> Perhaps you have to do single byte transfers with appropriate
> non-zero 'delay_usecs' and skilfully toggle 'cs_change' for
> each transfer.
>
>> delay between chip select assertion and the first clock edge
>>
> IMO that could already be done from within your controller driver.
>
>> and the delay between consecutive transfers.
>>
> Why not spi_transfer.delay_usecs ?
>
> -jassi

Hi Jassi, thanks for the reply.

> Sounds like your chip specific quirk. Apparently throughput would
> be the last of your concerns :D

Indeed, this is a very quirky device and throughput is not an issue.

> Why not spi_transfer.delay_usecs ?

This does not address the delay from chip select assertion to the
first edge of the serial clock, nor does it address the delay between
bytes within a single spi_message.  I agree that single byte transfers
might work especially with spi_transfer.cs_change = 0, however that
makes the code cumbersome with all those byte transfers and still does
not help with the CS to SPCK timings as I mentioned.

It would seem to me that if the hardware supports delays, then it
would be advantageous to add these attributes to the SPI framework.
Also, it would not be an expensive addition to add these attributes to
spi_device structure as my patch does.

Thoughts?

Thanks, Matt.
