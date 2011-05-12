From: wg@grandegger.com (Wolfgang Grandegger)
Date: Thu, 12 May 2011 09:13:40 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <201105112344.44171.arnd@arndb.de>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>	<2BFFDAA0A0DE4820876E5549867938EC@subhasishg>	<201105112331.47954.arnd@arndb.de>
	<201105112344.44171.arnd@arndb.de>
Message-ID: <4DCB88A4.2010901@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2011 11:44 PM, Arnd Bergmann wrote:
> On Wednesday 11 May 2011, Arnd Bergmann wrote:
>> If that interpretation is right, I would seriously recommend rethinking
>> the design of the CAN firmware for pruss, so you can start doing something
>> useful with the offload engine that fits into the Socket CAN API, or that
>> would be a useful extension to Socket CAN that is also implementable in
>> the kernel for all other drivers in a meaningful way.
> 
> I've looked some more into the CAN socket implementation, and I suppose that
> the idea of the pruss driver was really to help do the work from the
> can_rcv_filter function in hardware.

That software filter is per socket while the hardware filter will be per
device.

> Doing this right would really mean supporting both a mode where any new
> filter that gets added to socket can ends up being added to the hardware
> as long as it fits, similar to how we can add additional unicast mac
> addresses to an ethernet NIC. However, when the filters from all user
> sockets combined can not be represented in the hardware driver, the hardware
> needs to be put into a less efficient mode where all packets are returned
> to the kernel and processed in software.

Well, that seems sophisticated resulting in a complex implementation
(may code line) also because hardware filters are very hardware
dependent. Usually just one global filter can be defined. I think that's
overkill. A simple interface using:

  ip link set can0 type can filter <id>:<mask> [<id>:<mask> ...]

would just be fine.

Wolfgang.
