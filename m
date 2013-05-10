From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 10 May 2013 16:25:45 -0700
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <82612ce3-3be2-46fe-925c-3aa6ca743e7d@CO1EHSMHS004.ehs.local>
References: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
 <518D320C.4010707@elopez.com.ar>
 <fe9e603e-a432-4a29-a195-fd393b875a7e@TX2EHSMHS006.ehs.local>
 <518D411D.9070209@elopez.com.ar>
 <CAPtuhTgsP4gvMAFoQb3icXAZw3ucSg4dfrAdJMho-VxNmNTvwg@mail.gmail.com>
 <518D7C45.2090602@codeaurora.org>
 <82612ce3-3be2-46fe-925c-3aa6ca743e7d@CO1EHSMHS004.ehs.local>
Message-ID: <518D81F9.1090105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2013 04:06 PM, S?ren Brinkmann wrote:
> On Fri, May 10, 2013 at 04:01:25PM -0700, Saravana Kannan wrote:
>> On 05/10/2013 03:18 PM, Mike Turquette wrote:

>>> I think that Soren wants something with a stable interface that he can
>>> use for his Zynq use case.  Regarding that, why not write an actual
>>> device driver to do what you want to do from userspace?
>>
>> Exposing clock control to userspace production use is a terrible
>> idea. A misbehaving userspace can easily kill the system. This is
>> not so try for GPIO. So, exposing GPIOs to userspace is relatively
>> less of a concern.
> Well, the FPGA clocks are only used by stuff in the FPGA. They cannot
> mess up the Linux on the A9s. I my use-case is kinda special. And people
> request functionality to easily adjust the frequency for their FPGA
> design in SW from Linux.

How do you talk to the FPGA? What happens if the FPGA clock gets turned 
off when the Linux is communicating with it? At the least the I2C or 
whatever bus you used to talk to it could hang. You need to explain more 
about why it's "special" before people might turn around to give 
userspace ABI for clock control.

> Nevertheless, there is no real protection from taking the driver I'm
> proposing to control the FPGA clocks to control a clock vital to the
> system.

If we are talking about changing the kernel to control different clocks, 
that true for any driver.

If your idea of this driver was something that will take a clock name 
and rate and change that clock's rate, then that's not a good design. 
What Mike probably meant was a FPGA specific driver that will only 
clk_get() the clocks related to the FPGA, and expose options to 
userspace. Not the actual rate or enable/disable capability.

For example, opening the device could cause clk_prepare_enable() and 
closing it would cause clk_disable_unprepare(). You might have ioctls to 
let userspace pick one of different modes of operation with each 
corresponding to a different clock rate and other corresponding FPGA 
configuration changes, etc. That's just a rough sketch. If you write 
such a driver, userspace can't misuse it to mess with other clocks or 
leave the FPGA clock in a bad state.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
