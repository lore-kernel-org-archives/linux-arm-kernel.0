From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Dec 2014 10:40:49 +0000
Subject: [PATCH RFC 09/15] drm: imx: Add MIPI DSI host controller driver
In-Reply-To: <54915081.6020508@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
 <1418200648-32656-10-git-send-email-Ying.Liu@freescale.com>
 <20141210131640.GD23558@ulmo.nvidia.com>
 <54915081.6020508@freescale.com>
Message-ID: <20141217104049.GU11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 05:44:33PM +0800, Liu Ying wrote:
> Hi Thierry,
> 
> Sorry for the late response.
> I tried to address almost all your comments locally first.
> More feedback below.
> 
> On 12/10/2014 09:16 PM, Thierry Reding wrote:
> >On Wed, Dec 10, 2014 at 04:37:22PM +0800, Liu Ying wrote:
> >>+static int check_status(struct imx_mipi_dsi *dsi, u32 reg, u32 status,
> >>+			int timeout, bool to_set)
> >>+{
> >>+	u32 val;
> >>+	bool out = false;
> >>+
> >>+	val = dsi_read(dsi, reg);
> >>+	for (;;) {
> >>+		out = to_set ? (val & status) : !(val & status);
> >>+		if (out)
> >>+			break;
> >>+
> >>+		if (!timeout--)
> >>+			return -EFAULT;
> >>+
> >>+		msleep(1);
> >>+		val = dsi_read(dsi, reg);
> >>+	}
> >>+	return 0;
> >>+}
> >
> >You should probably use a properly timed loop here. msleep() isn't
> >guaranteed to return after exactly one millisecond, so your timeout is
> >never going to be accurate. Something like the following would be better
> >in my opinion:
> >
> >	timeout = jiffies + msecs_to_jiffies(timeout);
> >
> >	while (time_before(jiffies, timeout)) {
> >		...
> >	}
> >
> >Also timeout should be unsigned long in that case.
> 
> Accepted.

Actually, that's a bad example: what we want to do is to assess success
after we wait, before we decide that something has failed.  In other
words, we don't want to wait, and decide that we failed without first
checking for success.

In any case, returning -EFAULT is not sane: EFAULT doesn't mean "fault"
it means "Bad address", and it is returned to userspace to mean that
userspace passed the kernel a bad address.  That definition does /not/
fit what's going on here.

	timeout = jiffies + msecs_to_jiffies(timeout);

	do {
		val = dsi_read(dsi, reg);
		out = to_set ? (val & status) : !(val & status);
		if (out)
			break;

		if (time_is_after_jiffies(timeout))
			return -ETIMEDOUT;

		msleep(1);
	} while (1);

	return 0;

would be better: we only fail immediately after we have checked whether
we succeeded, and we also do the first check immediately.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
