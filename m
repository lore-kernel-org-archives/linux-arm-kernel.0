From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 7 May 2014 10:25:55 -0400 (EDT)
Subject: [PATCH 4/7] usb: ehci-platform: add optional reset controller
 retrieval
In-Reply-To: <1399434623-20383-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <Pine.LNX.4.44L0.1405071020490.1325-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 May 2014, Maxime Ripard wrote:

> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> On the Allwinner's A31 SoC the reset line connected to the EHCI IP has to
> be deasserted for the EHCI block to be usable.
> 
> Add support for an optional reset controller that will be deasserted on
> power off and asserted on power on.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Is this really a _reset_ line?  That is, when you assert the reset 
line, does it actually reset the EHCI controller, or does it merely 
leave the controller in a partially powered-down state?

The difference is important.  During suspend, the controller is
supposed to remember the state of the port connections as well as other
settings.  If it doesn't, the controller and all attached USB devices
will have to be reinitialized every time the controller resumes, which
will increase the latency.

Alan Stern
