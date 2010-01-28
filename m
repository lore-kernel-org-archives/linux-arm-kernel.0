From: lbassel@quicinc.com (Larry Bassel)
Date: Thu, 28 Jan 2010 15:04:49 -0800
Subject: [RFC 05/18] arm: msm: implement ioremap_strongly_ordered
In-Reply-To: <20100111233720.GK7925@n2100.arm.linux.org.uk>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-6-git-send-email-dwalker@codeaurora.org>
	<20100111233720.GK7925@n2100.arm.linux.org.uk>
Message-ID: <20100128230449.GU10547@labbmf-linux.quicinc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 03:37:20PM -0800, Russell King - ARM Linux wrote:
> On Mon, Jan 11, 2010 at 02:47:24PM -0800, Daniel Walker wrote:
> > From: Larry Bassel <lbassel@quicinc.com>
> > 
> > Both the clean and invalidate functionality needed
> > for the video encoder and 7x27 barrier code
> > need to have a strongly ordered mapping set up
> > so that one may perform a write to strongly ordered
> > memory. The generic ARM code does not provide this.
> > 
> > The generic ARM code does provide MT_DEVICE, which starts
> > as strongly ordered, but the code later turns the buffered flag
> > on for ARMv6 in order to make the device shared. This is not
> > suitable for my purpose, so this patch adds code for a
> > MT_DEVICE_STRONGLY_ORDERED mapping type.
> 
> This doesn't really describe what "my purpose" is; the patch description
> is too vague to ascertain why this is required.

Hopefully this is a better description of the patch:

Some Qualcomm SOCs (such as the MSM7x27) require a write to
strongly ordered memory in order to fully flush the AXI bus.
Although the generic ARM code provides MT_DEVICE, which starts
as strongly ordered, it later turns on the buffered flag to
make this memory shared.

Add an additional mapping type MT_DEVICE_STRONGLY_ORDERED which
will stay in strongly ordered mode and allow proper
implementation of cache and invalidate operations on these
devices.

Larry
