From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jan 2015 11:36:46 +0000
Subject: [PATCH V2 2/4] mmc: pwrseq: Document DT bindings for the simple
 MMC power sequence
In-Reply-To: <20150116075308.3f4e250a@notabene.brown>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
 <1421240530-7971-3-git-send-email-ulf.hansson@linaro.org>
 <20150115165825.GL16217@leverpostej>
 <20150116075308.3f4e250a@notabene.brown>
Message-ID: <20150116113646.GH12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 07:53:08AM +1300, NeilBrown wrote:
> Also, it isn't clear to me whether the need for power/reset is a function of
> the mmc-host, or a function of the device attached to the host.  I suspect
> some are needed by one, some by the other.  Any by both?

Neil,

There's a horrid issue there.  The standard model of MMC/SD is that the
device will be powered up by the host, and will then be probed to find
out what the device is.  This normally works fine as the host is
responsible for controlling the power to the socket which the card is
plugged into.

Where things fall down is when you have a MMC/SD device embedded onto
a board, and they decide that it'll be given separate controls for
power and reset which are not under the control of the host.

If the MMC/SD device is not powered up before we probe the bus, then
the device is not discoverable, and this breaks the standard model:
- If we run the standard MMC/SD device discovery code with the device
  powered down, it will find no device attached, so no device will be
  created.

- If we create a device, then the device driver will be probed
  immediately.  While the device driver can then bind, discover the
  power and reset controls, and activate them, it can't then talk to
  its device because the MMC layer hasn't gone through the required
  standard device discovery and probe sequence.  If we could do that,
  we would then need some way to stop that mechanism creating another
  device.

If we instead take the view that the host is responsible for powering
up the device, then we are merely keeping with the standard MMC/SD
model, and we don't have to hack around his.

Keeping to the standard model of a host responsible for power control
of its child devices is just a whole lot nicer.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
