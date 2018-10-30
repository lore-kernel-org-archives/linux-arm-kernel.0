From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Tue, 30 Oct 2018 11:50:15 +0100
Subject: [BUG] MVPP2 driver exploding in presence of a tap interface
In-Reply-To: <6355174d-4ab6-595d-17db-311bce607aef@arm.com>
References: <6355174d-4ab6-595d-17db-311bce607aef@arm.com>
Message-ID: <20181030105015.GB3407@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Mon, Oct 29, 2018 at 03:05:53PM +0000, Marc Zyngier wrote:
> 
> This is a follow-up on the conversation Thomas and I had last week at 
> ELC, with me ranting at the sorry state of the MVPP2 driver.

> Triggering this is dead simple:
> - Add a macvtap to one of the MVPP2 interfaces
> - Bring it online
> - Watch the kernel exploding and memory being corrupted
> 
> You don't even need anything listening on the tap interface, just its
> simple existence triggers it. I use a similar setup on a large variety 
> of machines, and this box is the only one that catches fire. Removing
> the macvtap interface makes it (more) reliable.
> 
> Given that I cannot reproduce this issue on any other ARM (32 or 64bit)
> platform, including other Marvell stuff, I can only conclude that the
> MVPP2 driver is responsible for this.
> 
> Example crash and .config below (4.19 vanilla, as linux/master dies in
> new and wonderful ways on this box). I'm looking forward to testing any
> idea you may have.

I used a 4.19 vanilla kernel, with both your configuration and mine,
on 2 different Macchiatobins, but was unable to trigger the issue:

  # ip link set eth0 up
  # ip link add link eth0 name macvtap0 type macvtap
  # ip link set macvtap0 up

I can even configure the eth0/macvtap0 interfaces, and use them
generating or receiving tcp/udp/icmp traffic.

(I also made other tests using macvtap and tap interfaces).

How much memory do you have on the board? What version of ATF are you
using? Version of U-Boot?

Antoine

-- 
Antoine T?nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
