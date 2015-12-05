From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sat, 5 Dec 2015 14:19:12 -0800
Subject: [PATCH LINUX v3 09/10] tty: xuartps: Only handle RX IRQs when RX
 is enabled
In-Reply-To: <56632231.6000000@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-10-git-send-email-soren.brinkmann@xilinx.com>
 <56632231.6000000@hurleysoftware.com>
Message-ID: <20151205221912.GP4900@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-12-05 at 12:43PM -0500, Peter Hurley wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> > Ignore RX-related interrupts if RX is not enabled.
> 
> This doesn't look like a safe approach; fast-forward a couple of years and
> some is trying to add some feature but can't figure out why no data is
> arriving...
> 
> What is this trying to solve?

I definitely saw two kinds of lock ups. One was on the TX side, that the
system tried to print with the transmitter disabled.

The other on the RX side. I don't recall the details, but the system was
stuck in some RX-related function waiting for data while the receiver
was disabled. I think my explanation was that some IRQ condition becomes
true and is dispatched to the RX handler even though the receiver isn't
enabled.
I guess a better way for solving this would be to disable the IRQs that
call the RX handler when the receiver is disabled.

	S?ren
