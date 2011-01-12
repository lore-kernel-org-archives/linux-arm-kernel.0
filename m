From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 09:03:01 +0000
Subject: Locking in the clk API
In-Reply-To: <4D2D184A.8020405@codeaurora.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<4D2D184A.8020405@codeaurora.org>
Message-ID: <20110112090301.GS11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 06:56:10PM -0800, Saravana Kannan wrote:
> On 01/11/2011 01:16 AM, Russell King - ARM Linux wrote:
>> On Tue, Jan 11, 2011 at 10:16:42AM +0800, Jeremy Kerr wrote:
>>> At present, we can satisfy these with:
>>>
>>> * clk_enable: may sleep
>>
>> I object to this as one of the purposes behind the clk API is to allow
>> power savings to be made, and unless we can perform clk enable/disable
>> from atomic contexts, the best you can do is enable the clock when the
>> device is probed and disable it when it's released.
>
> Since dev_pm_ops.suspend is not atomic anymore (am I wrong?), what is  

That never has been, and that is called for the _system_ going into
suspend.  That's not what I'm talking about.  I'm talking about drivers
doing their own power management in response to (a) their knowledge of
how the device behaves and (b) in response to the user state they know.

In the case of a UART, that means enabling the clock when the user opens
the device and turning it off when the user closes the device - and in
the case of the UART being used as the system console, enabled when
printk calls it, disabled when finished outputting the message.

The latter is a case where you're called in atomic context.

Another case - a storage device.  While you may receive open/close calls,
these are meaningless for power management - you'll receive an open call
when you mount a filesystem, and a close call when you finally unmount it.
That doesn't mean it's going to be used.  Your request handler will
generally run in an atomic context, so in order to do dynamic power
saving you need to be able to enable/disable clocks in that context.

A touchscreen controller which you communicate with over a dedicated bus.
The touchscreen controller doesn't require the host to be constantly
clocked - it only needs to be clocked when communicating with the
touchscreen.  The touchscreen controller raises an interrupt for service.
You'd want to enable the clock in the interrupt handler to communicate
with the device and turn it off afterwards.

Shall I continue?
