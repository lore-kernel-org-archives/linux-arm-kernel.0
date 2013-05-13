From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 13 May 2013 18:21:13 +0200
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <0bf5a185-86f7-4a93-a90f-42caefb06a1d@TX2EHSMHS009.ehs.local>
References: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130510212422.GY3200@sirena.org.uk>
 <7e18bed3-ae6b-4aa0-bf23-b6c61ba8b85b@CO9EHSMHS030.ehs.local>
 <20130512143344.GC3200@sirena.org.uk>
 <9e55c552-ce34-4663-9a57-bf2c626d7d58@TX2EHSMHS008.ehs.local>
 <20130513052135.GD6836@sirena.org.uk>
 <0bf5a185-86f7-4a93-a90f-42caefb06a1d@TX2EHSMHS009.ehs.local>
Message-ID: <519112F9.2010102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/13 18:09, S?ren Brinkmann wrote:
> On Mon, May 13, 2013 at 09:21:35AM +0400, Mark Brown wrote:
>> On Sun, May 12, 2013 at 12:05:04PM -0700, S?ren Brinkmann wrote:
>>> On Sun, May 12, 2013 at 06:33:44PM +0400, Mark Brown wrote:
>>>> No, there's no confusion here - the clocks that are being exposed to
>>>> userspace are the clocks which enter the FPGA.  The driver or whatever
>>>> that understands the FPGA can do what is needed to control them,
>>>> including routing them on to subdevices it instantiates or exposing them
>>>> to userspace.
>>
>>> Such a driver does not exist in general.
>>> For some IP cores, Linux drivers do exist and then
>>> they are supposed to directly use the CCF, IMHO, no need to expose
>>> things to userspace in that case.
>>> I'm trying to cover cases, in which there is no driver available/needed for
>>> the FPGA design, other than some simple clock controls.
>>
>> You're not understanding the point here.  If you've got a
>> reprogrammmable FPGA you at least need some way to get the FPGA image in
>> there.  This driver is presumably responsible for instantiating whatever
>> is needed to control what is on the FPGA, that could include punting the
>> clocks to userspace if that's sane.
> Well, that driver actually exists. But that just programs a bitstream
> you give it to program. It does not know anything about the design it
> programs and cannot make any kind of decision whether the clocks should
> be userspace controlled or not.

Soeren,

what Mark wants to point out is that you add fabric clocks to the Xilinx
driver instead. This way, you will have user-space controllable clocks
but only if you loaded the xilinx driver first.

IIRC the fabric clock controller provided by Zynq _is_ always there and
accessible from ARM CPUs. You just don't have a new generic driver
allowing to poke with all clocks, but a xilinx only driver allowing you
to set the (xilinx only) fabric clocks.

I've played with Zynq a while ago, did Xilinx mainline the bitfile
driver already? If not, why don't you give it a shot?

Sebastian
