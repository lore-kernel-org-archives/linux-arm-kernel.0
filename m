From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 4 Oct 2018 20:08:55 +0200
Subject: Reboot using an i2c power-system-controller ?
In-Reply-To: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
Message-ID: <20181004180855.GG4730@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 06:23:37PM +0200, Nicolas Cavallari wrote:
> So i got this ARM board with a rtc controlled by i2c that can also cut
> power.  I want to use it to reboot, because it will also cut power to
> clumsy USB and MMC devices.
> So the natural thing to do would be to just register a restart_handler
> that will kindly do i2c (saw at least a driver doing it), or use
> arm_pm_restart and be done with it.
> 
> Well that what I though.  Most of my naive attempts were met with
> occasional failures and now my understanding is that I do not
> understand why anything works in the first place.

Hi Nicolas

I doubt you can use the platform i2c driver.

If you look at how this is done for sending commands over a UART to a
micro-controller, you will see the reset driver hijack the UART
device. They poke registers with the require baud rate settings, and
then poke registers with the bytes to send, polling for completion of
each byte if needed.

To get this working reliably, i suspect you are going to need to do
the same with your i2c bus controller. Directly control it, stop any
in progress transfers, setup a new transfer, and hope you can do it
polled IO, not DMA.

       Andrew
