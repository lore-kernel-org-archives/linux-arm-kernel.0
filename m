From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2011 10:58:18 +0100
Subject: Bug in _und_usr on dual-core ARM?
In-Reply-To: <BANLkTinUYZm+Q3WBGLTQRXz1V2ca1AwE=g@mail.gmail.com>
References: <BANLkTinY+_+tHatRWuRFUJewUibpmvkUqA@mail.gmail.com>
	<20110621091529.GA22868@n2100.arm.linux.org.uk>
	<BANLkTinUYZm+Q3WBGLTQRXz1V2ca1AwE=g@mail.gmail.com>
Message-ID: <20110621095818.GA23802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 05:37:31PM +0800, TAO HU wrote:
> Hi, Russell
> 
> Wouldn't it lead to oops with your patch?

The might_sleep() occurs because its trying to process the page fault.
We shouldn't be trying to do that with IRQs disabled - instead, we
should try to fix up the fault from kernel space by invoking the fixup
for the ldrt instructions in __und_usr.

This may throw the system into a loop against your process (which you
should still be able to kill) which will suggest that there's dirty
I-cache lines - we seem to be executing code in a non-present page
(at 0xafd0ce5c).
