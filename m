From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Aug 2011 12:52:36 -0700
Subject: [PATCH] i2c: tegra: Check for overflow errors with BUG_ON.
In-Reply-To: <20110815191745.GA7178@legolas.emea.dhcp.ti.com>
References: <1313434172-18319-1-git-send-email-dianders@chromium.org>
	<20110815191745.GA7178@legolas.emea.dhcp.ti.com>
Message-ID: <CAD=FV=Xd67iw=GXV9i4O5LKnJd20=BkYyfVuxPgxQ5GZRJEy4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Mon, Aug 15, 2011 at 12:17 PM, Felipe Balbi <balbi@ti.com> wrote:
> so due to a FIFO overflow you lock up the whole system ? Can't you e.g.
> reset the controller and reconfigure it rather than locking up the
> system ?

Certainly we could try to be more proactive and reset / retry / return
the error to the client.  However, since the only expected situation
where this BUG_ON should hit is due to a bug in this driver itself
(AKA: i2c clients shouldn't be able to do anything to cause the BUG_ON
to hit), that seems like a lot of added complexity.

Also: if there is an arbitrary software bug that causing an overflow
condition to occur, I'm not sure how stable the system will be.
Specifically, the i2c controller is used (among other things) to talk
to the PMU and adjust voltages in the system.  If we just sent it a
random command, I'd rather report the bug right away so we don't get
hard to find/reproduce failures in other parts of the system.

What do others think?

-Doug
